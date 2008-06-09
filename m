From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH] Add a Track toolbar icon for adding resources
Date: Tue, 10 Jun 2008 00:50:16 +0200
Message-ID: <1213051816-4046-8-git-send-email-robin.rosenberg.lists@dewire.com>
References: <1213051816-4046-1-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-2-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-3-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-4-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-5-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-6-git-send-email-robin.rosenberg.lists@dewire.com>
 <1213051816-4046-7-git-send-email-robin.rosenberg.lists@dewire.com>
Cc: spearce@spearce.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 00:54:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qGG-0001Eo-Mh
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbYFIWxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755762AbYFIWxh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:53:37 -0400
Received: from [83.140.172.130] ([83.140.172.130]:17240 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755620AbYFIWxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:53:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A5DF4800691;
	Tue, 10 Jun 2008 00:53:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ip+oLPAVsf1X; Tue, 10 Jun 2008 00:53:27 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 033411434DE1;
	Tue, 10 Jun 2008 00:53:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
In-Reply-To: <1213051816-4046-7-git-send-email-robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84439>

From: Robin Rosenberg <robin.rosenberg@dewire.com>

We already had a track action, but it was only available in the team menu. I had to choose a different
handler baseclass for this to work.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

diff --git a/org.spearce.egit.ui/icons/toolbar/trackd.png b/org.spearce.egit.ui/icons/toolbar/trackd.png
new file mode 100644
index 0000000000000000000000000000000000000000..1ae9b5abd05c69681dd34485336f366772d530b4
GIT binary patch
literal 387
zcmV-}0et?6P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003>Nkl<ZIE{^y
zKgz;D5XFBZifExXurY;bmkU_f*`@a`NzPzrZJ*9ku<-zr&PoJ9i7to;HjafDlDK|f
z9t`_u=DnGn-4#`(EW$AS4p!Bi0h+bXeh>s&L=Xg8wPjLODQ5P4-&$1#V6|GQh^UAt
zKz3flWHR{{7!HS0%vxM$$yt$#jbtMO%;)pm2$1$*u~_KobYeD}F`Z7e+wC$QkH3Vn
z<WwMvBJK5h3<d*gwHmkE4Py*Z6shNVwrYg;ExiREj|U>c^ZCq0#c_=1c>siAm^*E*
zg3IN?Znwj69M0!6Ns@3l9B8##0QkOd?MW)2s&qOX+U+)tMuU32PP5r0Ns?c@6qUc6
zB0m$C6DWf!fH8*6W<$T<=YGF)JRaHa_gt^nautk5BevUZ&S8wfah!hz<nx`^>$NVI
h%hchzuJs`m@dBk;vWC9IYJva&002ovPDHLkV1m>)t&RWy

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/toolbar/tracke.png b/org.spearce.egit.ui/icons/toolbar/tracke.png
new file mode 100644
index 0000000000000000000000000000000000000000..b06c26581caef5b7bcd0e2f5f49840a0d47835e7
GIT binary patch
literal 411
zcmV;M0c8G(P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0004ENkl<ZIE|%~
zPfG$(6vcmU97-&Of<UaGO+nPEpdbrd25xHQ$C;VW(6(KlK>`<%X@v+yo2*5-C<xSa
zqeGy0TMXLFIFitT%e(K-IrqGON<^3xmSv4D77<SX;*P<%X`14PX_}%3RT2^9uWT4b
zpeqd^pU;a@N|aIp;LiO}mPgwWNTpKBU)A4tliea(5GjZZAclBak3cDxk>dHPT%9d*
zdAcB_TqbY}ZZd!lP{<}_Z*3mgIH5lkrPr>a>J<vvq#UGgg4`&aTXF<+y9-K#z70f&
zt2*UJNISV@Sso)E2c4Qu>+Olz^$5MM3g5MNwAW7}u|)t3!w5W+p@8%uva*jJ+d&IA
z(59=Xa0QCZal9ck0PmIm=3}11sK9@q1K2f<X8D1+?Hb*-js4Li^xURp$0u`ec$DD&
zWyUj6vg0H+JAVqO!FO)l9n0-SeK@hT8)7MaJ@)hm_yIyFuY%3nKQ;gW002ovPDHLk
FV1l|%vu*$Y

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index c0cb735..64a88c3 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -14,7 +14,7 @@ DisconnectAction_tooltip=Disconnect the Git team provider.
 AssumeUnchangedAction_label=Assume unchanged
 AssumeUnchangedAction_tooltip=Assume selected folders/files are unchanged
 
-TrackAction_label=Track (Add)
+TrackAction_label=Track (&Add)
 TrackAction_tooltip=Track selected files/folders with Git.
 
 UntrackAction_label=Untrack (Remove)
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index e47d75a..611829a 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -240,6 +240,17 @@
 		       toolbarPath="org.spearce.egit.ui"
 		       tooltip="%ResetAction_tooltip">
 		</action>
+		<action
+		       class="org.spearce.egit.ui.internal.actions.Track"
+		       disabledIcon="icons/toolbar/trackd.png"
+		       icon="icons/toolbar/tracke.png"
+		       id="org.spearce.egit.ui.trackaction"
+		       label="%TrackAction_label"
+		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+		       style="push"
+		       toolbarPath="org.spearce.egit.ui"
+		       tooltip="Start tracking the selected resources">
+		</action>
       </actionSet>
    </extension>
 </plugin>
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Track.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Track.java
index 7622ee4..6588cca 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Track.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Track.java
@@ -8,10 +8,15 @@
  *******************************************************************************/
 package org.spearce.egit.ui.internal.actions;
 
-import java.util.List;
+import java.lang.reflect.InvocationTargetException;
+import java.util.Arrays;
 
-import org.eclipse.core.resources.IWorkspaceRunnable;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.jface.action.IAction;
+import org.eclipse.jface.dialogs.MessageDialog;
+import org.eclipse.jface.operation.IRunnableWithProgress;
 import org.spearce.egit.core.op.TrackOperation;
 
 /**
@@ -19,9 +24,32 @@ import org.spearce.egit.core.op.TrackOperation;
  *
  * @see TrackOperation
  */
-public class Track extends AbstractOperationAction {
-	protected IWorkspaceRunnable createOperation(final IAction act,
-			final List sel) {
-		return sel.isEmpty() ? null : new TrackOperation(sel);
+public class Track extends RepositoryAction {
+
+	@Override
+	public void run(IAction action) {
+		try {
+			final TrackOperation op = new TrackOperation(Arrays.asList(getSelectedResources()));
+			getTargetPart().getSite().getWorkbenchWindow().run(true, false, new IRunnableWithProgress() {
+
+				public void run(IProgressMonitor arg0) throws InvocationTargetException,
+						InterruptedException {
+					try {
+						op.run(arg0);
+					} catch (CoreException e) {
+						MessageDialog.openError(getShell(),"Track failed", e.getMessage());
+					}
+				}
+			});
+		} catch (InvocationTargetException e) {
+			MessageDialog.openError(getShell(),"Reset failed", e.getMessage());
+		} catch (InterruptedException e) {
+			MessageDialog.openError(getShell(),"Reset failed", e.getMessage());
+		}
+	}
+
+	@Override
+	public boolean isEnabled() {
+		return getSelectedAdaptables(getSelection(), IResource.class).length > 0;
 	}
 }
-- 
1.5.5.1.178.g1f811
