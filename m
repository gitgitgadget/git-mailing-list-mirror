From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 07/10] Rename a parameter in PushProcessTest that hides another
Date: Mon, 16 Mar 2009 21:14:40 +0100
Message-ID: <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJFX-0007z8-TS
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758987AbZCPUPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758609AbZCPUPa
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:15:30 -0400
Received: from mail.dewire.com ([83.140.172.130]:5289 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757886AbZCPUP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:15:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1D292138AD5C;
	Mon, 16 Mar 2009 21:15:25 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mbFbvaPi0r9g; Mon, 16 Mar 2009 21:15:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id CF8F5138AD60;
	Mon, 16 Mar 2009 21:14:45 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113372>

---
 .../spearce/jgit/transport/PushProcessTest.java    |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
index eafd89c..ef9a8c8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/PushProcessTest.java
@@ -401,9 +401,9 @@ public void close() {
 		}
 
 		public void push(ProgressMonitor monitor,
-				Map<String, RemoteRefUpdate> refUpdates)
+				Map<String, RemoteRefUpdate> refsToUpdate)
 				throws TransportException {
-			for (final RemoteRefUpdate rru : refUpdates.values()) {
+			for (final RemoteRefUpdate rru : refsToUpdate.values()) {
 				assertEquals(Status.NOT_ATTEMPTED, rru.getStatus());
 				rru.setStatus(connectionUpdateStatus);
 			}
-- 
1.6.1.285.g35d8b
