From: "Eugene Sajine" <esajine@interactivebrokers.com>
Subject: Egit plugin - eclipse crushed and cannot restore workspace
Date: Fri, 19 Mar 2010 17:33:42 -0400
Message-ID: <033601cac7ab$d9838290$8c8a87b0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Ted Kubow'" <tkubow@interactivebrokers.com>,
	"'Eugene Sajine'" <euguess@gmail.com>
To: "'Git'" <git@vger.kernel.org>,
	"'Shawn O. Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 22:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjuM-0005kA-Lo
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 22:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab0CSVi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 17:38:59 -0400
Received: from mx1.interactivebrokers.com ([206.106.137.9]:47564 "EHLO
	mx1.interactivebrokers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751315Ab0CSVi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 17:38:58 -0400
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 17:38:58 EDT
Received: from interactivebrokers.com (localhost.localdomain [127.0.0.1])
	by mx1.interactivebrokers.com (Switch-3.3.2/Switch-3.3.2) with ESMTP id o2JLRZG9011792;
	Fri, 19 Mar 2010 17:27:51 -0400
Received: from esajinewww ([ool-45782185.dyn.optonline.net [69.120.33.133]]) by mx1.interactivebrokers.com with RELAY id o2JLRo54011810 ;
          Fri, 19 Mar 2010 17:27:51 -0400
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcrHq9heIeoR7oVOQ5KHp/bv40agLQ==
Content-Language: en-us
X-Copied: Archived
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142651>

Hi Shawn,

I have Eclipse 3.5 which suddenly crashed and now it cannot restore the
workspace failing with exceptions. It says in log that the root one is a
NullPointer in Egit. We are using Egit 0.5.0
Please see the log below.

Currently, the only work around we were able to find is to create a new
workspace...

Thanks,
Eugene Sajine

!SESSION 2010-03-19 16:58:42.676
-----------------------------------------------
eclipse.buildId=M20090917-0800
java.version=1.5.0_22
java.vendor=Sun Microsystems Inc.
BootLoader constants: OS=linux, ARCH=x86, WS=gtk, NL=en_US
Framework arguments:  -product org.eclipse.epp.package.jee.product -refresh
Command-line arguments:  -os linux -ws gtk -arch x86 -product
org.eclipse.epp.package.jee.product -refresh -clean

!ENTRY org.eclipse.core.resources 2 10035 2010-03-19 16:58:59.971
!MESSAGE The workspace exited with unsaved changes in the previous session;
refreshing workspace to recover changes.

!ENTRY org.apache.ivyde.eclipse 1 0 2010-03-19 16:59:03.702
!MESSAGE starting IvyDE plugin

!ENTRY org.apache.ivyde.eclipse 1 0 2010-03-19 16:59:03.727
!MESSAGE IvyDE plugin started

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.292
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.299
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.300
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.303
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.305
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 0 2010-03-19 16:59:04.306
!MESSAGE Widget disposed too early!
!STACK 0
java.lang.RuntimeException: Widget disposed too early!
	at
org.eclipse.ui.internal.WorkbenchPartReference$1.widgetDisposed(WorkbenchPar
tReference.java:172)
	at
org.eclipse.swt.widgets.TypedListener.handleEvent(TypedListener.java:117)
	at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1176)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1200)
	at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1181)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1044)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at
org.eclipse.swt.widgets.Composite.releaseChildren(Composite.java:1185)
	at org.eclipse.swt.widgets.Canvas.releaseChildren(Canvas.java:211)
	at
org.eclipse.swt.widgets.Decorations.releaseChildren(Decorations.java:467)
	at org.eclipse.swt.widgets.Shell.releaseChildren(Shell.java:2063)
	at org.eclipse.swt.widgets.Widget.release(Widget.java:1047)
	at org.eclipse.swt.widgets.Control.release(Control.java:3293)
	at org.eclipse.swt.widgets.Widget.dispose(Widget.java:446)
	at org.eclipse.swt.widgets.Shell.dispose(Shell.java:1999)
	at org.eclipse.swt.widgets.Display.release(Display.java:3162)
	at org.eclipse.swt.graphics.Device.dispose(Device.java:235)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:129)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.osgi 4 0 2010-03-19 16:59:04.327
!MESSAGE Application error
!STACK 1
java.lang.NoClassDefFoundError:
org/eclipse/ui/internal/navigator/extensions/LinkHelperService
	at
org.springframework.ide.eclipse.ui.navigator.SpringNavigator.getLinkHelperSe
rvice(SpringNavigator.java:280)
	at
org.springframework.ide.eclipse.ui.navigator.SpringNavigator.selectReveal(Sp
ringNavigator.java:345)
	at
org.springframework.ide.eclipse.ui.navigator.SpringNavigator.determineAndRef
reshViewer(SpringNavigator.java:187)
	at
org.springframework.ide.eclipse.ui.navigator.SpringNavigator.updateTreeViewe
r(SpringNavigator.java:369)
	at
org.springframework.ide.eclipse.ui.navigator.SpringNavigator.selectionChange
d(SpringNavigator.java:127)
	at
org.eclipse.ui.internal.AbstractSelectionService.firePostSelection(AbstractS
electionService.java:179)
	at
org.eclipse.ui.internal.AbstractSelectionService$2.selectionChanged(Abstract
SelectionService.java:71)
	at
org.eclipse.jface.text.TextViewer.firePostSelectionChanged(TextViewer.java:2
731)
	at
org.eclipse.jface.text.TextViewer.firePostSelectionChanged(TextViewer.java:2
679)
	at org.eclipse.jface.text.TextViewer$5.run(TextViewer.java:2658)
	at org.eclipse.swt.widgets.Display.timerProc(Display.java:3978)
	at org.eclipse.swt.internal.gtk.OS._g_main_context_iteration(Native
Method)
	at
org.eclipse.swt.internal.gtk.OS.g_main_context_iteration(OS.java:1860)
	at
org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3110)
	at
org.eclipse.ui.application.WorkbenchAdvisor.openWindows(WorkbenchAdvisor.jav
a:803)
	at
org.eclipse.ui.internal.Workbench$28.runWithException(Workbench.java:1384)
	at
org.eclipse.ui.internal.StartupThreading$StartupRunnable.run(StartupThreadin
g.java:31)
	at org.eclipse.swt.widgets.RunnableLock.run(RunnableLock.java:35)
	at
org.eclipse.swt.widgets.Synchronizer.runAsyncMessages(Synchronizer.java:134)
	at
org.eclipse.swt.widgets.Display.runAsyncMessages(Display.java:3468)
	at
org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3115)
	at org.eclipse.ui.internal.Workbench.runUI(Workbench.java:2316)
	at org.eclipse.ui.internal.Workbench.access$4(Workbench.java:2221)
	at org.eclipse.ui.internal.Workbench$5.run(Workbench.java:500)
	at
org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:332)
	at
org.eclipse.ui.internal.Workbench.createAndRunWorkbench(Workbench.java:493)
	at
org.eclipse.ui.PlatformUI.createAndRunWorkbench(PlatformUI.java:149)
	at
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.
java:113)
	at
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:
194)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(
EclipseAppLauncher.java:110)
	at
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAp
pLauncher.java:79)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:368)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)

!ENTRY org.eclipse.ui.workbench 4 2 2010-03-19 16:59:04.331
!MESSAGE Problems occurred when invoking code from plug-in:
"org.eclipse.ui.workbench".
!STACK 0
org.eclipse.swt.SWTException: Device is disposed
	at org.eclipse.swt.SWT.error(SWT.java:3884)
	at org.eclipse.swt.SWT.error(SWT.java:3799)
	at org.eclipse.swt.SWT.error(SWT.java:3770)
	at org.eclipse.swt.widgets.Display.error(Display.java:1150)
	at org.eclipse.swt.widgets.Display.syncExec(Display.java:4104)
	at
org.eclipse.ui.internal.StartupThreading.runWithoutExceptions(StartupThreadi
ng.java:94)
	at
org.eclipse.ui.internal.Workbench.doRestoreState(Workbench.java:3399)
	at org.eclipse.ui.internal.Workbench.access$30(Workbench.java:3328)
	at org.eclipse.ui.internal.Workbench$54.run(Workbench.java:2114)
	at
org.eclipse.ui.internal.Workbench.runStartupWithProgress(Workbench.java:1827
)
	at
org.eclipse.ui.internal.Workbench.restoreState(Workbench.java:2112)
	at org.eclipse.ui.internal.Workbench.access$28(Workbench.java:2083)
	at org.eclipse.ui.internal.Workbench$49.run(Workbench.java:1946)
	at org.eclipse.core.runtime.SafeRunner.run(SafeRunner.java:42)
	at
org.eclipse.ui.internal.Workbench.restoreState(Workbench.java:1890)
	at
org.eclipse.ui.internal.WorkbenchConfigurer.restoreState(WorkbenchConfigurer
.java:183)
	at
org.eclipse.ui.application.WorkbenchAdvisor$1.run(WorkbenchAdvisor.java:781)

!ENTRY org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
!MESSAGE The following is a complete list of bundles which are not resolved,
see the prior log entry for the root cause if it exists:
!SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
!MESSAGE Bundle
org.eclipse.jdt.apt.pluggable.core_1.0.201.R35x_v20090818-0225 [304] was not
resolved.
!SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing imported package
org.eclipse.jdt.internal.compiler.tool_0.0.0.
!SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing imported package
org.eclipse.jdt.internal.compiler.apt.dispatch_0.0.0.
!SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing imported package
org.eclipse.jdt.internal.compiler.apt.model_0.0.0.
!SUBENTRY 2 org.eclipse.jdt.apt.pluggable.core 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing imported package
org.eclipse.jdt.internal.compiler.apt.util_0.0.0.
!SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
!MESSAGE Bundle org.eclipse.jdt.compiler.apt_1.0.201.R35x_v20090825-1530
[306] was not resolved.
!SUBENTRY 2 org.eclipse.jdt.compiler.apt 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing imported package
org.eclipse.jdt.internal.compiler.tool_0.0.0.
!SUBENTRY 1 org.eclipse.osgi 2 0 2010-03-19 16:59:05.044
!MESSAGE Bundle org.eclipse.jdt.compiler.tool_1.0.100.v_972_R35x [307] was
not resolved.
!SUBENTRY 2 org.eclipse.jdt.compiler.tool 2 0 2010-03-19 16:59:05.044
!MESSAGE Missing Constraint: Bundle-RequiredExecutionEnvironment: JavaSE-1.6

!ENTRY org.eclipse.jdt.ui 4 0 2010-03-19 16:59:05.172
!MESSAGE 
!STACK 0
org.osgi.framework.BundleException: Exception in
org.eclipse.jdt.internal.ui.JavaPlugin.stop() of bundle org.eclipse.jdt.ui.
	at
org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleContex
tImpl.java:863)
	at
org.eclipse.osgi.framework.internal.core.BundleHost.stopWorker(BundleHost.ja
va:474)
	at
org.eclipse.osgi.framework.internal.core.AbstractBundle.suspend(AbstractBund
le.java:546)
	at
org.eclipse.osgi.framework.internal.core.Framework.suspendBundle(Framework.j
ava:1098)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.decFWSL(StartLeve
lManager.java:593)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.doSetStartLevel(S
tartLevelManager.java:261)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.shutdown(StartLev
elManager.java:216)
	at
org.eclipse.osgi.framework.internal.core.InternalSystemBundle.suspend(Intern
alSystemBundle.java:266)
	at
org.eclipse.osgi.framework.internal.core.Framework.shutdown(Framework.java:6
85)
	at
org.eclipse.osgi.framework.internal.core.Framework.close(Framework.java:583)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.shutdown(EclipseStarter.java
:409)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:200)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
Caused by: java.lang.NullPointerException
	at org.eclipse.egit.ui.Activator.trace(Activator.java:143)
	at
org.eclipse.egit.ui.internal.decorators.GitQuickDiffProvider.dispose(GitQuic
kDiffProvider.java:51)
	at
org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.uninstall(Do
cumentLineDiffer.java:1442)
	at
org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.disconnect(D
ocumentLineDiffer.java:1407)
	at
org.eclipse.jface.text.source.AnnotationModel.disconnect(AnnotationModel.jav
a:546)
	at
org.eclipse.core.internal.filebuffers.ResourceTextFileBuffer.dispose(Resourc
eTextFileBuffer.java:330)
	at
org.eclipse.core.internal.filebuffers.TextFileBufferManager.disconnect(TextF
ileBufferManager.java:209)
	at
org.eclipse.ui.editors.text.TextFileDocumentProvider.disposeFileInfo(TextFil
eDocumentProvider.java:696)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.dispo
seFileInfo(CompilationUnitDocumentProvider.java:1190)
	at
org.eclipse.ui.editors.text.TextFileDocumentProvider.disconnect(TextFileDocu
mentProvider.java:653)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disco
nnect(CompilationUnitDocumentProvider.java:1255)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.shutd
own(CompilationUnitDocumentProvider.java:1487)
	at
org.eclipse.jdt.internal.ui.javaeditor.WorkingCopyManager.shutdown(WorkingCo
pyManager.java:77)
	at org.eclipse.jdt.internal.ui.JavaPlugin.stop(JavaPlugin.java:539)
	at
org.eclipse.osgi.framework.internal.core.BundleContextImpl$2.run(BundleConte
xtImpl.java:843)
	at java.security.AccessController.doPrivileged(Native Method)
	at
org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleContex
tImpl.java:836)
	... 18 more
Root exception:
java.lang.NullPointerException
	at org.eclipse.egit.ui.Activator.trace(Activator.java:143)
	at
org.eclipse.egit.ui.internal.decorators.GitQuickDiffProvider.dispose(GitQuic
kDiffProvider.java:51)
	at
org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.uninstall(Do
cumentLineDiffer.java:1442)
	at
org.eclipse.ui.internal.texteditor.quickdiff.DocumentLineDiffer.disconnect(D
ocumentLineDiffer.java:1407)
	at
org.eclipse.jface.text.source.AnnotationModel.disconnect(AnnotationModel.jav
a:546)
	at
org.eclipse.core.internal.filebuffers.ResourceTextFileBuffer.dispose(Resourc
eTextFileBuffer.java:330)
	at
org.eclipse.core.internal.filebuffers.TextFileBufferManager.disconnect(TextF
ileBufferManager.java:209)
	at
org.eclipse.ui.editors.text.TextFileDocumentProvider.disposeFileInfo(TextFil
eDocumentProvider.java:696)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.dispo
seFileInfo(CompilationUnitDocumentProvider.java:1190)
	at
org.eclipse.ui.editors.text.TextFileDocumentProvider.disconnect(TextFileDocu
mentProvider.java:653)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.disco
nnect(CompilationUnitDocumentProvider.java:1255)
	at
org.eclipse.jdt.internal.ui.javaeditor.CompilationUnitDocumentProvider.shutd
own(CompilationUnitDocumentProvider.java:1487)
	at
org.eclipse.jdt.internal.ui.javaeditor.WorkingCopyManager.shutdown(WorkingCo
pyManager.java:77)
	at org.eclipse.jdt.internal.ui.JavaPlugin.stop(JavaPlugin.java:539)
	at
org.eclipse.osgi.framework.internal.core.BundleContextImpl$2.run(BundleConte
xtImpl.java:843)
	at java.security.AccessController.doPrivileged(Native Method)
	at
org.eclipse.osgi.framework.internal.core.BundleContextImpl.stop(BundleContex
tImpl.java:836)
	at
org.eclipse.osgi.framework.internal.core.BundleHost.stopWorker(BundleHost.ja
va:474)
	at
org.eclipse.osgi.framework.internal.core.AbstractBundle.suspend(AbstractBund
le.java:546)
	at
org.eclipse.osgi.framework.internal.core.Framework.suspendBundle(Framework.j
ava:1098)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.decFWSL(StartLeve
lManager.java:593)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.doSetStartLevel(S
tartLevelManager.java:261)
	at
org.eclipse.osgi.framework.internal.core.StartLevelManager.shutdown(StartLev
elManager.java:216)
	at
org.eclipse.osgi.framework.internal.core.InternalSystemBundle.suspend(Intern
alSystemBundle.java:266)
	at
org.eclipse.osgi.framework.internal.core.Framework.shutdown(Framework.java:6
85)
	at
org.eclipse.osgi.framework.internal.core.Framework.close(Framework.java:583)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.shutdown(EclipseStarter.java
:409)
	at
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:200)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39
)
	at
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl
.java:25)
	at java.lang.reflect.Method.invoke(Method.java:592)
	at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:559)
	at org.eclipse.equinox.launcher.Main.basicRun(Main.java:514)
	at org.eclipse.equinox.launcher.Main.run(Main.java:1311)
