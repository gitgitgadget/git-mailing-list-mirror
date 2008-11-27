From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 3/4] Cleanup malformed test cases
Date: Thu, 27 Nov 2008 22:15:34 +0100
Message-ID: <1227820535-9785-4-git-send-email-robin.rosenberg@dewire.com>
References: <1227820535-9785-1-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-2-git-send-email-robin.rosenberg@dewire.com>
 <1227820535-9785-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Nov 27 22:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5oEg-0006HN-9X
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 22:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYK0VPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 16:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYK0VPm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 16:15:42 -0500
Received: from mail.dewire.com ([83.140.172.130]:6573 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbYK0VPi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 16:15:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 97BC7147D53A;
	Thu, 27 Nov 2008 22:15:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qqf42L9lkYZS; Thu, 27 Nov 2008 22:15:36 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 21DF8147D535;
	Thu, 27 Nov 2008 22:15:36 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1227820535-9785-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101833>

---
 .../tst/org/spearce/jgit/lib/PackWriterTest.java   |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
index e5bce4d..3c02955 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackWriterTest.java
@@ -309,6 +309,7 @@ public void testWritePack4ThinPack() throws IOException {
 	public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 		testWritePack2();
 		final int sizePack2NoDeltas = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack2DeltasReuseRefs();
 		final int sizePack2DeltasRefs = cos.getCount();
@@ -327,6 +328,7 @@ public void testWritePack2SizeDeltasVsNoDeltas() throws Exception {
 	public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 		testWritePack2DeltasReuseRefs();
 		final int sizePack2DeltasRefs = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack2DeltasReuseOffsets();
 		final int sizePack2DeltasOffsets = cos.getCount();
@@ -344,6 +346,7 @@ public void testWritePack2SizeOffsetsVsRefs() throws Exception {
 	public void testWritePack4SizeThinVsNoThin() throws Exception {
 		testWritePack4();
 		final int sizePack4 = cos.getCount();
+		tearDown();
 		setUp();
 		testWritePack4ThinPack();
 		final int sizePack4Thin = cos.getCount();
-- 
1.6.0.3.640.g6331a
