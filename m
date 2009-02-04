From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Resurrect group filtering options in history view
Date: Thu,  5 Feb 2009 00:23:19 +0100
Message-ID: <1233789799-24333-1-git-send-email-robin.rosenberg@dewire.com>
References: <1233787393-21023-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Feb 05 00:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUr6y-0006Jk-0i
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbZBDXXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756063AbZBDXXY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:23:24 -0500
Received: from mail.dewire.com ([83.140.172.130]:23318 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754710AbZBDXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:23:23 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C4576147E872;
	Thu,  5 Feb 2009 00:23:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tn+oxTl+gaBE; Thu,  5 Feb 2009 00:23:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4F031147E7FF;
	Thu,  5 Feb 2009 00:23:20 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1233787393-21023-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108462>

This commit restores the ability to filter on not only the selected
resource but instead all changes in the same folder, same project
or same repository. The flag is persistent.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Same thing, not not adding the NON-NLS stuff tof UIIcons and UIText. We
should use SuppressWarnings for those files.

-- robin
 org.spearce.egit.ui/icons/elcl16/filterfolder.gif  |  Bin 0 -> 153 bytes
 org.spearce.egit.ui/icons/elcl16/filterproject.gif |  Bin 0 -> 154 bytes
 org.spearce.egit.ui/icons/elcl16/filterrepo.gif    |  Bin 0 -> 322 bytes
 .../src/org/spearce/egit/ui/UIIcons.java           |   12 ++
 .../src/org/spearce/egit/ui/UIText.java            |    9 ++
 .../egit/ui/internal/history/GitHistoryPage.java   |  113 +++++++++++++++++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    4 +
 7 files changed, 134 insertions(+), 4 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterfolder.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterproject.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterrepo.gif

diff --git a/org.spearce.egit.ui/icons/elcl16/filterfolder.gif b/org.spearce.egit.ui/icons/elcl16/filterfolder.gif
new file mode 100644
index 0000000000000000000000000000000000000000..55843e768f2d5509d2b48a1f881fe69ffbe9d59a
GIT binary patch
literal 153
zcmZ?wbhEHb6krfw_{_lI8x<R#Qq$nT@Z&;7epyRu?UeGCSuw3kL%KKrxG~|!g9Sf6
zoM1o#ia%Kx85npNbU<PtGZ<LhCY<zKt$O)}SHl&tA`zFDjkB+KI$9<6DD0lRK&9Cx
w|InlVO;daqUU;k3<f62a=TlMhipj#pewK1>+9q0S16GPM?`iDS6=bjm0G<puSpWb4

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/filterproject.gif b/org.spearce.egit.ui/icons/elcl16/filterproject.gif
new file mode 100644
index 0000000000000000000000000000000000000000..a24b94dcfa75ff64da290f69c8b20d21886c7c11
GIT binary patch
literal 154
zcmZ?wbhEHb6krfw_{_lI8x<R#Qq$nT@Z&;7epyRu?Gy%v|K%;SVp^AmbZ=((|NqC0
z2|pez`0?Qc0~jd&WMO1r;A7AM@jzxUu()41>A70<^9`?tD`8C{E-xErU-5LbO6*hE
zJ^7$cvrWF+<Nr-ldJh^%@H%!UZZy!C$M*05=iP+9<5x~y<m&a(o^tK6K(z5R4hCxg
DA$>k#

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/filterrepo.gif b/org.spearce.egit.ui/icons/elcl16/filterrepo.gif
new file mode 100644
index 0000000000000000000000000000000000000000..c1cfa7bedc95329943acc214bf92e072059ad54b
GIT binary patch
literal 322
zcmZ?wbhEHb6krfw_^QU>8x<R#QnS6Ddt<HD-bo_6CtK{EV)=F+&!IlmgS~1m+LaD3
zQaQa+|JW+iLtCsKFVTOxUhnlzmB(9bUmsNccGBX+&al_V{J&iH`g6<Y&uzbtM?=0p
ziuign;p@G`-;c6?KPk;GYe}u0Qr<EvrgdpZ_vYUprv3l_pMiQn@h1x-1A{t)4#-H5
zpBUKU4@@rb(2;U<p16^NiDRnUB@LEURtvoogC$PzO+0d{DZsGOpYP0a=fXMClKjyH
zW-exvogc+Km~w+7ota-;fQ#A3MT)tVna9UZol#AUnOP_;C?rfhA~Jezx_ZJwS4ReG
E0D-q??*IS*

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 1697542..ced186e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -71,6 +71,15 @@
 	/** Connect Wizard banner */
 	public static final ImageDescriptor WIZBAN_CONNECT_REPO;
 
+	/** History filter, select all version in repo */
+	public static ImageDescriptor FILTERREPO;
+
+	/** History filter, select all version in same project */
+	public static ImageDescriptor FILTERPROJECT;
+
+	/** History filter, select all version in same folder */
+	public static ImageDescriptor FILTERFOLDER;
+
 	private static final URL base;
 
 	static {
@@ -97,6 +106,9 @@
 		CHECKBOX_ENABLED_UNCHECKED = map("checkboxes/enabled_unchecked.gif");
 		CHECKBOX_DISABLED_CHECKED = map("checkboxes/disabled_checked.gif");
 		CHECKBOX_DISABLED_UNCHECKED = map("checkboxes/disabled_unchecked.gif");
+		FILTERREPO = map("elcl16/filterrepo.gif");
+		FILTERPROJECT = map("elcl16/filterproject.gif");
+		FILTERFOLDER = map("elcl16/filterfolder.gif");
 	}
 
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 7a7d3ef..d74f53e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -913,6 +913,15 @@
 	/** */
 	public static String BranchSelectionDialog_Refs;
 
+	/** */
+	public static String HistoryPage_ShowAllVersionsForProject;
+
+	/** */
+	public static String HistoryPage_ShowAllVersionsForRepo;
+
+	/** */
+	public static String HistoryPage_ShowAllVersionsForFolder;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index d718cd7..08887c8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -1,5 +1,4 @@
 /*******************************************************************************
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
  * Copyright (C) 2008, Roger C. Soares <rogersoares@intelinet.com.br>
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
  *
@@ -27,6 +26,7 @@
 import org.eclipse.jface.action.IToolBarManager;
 import org.eclipse.jface.action.MenuManager;
 import org.eclipse.jface.action.Separator;
+import org.eclipse.jface.resource.ImageDescriptor;
 import org.eclipse.jface.text.ITextOperationTarget;
 import org.eclipse.jface.viewers.ISelection;
 import org.eclipse.jface.viewers.ISelectionChangedListener;
@@ -193,6 +193,98 @@ private static boolean typeOk(final IResource object) {
 	 */
 	private RevObjectSelectionProvider revObjectSelectionProvider;
 
+	private static final String PREF_SHOWALLFILTER = "org.spearce.egit.ui.githistorypage.showallfilter"; //$NON-NLS-1$
+
+	enum ShowFilter {
+		SHOWALLRESOURCE,
+		SHOWALLFOLDER,
+		SHOWALLPROJECT,
+		SHOWALLREPO,
+	}
+
+	class ShowFilterAction extends Action {
+		private final ShowFilter filter;
+
+		ShowFilterAction(ShowFilter filter, ImageDescriptor icon, String toolTipText) {
+			super(null, IAction.AS_CHECK_BOX);
+			this.filter = filter;
+			setImageDescriptor(icon);
+			setToolTipText(toolTipText);
+		}
+		@Override
+		public void run() {
+			if (!isChecked()) {
+				if (showAllFilter == filter) {
+					showAllFilter = ShowFilter.SHOWALLRESOURCE;
+					refresh();
+				}
+			}
+			if (isChecked() && showAllFilter != filter) {
+				showAllFilter = filter;
+				if (this != showAllRepoVersionsAction)
+					showAllRepoVersionsAction.setChecked(false);
+				if (this != showAllProjectVersionsAction)
+					showAllProjectVersionsAction.setChecked(false);
+				if (this != showAllFolderVersionsAction)
+					showAllFolderVersionsAction.setChecked(false);
+				refresh();
+			}
+			Activator.getDefault().getPreferenceStore().setValue(
+					PREF_SHOWALLFILTER, showAllFilter.toString());
+		}
+		@Override
+		public String toString() {
+			return "ShowFilter[" + filter.toString() + "]"; //$NON-NLS-1$ //$NON-NLS-2$
+		}
+	}
+
+	private ShowFilter showAllFilter = ShowFilter.SHOWALLRESOURCE;
+
+	private ShowFilterAction showAllRepoVersionsAction;
+
+	private ShowFilterAction showAllProjectVersionsAction;
+
+	private ShowFilterAction showAllFolderVersionsAction;
+
+	private void createResourceFilterActions() {
+		try {
+			showAllFilter = ShowFilter.valueOf(Activator.getDefault()
+					.getPreferenceStore().getString(PREF_SHOWALLFILTER));
+		} catch (IllegalArgumentException e) {
+			showAllFilter = ShowFilter.SHOWALLRESOURCE;
+		}
+
+		showAllRepoVersionsAction = new ShowFilterAction(
+				ShowFilter.SHOWALLREPO, UIIcons.FILTERREPO,
+				UIText.HistoryPage_ShowAllVersionsForRepo);
+
+		showAllProjectVersionsAction = new ShowFilterAction(
+				ShowFilter.SHOWALLPROJECT, UIIcons.FILTERPROJECT,
+				UIText.HistoryPage_ShowAllVersionsForProject);
+
+		showAllFolderVersionsAction = new ShowFilterAction(
+				ShowFilter.SHOWALLFOLDER, UIIcons.FILTERFOLDER,
+				UIText.HistoryPage_ShowAllVersionsForFolder);
+
+		showAllRepoVersionsAction
+				.setChecked(showAllFilter == showAllRepoVersionsAction.filter);
+		showAllProjectVersionsAction
+				.setChecked(showAllFilter == showAllProjectVersionsAction.filter);
+		showAllFolderVersionsAction
+				.setChecked(showAllFilter == showAllFolderVersionsAction.filter);
+
+		getSite().getActionBars().getToolBarManager().add(new Separator());
+
+		getSite().getActionBars().getToolBarManager().add(
+				showAllRepoVersionsAction);
+
+		getSite().getActionBars().getToolBarManager().add(
+				showAllProjectVersionsAction);
+
+		getSite().getActionBars().getToolBarManager().add(
+				showAllFolderVersionsAction);
+	}
+
 	@Override
 	public void createControl(final Composite parent) {
 		GridData gd;
@@ -227,6 +319,7 @@ public void createControl(final Composite parent) {
 		popupMgr = new MenuManager(null, POPUP_ID);
 		attachCommitSelectionChanged();
 		createLocalToolbarActions();
+		createResourceFilterActions();
 		createStandardActions();
 		createViewMenu();
 
@@ -566,9 +659,21 @@ public boolean inputSet() {
 			else if (db != map.getRepository())
 				return false;
 
-			final String name = map.getRepoRelativePath(r);
-			if (name != null && name.length() > 0)
-				paths.add(name);
+			if (showAllFilter == ShowFilter.SHOWALLFOLDER) {
+				final String name = map.getRepoRelativePath(r.getParent());
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			} else if (showAllFilter == ShowFilter.SHOWALLPROJECT) {
+				final String name = map.getRepoRelativePath(r.getProject());
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			} else if (showAllFilter == ShowFilter.SHOWALLREPO) {
+				// nothing
+			} else /*if (showAllFilter == ShowFilter.SHOWALLRESOURCE)*/ {
+				final String name = map.getRepoRelativePath(r);
+				if (name != null && name.length() > 0)
+					paths.add(name);
+			}
 		}
 
 		if (db == null)
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index a86e58b..52fa4f8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -199,6 +199,10 @@ HistoryPage_findbar_changeto_committer=Change to Committer
 HistoryPage_findbar_exceeded=Results limit exceeded
 HistoryPage_findbar_notFound=String not found
 
+HistoryPage_ShowAllVersionsForRepo=Show all versions for the repository containing the resource
+HistoryPage_ShowAllVersionsForProject=Show all versions for the project containing the resource
+HistoryPage_ShowAllVersionsForFolder=Show all versions for the folder containing the resource
+
 HistoryPreferencePage_title=Git
 
 PushAction_wrongURIDescription=Remote repositories URIs configuration is corrupted.
-- 
1.6.1.285.g35d8b
