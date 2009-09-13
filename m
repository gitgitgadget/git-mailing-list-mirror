From: mr.gaffo@gmail.com
Subject: [PATCH JGit 12/19] moved info/packs into a constant
Date: Sun, 13 Sep 2009 13:44:28 -0500
Message-ID: <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-11-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu9Q-0004WC-T0
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbZIMSuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbZIMSuI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:50:08 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:50060 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbZIMSuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:50:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so7555460and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+MQ7iYtUuh/+ok2i0EKXO/rx2OtnBNwE+wKpF3YoiMI=;
        b=Q/8nx4XcfMJ4489ML+ndES7uLeo4X2fhHp4r1UdrikuHSqV644ZQq8TwZXULcxdTml
         VmRjgnuse0RdFtvBYduvGB9T1Jb1vEYBwZZCsn3rz3zbkvr+BcxBMU0kUM0tEeuyaD6B
         nTO7TDkcXAKP7Yxb/en5Kf84cR4fJACFzJkxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qiRQ0mgm/IIOSz2VhWwdDois9rak/fPB39Zu4gM8Z7TtVqU86imDC0HmN+4pblTIWd
         AHh4PNfNXBgNbE6/1MdvjIuaViHKucyUtVuNe9TQmWKIv2OMEmnNBEQuCmJa3xD53cSw
         +o1CLTNxMmHLsCvl69r+Zt4aOM/cnpSmlZcLk=
Received: by 10.101.213.5 with SMTP id p5mr5593754anq.1.1252867496336;
        Sun, 13 Sep 2009 11:44:56 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:56 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-12-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128397>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../org/spearce/jgit/lib/ObjectDirectoryTest.java  |    5 ++---
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +++
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
index 4ac62fa..b27f2f8 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/ObjectDirectoryTest.java
@@ -79,7 +79,7 @@ public void testListLocalPacksWhenThereIsAPack() throws Exception {
 		assertEquals(TEST_PACK.getName(), localPacks.get(0).getPackFile().getName());
 	}
 	
-	public void testUpdateInfoCacheCreatesPacksFile() throws Exception {
+	public void testUpdateInfoCacheCreatesPacksAndRefsFile() throws Exception {
 		createSamplePacksDir();
 
 		ObjectDirectory od = new ObjectDirectory(testDir);
@@ -87,7 +87,7 @@ public void testUpdateInfoCacheCreatesPacksFile() throws Exception {
 		od.updateInfoCache();
 		
 		String expectedContents = new PacksFileContentsCreator(od.listLocalPacks()).toString();
-		File packsFile = new File(od.getDirectory(), "info/packs");
+		File packsFile = new File(od.getDirectory(), Constants.CACHED_PACKS_FILE);
 
 		assertTrue(packsFile.exists());
 		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
@@ -103,7 +103,6 @@ public boolean deleteDir(File dir) {
                 }
             }
         }
-    
         // The directory is now empty so delete it
         return dir.delete();
     }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index 9afea67..2d78dda 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -224,6 +224,9 @@
 
 	/** Info refs folder */
 	public static final String INFO_REFS = "info/refs";
+	
+	/** cached packs file */
+	public static final String CACHED_PACKS_FILE = "info/packs"; 
 
 	/** Packed refs file */
 	public static final String PACKED_REFS = "packed-refs";
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 71536c9..f4251c1 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -517,6 +517,6 @@ boolean tryAgain(final long currLastModified) {
 
 	@Override
 	public void updateInfoCache() throws IOException {
-		new UpdateDirectoryBasedPacksInfoCache(this.listLocalPacks(), new File(this.infoDirectory, "packs")).execute();
+		new UpdateDirectoryBasedPacksInfoCache(this.listLocalPacks(), new File(this.getDirectory(), Constants.CACHED_PACKS_FILE)).execute();
 	}
 }
-- 
1.6.4.2
