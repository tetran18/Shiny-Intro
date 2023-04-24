## -----------------------------------------------------------------------------
## Title: ShinyIntro_App1.R
## Author(s): Shiny Development Team, Nathan Aagard
## Created On: 4/23/23
## Modified On: 4/23/23
## Description: Shiny web application built using R programming language for the
##              purpose of introducing the Shiny library in R and displaying
##              some of its functionalities.
## Notes:
##      * You can run the application by clicking the 'Run App' button above 
##        or by pressing Ctrl + Shift + Enter.
##
##      * Shiny website for reference: http://shiny.rstudio.com/
## -----------------------------------------------------------------------------

# load the Shiny library
library(shiny)

### Create the UI (User Interface) object ###
ui <- fluidPage(
  
  # App title
  titlePanel("Hello Shiny!"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # Input: Slider for the number of bins
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      # Output: Histogram
      plotOutput(outputId = "distPlot")
    )
    
  )
)

### Create the server function ###
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    # store old faithful wait time vector
    x <- faithful$waiting
    # create a bin vector based user input bin number
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # plot a histogram using the specified data vector and bin vector
    hist(x, breaks = bins, col = "#007bc2", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
  })
}

### Create a Shiny app object using specified UI object & server function ###
shinyApp(ui = ui, server = server)