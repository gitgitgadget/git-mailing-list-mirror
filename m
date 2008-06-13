From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v4 22/24] Formatted RepositoryTestCase.
Date: Fri, 13 Jun 2008 20:35:19 +0200
Message-ID: <1213382121-19786-22-git-send-email-florianskarten@web.de>
References: <4852BCCA.4030404@web.de>
Cc: Florian Koeberle <florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7EAV-0005zA-G9
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYFMSgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 14:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYFMSgR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:36:17 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33555 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYFMSff (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:35:35 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id B29E2E3F1F2B
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 20:35:34 +0200 (CEST)
Received: from [84.150.79.9] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E7a-0000eI-00; Fri, 13 Jun 2008 20:35:34 +0200
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <4852BCCA.4030404@web.de>
In-Reply-To: <4852BCCA.4030404@web.de>
References: <4852BCCA.4030404@web.de>
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX184+raRyAj9Qs/a32Sq8zqBEQInA7ragUP/f1Ys
	XqSM5iCymCa1ZkJ/MsfvVUnAN7aKlLHOnsbF3EINIL0dlZtkI3
	/VMTlSrMpVZoTGgjmJIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84924>

Signed-off-by: Florian Koeberle <florianskarten@web.de>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   22 ++++++++++---------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 14e7179..aae9ed6 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -113,8 +113,8 @@ public abstract class RepositoryTestCase extends TestCase {
 			throws IOException {
 		Reader r = new InputStreamReader(new FileInputStream(f), "ISO-8859-1");
 		char[] data = new char[(int) f.length()];
-		if (f.length() !=  r.read(data))
-			throw new IOException("Internal error reading file data from "+f);
+		if (f.length() != r.read(data))
+			throw new IOException("Internal error reading file data from " + f);
 		assertEquals(checkData, new String(data));
 	}
 
@@ -123,7 +123,7 @@ public abstract class RepositoryTestCase extends TestCase {
 	public void setUp() throws Exception {
 		super.setUp();
 		recursiveDelete(trashParent);
-		trash = new File(trashParent,"trash"+System.currentTimeMillis());
+		trash = new File(trashParent, "trash" + System.currentTimeMillis());
 		trash_git = new File(trash, ".git");
 
 		Runtime.getRuntime().addShutdownHook(new Thread() {
@@ -140,8 +140,7 @@ public abstract class RepositoryTestCase extends TestCase {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f",
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371",
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
-				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
-		};
+				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa" };
 		final File tst = new File("tst");
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
 		for (int k = 0; k < packs.length; k++) {
@@ -151,7 +150,8 @@ public abstract class RepositoryTestCase extends TestCase {
 					packs[k] + ".idx"));
 		}
 
-		copyFile(new File(tst, "packed-refs"), new File(trash_git,"packed-refs"));
+		copyFile(new File(tst, "packed-refs"), new File(trash_git,
+				"packed-refs"));
 
 		db.scanForPacks();
 	}
@@ -163,15 +163,17 @@ public abstract class RepositoryTestCase extends TestCase {
 
 	/**
 	 * Helper for creating extra empty repos
-	 *
+	 * 
 	 * @return a new empty git repository for testing purposes
-	 *
+	 * 
 	 * @throws IOException
 	 */
 	protected Repository createNewEmptyRepo() throws IOException {
-		File newTestRepo = new File(trashParent, "new"+System.currentTimeMillis()+"/.git");
+		File newTestRepo = new File(trashParent, "new"
+				+ System.currentTimeMillis() + "/.git");
 		assertFalse(newTestRepo.exists());
-		File unusedDir = new File(trashParent, "tmp"+System.currentTimeMillis());
+		File unusedDir = new File(trashParent, "tmp"
+				+ System.currentTimeMillis());
 		assertTrue(unusedDir.mkdirs());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
-- 
1.5.4.3
