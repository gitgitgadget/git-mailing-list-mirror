From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 2/2] Add a border to the refs tree in the branch dialog
Date: Sun, 11 Jan 2009 17:18:56 +0100
Message-ID: <1231690736-6452-2-git-send-email-robin.rosenberg@dewire.com>
References: <1231690736-6452-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jan 11 17:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM33S-0004gR-4k
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 17:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZAKQTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 11:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZAKQTI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 11:19:08 -0500
Received: from mail.dewire.com ([83.140.172.130]:14335 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbZAKQTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 11:19:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BE7E51484F7B;
	Sun, 11 Jan 2009 17:19:01 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMqQQmO1-E0s; Sun, 11 Jan 2009 17:19:00 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 997161484F78;
	Sun, 11 Jan 2009 17:19:00 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231690736-6452-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105191>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/dialogs/BranchSelectionDialog.java |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
index 8859b5d..db9adf0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/BranchSelectionDialog.java
@@ -87,7 +87,7 @@ protected Composite createDialogArea(Composite base) {
 		parent = (Composite) super.createDialogArea(base);
 		parent.setLayout(GridLayoutFactory.swtDefaults().create());
 		new Label(parent, SWT.NONE).setText(UIText.BranchSelectionDialog_Refs);
-		branchTree = new Tree(parent, SWT.NONE);
+		branchTree = new Tree(parent, SWT.BORDER);
 		branchTree.setLayoutData(GridDataFactory.fillDefaults().grab(true,true).hint(500, 300).create());
 
 		if (showResetType) {
-- 
1.6.1.rc3.56.gd0306
