From: Chris Dumoulin <dumoulin@oanda.com>
Subject: EGIT branch checkout errors
Date: Wed, 12 Nov 2008 10:50:24 -0500
Message-ID: <491AFB40.4000800@oanda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 16:51:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0I0F-0003U9-S2
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 16:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbYKLPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYKLPuT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 10:50:19 -0500
Received: from mail.oanda.com ([216.220.44.220]:39049 "EHLO mail.oanda.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbYKLPuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 10:50:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.oanda.com (Postfix) with ESMTP id 0819EEC09B
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 10:50:17 -0500 (EST)
Received: from mail.oanda.com ([127.0.0.1])
	by localhost (mail.q9.oanda.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14594-02 for <git@vger.kernel.org>;
	Wed, 12 Nov 2008 10:50:16 -0500 (EST)
Received: from gateway.oanda.com (unknown [216.235.10.210])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.oanda.com (Postfix) with ESMTPS id DF571EC00D
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 10:50:16 -0500 (EST)
Received: from [10.0.10.50] (unknown [10.0.10.50])
	by eddie.dev.oanda.com (Postfix) with ESMTP id 7DF8F64080
	for <git@vger.kernel.org>; Wed, 12 Nov 2008 10:50:16 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100760>

Using EGIT in Eclipse, I'm able to create a new branch, but not able to 
checkout a branch. When I try Team->Branch...->Checkout, nothing 
happens, so I launched Eclipse from a terminal to see any output it 
might be giving. Here's what I got:

java.lang.reflect.InvocationTargetException
    at org.eclipse.jface.operation.ModalContext.run(ModalContext.java:415)
    at 
org.eclipse.jface.window.ApplicationWindow$1.run(ApplicationWindow.java:758)
    at org.eclipse.swt.custom.BusyIndicator.showWhile(BusyIndicator.java:70)
    at 
org.eclipse.jface.window.ApplicationWindow.run(ApplicationWindow.java:755)
    at 
org.eclipse.ui.internal.WorkbenchWindow.run(WorkbenchWindow.java:2487)
    at 
org.spearce.egit.ui.internal.actions.BranchAction.run(BranchAction.java:53)
    at 
org.eclipse.team.internal.ui.actions.TeamAction.runWithEvent(TeamAction.java:548)
    at 
org.eclipse.ui.internal.PluginAction.runWithEvent(PluginAction.java:241)
    at 
org.eclipse.jface.action.ActionContributionItem.handleWidgetSelection(ActionContributionItem.java:583)
    at 
org.eclipse.jface.action.ActionContributionItem.access$2(ActionContributionItem.java:500)
    at 
org.eclipse.jface.action.ActionContributionItem$5.handleEvent(ActionContributionItem.java:411)
    at org.eclipse.swt.widgets.EventTable.sendEvent(EventTable.java:84)
    at org.eclipse.swt.widgets.Widget.sendEvent(Widget.java:1158)
    at org.eclipse.swt.widgets.Display.runDeferredEvents(Display.java:3401)
    at org.eclipse.swt.widgets.Display.readAndDispatch(Display.java:3033)
    at org.eclipse.ui.internal.Workbench.runEventLoop(Workbench.java:2382)
    at org.eclipse.ui.internal.Workbench.runUI(Workbench.java:2346)
    at org.eclipse.ui.internal.Workbench.access$4(Workbench.java:2198)
    at org.eclipse.ui.internal.Workbench$5.run(Workbench.java:493)
    at 
org.eclipse.core.databinding.observable.Realm.runWithDefault(Realm.java:288)
    at 
org.eclipse.ui.internal.Workbench.createAndRunWorkbench(Workbench.java:488)
    at org.eclipse.ui.PlatformUI.createAndRunWorkbench(PlatformUI.java:149)
    at 
org.eclipse.ui.internal.ide.application.IDEApplication.start(IDEApplication.java:113)
    at 
org.eclipse.equinox.internal.app.EclipseAppHandle.run(EclipseAppHandle.java:193)
    at 
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.runApplication(EclipseAppLauncher.java:110)
    at 
org.eclipse.core.runtime.internal.adaptor.EclipseAppLauncher.start(EclipseAppLauncher.java:79)
    at 
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:386)
    at 
org.eclipse.core.runtime.adaptor.EclipseStarter.run(EclipseStarter.java:179)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at 
sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
    at 
sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
    at java.lang.reflect.Method.invoke(Method.java:616)
    at org.eclipse.equinox.launcher.Main.invokeFramework(Main.java:549)
    at org.eclipse.equinox.launcher.Main.basicRun(Main.java:504)
    at org.eclipse.equinox.launcher.Main.run(Main.java:1236)
    at org.eclipse.equinox.launcher.Main.main(Main.java:1212)
Caused by: java.lang.NullPointerException
    at org.spearce.jgit.lib.GitIndex.addEntry(GitIndex.java:746)
    at 
org.spearce.jgit.lib.WorkDirCheckout.checkoutTwoTrees(WorkDirCheckout.java:146)
    at 
org.spearce.jgit.lib.WorkDirCheckout.checkout(WorkDirCheckout.java:137)
    at 
org.spearce.egit.core.op.BranchOperation.checkoutTree(BranchOperation.java:133)
    at org.spearce.egit.core.op.BranchOperation.run(BranchOperation.java:69)
    at 
org.spearce.egit.ui.internal.actions.BranchAction$1.run(BranchAction.java:58)
    at 
org.eclipse.jface.operation.ModalContext$ModalContextThread.run(ModalContext.java:121)

Any help would be appreciated.
Thanks,
Chris
