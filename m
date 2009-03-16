From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 04/10] Rename a parameter i PackWriter that hides another with the same name
Date: Mon, 16 Mar 2009 21:14:37 +0100
Message-ID: <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFV-0007z8-7r
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939AbZCPUO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758161AbZCPUO5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:14:57 -0400
Received: from mail.dewire.com ([83.140.172.130]:5263 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757831AbZCPUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:14:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 158C5138AD57;
	Mon, 16 Mar 2009 21:14:50 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wJPd5Kv7vWE; Mon, 16 Mar 2009 21:14:49 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0E7EE138AD5B;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113375>

---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 2183872..601ce71 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -447,7 +447,7 @@ public void preparePack(final Iterator<RevObject> objectsSource)
 	 * @param uninterestingObjects
 	 *            collection of objects to be marked as uninteresting (end
 	 *            points of graph traversal).
-	 * @param thin
+	 * @param packthin
 	 *            a boolean indicating whether writer may pack objects with
 	 *            delta base object not within set of objects to pack, but
 	 *            belonging to party repository (uninteresting/boundary) as
@@ -464,9 +464,9 @@ public void preparePack(final Iterator<RevObject> objectsSource)
 	public void preparePack(
 			final Collection<? extends ObjectId> interestingObjects,
 			final Collection<? extends ObjectId> uninterestingObjects,
-			final boolean thin, final boolean ignoreMissingUninteresting)
+			final boolean packthin, final boolean ignoreMissingUninteresting)
 			throws IOException {
-		this.thin = thin;
+		this.thin = packthin;
 		ObjectWalk walker = setUpWalker(interestingObjects,
 				uninterestingObjects, ignoreMissingUninteresting);
 		findObjectsToPack(walker);
-- 
1.6.1.285.g35d8b
