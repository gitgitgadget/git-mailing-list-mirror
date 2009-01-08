From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/7] Fix two strings in the cloning wizard that were not translated.
Date: Thu,  8 Jan 2009 17:56:26 +0100
Message-ID: <1231433791-9267-3-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
 <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDL-0001ZY-G8
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbZAHQ4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754978AbZAHQ4h
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:37 -0500
Received: from mail.dewire.com ([83.140.172.130]:25773 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685AbZAHQ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 396851484F76;
	Thu,  8 Jan 2009 17:56:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxqBI+sYZOtM; Thu,  8 Jan 2009 17:56:33 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B00431484F6F;
	Thu,  8 Jan 2009 17:56:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104939>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    6 ++++++
 .../ui/internal/clone/CloneDestinationPage.java    |    4 ++--
 .../src/org/spearce/egit/ui/uitext.properties      |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 124d7a0..30122d2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -218,6 +218,12 @@
 	public static String CloneDestinationPage_errorNotEmptyDir;
 
 	/** */
+	public static String CloneDestinationPage_workspaceImport;
+
+	/** */
+	public static String CloneDestinationPage_importProjectsAfterClone;
+
+	/** */
 	public static String RefSpecPanel_refChooseSome;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index a02b3a2..16f9773 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -172,10 +172,10 @@ public void modifyText(ModifyEvent e) {
 	}
 
 	private void createWorkbenchGroup(Composite parent) {
-		final Group g = createGroup(parent, "Workspace import");
+		final Group g = createGroup(parent, UIText.CloneDestinationPage_workspaceImport);
 		showImportWizard = new Button(g, SWT.CHECK);
 		showImportWizard.setSelection(true);
-		showImportWizard.setText("Import projects after clone");
+		showImportWizard.setText(UIText.CloneDestinationPage_importProjectsAfterClone);
 		showImportWizard.setLayoutData(createFieldGridData());
 		showImportWizard.addSelectionListener(new SelectionAdapter() {
 			@Override
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 98ce80f..7f2e4b0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -90,6 +90,8 @@ CloneDestinationPage_promptRemoteName=Remote name
 CloneDestinationPage_fieldRequired={0} is required.
 CloneDestinationPage_browseButton=Browse
 CloneDestinationPage_errorNotEmptyDir={0} is not an empty directory.
+CloneDestinationPage_importProjectsAfterClone=&Import projects after clone
+CloneDestinationPage_workspaceImport=Workspace import
 
 RefSpecPanel_clickToChange=[Click to change]
 RefSpecPanel_columnDst=Destination Ref
-- 
1.6.1.rc3.56.gd0306
