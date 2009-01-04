From: Alexander Potashev <aspotashev@gmail.com>
Subject: [PATCH] Replace deprecated dashed git commands in usage
Date: Sun,  4 Jan 2009 21:39:27 +0300
Message-ID: <1231094367-8831-1-git-send-email-aspotashev@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexander Potashev <aspotashev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 19:41:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJXv2-00009T-LG
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 19:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760265AbZADSjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbZADSje
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 13:39:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:43754 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760240AbZADSjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 13:39:32 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2513690fgg.17
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oZgBFSQ3LARLgYL/aCyAzQ03ycQjU7IXIQHFu9Bli1o=;
        b=DFS/MoMW6zx0B980XD6HVdGka4TPhmi0MLdYypdQsbhiqXbnvEuUDN/Yudm/MB6kcV
         /xqaXwM4ZpeXnvK9iwnEpocsTbgXZ+xvkUpP3h8pf57XR5lqAkDZcECzIRbxHCzMvkYN
         3uVrbIvwydzp8B382tzDQrMV+nXsGphQzwCE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aALyngGnVcw8w6AQoL1++fcq7NvNFN/ql6YuuSkmXbBx9HBCR2PgiwSPmoyCxNBFdF
         DqepVwmMgyDQwhU9bV+nLErrIr+NFCz8yRzGYEHaGwReeEuf9CDbCW4mF9MPebe1csga
         U0W8CRY7mQXsptPdVMjVBEBd1xM803ONIOkgA=
Received: by 10.86.84.5 with SMTP id h5mr11740749fgb.10.1231094369276;
        Sun, 04 Jan 2009 10:39:29 -0800 (PST)
Received: from localhost.localdomain (ppp91-78-207-99.pppoe.mtu-net.ru [91.78.207.99])
        by mx.google.com with ESMTPS id 4sm30312674fgg.24.2009.01.04.10.39.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 10:39:28 -0800 (PST)
X-Mailer: git-send-email 1.6.0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104533>

Signed-off-by: Alexander Potashev <aspotashev@gmail.com>
---
 builtin-merge.c        |    4 ++--
 builtin-receive-pack.c |    2 +-
 builtin-verify-pack.c  |    2 +-
 merge-index.c          |    2 +-
 merge-tree.c           |    2 +-
 mktag.c                |    2 +-
 mktree.c               |    2 +-
 patch-id.c             |    2 +-
 unpack-file.c          |    2 +-
 upload-pack.c          |    2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index cf86975..261a92e 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -36,8 +36,8 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	"git-merge [options] <remote>...",
-	"git-merge [options] <msg> HEAD <remote>",
+	"git merge [options] <remote>...",
+	"git merge [options] <msg> HEAD <remote>",
 	NULL
 };
 
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index db67c31..929df19 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -9,7 +9,7 @@
 #include "remote.h"
 #include "transport.h"
 
-static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
+static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
 enum deny_action {
 	DENY_IGNORE,
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 25a29f1..0ee0a9a 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -107,7 +107,7 @@ static int verify_one_pack(const char *path, int verbose)
 	return err;
 }
 
-static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
+static const char verify_pack_usage[] = "git verify-pack [-v] <pack>...";
 
 int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
diff --git a/merge-index.c b/merge-index.c
index 7827e87..a6e1921 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git-merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
 
 	setup_git_directory();
 	read_cache();
diff --git a/merge-tree.c b/merge-tree.c
index 2d1413e..4f567a4 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -3,7 +3,7 @@
 #include "xdiff-interface.h"
 #include "blob.h"
 
-static const char merge_tree_usage[] = "git-merge-tree <base-tree> <branch1> <branch2>";
+static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
 static int resolve_directories = 1;
 
 struct merge_list {
diff --git a/mktag.c b/mktag.c
index ba3d495..9a93ce2 100644
--- a/mktag.c
+++ b/mktag.c
@@ -157,7 +157,7 @@ int main(int argc, char **argv)
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
-		usage("git-mktag < signaturefile");
+		usage("git mktag < signaturefile");
 
 	setup_git_directory();
 
diff --git a/mktree.c b/mktree.c
index 514fd9b..0f98bc7 100644
--- a/mktree.c
+++ b/mktree.c
@@ -61,7 +61,7 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char mktree_usage[] = "git-mktree [-z]";
+static const char mktree_usage[] = "git mktree [-z]";
 
 int main(int ac, char **av)
 {
diff --git a/patch-id.c b/patch-id.c
index 871f1d2..429c3a2 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -72,7 +72,7 @@ static void generate_id_list(void)
 	flush_current_id(patchlen, sha1, &ctx);
 }
 
-static const char patch_id_usage[] = "git-patch-id < patch";
+static const char patch_id_usage[] = "git patch-id < patch";
 
 int main(int argc, char **argv)
 {
diff --git a/unpack-file.c b/unpack-file.c
index bcdc8bb..75c5f51 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -26,7 +26,7 @@ int main(int argc, char **argv)
 	unsigned char sha1[20];
 
 	if (argc != 2)
-		usage("git-unpack-file <sha1>");
+		usage("git unpack-file <sha1>");
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..24ab49d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,7 +11,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 
-static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
+static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
-- 
1.6.0.6
