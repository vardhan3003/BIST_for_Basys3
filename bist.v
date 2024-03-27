`timescale 1ns / 1ps
 
module bist(input clk,input [15:0] sw,output [15:0] led);
    
integer count = 0;
reg sclk = 0;
 
always@(posedge clk)   
begin
if(count < 50000000) 
 count <= count + 1;
else
 begin
  count <= 0;
  sclk <= ~sclk;
 end
end
 

reg flag   = 1'b0;
 
always@(posedge clk)
begin
 if(sw == 16'b0000000000000000)
   flag <= 1'b0;
 else
   flag <= 1'b1;
end
 

 
integer i  = 0;
reg [15:0] temp = 0;
 
always@(posedge sclk)
begin
if(flag == 1'b0)
begin
            if(i < 16) 
            begin
            temp <= { 1'b1, temp[15:1]}; 
            i <= i + 1;
            end
            else if(i < 32)
            begin
            i <= i + 1;
            temp <= {temp[14:0], 1'b0};
            end
            else
            begin
            i <= 0;
            temp <= 16'b0000000000000000;
            end          
end
else
begin
   temp <= sw;
end
end
 
assign led = temp;
    
endmodule
