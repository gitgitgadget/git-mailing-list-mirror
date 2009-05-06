From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [PATCH] Don't allow others to instantiate NullProgressMonitor
Date: Wed,  6 May 2009 21:41:26 +0100
Message-ID: <1241642486-7067-1-git-send-email-alex.blewitt@gmail.com>
Cc: git@vger.kernel.org, Alex Blewitt <alex.blewitt@gmail.com>
To: spearce@spearce.org, robin.rosenberg@dewire.com
X-From: git-owner@vger.kernel.org Wed May 06 22:43:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nxU-0007xX-Fi
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761422AbZEFUla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761417AbZEFUl3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:41:29 -0400
Received: from server.bandlem.com ([217.155.97.60]:47277 "EHLO
	apple.int.bandlem.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755875AbZEFUl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:41:27 -0400
Received: by apple.int.bandlem.com (Postfix, from userid 1000)
	id 035B5E263B; Wed,  6 May 2009 21:41:26 +0100 (BST)
X-Mailer: git-send-email 1.6.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118384>

---
 .../org/spearce/jgit/lib/NullProgressMonitor.java  |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java b/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
index 191dc00..1c30e6b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/NullProgressMonitor.java
@@ -45,6 +45,10 @@
 	/** Immutable instance of a null progress monitor. */
 	public static final NullProgressMonitor INSTANCE = new NullProgressMonitor();
 
+	private NullProgressMonitor() {
+		// Do not let others instantiate
+	}
+	
 	public void start(int totalTasks) {
 		// Do not report.
 	}
-- 
1.6.2.2
