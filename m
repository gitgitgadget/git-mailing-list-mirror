From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Resurrect group filtering options in history view
Date: Wed,  4 Feb 2009 23:43:13 +0100
Message-ID: <1233787393-21023-1-git-send-email-robin.rosenberg@dewire.com>
References: <20090201223920.GQ26880@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 04 23:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqUB-0000ZI-4w
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZBDWnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:43:21 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbZBDWnU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:43:20 -0500
Received: from mail.dewire.com ([83.140.172.130]:23090 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634AbZBDWnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:43:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 59911147E7FF;
	Wed,  4 Feb 2009 23:43:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZcIm9uq8YqSr; Wed,  4 Feb 2009 23:43:13 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id BE55F147E7DD;
	Wed,  4 Feb 2009 23:43:13 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <20090201223920.GQ26880@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108449>

This commit restores the ability to filter on not only the selected
resource but instead all changes in the same folder, same project
or same repository. The flag is persistent.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.egit.ui/icons/elcl16/filterfolder.gif  |  Bin 0 -> 153 byt=
es
 org.spearce.egit.ui/icons/elcl16/filterproject.gif |  Bin 0 -> 154 byt=
es
 org.spearce.egit.ui/icons/elcl16/filterrepo.gif    |  Bin 0 -> 322 byt=
es
 .../src/org/spearce/egit/ui/UIIcons.java           |   12 ++
 .../src/org/spearce/egit/ui/UIText.java            |   11 ++-
 .../egit/ui/internal/history/GitHistoryPage.java   |  115 ++++++++++++=
+++++++-
 .../src/org/spearce/egit/ui/uitext.properties      |    4 +
 7 files changed, 136 insertions(+), 6 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterfolder.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterproject.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/filterrepo.gif

s=C3=B6ndag 01 februari 2009 23:39:20 skrev Shawn O. Pearce:
> Shouldn't these filtering flag buttons be exclusive buttons,
> in the sense that only one can be depressed at a time, or none
> are depressed?
=46ixed.
> Also, the R/P/F labels are a bit too similar.  I know its what we
> had before, but these are blending too much to me visually and I
> keep reading the F as though it were a misdrawn R or P, like the
> box isn't big enough for it.  Which actually has me thinking that
> with the proportional width font on my workbench the F is using a
> narrower button box than the R or P, which looks funny.

How about these cute icons instead? They are shamelessy stolen from
other places in Eclipse and mis-treated using kolourpaint.

Btw, I think we have a case for open source mail programs that can disp=
lay
image patches inline.... Any takers? (I'm using KMail).

-- robin

diff --git a/org.spearce.egit.ui/icons/elcl16/filterfolder.gif b/org.sp=
earce.egit.ui/icons/elcl16/filterfolder.gif
new file mode 100644
index 0000000000000000000000000000000000000000..55843e768f2d5509d2b48a1=
f881fe69ffbe9d59a
GIT binary patch
literal 153
zcmZ?wbhEHb6krfw_{_lI8x<R#Qq$nT@Z&;7epyRu?UeGCSuw3kL%KKrxG~|!g9Sf6
zoM1o#ia%Kx85npNbU<PtGZ<LhCY<zKt$O)}SHl&tA`zFDjkB+KI$9<6DD0lRK&9Cx
w|InlVO;daqUU;k3<f62a=3DTlMhipj#pewK1>+9q0S16GPM?`iDS6=3Dbjm0G<puSpWb4

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/filterproject.gif b/org.s=
pearce.egit.ui/icons/elcl16/filterproject.gif
new file mode 100644
index 0000000000000000000000000000000000000000..a24b94dcfa75ff64da290f6=
9c8b20d21886c7c11
GIT binary patch
literal 154
zcmZ?wbhEHb6krfw_{_lI8x<R#Qq$nT@Z&;7epyRu?Gy%v|K%;SVp^AmbZ=3D((|NqC0
z2|pez`0?Qc0~jd&WMO1r;A7AM@jzxUu()41>A70<^9`?tD`8C{E-xErU-5LbO6*hE
zJ^7$cvrWF+<Nr-ldJh^%@H%!UZZy!C$M*05=3DiP+9<5x~y<m&a(o^tK6K(z5R4hCxg
DA$>k#

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/filterrepo.gif b/org.spea=
rce.egit.ui/icons/elcl16/filterrepo.gif
new file mode 100644
index 0000000000000000000000000000000000000000..c1cfa7bedc95329943acc21=
4bf92e072059ad54b
GIT binary patch
literal 322
zcmZ?wbhEHb6krfw_^QU>8x<R#QnS6Ddt<HD-bo_6CtK{EV)=3DF+&!IlmgS~1m+LaD3
zQaQa+|JW+iLtCsKFVTOxUhnlzmB(9bUmsNccGBX+&al_V{J&iH`g6<Y&uzbtM?=3D0p
ziuign;p@G`-;c6?KPk;GYe}u0Qr<EvrgdpZ_vYUprv3l_pMiQn@h1x-1A{t)4#-H5
zpBUKU4@@rb(2;U<p16^NiDRnUB@LEURtvoogC$PzO+0d{DZsGOpYP0a=3DfXMClKjyH
zW-exvogc+Km~w+7ota-;fQ#A3MT)tVna9UZol#AUnOP_;C?rfhA~Jezx_ZJwS4ReG
E0D-q??*IS*

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b=
/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 1697542..13749fa 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -71,6 +71,15 @@
 	/** Connect Wizard banner */
 	public static final ImageDescriptor WIZBAN_CONNECT_REPO;
=20
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
=20
 	static {
@@ -97,6 +106,9 @@
 		CHECKBOX_ENABLED_UNCHECKED =3D map("checkboxes/enabled_unchecked.gif=
");
 		CHECKBOX_DISABLED_CHECKED =3D map("checkboxes/disabled_checked.gif")=
;
 		CHECKBOX_DISABLED_UNCHECKED =3D map("checkboxes/disabled_unchecked.g=
if");
+		FILTERREPO =3D map("elcl16/filterrepo.gif"); //$NON-NLS-1$
+		FILTERPROJECT =3D map("elcl16/filterproject.gif"); //$NON-NLS-1$
+		FILTERFOLDER =3D map("elcl16/filterfolder.gif"); //$NON-NLS-1$
 	}
=20
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 7a7d3ef..d386482 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -913,8 +913,17 @@
 	/** */
 	public static String BranchSelectionDialog_Refs;
=20
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
-		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
+		initializeMessages(UIText.class.getPackage().getName() + ".uitext", =
//$NON-NLS-1$
 				UIText.class);
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/histo=
ry/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/in=
ternal/history/GitHistoryPage.java
index d718cd7..08b8d69 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitH=
istoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitH=
istoryPage.java
@@ -1,5 +1,4 @@
 /*********************************************************************=
**********
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
@@ -96,7 +96,7 @@
=20
 	/**
 	 * Determine if the input can be shown in this viewer.
-	 *=20
+	 *
 	 * @param object
 	 *            an object that is hopefully of type ResourceList or IRe=
source,
 	 *            but may be anything (including null).
@@ -193,6 +193,98 @@ private static boolean typeOk(final IResource obje=
ct) {
 	 */
 	private RevObjectSelectionProvider revObjectSelectionProvider;
=20
+	private static final String PREF_SHOWALLFILTER =3D "org.spearce.egit.=
ui.githistorypage.showallfilter"; //$NON-NLS-1$
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
+		ShowFilterAction(ShowFilter filter, ImageDescriptor icon, String too=
lTipText) {
+			super(null, IAction.AS_CHECK_BOX);
+			this.filter =3D filter;
+			setImageDescriptor(icon);
+			setToolTipText(toolTipText);
+		}
+		@Override
+		public void run() {
+			if (!isChecked()) {
+				if (showAllFilter =3D=3D filter) {
+					showAllFilter =3D ShowFilter.SHOWALLRESOURCE;
+					refresh();
+				}
+			}
+			if (isChecked() && showAllFilter !=3D filter) {
+				showAllFilter =3D filter;
+				if (this !=3D showAllRepoVersionsAction)
+					showAllRepoVersionsAction.setChecked(false);
+				if (this !=3D showAllProjectVersionsAction)
+					showAllProjectVersionsAction.setChecked(false);
+				if (this !=3D showAllFolderVersionsAction)
+					showAllFolderVersionsAction.setChecked(false);
+				refresh();
+			}
+			Activator.getDefault().getPreferenceStore().setValue(
+					PREF_SHOWALLFILTER, showAllFilter.toString());
+		}
+		@Override
+		public String toString() {
+			return "ShowFilter[" + filter.toString() + "]"; //$NON-NLS-1$ //$NO=
N-NLS-2$
+		}
+	}
+
+	private ShowFilter showAllFilter =3D ShowFilter.SHOWALLRESOURCE;
+
+	private ShowFilterAction showAllRepoVersionsAction;
+
+	private ShowFilterAction showAllProjectVersionsAction;
+
+	private ShowFilterAction showAllFolderVersionsAction;
+
+	private void createResourceFilterActions() {
+		try {
+			showAllFilter =3D ShowFilter.valueOf(Activator.getDefault()
+					.getPreferenceStore().getString(PREF_SHOWALLFILTER));
+		} catch (IllegalArgumentException e) {
+			showAllFilter =3D ShowFilter.SHOWALLRESOURCE;
+		}
+
+		showAllRepoVersionsAction =3D new ShowFilterAction(
+				ShowFilter.SHOWALLREPO, UIIcons.FILTERREPO,
+				UIText.HistoryPage_ShowAllVersionsForRepo);
+
+		showAllProjectVersionsAction =3D new ShowFilterAction(
+				ShowFilter.SHOWALLPROJECT, UIIcons.FILTERPROJECT,
+				UIText.HistoryPage_ShowAllVersionsForProject);
+
+		showAllFolderVersionsAction =3D new ShowFilterAction(
+				ShowFilter.SHOWALLFOLDER, UIIcons.FILTERFOLDER,
+				UIText.HistoryPage_ShowAllVersionsForFolder);
+
+		showAllRepoVersionsAction
+				.setChecked(showAllFilter =3D=3D showAllRepoVersionsAction.filter)=
;
+		showAllProjectVersionsAction
+				.setChecked(showAllFilter =3D=3D showAllProjectVersionsAction.filt=
er);
+		showAllFolderVersionsAction
+				.setChecked(showAllFilter =3D=3D showAllFolderVersionsAction.filte=
r);
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
 		popupMgr =3D new MenuManager(null, POPUP_ID);
 		attachCommitSelectionChanged();
 		createLocalToolbarActions();
+		createResourceFilterActions();
 		createStandardActions();
 		createViewMenu();
=20
@@ -566,9 +659,21 @@ public boolean inputSet() {
 			else if (db !=3D map.getRepository())
 				return false;
=20
-			final String name =3D map.getRepoRelativePath(r);
-			if (name !=3D null && name.length() > 0)
-				paths.add(name);
+			if (showAllFilter =3D=3D ShowFilter.SHOWALLFOLDER) {
+				final String name =3D map.getRepoRelativePath(r.getParent());
+				if (name !=3D null && name.length() > 0)
+					paths.add(name);
+			} else if (showAllFilter =3D=3D ShowFilter.SHOWALLPROJECT) {
+				final String name =3D map.getRepoRelativePath(r.getProject());
+				if (name !=3D null && name.length() > 0)
+					paths.add(name);
+			} else if (showAllFilter =3D=3D ShowFilter.SHOWALLREPO) {
+				// nothing
+			} else /*if (showAllFilter =3D=3D ShowFilter.SHOWALLRESOURCE)*/ {
+				final String name =3D map.getRepoRelativePath(r);
+				if (name !=3D null && name.length() > 0)
+					paths.add(name);
+			}
 		}
=20
 		if (db =3D=3D null)
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index a86e58b..52fa4f8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -199,6 +199,10 @@ HistoryPage_findbar_changeto_committer=3DChange to=
 Committer
 HistoryPage_findbar_exceeded=3DResults limit exceeded
 HistoryPage_findbar_notFound=3DString not found
=20
+HistoryPage_ShowAllVersionsForRepo=3DShow all versions for the reposit=
ory containing the resource
+HistoryPage_ShowAllVersionsForProject=3DShow all versions for the proj=
ect containing the resource
+HistoryPage_ShowAllVersionsForFolder=3DShow all versions for the folde=
r containing the resource
+
 HistoryPreferencePage_title=3DGit
=20
 PushAction_wrongURIDescription=3DRemote repositories URIs configuratio=
n is corrupted.
--=20
1.6.1.285.g35d8b
