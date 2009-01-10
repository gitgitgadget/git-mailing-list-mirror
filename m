From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/3] Present full name of file revision
Date: Sat, 10 Jan 2009 02:14:37 +0100
Message-ID: <1231550077-1057-4-git-send-email-robin.rosenberg@dewire.com>
References: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com>
 <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
 <1231550077-1057-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jan 10 02:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLSSR-0002Kg-MJ
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 02:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbZAJBOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 20:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbZAJBOt
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 20:14:49 -0500
Received: from mail.dewire.com ([83.140.172.130]:8476 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbZAJBOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 20:14:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C13C11484F6D;
	Sat, 10 Jan 2009 02:14:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLvml1hUwpnq; Sat, 10 Jan 2009 02:14:41 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 727DD1484F72;
	Sat, 10 Jan 2009 02:14:39 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc3.56.gd0306
In-Reply-To: <1231550077-1057-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105059>

The name need not be a path.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../core/internal/storage/GitFileRevision.java     |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
index 21ba19e..c762e2e 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
@@ -32,7 +32,7 @@
 
 	/**
 	 * Obtain a file revision for a specific blob of an existing commit.
-	 * 
+	 *
 	 * @param db
 	 *            the repository this commit was loaded out of, and that this
 	 *            file's blob should also be reachable through.
@@ -56,8 +56,7 @@ GitFileRevision(final String fileName) {
 	}
 
 	public String getName() {
-		final int last = path.lastIndexOf('/');
-		return last >= 0 ? path.substring(last + 1) : path;
+		return path;
 	}
 
 	public boolean isPropertyMissing() {
-- 
1.6.1.rc3.56.gd0306
