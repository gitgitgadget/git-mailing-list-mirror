From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Revert "Fix commit id in egit test T0001_ConnectProviderOperationTest"
Date: Wed, 17 Dec 2008 01:07:18 +0100
Message-ID: <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com>
References: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 17 01:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCjzz-0002Ha-6J
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 01:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759970AbYLQAIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 19:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759801AbYLQAH3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 19:07:29 -0500
Received: from mail.dewire.com ([83.140.172.130]:4312 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759856AbYLQAH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 19:07:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BAA15147E51F;
	Wed, 17 Dec 2008 01:07:22 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pxzE8FUH7M87; Wed, 17 Dec 2008 01:07:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 15C3A147E525;
	Wed, 17 Dec 2008 01:07:20 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103299>

This reverts commit 61133091d5f22398828b350ff772165e9945db8a.

Bisect says this is the commit that failed, which is odd. Bad QA.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../op/T0001_ConnectProviderOperationTest.java     |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
index 0ce2d7f..aae1ef4 100644
--- a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
+++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
@@ -99,8 +99,9 @@ assertTrue("tree missing", new File(gitDir,
 				"objects/08/ccc3d91a14d337a45f355d3d63bd97fd5e4db9").exists());
 		assertTrue("tree missing", new File(gitDir,
 				"objects/9d/aeec817090098f05eeca858e3a552d78b0a346").exists());
+
 		assertTrue("commit missing", new File(gitDir,
-				"objects/09/6f1a84091b90b6d9fb12f95848da69496305c1").exists());
+				"objects/45/df73fd9abbc2c61620c036948b1157e4d21253").exists());
 
 		ConnectProviderOperation operation = new ConnectProviderOperation(
 				project.getProject(), null);
-- 
1.6.0.3.640.g6331a
