From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: [EGIT PATCH 2/4] Change the find toolbar find-in prefs into radio rotating options.
Date: Sun, 23 Mar 2008 22:57:32 -0400
Message-ID: <1206327452-6500-1-git-send-email-rogersoares@intelinet.com.br>
Cc: robin.rosenberg@dewire.com,
	"Roger C. Soares" <rogersoares@intelinet.com.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 02:59:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdby6-000516-L2
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 02:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYCXB6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYCXB6l
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 21:58:41 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1383 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753696AbYCXB6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 21:58:39 -0400
Received: (qmail 4412 invoked by uid 0); 23 Mar 2008 23:01:06 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 1.992631 secs); 24 Mar 2008 02:01:06 -0000
Received: from unknown (HELO localhost.localdomain) (189.79.228.249)
  by cvxbsd.convex.com.br with SMTP; 24 Mar 2008 02:01:04 -0000
X-Mailer: git-send-email 1.5.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77991>

The find toolbar now searches only in one field at a time and the user
can change the find-in field by clicking on the button. The button shows
an icon so the user knows at all times what field is selected.

We don't have the option to find in all fields at the same time anymore,
but from day to day usage I noticed that I usually only want to search
in one field at a time. It feels a lot better to me and also makes it
more like gitk.

Signed-off-by: Roger C. Soares <rogersoares@intelinet.com.br>
---
 org.spearce.egit.ui/icons/elcl16/author.gif        |  Bin 0 -> 594 bytes
 org.spearce.egit.ui/icons/elcl16/comment.gif       |  Bin 0 -> 341 bytes
 org.spearce.egit.ui/icons/elcl16/commit.gif        |  Bin 0 -> 173 bytes
 org.spearce.egit.ui/icons/elcl16/committer.gif     |  Bin 0 -> 589 bytes
 .../src/org/spearce/egit/ui/FindToolbar.java       |  149 +++++++++++++++-----
 .../egit/ui/PluginPreferenceInitializer.java       |    5 +-
 .../src/org/spearce/egit/ui/UIIcons.java           |   12 ++
 .../src/org/spearce/egit/ui/UIPreferences.java     |    8 +-
 .../src/org/spearce/egit/ui/UIText.java            |    9 ++
 .../src/org/spearce/egit/ui/uitext.properties      |    5 +
 10 files changed, 141 insertions(+), 47 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/elcl16/author.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/comment.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/commit.gif
 create mode 100644 org.spearce.egit.ui/icons/elcl16/committer.gif

diff --git a/org.spearce.egit.ui/icons/elcl16/author.gif b/org.spearce.egit.ui/icons/elcl16/author.gif
new file mode 100644
index 0000000000000000000000000000000000000000..c4ae8cda9a848e562cd1574b6b797495e6d22836
GIT binary patch
literal 594
zcmZ?wbhEHb6krfwI2OU6V3??EmL+GAFK<<(;!vt-U!mn#uj|sH;ofH8*{SE<Wa!&$
z=-+7>Hqku1-!fu?b;LZUq}k5Nv)$6>`D8Ek$yrua>|b3RP+j6*T@p}N>K9SIuDRT|
zy~?Mj)@x$DM@rMS=}m5PTU{4*I4|#VTGQiDGjZ#Ne!DFbY};n->z;R{Xa1r7#m6Tv
zJ2rFm=~-(|&suwa*4hiR*Pfrf_QKpv*A{I)e`Qm~l}(vfH)XEaae2+2tGD*nY&`OK
z)6vHdPV}F+`r^*>?{}YnzxM)&e%ycY{r<}z4`2Ow^5*BWcR!!M`}yj_&$pj`z5Dd*
z!`I)RzW)9UB)|Rs{O$MGAHTo-`2GFo?;jxa=jX3K{|5*t{$yd~VyI`(VE_V9oG`Gj
zZ>Vo-ZfR}O=;-WdYY*@1H`l1w<4|i>4+#sM8D?#vA!^UmtQw@RtF0MqXKkj&G_6U+
zFEAj`KX9iGA2*v$ld`XsrRnmOLMFyq>`hAE-ah9q3ECJc2s9~r9X`53Q`pu}?MA)4
zhv$oz9?a5OA`DG(?stx9y0aKDHp{yG{r8V6K}6!nLXYhsE-gHX3z8Nn@H#ZGOw=fR
d)GW`*7JH)MAk*<a3B864hsKE~9UB=KtN}d*Uh4n=

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/comment.gif b/org.spearce.egit.ui/icons/elcl16/comment.gif
new file mode 100644
index 0000000000000000000000000000000000000000..0f6e19e604a7fa73e6b2fc3fcffe65a7ec309d03
GIT binary patch
literal 341
zcmZ?wbhEHb6krfwSZc@s1iXCwe0==!ib{$~%Jxn!{sDnLfx*EMQQ^_CF$qZt$*FNE
zY02rCNf}w01;xc>W!=+OPn*AZ&VmK=maks0eAR-LYZt9tvvU2WRU5Z#*?;)pkz*I{
zKECnb@%^`-p1k{X_4EJdUw*v!`t$9VZ?As*d;RnOo1cH*{QCdy_y3Q-|9|@Z@5}GM
zpa1;-_V@qKzyE*z|NrMdX+ZHO3nLeUJ%bL&Cm=sDuoWGcU*Mr5)qk|3=wu3)@`4p5
zQoS~gOD8=ER4Qb;JLxOC?OZ-7{wARf27bvJS|$byU055KTf3TrB)K%@IYpVoc{S^F
zxFvLSv}Bnk=+tSmDC^FeJ*!TdO>g0%MRfwg`YTqhtTR}<ZoNUF?`AKLZQI=(8LR<U
Cd%3;<

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/commit.gif b/org.spearce.egit.ui/icons/elcl16/commit.gif
new file mode 100644
index 0000000000000000000000000000000000000000..e0625b45deef1ee3687c0dd7e521b9b9bcc11435
GIT binary patch
literal 173
zcmZ?wbhEHb6krfwc+ATH2LD&CTzU2L|JOhNzxnn5-S7V&fB*md=l{3A|9}4d|Lgz%
zKmQRx@h1x-7Xv?o4oD-&3<j2{4<|iW%UEzv{H&_5qxE6voab$erazQ&;Mw!8^p3*<
z_5-!sH{8t&tL7<iihZB%qEO`7AYACFvcRdqv@oz@qs{v7n>6%O7>a)$%Ghq6XCApX
QaD8tfn@#@9U?m1?00Qk-fdBvi

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/elcl16/committer.gif b/org.spearce.egit.ui/icons/elcl16/committer.gif
new file mode 100644
index 0000000000000000000000000000000000000000..c31e9619e8f25d7b10396bcee4e058d938c5b43a
GIT binary patch
literal 589
zcmZ?wbhEHb6krfwI2Od9V3??EmL+GAFK<<(;!vt-U!mn#uj|sH;ofH8*{SE<Wa!&$
z=-+7>Hqku1-!fu?b;LZUq}k5Nv)$6>`D8Ek$ypXrzAmL{+xB|yjkQ)a6Sp4hRXfzD
zx_6Suu1S_J+Ld-sw%9$z^1vL~?s-QJFH$+YSiOJo@x#lt-_GMXy;A?!D$~bH^k=R<
zJ!|dxS!*xMUVDD_+6#xaSk2vZ?df{G6Fb8mZ?S#7Q|0wR)s06UZ#w$;^)dgCM?=1y
zw0M8o;q!H;FW0?JTz&ENX2PFaK7VfeeZ80X{ZYjC$4S2*W&eIs`txP!&sU8<Up4*u
zSoHhDwBKKQ{(M>U=gZo^zxMtgG(hnu3nLdpJ%bJd5P;%@fqhj&eN%HwYqN=px~h__
zNn4YllSg2Hw~LKoy$**|vzD{_lxa2+^`Z_;&5CBOex7#b8q)PrOmmy$9DNr}msaEB
zW>afY*cIsSHC;x?$UvF>$gvZr1TFN$1upKsY$GFVsV8-_{^;$KcbUbMMHp@!e=bwc
zqR-g;^!=%NE?w4UNp1TX5-$xOJGa^MxP1}cqU?O2(b#CokIxJqOiort8CN2lFSN3W
M$aTtya4=W{0B0msW&i*H

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
index 3d2472c..f744db7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/FindToolbar.java
@@ -58,6 +58,14 @@ import org.eclipse.team.core.history.IFileRevision;
  * @see GitHistoryPage
  */
 public class FindToolbar extends Composite {
+	private static final int PREFS_FINDIN_COMMITID = 1;
+
+	private static final int PREFS_FINDIN_COMMENTS = 2;
+
+	private static final int PREFS_FINDIN_AUTHOR = 4;
+
+	private static final int PREFS_FINDIN_COMMITTER = 5;
+
 	private Color errorBackgroundColor;
 
 	/**
@@ -69,10 +77,6 @@ public class FindToolbar extends Composite {
 
 	private List<Listener> eventList = new ArrayList<Listener>();
 
-	private Image nextIcon;
-
-	private Image previousIcon;
-
 	private Table historyTable;
 
 	private List<IFileRevision> fileRevisions;
@@ -89,6 +93,26 @@ public class FindToolbar extends Composite {
 
 	private String lastErrorPattern;
 
+	private MenuItem commitIdItem;
+
+	private MenuItem commentsItem;
+
+	private MenuItem authorItem;
+
+	private MenuItem committerItem;
+
+	private Image nextIcon;
+
+	private Image previousIcon;
+
+	private Image commitIdIcon;
+
+	private Image commentsIcon;
+
+	private Image authorIcon;
+
+	private Image committerIcon;
+
 	/**
 	 * Creates the toolbar.
 	 *
@@ -104,6 +128,10 @@ public class FindToolbar extends Composite {
 		errorBackgroundColor = new Color(getDisplay(), new RGB(255, 150, 150));
 		nextIcon = UIIcons.ELCL16_NEXT.createImage();
 		previousIcon = UIIcons.ELCL16_PREVIOUS.createImage();
+		commitIdIcon = UIIcons.ELCL16_COMMIT.createImage();
+		commentsIcon = UIIcons.ELCL16_COMMENTS.createImage();
+		authorIcon = UIIcons.ELCL16_AUTHOR.createImage();
+		committerIcon = UIIcons.ELCL16_COMMITTER.createImage();
 
 		GridLayout findLayout = new GridLayout();
 		findLayout.marginHeight = 2;
@@ -138,13 +166,13 @@ public class FindToolbar extends Composite {
 		final MenuItem caseItem = new MenuItem(prefsMenu, SWT.CHECK);
 		caseItem.setText("Ignore case");
 		new MenuItem(prefsMenu, SWT.SEPARATOR);
-		final MenuItem commitIdItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commitIdItem = new MenuItem(prefsMenu, SWT.RADIO);
 		commitIdItem.setText("Revision");
-		final MenuItem commentsItem = new MenuItem(prefsMenu, SWT.CHECK);
+		commentsItem = new MenuItem(prefsMenu, SWT.RADIO);
 		commentsItem.setText("Comments");
-		final MenuItem authorItem = new MenuItem(prefsMenu, SWT.CHECK);
+		authorItem = new MenuItem(prefsMenu, SWT.RADIO);
 		authorItem.setText("Author");
-		final MenuItem committerItem = new MenuItem(prefsMenu, SWT.CHECK);
+		committerItem = new MenuItem(prefsMenu, SWT.RADIO);
 		committerItem.setText("Committer");
 
 		prefsItem.addListener(SWT.Selection, new Listener() {
@@ -155,6 +183,22 @@ public class FindToolbar extends Composite {
 							+ itemBounds.height);
 					prefsMenu.setLocation(point);
 					prefsMenu.setVisible(true);
+				} else {
+					switch (prefs.getInt(UIPreferences.FINDTOOLBAR_FIND_IN)) {
+					case PREFS_FINDIN_COMMITID:
+						commentsItem.notifyListeners(SWT.Selection, null);
+						break;
+					case PREFS_FINDIN_COMMENTS:
+						authorItem.notifyListeners(SWT.Selection, null);
+						break;
+					case PREFS_FINDIN_AUTHOR:
+						committerItem.notifyListeners(SWT.Selection, null);
+						break;
+					case PREFS_FINDIN_COMMITTER:
+						commitIdItem.notifyListeners(SWT.Selection, null);
+						break;
+					}
+
 				}
 			}
 		});
@@ -249,13 +293,13 @@ public class FindToolbar extends Composite {
 
 			@Override
 			public void keyPressed(KeyEvent e) {
-				if(e.keyCode == SWT.ARROW_DOWN) {
-					if(nextButton.isEnabled()) {
+				if (e.keyCode == SWT.ARROW_DOWN) {
+					if (nextButton.isEnabled()) {
 						event.widget = nextButton;
 						findButtonsListener.handleEvent(event);
 					}
-				} else if(e.keyCode == SWT.ARROW_UP) {
-					if(previousButton.isEnabled()) {
+				} else if (e.keyCode == SWT.ARROW_UP) {
+					if (previousButton.isEnabled()) {
 						event.widget = previousButton;
 						findButtonsListener.handleEvent(event);
 					}
@@ -274,49 +318,78 @@ public class FindToolbar extends Composite {
 		caseItem.setSelection(prefs
 				.getBoolean(UIPreferences.FINDTOOLBAR_IGNORE_CASE));
 
+		int selectedPrefsItem = prefs.getInt(UIPreferences.FINDTOOLBAR_FIND_IN);
+
 		commitIdItem.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
-				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMIT_ID,
-						commitIdItem.getSelection());
-				Activator.getDefault().savePluginPreferences();
-				clear();
+				prefsItem.setImage(commitIdIcon);
+				prefsItem
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_comments);
+				prefsItemChanged(PREFS_FINDIN_COMMITID, commitIdItem);
 			}
 		});
-		commitIdItem.setSelection(prefs
-				.getBoolean(UIPreferences.FINDTOOLBAR_COMMIT_ID));
+		if (selectedPrefsItem == PREFS_FINDIN_COMMITID) {
+			commitIdItem.setSelection(true);
+			prefsItem.setImage(commitIdIcon);
+			prefsItem
+					.setToolTipText(UIText.ResourceHistory_findbar_changeto_comments);
+		}
 
 		commentsItem.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
-				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMENTS, commentsItem
-						.getSelection());
-				Activator.getDefault().savePluginPreferences();
-				clear();
+				prefsItem.setImage(commentsIcon);
+				prefsItem
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_author);
+				prefsItemChanged(PREFS_FINDIN_COMMENTS, commentsItem);
 			}
 		});
-		commentsItem.setSelection(prefs
-				.getBoolean(UIPreferences.FINDTOOLBAR_COMMENTS));
+		if (selectedPrefsItem == PREFS_FINDIN_COMMENTS) {
+			commentsItem.setSelection(true);
+			prefsItem.setImage(commentsIcon);
+			prefsItem
+					.setToolTipText(UIText.ResourceHistory_findbar_changeto_author);
+		}
 
 		authorItem.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
-				prefs.setValue(UIPreferences.FINDTOOLBAR_AUTHOR, authorItem
-						.getSelection());
-				Activator.getDefault().savePluginPreferences();
-				clear();
+				prefsItem.setImage(authorIcon);
+				prefsItem
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_committer);
+				prefsItemChanged(PREFS_FINDIN_AUTHOR, authorItem);
 			}
 		});
-		authorItem.setSelection(prefs
-				.getBoolean(UIPreferences.FINDTOOLBAR_AUTHOR));
+		if (selectedPrefsItem == PREFS_FINDIN_AUTHOR) {
+			authorItem.setSelection(true);
+			prefsItem.setImage(authorIcon);
+			prefsItem
+					.setToolTipText(UIText.ResourceHistory_findbar_changeto_committer);
+		}
 
 		committerItem.addSelectionListener(new SelectionAdapter() {
 			public void widgetSelected(SelectionEvent e) {
-				prefs.setValue(UIPreferences.FINDTOOLBAR_COMMITTER, committerItem
-						.getSelection());
-				Activator.getDefault().savePluginPreferences();
-				clear();
+				prefsItem.setImage(committerIcon);
+				prefsItem
+						.setToolTipText(UIText.ResourceHistory_findbar_changeto_commit);
+				prefsItemChanged(PREFS_FINDIN_COMMITTER, committerItem);
 			}
 		});
-		committerItem.setSelection(prefs
-				.getBoolean(UIPreferences.FINDTOOLBAR_COMMITTER));
+		if (selectedPrefsItem == PREFS_FINDIN_COMMITTER) {
+			committerItem.setSelection(true);
+			prefsItem.setImage(committerIcon);
+			prefsItem
+					.setToolTipText(UIText.ResourceHistory_findbar_changeto_commit);
+		}
+	}
+
+	private void prefsItemChanged(int findin, MenuItem item) {
+		prefs.setValue(UIPreferences.FINDTOOLBAR_FIND_IN, findin);
+		Activator.getDefault().savePluginPreferences();
+		commitIdItem.setSelection(false);
+		commentsItem.setSelection(false);
+		authorItem.setSelection(false);
+		committerItem.setSelection(false);
+		item.setSelection(true);
+		clear();
 	}
 
 	@Override
@@ -324,6 +397,10 @@ public class FindToolbar extends Composite {
 		errorBackgroundColor.dispose();
 		nextIcon.dispose();
 		previousIcon.dispose();
+		commitIdIcon.dispose();
+		commentsIcon.dispose();
+		authorIcon.dispose();
+		committerIcon.dispose();
 		super.dispose();
 	}
 
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
index ecb79b8..c8ca116 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceInitializer.java
@@ -43,10 +43,7 @@ public class PluginPreferenceInitializer extends AbstractPreferenceInitializer {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false);
 
 		prefs.setDefault(UIPreferences.FINDTOOLBAR_IGNORE_CASE, true);
-		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMIT_ID, true);
-		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMENTS, true);
-		prefs.setDefault(UIPreferences.FINDTOOLBAR_AUTHOR, false);
-		prefs.setDefault(UIPreferences.FINDTOOLBAR_COMMITTER, false);
+		prefs.setDefault(UIPreferences.FINDTOOLBAR_FIND_IN, 2);
 	}
 
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index 881265d..33edcec 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -46,6 +46,14 @@ public class UIIcons {
 	public static final ImageDescriptor ELCL16_NEXT;
 	/** Previous arrow icon */
 	public static final ImageDescriptor ELCL16_PREVIOUS;
+	/** Commit icon */
+	public static final ImageDescriptor ELCL16_COMMIT;
+	/** Comments icon */
+	public static final ImageDescriptor ELCL16_COMMENTS;
+	/** Author icon */
+	public static final ImageDescriptor ELCL16_AUTHOR;
+	/** Committer icon */
+	public static final ImageDescriptor ELCL16_COMMITTER;
 
 	private static final URL base;
 
@@ -59,6 +67,10 @@ public class UIIcons {
 		ELCL16_FIND = map("elcl16/find.gif");
 		ELCL16_NEXT = map("elcl16/next.gif");
 		ELCL16_PREVIOUS = map("elcl16/previous.gif");
+		ELCL16_COMMIT = map("elcl16/commit.gif");
+		ELCL16_COMMENTS = map("elcl16/comment.gif");
+		ELCL16_AUTHOR = map("elcl16/author.gif");
+		ELCL16_COMMITTER = map("elcl16/committer.gif");
 	}
 
 	private static ImageDescriptor map(final String icon) {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index cb9443b..2ff7589 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -34,11 +34,5 @@ public class UIPreferences {
 	/** */
 	public final static String FINDTOOLBAR_IGNORE_CASE = "findtoolbar_ignore_case";
 	/** */
-	public final static String FINDTOOLBAR_COMMIT_ID = "findtoolbar_commit_id";
-	/** */
-	public final static String FINDTOOLBAR_COMMENTS = "findtoolbar_comments";
-	/** */
-	public final static String FINDTOOLBAR_AUTHOR = "findtoolbar_author";
-	/** */
-	public final static String FINDTOOLBAR_COMMITTER = "findtoolbar_committer";
+	public final static String FINDTOOLBAR_FIND_IN = "findtoolbar_find_in";
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 1454124..318c12a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -62,6 +62,15 @@ public class UIText extends NLS {
 	/** */
 	public static String ResourceHistory_toggleTooltips;
 
+	/** */
+	public static String ResourceHistory_findbar_changeto_commit;
+	/** */
+	public static String ResourceHistory_findbar_changeto_comments;
+	/** */
+	public static String ResourceHistory_findbar_changeto_author;
+	/** */
+	public static String ResourceHistory_findbar_changeto_committer;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index be02978..7bbca5f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -33,3 +33,8 @@ ResourceHistory_toggleCommentWrap=Wrap Comments
 ResourceHistory_toggleRevDetail=Show Revision Details
 ResourceHistory_toggleRevComment=Show Revision Comment
 ResourceHistory_toggleTooltips=Show Revision Tooltip
+
+ResourceHistory_findbar_changeto_commit=Change to Revision
+ResourceHistory_findbar_changeto_comments=Change to Comments
+ResourceHistory_findbar_changeto_author=Change to Author
+ResourceHistory_findbar_changeto_committer=Change to Committer
-- 
1.5.4.1
