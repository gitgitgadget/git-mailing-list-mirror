From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] Fix grammar nits in documentation and in code comments.
Date: Thu, 03 Jan 2008 15:18:07 +0100
Message-ID: <87wsqr802o.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 03 15:18:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAQu6-0002Q2-Fo
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 15:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbYACOSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 09:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYACOSK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 09:18:10 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:32929 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751975AbYACOSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 09:18:09 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B222317B5AC
	for <git@vger.kernel.org>; Thu,  3 Jan 2008 15:18:07 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7118317B5B4
	for <git@vger.kernel.org>; Thu,  3 Jan 2008 15:18:07 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4C36A58B6D; Thu,  3 Jan 2008 15:18:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69526>


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/i18n.txt |    2 +-
 builtin-blame.c        |    2 +-
 ident.c                |    2 +-
 merge-recursive.c      |    2 +-
 setup.c                |    2 +-
 sha1_file.c            |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index b95f99b..1e188e6 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -22,7 +22,7 @@ does not forbid it.  However, there are a few things to keep in
 mind.

 . `git-commit-tree` (hence, `git-commit` which uses it) issues
-  an warning if the commit log message given to it does not look
+  a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
   have i18n.commitencoding in `.git/config` file, like this:
diff --git a/builtin-blame.c b/builtin-blame.c
index d98caaf..9b4c02e 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -606,7 +606,7 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)

 /*
  * src typically is on-stack; we want to copy the information in it to
- * an malloced blame_entry that is already on the linked list of the
+ * a malloced blame_entry that is already on the linked list of the
  * scoreboard.  The origin of dst loses a refcnt while the origin of src
  * gains one.
  */
diff --git a/ident.c b/ident.c
index 892d77a..b839dcf 100644
--- a/ident.c
+++ b/ident.c
@@ -152,7 +152,7 @@ static int copy(char *buf, size_t size, int offset, const char *src)
 	/*
 	 * Copy the rest to the buffer, but avoid the special
 	 * characters '\n' '<' and '>' that act as delimiters on
-	 * a identification line
+	 * an identification line
 	 */
 	for (i = 0; i < len; i++) {
 		c = *src++;
diff --git a/merge-recursive.c b/merge-recursive.c
index 33ccc40..b34177d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -289,7 +289,7 @@ static int get_files_dirs(struct tree *tree)
 }

 /*
- * Returns a index_entry instance which doesn't have to correspond to
+ * Returns an index_entry instance which doesn't have to correspond to
  * a real cache entry in Git's index.
  */
 static struct stage_data *insert_stage_data(const char *path,
diff --git a/setup.c b/setup.c
index b59dbe7..adede16 100644
--- a/setup.c
+++ b/setup.c
@@ -140,7 +140,7 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
  * Test if it looks like we're at a git directory.
  * We want to see:
  *
- *  - either a objects/ directory _or_ the proper
+ *  - either an objects/ directory _or_ the proper
  *    GIT_OBJECT_DIRECTORY environment variable
  *  - a refs/ directory
  *  - either a HEAD symlink or a HEAD file that is formatted as
diff --git a/sha1_file.c b/sha1_file.c
index b0c2435..6583797 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -148,7 +148,7 @@ static void fill_sha1_path(char *pathbuf, const unsigned char *sha1)

 /*
  * NOTE! This returns a statically allocated buffer, so you have to be
- * careful about using it. Do a "xstrdup()" if you need to save the
+ * careful about using it. Do an "xstrdup()" if you need to save the
  * filename.
  *
  * Also note that this returns the location for creating.  Reading
--
1.5.4.rc2.7.gcb27
