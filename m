From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 1/2] "File/Import/Git Repository" showing a not ready yet warning.
Date: Sun, 10 Feb 2008 21:31:43 -0200
Message-ID: <1202686303-2868-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 00:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLlL-0002gh-LF
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYBJXi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbYBJXi1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:38:27 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1958 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752923AbYBJXiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 18:38:23 -0500
Received: (qmail 72573 invoked by uid 0); 10 Feb 2008 21:41:42 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.806322 secs); 10 Feb 2008 23:41:42 -0000
Received: from unknown (HELO localhost.localdomain) (201.68.3.109)
  by cvxbsd.convex.com.br with SMTP; 10 Feb 2008 23:41:40 -0000
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73437>

The warning explains how to proceed, so new users will know what to do.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 org.spearce.egit.ui/icons/etool16/import_wiz.gif   |  Bin 0 -> 602 bytes
 org.spearce.egit.ui/icons/wizban/import.png        |  Bin 0 -> 4739 bytes
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |   11 +++
 .../src/org/spearce/egit/ui/UIIcons.java           |    4 +
 .../egit/ui/internal/wizards/GitCloneWizard.java   |   83 ++++++++++++++++++++
 6 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/etool16/import_wiz.gif
 create mode 100644 org.spearce.egit.ui/icons/wizban/import.png
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java

diff --git a/org.spearce.egit.ui/icons/etool16/import_wiz.gif b/org.spearce.egit.ui/icons/etool16/import_wiz.gif
new file mode 100644
index 0000000000000000000000000000000000000000..57878582d7daad0d2ca76ccb9192b75d6587b1a4
GIT binary patch
literal 602
zcmZ?wbhEHb6krfwI2Opj8#9Zcfq}Q3*SKJ@alsOiE)j?F<?<8c6(=a3$zn5}Y5cU3
z?QX5u{W{TW%{-S{l>L_bU2apl+^!tDDl}$Y%$>=CNgI>WHm7B7$(*`y+oL(ckLHNx
zZp(czSG-_HLGjMwM~fuqu2^5TyX?_2kyWc#JX@jAe6V@r#`T>?IzMfczrS61*UniJ
zPE0tuXXeZ^Ghgnve0x;&!wKu(Cv{d|UH$vC?uYX>pRby3zrFqERhOSPe81iIJ@V+t
zw+E5m9z^|oS#aa^jazST{rr%6=k1-l@9zG7-~Ic2&!dlzo_~J+`s?dIKNi0I_V)ev
z_n&@z`u6MF_ut=t{Q2?w@9+PE2`K&(bS_FwEJ;mKD9<d(P;mG34Pa3G$->CRP|u*l
z00f|jVqjm?P~X(t(%P&qtspDPr{C73Wn}5;YHO;g)vsz|F=d)2XTOk?nWL3~GB-~@
zzoFf{>8slW*Lk|wOy}*_-LrS!z9#L!!-xI6j~v!Mcp^}bE6_>YJ@8b$dVrdYu(_O=
zmjt7{uX>Y;2cr_By#{Nb^{c>UMIR0UMspD+^Y=Rb^=$P{E;Ah;GE7i(?y+$E(SKk*
XkASk5NJ;}kgL^9v4+DdO0E0CEz8Ygu

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/wizban/import.png b/org.spearce.egit.ui/icons/wizban/import.png
new file mode 100644
index 0000000000000000000000000000000000000000..8f9fc202ca7c8870da720b5983d42cbc8a9edc16
GIT binary patch
literal 4739
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
Rl+^$L002ovPDHLkV1g)i1z-RG

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.ui/plugin.properties
index 7ae05ef..e84f860 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -1,6 +1,9 @@
 plugin_name=Git Team Provider (UI)
 provider_name=spearce.org
 
+Git_clone_category=Git
+Git_clone_wizard=Git Repository
+
 SharingWizard_name=Git
 PreferencePage_name=Git
 GitRemoteQuickDiffProvider_label=Latest Git Revision
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index b62c9d7..78dc6e1 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -5,6 +5,17 @@
       <initializer class="org.spearce.egit.ui.PluginPreferenceInitializer"/>
    </extension>
 
+   <extension point="org.eclipse.ui.importWizards">
+      <category name="%Git_clone_category"
+            id="org.spearce.egit.ui.internal.wizards.gitclonecategory"/>
+      <wizard name="%Git_clone_wizard"
+            icon="icons/etool16/import_wiz.gif"
+            class="org.spearce.egit.ui.internal.wizards.GitCloneWizard"
+            id="org.spearce.egit.ui.internal.wizards.GitCloneWizard"
+            category="org.spearce.egit.ui.internal.wizards.gitclonecategory">
+      </wizard>
+   </extension>
+
    <extension point="org.eclipse.team.ui.configurationWizards">
       <wizard name="%SharingWizard_name"
             icon="icons/sharing.gif"
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 881265d..9b568ce 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -47,6 +47,9 @@ public class UIIcons {
 	/** Previous arrow icon */
 	public static final ImageDescriptor ELCL16_PREVIOUS;
 
+	/** Import Wizard banner */
+	public static final ImageDescriptor WIZBAN_IMPORT_REPO;
+
 	private static final URL base;
 
 	static {
@@ -59,6 +62,7 @@ public class UIIcons {
 		ELCL16_FIND = map("elcl16/find.gif");
 		ELCL16_NEXT = map("elcl16/next.gif");
 		ELCL16_PREVIOUS = map("elcl16/previous.gif");
+		WIZBAN_IMPORT_REPO = map("wizban/import.png");
 	}
 
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java
new file mode 100644
index 0000000..e8ba87e
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/wizards/GitCloneWizard.java
@@ -0,0 +1,83 @@
+/*
+ *  Copyright (C) 2008  Roger C. Soares
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License, version 2.1, as published by the Free Software Foundation.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
+ */
+package org.spearce.egit.ui.internal.wizards;
+
+import org.eclipse.jface.viewers.IStructuredSelection;
+import org.eclipse.jface.wizard.Wizard;
+import org.eclipse.jface.wizard.WizardPage;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.layout.FillLayout;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Label;
+import org.eclipse.ui.IImportWizard;
+import org.eclipse.ui.IWorkbench;
+import org.spearce.egit.ui.UIIcons;
+
+/**
+ * Import Git Repository Wizard. A front end to a git clone operation.
+ */
+public class GitCloneWizard extends Wizard implements IImportWizard {
+	private WarningPage warning;
+
+	public void init(IWorkbench arg0, IStructuredSelection arg1) {
+		// Empty
+	}
+
+	@Override
+	public void addPages() {
+		warning = new WarningPage();
+		addPage(warning);
+	}
+
+	@Override
+	public boolean performFinish() {
+		return true;
+	}
+}
+
+class WarningPage extends WizardPage {
+	private Composite container;
+
+	/**
+	 * Warning message for new users alerting on how to use egit.
+	 */
+	public WarningPage() {
+		super("Warning Page", "Warning", UIIcons.WIZBAN_IMPORT_REPO);
+		setDescription("Git Import is not ready yet.");
+	}
+
+	public void createControl(Composite parent) {
+		container = new Composite(parent, SWT.NULL);
+		FillLayout layout = new FillLayout();
+		container.setLayout(layout);
+		Label label1 = new Label(container, SWT.NULL);
+		label1.setText("\nUse Git (THE Git) to create or clone your repo."
+				+ "\nSelect the project in the navigator and"
+				+ "\ngo to the context menu's Team item and"
+				+ "\nbelow it you will find \"Share Project\"."
+				+ "\nSelect it and the rest is self explanatory.");
+
+		setControl(container);
+		setPageComplete(false);
+	}
+
+	@Override
+	public Control getControl() {
+		return container;
+	}
+}
-- 
1.5.3.8
