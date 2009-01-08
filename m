From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/7] Create the import wizard question checkbox properly
Date: Thu,  8 Jan 2009 17:56:25 +0100
Message-ID: <1231433791-9267-2-git-send-email-robin.rosenberg@dewire.com>
References: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Jan 08 17:58:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyDO-0001ZY-94
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 17:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbZAHQ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756347AbZAHQ4o
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 11:56:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:25795 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756120AbZAHQ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 11:56:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CDB561484F48;
	Thu,  8 Jan 2009 17:56:38 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uUvwUGkuXAjI; Thu,  8 Jan 2009 17:56:32 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 941AD1484F6D;
	Thu,  8 Jan 2009 17:56:32 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231433791-9267-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104938>

This is necessary for good layout and to make the UI test work. Anyway, this
is the way checkboxes should be created.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/clone/CloneDestinationPage.java    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
index d017b60..a02b3a2 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/clone/CloneDestinationPage.java
@@ -173,9 +173,9 @@ public void modifyText(ModifyEvent e) {
 
 	private void createWorkbenchGroup(Composite parent) {
 		final Group g = createGroup(parent, "Workspace import");
-		newLabel(g, "Import projects after clone");
 		showImportWizard = new Button(g, SWT.CHECK);
 		showImportWizard.setSelection(true);
+		showImportWizard.setText("Import projects after clone");
 		showImportWizard.setLayoutData(createFieldGridData());
 		showImportWizard.addSelectionListener(new SelectionAdapter() {
 			@Override
-- 
1.6.1.rc3.56.gd0306
