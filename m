From: mr.gaffo@gmail.com
Subject: [PATCH JGit 19/19] changed \r to \n per compliance with real git
Date: Sun, 13 Sep 2009 13:44:35 -0500
Message-ID: <1252867475-858-20-git-send-email-mr.gaffo@gmail.com>
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
 <1252867475-858-13-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-14-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-15-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-16-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-17-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-18-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-19-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4n-0003Gw-GJ
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZIMSpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZIMSpN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:45:13 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:47904 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbZIMSpB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:45:01 -0400
Received: by mail-yw0-f174.google.com with SMTP id 4so3391282ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/yuMi6NGCS1pMCjZV4iRdtmHfqPA8w1RsqNpANXHFh8=;
        b=Uo8QworhpPWJxiTLeHnPqoOC3Py26/js1MDrSRLilumqKuHP3kzfnqIc6w5FPZfrwF
         jXo97guBUQ0Mv+XMULrMFjx4Xq5U28SJbTgHnyo0O7Y63HF4u7I5xUlWhyIrlrgbynrS
         TFyuBEmkIusqHFSzG64OdijppHi8tw6EMABGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZW+lLw05YZVTOoEUeBvrquzCtviOfucm9X8zRLqOnui7sOapY5d0yP8+PlgO8+ocLo
         J610NVVFJ8m25SQhvupDE4ytgFOSEC3sy4JYQctjpneJ0bj+bH6U8TX9oFXjsvkFl9fP
         wQIIfppLmQmj4IxMCIkarhyE/UGWXZRX3TU7w=
Received: by 10.101.148.37 with SMTP id a37mr386498ano.127.1252867505008;
        Sun, 13 Sep 2009 11:45:05 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.45.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:45:04 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-19-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128392>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/PacksFileContentsCreatorTest.java     |    9 +++++----
 .../spearce/jgit/lib/PacksFileContentsCreator.java |    3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
index 8dc9109..bf61a59 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/PacksFileContentsCreatorTest.java
@@ -53,7 +53,7 @@ public void testGettingPacksContentsSinglePack() throws Exception {
 		List<PackFile> packs = new ArrayList<PackFile>();
 		packs.add(new PackFile(TEST_IDX, TEST_PACK));
 		
-		assertEquals("P " + TEST_PACK.getName() + '\r', new PacksFileContentsCreator(packs).toString());
+		assertEquals("P " + TEST_PACK.getName() + "\n\n", new PacksFileContentsCreator(packs).toString());
 	}
 	
 	public void testGettingPacksContentsMultiplePacks() throws Exception {
@@ -63,9 +63,10 @@ public void testGettingPacksContentsMultiplePacks() throws Exception {
 		packs.add(new PackFile(TEST_IDX, TEST_PACK));
 		
 		StringBuilder expected = new StringBuilder();
-		expected.append("P ").append(TEST_PACK.getName()).append("\r");
-		expected.append("P ").append(TEST_PACK.getName()).append("\r");
-		expected.append("P ").append(TEST_PACK.getName()).append("\r");
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append("P ").append(TEST_PACK.getName()).append('\n');
+		expected.append('\n');
 		
 		assertEquals(expected.toString(), new PacksFileContentsCreator(packs).toString());
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
index 0efc244..e8b90a2 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
@@ -49,8 +49,9 @@ public PacksFileContentsCreator(List<PackFile> packs) {
 	public String toString(){
 		StringBuilder builder = new StringBuilder();
 		for (PackFile packFile : packs) {
-			builder.append("P ").append(packFile.getPackFile().getName()).append('\r');
+			builder.append("P ").append(packFile.getPackFile().getName()).append('\n');
 		}
+		builder.append('\n');
 		return builder.toString();
 	}
 
-- 
1.6.4.2
