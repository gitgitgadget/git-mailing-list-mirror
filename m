From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Egit plugin - eclipse crushed and cannot restore workspace
Date: Sun, 28 Mar 2010 00:11:49 +0100
Message-ID: <201003280011.49509.robin.rosenberg@dewire.com>
References: <033601cac7ab$d9838290$8c8a87b0$@com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "'Git'" <git@vger.kernel.org>,
	"'Shawn O. Pearce'" <spearce@spearce.org>,
	"'Ted Kubow'" <tkubow@interactivebrokers.com>,
	"'Eugene Sajine'" <euguess@gmail.com>
To: "Eugene Sajine" <esajine@interactivebrokers.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 00:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvfTQ-0005yw-H9
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 00:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab0C0XbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 19:31:18 -0400
Received: from av9-2-sn3.vrr.skanova.net ([81.228.9.186]:41654 "EHLO
	av9-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab0C0XbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 19:31:17 -0400
X-Greylist: delayed 1161 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2010 19:31:16 EDT
Received: by av9-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id A3A9C37E67; Sun, 28 Mar 2010 00:11:53 +0100 (CET)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av9-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 39FDE37E62; Sun, 28 Mar 2010 00:11:53 +0100 (CET)
Received: from sleipner.localnet (host-90-236-116-26.mobileonline.telia.com [90.236.116.26])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 9D49437E49;
	Sun, 28 Mar 2010 00:11:50 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-20-generic; KDE/4.3.5; i686; ; )
In-Reply-To: <033601cac7ab$d9838290$8c8a87b0$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143364>

fredagen den 19 mars 2010 22.33.42 skrev  Eugene Sajine:
> Hi Shawn,
> 
> I have Eclipse 3.5 which suddenly crashed and now it cannot restore the
> workspace failing with exceptions. It says in log that the root one is a
> NullPointer in Egit. We are using Egit 0.5.0
> Please see the log below.
> 
> Currently, the only work around we were able to find is to create a new
> workspace...

> Thanks,
> Eugene Sajine
> 

Eugene, please send things like this to the EGit, mailing list, or since this
is a real bug it would be better to the  EGit bug tracker.  Normally we'd just
reject this as an old bug since you are on 0.5.0, but on the other hand I 
think we haven't changed anything here, I believe this problem is still
valid, but a bit hard to reproduce.
 
-- robin

> !SESSION 2010-03-19 16:58:42.676
> -----------------------------------------------
> eclipse.buildId=M20090917-0800
> java.version=1.5.0_22
> java.vendor=Sun Microsystems Inc.
> BootLoader constants: OS=linux, ARCH=x86, WS=gtk, NL=en_US
> Framework arguments:  -product org.eclipse.epp.package.jee.product -refresh
> Command-line arguments:  -os linux -ws gtk -arch x86 -product
> org.eclipse.epp.package.jee.product -refresh -clean
> 
> !ENTRY org.eclipse.core.resources 2 10035 2010-03-19 16:58:59.971
> !MESSAGE The workspace exited with unsaved changes in the previous session;
> refreshing workspace to recover changes.
> 
> !ENTRY org.apache.ivyde.eclipse 1 0 2010-03-19 16:59:03.702
> !MESSAGE starting IvyDE plugin
> 
> !ENTRY org.apache.ivyde.eclipse 1 0 2010-03-19 16:59:03.727
> !MESSAGE IvyDE plugin started
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.292
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.299
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.300
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.303
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.305
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.306
> !MESSAGE Widget disposed too early!
> !STACK 0
> java.lang.RuntimeException: Widget disposed too early!
> 	at
> org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPa
> r tReference.java:172)
> 	at
> org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
> 	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
> 	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at
> org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
> 	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
> 	at
> org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
> 	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
> 	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
> 	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
> 	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
> 	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
> 	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
> 	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:129)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.osgi 4 0 2010-03-19 16:59:04.327
> !MESSAGE Application error
> !STACK 1
> java.lang.NoClassDefFoundError:
> org/eclipse/ui/internal/navigator/extensions/LinkHelperService
> 	at
> org.springframework.ide.eclipse.ui.navigator.SpringNavigator.getLinkHelperS
> e rvice(SpringNavigator.java:280)
> 	at
> org.springframework.ide.eclipse.ui.navigator.SpringNavigator.selectReveal(S
> p ringNavigator.java:345)
> 	at
> org.springframework.ide.eclipse.ui.navigator.SpringNavigator.determineAndRe
> f reshViewer(SpringNavigator.java:187)
> 	at
> org.springframework.ide.eclipse.ui.navigator.SpringNavigator.updateTreeView
> e r(SpringNavigator.java:369)
> 	at
> org.springframework.ide.eclipse.ui.navigator.SpringNavigator.selectionChang
> e d(SpringNavigator.java:127)
> 	at
> org.eclipse.ui.internal.AbstractSelectionService.firePostSelection(Abstract
> S electionService.java:179)
> 	at
> org.eclipse.ui.internal.AbstractSelectionService$2.selectionChanged(Abstrac
> t SelectionService.java:71)
> 	at
> org.eclipse.jface.text.TextViewer.firePostSelectionChanged(TextViewer.java:
> 2 731)
> 	at
> org.eclipse.jface.text.TextViewer.firePostSelectionChanged(TextViewer.java:
> 2 679)
> 	at org.eclipse.jface.text.TextViewer$5.run(TextViewer.java:2658)
> 	at org.eclipse.swt.widgets.Display.timerProc(Display.java:3978)
> 	at org.eclipse.swt.internal.gtk.OS._g_main_context_iteration(Native
> Method)
> 	at
> org.eclipse.swt.internal.gtk.OS.g_main_context_iteration(OS.java:1860)
> 	at
> org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3110)
> 	at
> org.eclipse.ui.application.WorkbenchAdvisor.openWindows(WorkbenchAdvisor.ja
> v a:803)
> 	at
> org.eclipse.ui.internal.Workbench$28.runWithException(Workbench.java:1384)
> 	at
> org.eclipse.ui.internal.StartupThreading$StartupRunnable.run(StartupThreadi
> n g.java:31)
> 	at org.eclipse.swt.widgets.RunnableLock.run(RunnableLock.java:35)
> 	at
> org.eclipse.swt.widgets.Synchronizer.runAsyncMessages(Synchronizer.java:134
> ) at
> org.eclipse.swt.widgets.Display.runAsyncMessages(Display.java:3468)
> 	at
> org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3115)
> 	at org.eclipse.ui.internal.Workbench.runUI(Workbench.java:2316)
> 	at org.eclipse.ui.internal.Workbench.access$4(Workbench.java:2221)
> 	at org.eclipse.ui.internal.Workbench$5.run(Workbench.java:500)
> 	at
> org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:332
> ) at
> org.eclipse.ui.internal.Workbench.createAndRunWorkbench(Workbench.java:493)
> 	at
> org.eclipse.ui.PlatformUI.createAndRunWorkbench(PlatformUI.java:149)
> 	at
> org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication
> . java:113)
> 	at
> org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java
> : 194)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication
> ( EclipseAppLauncher.java:110)
> 	at
> org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseA
> p pLauncher.java:79)
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> !ENTRY org.eclipse.ui.workbench 4 2 2010-03-19 16:59:04.331
> !MESSAGE Problems occurred when invoking code from plug-in:
> "org.eclipse.ui.workbench".
> !STACK 0
> org.eclipse.swt.SWTException: Device is disposed
> 	at org.eclipse.swt.SWT.error(SWT.java:3884)
> 	at org.eclipse.swt.SWT.error(SWT.java:3799)
> 	at org.eclipse.swt.SWT.error(SWT.java:3770)
> 	at org.eclipse.swt.widgets.Display.error(Display.java:1150)
> 	at org.eclipse.swt.widgets.Display.syncExec(Display.java:4104)
> 	at
> org.eclipse.ui.internal.StartupThreading.runWithoutExceptions(StartupThread
> i ng.java:94)
> 	at
> org.eclipse.ui.internal.Workbench.doRestoreState(Workbench.java:3399)
> 	at org.eclipse.ui.internal.Workbench.access$30(Workbench.java:3328)
> 	at org.eclipse.ui.internal.Workbench$54.run(Workbench.java:2114)
> 	at
> org.eclipse.ui.internal.Workbench.runStartupWithProgress(Workbench.java:182
> 7 )
> 	at
> org.eclipse.ui.internal.Workbench.restoreState(Workbench.java:2112)
> 	at org.eclipse.ui.internal.Workbench.access$28(Workbench.java:2083)
> 	at org.eclipse.ui.internal.Workbench$49.run(Workbench.java:1946)
> 	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:42)
> 	at
> org.eclipse.ui.internal.Workbench.restoreState(Workbench.java:1890)
> 	at
> org.eclipse.ui.internal.WorkbenchConfigurer.restoreState(WorkbenchConfigure
> r .java:183)
> 	at
> org.eclipse.ui.application.WorkbenchAdvisor$1.run(WorkbenchAdvisor.java:781
> )
> 
> !ENTRY org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
> !MESSAGE The following is a complete list of bundles which are not
>  resolved, see the prior log entry for the root cause if it exists:
> !SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
> !MESSAGE Bundle
> org.eclipse.jdt.apt.pluggable.core_1.0.201.R35x_v20090818-0225 [304] was
>  not resolved.
> !SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing imported package
> org.eclipse.jdt.internal.compiler.tool_0.0.0.
> !SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing imported package
> org.eclipse.jdt.internal.compiler.apt.dispatch_0.0.0.
> !SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing imported package
> org.eclipse.jdt.internal.compiler.apt.model_0.0.0.
> !SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing imported package
> org.eclipse.jdt.internal.compiler.apt.util_0.0.0.
> !SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
> !MESSAGE Bundle org.eclipse.jdt.compiler.apt_1.0.201.R35x_v20090825-1530
> [306] was not resolved.
> !SUBENTRY 2 org.eclipse.jdt.compiler.apt 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing imported package
> org.eclipse.jdt.internal.compiler.tool_0.0.0.
> !SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
> !MESSAGE Bundle org.eclipse.jdt.compiler.tool_1.0.100.v_972_R35x [307] was
> not resolved.
> !SUBENTRY 2 org.eclipse.jdt.compiler.tool 2 0 2010-03-19 16:59:05.044
> !MESSAGE Missing Constraint: Bundle-RequiredExecutionEnvironment:
>  JavaSE-1.6
> 
> !ENTRY org.eclipse.jdt.ui 4 0 2010-03-19 16:59:05.172
> !MESSAGE
> !STACK 0
> org.osgi.framework.BundleException: Exception in
> org.eclipse.jdt.internal.ui.JavaPlugin.stop() of bundle org.eclipse.jdt.ui.
> 	at
> org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleConte
> x tImpl.java:863)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleHost.stopWorker(BundleHost.j
> a va:474)
> 	at
> org.eclipse.osgi.framework.internal.core.AbstractBundle.suspend(AbstractBun
> d le.java:546)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.suspendBundle(Framework.
> j ava:1098)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.decFWSL(StartLev
> e lManager.java:593)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.doSetStartLevel(
> S tartLevelManager.java:261)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.shutdown(StartLe
> v elManager.java:216)
> 	at
> org.eclipse.osgi.framework.internal.core.InternalSystemBundle.suspend(Inter
> n alSystemBundle.java:266)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.shutdown(Framework.java:
> 6 85)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.close(Framework.java:583
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.shutdown(EclipseStarter.jav
> a
> 
> :409)
> 
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:200
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> Caused by: java.lang.NullPointerException
> 	at org.eclipse.egit.ui.Activator.trace(Activator.java:143)
> 	at
> org.eclipse.egit.ui.internal.decorators.GitQuickDiffProvider.dispose(GitQui
> c kDiffProvider.java:51)
> 	at
> org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.uninstall(D
> o cumentLineDiffer.java:1442)
> 	at
> org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.disconnect(
> D ocumentLineDiffer.java:1407)
> 	at
> org.eclipse.jface.text.source.AnnotationModel.disconnect(AnnotationModel.ja
> v a:546)
> 	at
> org.eclipse.core.internal.filebuffers.ResourceTextFileBuffer.dispose(Resour
> c eTextFileBuffer.java:330)
> 	at
> org.eclipse.core.internal.filebuffers.TextFileBufferManager.disconnect(Text
> F ileBufferManager.java:209)
> 	at
> org.eclipse.ui.editors.text.TextFileDocumentProvider.disposeFileInfo(TextFi
> l eDocumentProvider.java:696)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disp
> o seFileInfo(CompilationUnitDocumentProvider.java:1190)
> 	at
> org.eclipse.ui.editors.text.TextFileDocumentProvider.disconnect(TextFileDoc
> u mentProvider.java:653)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disc
> o nnect(CompilationUnitDocumentProvider.java:1255)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.shut
> d own(CompilationUnitDocumentProvider.java:1487)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.WorkingCopyManager.shutdown(WorkingC
> o pyManager.java:77)
> 	at org.eclipse.jdt.internal.ui.JavaPlugin.stop(JavaPlugin.java:539)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleContextImpl$2.run(BundleCont
> e xtImpl.java:843)
> 	at java.security.AccessController.doPrivileged(Native Method)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleConte
> x tImpl.java:836)
> 	... 18 more
> Root exception:
> java.lang.NullPointerException
> 	at org.eclipse.egit.ui.Activator.trace(Activator.java:143)
> 	at
> org.eclipse.egit.ui.internal.decorators.GitQuickDiffProvider.dispose(GitQui
> c kDiffProvider.java:51)
> 	at
> org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.uninstall(D
> o cumentLineDiffer.java:1442)
> 	at
> org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.disconnect(
> D ocumentLineDiffer.java:1407)
> 	at
> org.eclipse.jface.text.source.AnnotationModel.disconnect(AnnotationModel.ja
> v a:546)
> 	at
> org.eclipse.core.internal.filebuffers.ResourceTextFileBuffer.dispose(Resour
> c eTextFileBuffer.java:330)
> 	at
> org.eclipse.core.internal.filebuffers.TextFileBufferManager.disconnect(Text
> F ileBufferManager.java:209)
> 	at
> org.eclipse.ui.editors.text.TextFileDocumentProvider.disposeFileInfo(TextFi
> l eDocumentProvider.java:696)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disp
> o seFileInfo(CompilationUnitDocumentProvider.java:1190)
> 	at
> org.eclipse.ui.editors.text.TextFileDocumentProvider.disconnect(TextFileDoc
> u mentProvider.java:653)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disc
> o nnect(CompilationUnitDocumentProvider.java:1255)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.shut
> d own(CompilationUnitDocumentProvider.java:1487)
> 	at
> org.eclipse.jdt.internal.ui.javaeditor.WorkingCopyManager.shutdown(WorkingC
> o pyManager.java:77)
> 	at org.eclipse.jdt.internal.ui.JavaPlugin.stop(JavaPlugin.java:539)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleContextImpl$2.run(BundleCont
> e xtImpl.java:843)
> 	at java.security.AccessController.doPrivileged(Native Method)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleConte
> x tImpl.java:836)
> 	at
> org.eclipse.osgi.framework.internal.core.BundleHost.stopWorker(BundleHost.j
> a va:474)
> 	at
> org.eclipse.osgi.framework.internal.core.AbstractBundle.suspend(AbstractBun
> d le.java:546)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.suspendBundle(Framework.
> j ava:1098)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.decFWSL(StartLev
> e lManager.java:593)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.doSetStartLevel(
> S tartLevelManager.java:261)
> 	at
> org.eclipse.osgi.framework.internal.core.StartLevelManager.shutdown(StartLe
> v elManager.java:216)
> 	at
> org.eclipse.osgi.framework.internal.core.InternalSystemBundle.suspend(Inter
> n alSystemBundle.java:266)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.shutdown(Framework.java:
> 6 85)
> 	at
> org.eclipse.osgi.framework.internal.core.Framework.close(Framework.java:583
> ) at
> org.eclipse.core.runtime.adaptor.EclipseStarter.shutdown(EclipseStarter.jav
> a
> 
> :409)
> 
> 	at
> org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:200
> ) at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
> 	at
> sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:3
> 9 )
> 	at
> sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImp
> l .java:25)
> 	at java.lang.reflect.Method.invoke(Method.java:592)
> 	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
> 	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
> 	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
