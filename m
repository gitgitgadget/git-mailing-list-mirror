From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 1/8] Drop unneeded code in unit tests
Date: Mon,  1 Dec 2008 00:40:28 +0100
Message-ID: <1228088435-23722-2-git-send-email-robin.rosenberg@dewire.com>
References: <20081127214916.GD23984@spearce.org>
 <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, fonseca@diku.dk,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Dec 01 00:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6vvf-0001xS-Up
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 00:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYK3Xkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 18:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbYK3Xko
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 18:40:44 -0500
Received: from mail.dewire.com ([83.140.172.130]:25191 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbYK3Xkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 18:40:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 2780214433E9;
	Mon,  1 Dec 2008 00:40:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xl9yXhuMojJW; Mon,  1 Dec 2008 00:40:37 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 0B1E51471C21;
	Mon,  1 Dec 2008 00:40:37 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
In-Reply-To: <1228088435-23722-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101987>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 9d7d133..e164faf 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -172,8 +172,6 @@ protected void tearDown() throws Exception {
 	protected Repository createNewEmptyRepo() throws IOException {
 		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
 		assertFalse(newTestRepo.exists());
-		File unusedDir = new File(trashParent, "tmp"+System.currentTimeMillis());
-		assertTrue(unusedDir.mkdirs());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
 		return newRepo;
-- 
1.6.0.3.640.g6331a
