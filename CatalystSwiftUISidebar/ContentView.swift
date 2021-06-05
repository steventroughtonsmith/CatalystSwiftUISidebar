//
//  ContentView.swift
//  CatalystSwiftUISidebar
//
//  Created by Steven Troughton-Smith on 04/06/2021.
//

import SwiftUI


struct SidebarSplitView: View, UIViewControllerRepresentable {
	
	typealias UIViewControllerType = UISplitViewController
	let splitViewController = UISplitViewController(style: .tripleColumn)
	
	var columnA = UIViewController()
	var columnB = UIViewController()
	var columnC = UIViewController()
	
	init<A:View, B:View, C:View>(@ViewBuilder content: @escaping () -> TupleView <(A,B,C)>) {
		let content = content()
		
		columnA = UIHostingController(rootView: content.value.0)
		columnB = UIHostingController(rootView: content.value.1)
		columnC = UIHostingController(rootView: content.value.2)
		
		columnA.view.backgroundColor = .clear
		columnB.view.backgroundColor = .clear
		columnC.view.backgroundColor = .clear
		
		splitViewController.viewControllers = [columnA, columnB, columnC]
	}
	
	func makeUIViewController(context: Context) -> UIViewControllerType {
		splitViewController.primaryBackgroundStyle = .sidebar
		splitViewController.preferredDisplayMode = .twoBesideSecondary
		
		return splitViewController
	}
	
	func updateUIViewController(_ uiView: UIViewControllerType, context: Context) {
		
	}
}

struct ContentView: View {
	var body: some View {
		SidebarSplitView {
			List {
				Section(header: Text("Library")) {
					HStack{
						Image(systemName: "doc")
						Text("All")
					}
					HStack{
						Image(systemName: "clock")
						Text("Recents")
					}
				}
			}
			.listStyle(PlainListStyle())
			.navigationBarHidden((UIDevice.current.userInterfaceIdiom == .mac))
			
			List {
				Text("Item 1")
				Text("Item 2")
				Text("Item 3")
			}
			.navigationBarHidden((UIDevice.current.userInterfaceIdiom == .mac))
			
			Group {
				Text("Hello, world!")
					.padding()
			}
			.navigationBarHidden((UIDevice.current.userInterfaceIdiom == .mac))
			
		}
		.ignoresSafeArea()
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
