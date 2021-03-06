//
//  CardExpirationPickerDelegate.m
//  TransFS Card Terminal
//
//  Created by Joshua Krall on 2/14/09.
//  Copyright 2009 TransFS.com. All rights reserved.
//

#import "CardExpirationPickerDelegate.h"


@implementation CardExpirationPickerDelegate

- (id) init
{
	months = [[NSMutableArray alloc] init];
	//	NSArray *monthNames = [NSArray arrayWithObjects:
	//							@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec",
	//						   nil];
	//	for (int i=0; i<12; i++)
	//		[months addObject:[NSString stringWithFormat:@"(%@) %02d ", [monthNames objectAtIndex:i] ,i+1]];
	for (int i=0; i<12; i++)
		[months addObject:[NSString stringWithFormat:@"%02d ", i+1]];
	
	int todayYear = [CardExpirationPickerDelegate currentYear];
	years = [[NSMutableArray alloc] init];
	for (int i=0; i<10; i++)
		[years addObject:[NSString stringWithFormat:@"%04d", i+todayYear]];	
	
	return [super init];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerView==monthPicker)
		return 12;
	if (pickerView==yearPicker)
		return 10; // 10 years from today
	return 0;
}

#define PICKER_ROW_HEIGHT 40
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	if (pickerView==monthPicker)
		return 90;
	if (pickerView==yearPicker)
		return 90;
	return 0.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
	if (pickerView==monthPicker) {
		UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, PICKER_ROW_HEIGHT)];
		[l setBackgroundColor:[UIColor colorWithRed:0.0	green:0.0 blue:0.0 alpha:0.0]];
		[l setFont:[UIFont systemFontOfSize:24.0]];				
		[l setTextAlignment:UITextAlignmentCenter];
		[l setText:[months objectAtIndex:row]];
		return l;
	}
	if (pickerView==yearPicker) {
		UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, PICKER_ROW_HEIGHT)];
		[l setBackgroundColor:[UIColor colorWithRed:0.0	green:0.0 blue:0.0 alpha:0.0]];
		[l setFont:[UIFont systemFontOfSize:24.0]];				
		[l setTextAlignment:UITextAlignmentCenter];
		[l setText:[years objectAtIndex:row]];
		return l;
	}
	return nil;
}


+ (int) currentYear
{
	NSDate *today = [NSDate date];
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *dateComponents = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit) fromDate:today];
	return [dateComponents year];
}

@end
