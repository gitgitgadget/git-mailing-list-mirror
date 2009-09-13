From: mr.gaffo@gmail.com
Subject: [PATCH JGit 09/19] Didn't like the old name, this is more specific to it just updating the packs info cache
Date: Sun, 13 Sep 2009 13:44:25 -0500
Message-ID: <1252867475-858-10-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-6-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-7-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuBT-0004zi-Mb
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbZIMSwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbZIMSwN
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:52:13 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:36999 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbZIMSwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:52:12 -0400
Received: by yxe29 with SMTP id 29so3069255yxe.16
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jgJwdP0vyPmk0Mt6thyB747E6JAWTrtF5ngjdioyjzw=;
        b=tEiw4AhznUV+gjq5QfqZqxfkgUwdgHp1j7X273RTN+hOVfEwXqPg3SfWIE2T7BjhE6
         NUpQNr1BdFEPdHvivv1rt6WtjJFxi7XCPkUzeNt5OJ1XuGviz9aR5HBynuldp9mqyYaA
         KzCO96D6U2/f2/XlMZe+LY4rPajxVa8JlCh3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rlw4NcLzrahLCCvtA0szZlsrvzULVVE3Byf/tbIBMjbPITRYIzEo1+lBL/YmBxsxaT
         Pf+qpxy9WUdgU+jvXAnllmnVxhFeTMMPz8gnR/2UVkuRx1b7aDSnuD0qWypzmJIzJbL8
         Z7JY7XK8SGxxxtv8/QIFlG6tUukh0cgSkU824=
Received: by 10.100.235.21 with SMTP id i21mr5534339anh.96.1252867493050;
        Sun, 13 Sep 2009 11:44:53 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:52 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-9-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128400>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../UpdateDirectoryBasedPacksInfoCacheTest.java    |   30 ++++++++++++++++++++
 .../jgit/lib/UpdateDirectoryInfoCacheTest.java     |   30 --------------------
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    2 +-
 .../lib/UpdateDirectoryBasedPacksInfoCache.java    |   27 ++++++++++++++++++
 .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   27 ------------------
 5 files changed, 58 insertions(+), 58 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java
 delete mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java
new file mode 100644
index 0000000..f5163e4
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCacheTest.java
@@ -0,0 +1,30 @@
+package org.spearce.jgit.lib;
+
+import java.io.File;
+import java.util.ArrayList;
+import java.util.List;
+
+import junit.framework.TestCase;
+
+import org.spearce.jgit.util.JGitTestUtil;
+
+public class UpdateDirectoryBasedPacksInfoCacheTest extends TestCase {
+	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
+	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
+	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
+	
+	public void testCreatesTheFileAndPutsTheContentsIn() throws Exception {
+		List<PackFile> packs = new ArrayList<PackFile>();
+		packs.add(new PackFile(TEST_IDX, TEST_PACK));
+		
+		File packsFile = File.createTempFile(UpdateDirectoryBasedPacksInfoCacheTest.class.getSimpleName(), "tstdata");
+		packsFile.deleteOnExit();
+		
+		String expectedContents = new PacksFileContentsCreator(packs).toString();
+		
+		new UpdateDirectoryBasedPacksInfoCache(packs, packsFile).execute();
+		
+		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
+	}
+
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
deleted file mode 100644
index 25b78c5..0000000
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryInfoCacheTest.java
+++ /dev/null
@@ -1,30 +0,0 @@
-package org.spearce.jgit.lib;
-
-import java.io.File;
-import java.util.ArrayList;
-import java.util.List;
-
-import junit.framework.TestCase;
-
-import org.spearce.jgit.util.JGitTestUtil;
-
-public class UpdateDirectoryInfoCacheTest extends TestCase {
-	private static final String PACK_NAME = "pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f";
-	private static final File TEST_PACK = JGitTestUtil.getTestResourceFile(PACK_NAME + ".pack");
-	private static final File TEST_IDX = JGitTestUtil.getTestResourceFile(PACK_NAME + ".idx");
-	
-	public void testCreatesTheFileAndPutsTheContentsIn() throws Exception {
-		List<PackFile> packs = new ArrayList<PackFile>();
-		packs.add(new PackFile(TEST_IDX, TEST_PACK));
-		
-		File packsFile = File.createTempFile(UpdateDirectoryInfoCacheTest.class.getSimpleName(), "tstdata");
-		packsFile.deleteOnExit();
-		
-		String expectedContents = new PacksFileContentsCreator(packs).toString();
-		
-		new UpdateDirectoryInfoCache(packs, packsFile).execute();
-		
-		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packsFile));
-	}
-
-}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 95618b9..71536c9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -517,6 +517,6 @@ boolean tryAgain(final long currLastModified) {
 
 	@Override
 	public void updateInfoCache() throws IOException {
-		new UpdateDirectoryInfoCache(this.listLocalPacks(), new File(this.infoDirectory, "packs")).execute();
+		new UpdateDirectoryBasedPacksInfoCache(this.listLocalPacks(), new File(this.infoDirectory, "packs")).execute();
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
new file mode 100644
index 0000000..3e24cd2
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryBasedPacksInfoCache.java
@@ -0,0 +1,27 @@
+package org.spearce.jgit.lib;
+
+import java.io.BufferedWriter;
+import java.io.File;
+import java.io.FileOutputStream;
+import java.io.IOException;
+import java.util.List;
+
+public class UpdateDirectoryBasedPacksInfoCache {
+
+	private List<PackFile> packsList;
+	private File infoPacksFile;
+
+	public UpdateDirectoryBasedPacksInfoCache(List<PackFile> packsList,
+									File infoPacksFile) {
+		this.packsList = packsList;
+		this.infoPacksFile = infoPacksFile;
+	}
+
+	public void execute() throws IOException {
+		String packsContents = new PacksFileContentsCreator(packsList).toString();
+		FileOutputStream fos = new FileOutputStream(infoPacksFile);
+		fos.write(packsContents.getBytes());
+		fos.close();
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
deleted file mode 100644
index 72a315a..0000000
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCache.java
+++ /dev/null
@@ -1,27 +0,0 @@
-package org.spearce.jgit.lib;
-
-import java.io.BufferedWriter;
-import java.io.File;
-import java.io.FileOutputStream;
-import java.io.IOException;
-import java.util.List;
-
-public class UpdateDirectoryInfoCache {
-
-	private List<PackFile> packsList;
-	private File infoPacksFile;
-
-	public UpdateDirectoryInfoCache(List<PackFile> packsList,
-									File infoPacksFile) {
-		this.packsList = packsList;
-		this.infoPacksFile = infoPacksFile;
-	}
-
-	public void execute() throws IOException {
-		String packsContents = new PacksFileContentsCreator(packsList).toString();
-		FileOutputStream fos = new FileOutputStream(infoPacksFile);
-		fos.write(packsContents.getBytes());
-		fos.close();
-	}
-
-}
-- 
1.6.4.2
