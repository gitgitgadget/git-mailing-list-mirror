From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: [PATCH 1/5] Header includes cleanup
Date: Mon, 30 Mar 2009 02:55:21 -0700
Message-ID: <1238406925-15907-2-git-send-email-nathaniel.dawson@gmail.com>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:57:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoEFE-0001ZQ-O8
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758399AbZC3Jzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:55:41 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758334AbZC3Jzk
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:55:40 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:36956 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755477AbZC3Jzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 05:55:33 -0400
Received: by an-out-0708.google.com with SMTP id d14so1536958and.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PWdmh35P3o4NAEcKNuBj1KqfURDgsa0ZTmOOwAVOkF0=;
        b=ZqdHi63y92e8m4DEA+G9Jnn3Ei51wA96RlL8ttW86sBsK0/2ul0pEHcB+l7HJiEPnD
         6UfoY07MhFTuKv9B+XA7xqlxuUunXgIv+b0P6Km601QU/aEPsxWhZJTTDkUIDkbNn/8y
         UTKkYJ2YXFqQQjaI3p8XdQELOhZ1uhF0KnzEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WZWKSAO8Ga9zSNCZwgBb9sRbUwuyQrfb7U4Oc1r9kaMHy6FHwB6s9qbKs+ANJJIH7g
         NDYY1vEQEt29JOekW/A6p/APEmKXjQOZOoK/Jq2WOrrPTJM2/vYxwAPfS7zaJ+4qgEHU
         mzDQlSyfrl9leivDyZKLo41D/PfZoQxkOnfn4=
Received: by 10.101.1.16 with SMTP id d16mr3757436ani.111.1238406930838;
        Mon, 30 Mar 2009 02:55:30 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id d12sm9538752and.24.2009.03.30.02.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 02:55:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.3
In-Reply-To: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115124>

Deleted all header includes of git-compat-util.h, strbuf.h, cache.h, an=
d commit.h where builtin.h was already included since builtin.h include=
s them.

Signed-off-by: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
---
 builtin-add.c              |    1 -
 builtin-annotate.c         |    1 -
 builtin-apply.c            |    5 ++---
 builtin-archive.c          |    1 -
 builtin-blame.c            |    3 ---
 builtin-branch.c           |    5 +----
 builtin-bundle.c           |    1 -
 builtin-cat-file.c         |    3 +--
 builtin-check-attr.c       |    1 -
 builtin-check-ref-format.c |    3 +--
 builtin-checkout-index.c   |    1 -
 builtin-checkout.c         |    4 +---
 builtin-clean.c            |    1 -
 builtin-commit-tree.c      |    4 +---
 builtin-commit.c           |    5 +----
 builtin-config.c           |    1 -
 builtin-count-objects.c    |    3 +--
 builtin-describe.c         |    4 +---
 builtin-diff-files.c       |    4 +---
 builtin-diff-index.c       |    4 +---
 builtin-diff-tree.c        |    4 +---
 builtin-diff.c             |    6 ++----
 builtin-fast-export.c      |    2 --
 builtin-fetch--tool.c      |    2 --
 builtin-fetch.c            |    4 +---
 builtin-fmt-merge-msg.c    |    2 --
 builtin-for-each-ref.c     |    6 ++----
 builtin-fsck.c             |    2 --
 builtin-gc.c               |    1 -
 builtin-grep.c             |    4 +---
 builtin-help.c             |    1 -
 builtin-init-db.c          |    1 -
 builtin-log.c              |    4 +---
 builtin-ls-files.c         |    3 +--
 builtin-ls-remote.c        |    1 -
 builtin-ls-tree.c          |    4 +---
 builtin-mailinfo.c         |    2 --
 builtin-mailsplit.c        |    1 -
 builtin-merge-base.c       |    2 --
 builtin-merge-file.c       |    1 -
 builtin-merge-ours.c       |    1 -
 builtin-merge.c            |    4 +---
 builtin-mv.c               |    1 -
 builtin-name-rev.c         |    2 --
 builtin-pack-objects.c     |    2 --
 builtin-prune-packed.c     |    1 -
 builtin-prune.c            |    4 +---
 builtin-push.c             |    3 +--
 builtin-read-tree.c        |    3 +--
 builtin-reflog.c           |    2 --
 builtin-rerere.c           |    1 -
 builtin-rev-list.c         |    6 ++----
 builtin-revert.c           |    2 --
 builtin-rm.c               |    1 -
 builtin-shortlog.c         |    2 --
 builtin-show-branch.c      |    4 +---
 builtin-show-ref.c         |    1 -
 builtin-stripspace.c       |    1 -
 builtin-symbolic-ref.c     |    1 -
 builtin-tag.c              |    1 -
 builtin-tar-tree.c         |    2 --
 builtin-unpack-objects.c   |    2 --
 builtin-update-index.c     |    3 +--
 builtin-update-ref.c       |    3 +--
 builtin-upload-archive.c   |    1 -
 builtin-verify-pack.c      |    1 -
 builtin-verify-tag.c       |    1 -
 builtin-write-tree.c       |    1 -
 diff-no-index.c            |    4 +---
 fast-import.c              |    2 --
 git.c                      |    1 -
 help.c                     |    1 -
 merge-recursive.c          |    6 ++----
 73 files changed, 34 insertions(+), 145 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index cb67d2c..4d61e72 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#include "cache.h"
 #include "builtin.h"
 #include "dir.h"
 #include "exec_cmd.h"
diff --git a/builtin-annotate.c b/builtin-annotate.c
index fc43eed..0a259a3 100644
--- a/builtin-annotate.c
+++ b/builtin-annotate.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) 2006 Ryan Anderson
  */
-#include "git-compat-util.h"
 #include "builtin.h"
=20
 int cmd_annotate(int argc, const char **argv, const char *prefix)
diff --git a/builtin-apply.c b/builtin-apply.c
index 1926cd8..356db67 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -6,12 +6,11 @@
  * This applies patches on top of some (arbitrary) version of the SCM.
  *
  */
-#include "cache.h"
+#include "builtin.h"
+#include "blob.h"
 #include "cache-tree.h"
 #include "quote.h"
-#include "blob.h"
 #include "delta.h"
-#include "builtin.h"
 #include "string-list.h"
 #include "dir.h"
 #include "parse-options.h"
diff --git a/builtin-archive.c b/builtin-archive.c
index ab50ceb..f293d40 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "parse-options.h"
diff --git a/builtin-blame.c b/builtin-blame.c
index 83141fc..a91d350 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -3,11 +3,8 @@
  *
  * Copyright (c) 2006, Junio C Hamano
  */
-
-#include "cache.h"
 #include "builtin.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
 #include "diff.h"
diff --git a/builtin-branch.c b/builtin-branch.c
index 07a440e..2cb22c7 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -4,12 +4,9 @@
  * Copyright (c) 2006 Kristian H=C3=B8gsberg <krh@redhat.com>
  * Based on git-branch.sh by Junio C Hamano.
  */
-
-#include "cache.h"
+#include "builtin.h"
 #include "color.h"
 #include "refs.h"
-#include "commit.h"
-#include "builtin.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 9b58152..b36456e 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "bundle.h"
=20
 /*
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 8fad19d..70c9bda 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -3,11 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "exec_cmd.h"
 #include "tag.h"
 #include "tree.h"
-#include "builtin.h"
 #include "parse-options.h"
=20
 #define BATCH 1
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 15a04b7..c8f0cb3 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "attr.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 701de43..5289580 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -2,9 +2,8 @@
  * GIT - The information manager from hell
  */
=20
-#include "cache.h"
-#include "refs.h"
 #include "builtin.h"
+#include "refs.h"
=20
 int cmd_check_ref_format(int argc, const char **argv, const char *pref=
ix)
 {
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 0d534bc..fbdb37f 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -37,7 +37,6 @@
  * but get used to it in scripting!).
  */
 #include "builtin.h"
-#include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "parse-options.h"
diff --git a/builtin-checkout.c b/builtin-checkout.c
index fc55bbe..f8bb9ea 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -1,8 +1,7 @@
-#include "cache.h"
 #include "builtin.h"
+#include "blob.h"
 #include "parse-options.h"
 #include "refs.h"
-#include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
@@ -13,7 +12,6 @@
 #include "diff.h"
 #include "revision.h"
 #include "remote.h"
-#include "blob.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
=20
diff --git a/builtin-clean.c b/builtin-clean.c
index c5ad33d..46a483c 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -7,7 +7,6 @@
  */
=20
 #include "builtin.h"
-#include "cache.h"
 #include "dir.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 0453425..ea83003 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -3,10 +3,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
-#include "commit.h"
-#include "tree.h"
 #include "builtin.h"
+#include "tree.h"
 #include "utf8.h"
=20
 #define BLOCKING (1ul << 14)
diff --git a/builtin-commit.c b/builtin-commit.c
index 46e649c..aba5660 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -5,20 +5,17 @@
  * Based on git-commit.sh by Junio C Hamano and Linus Torvalds
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "cache-tree.h"
 #include "color.h"
 #include "dir.h"
-#include "builtin.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "commit.h"
 #include "revision.h"
 #include "wt-status.h"
 #include "run-command.h"
 #include "refs.h"
 #include "log-tree.h"
-#include "strbuf.h"
 #include "utf8.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin-config.c b/builtin-config.c
index d8da72c..6a31764 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "color.h"
 #include "parse-options.h"
=20
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index b814fe5..a6f2337 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -4,9 +4,8 @@
  * Copyright (c) 2006 Junio C Hamano
  */
=20
-#include "cache.h"
-#include "dir.h"
 #include "builtin.h"
+#include "dir.h"
 #include "parse-options.h"
=20
 static void count_objects(DIR *d, char *path, int len, int verbose,
diff --git a/builtin-describe.c b/builtin-describe.c
index 3a007ed..159c1ad 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -1,8 +1,6 @@
-#include "cache.h"
-#include "commit.h"
+#include "builtin.h"
 #include "tag.h"
 #include "refs.h"
-#include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
=20
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5b64011..4770aeb 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -3,11 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "diff.h"
-#include "commit.h"
 #include "revision.h"
-#include "builtin.h"
=20
 static const char diff_files_usage[] =3D
 "git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<pa=
th>...]"
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 0483749..7b8c813 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -1,8 +1,6 @@
-#include "cache.h"
+#include "builtin.h"
 #include "diff.h"
-#include "commit.h"
 #include "revision.h"
-#include "builtin.h"
=20
 static const char diff_cache_usage[] =3D
 "git diff-index [-m] [--cached] "
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 79cedb7..0b06748 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -1,8 +1,6 @@
-#include "cache.h"
+#include "builtin.h"
 #include "diff.h"
-#include "commit.h"
 #include "log-tree.h"
-#include "builtin.h"
=20
 static struct rev_info log_tree_opt;
=20
diff --git a/builtin-diff.c b/builtin-diff.c
index d75d69b..252c519 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -3,16 +3,14 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#include "cache.h"
-#include "color.h"
-#include "commit.h"
+#include "builtin.h"
 #include "blob.h"
+#include "color.h"
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
=20
 struct blobinfo {
 	unsigned char sha1[20];
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 34a419c..b62e48d 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2007 Johannes E. Schindelin
  */
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "object.h"
 #include "tag.h"
 #include "diff.h"
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 29356d2..1863d5f 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -1,7 +1,5 @@
 #include "builtin.h"
-#include "cache.h"
 #include "refs.h"
-#include "commit.h"
 #include "sigchain.h"
=20
 static char *get_stdin(void)
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3c998ea..c203286 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -1,10 +1,8 @@
 /*
  * "git fetch"
  */
-#include "cache.h"
-#include "refs.h"
-#include "commit.h"
 #include "builtin.h"
+#include "refs.h"
 #include "string-list.h"
 #include "remote.h"
 #include "transport.h"
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index a788369..772414f 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -1,6 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "tag.h"
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 5cbb4b0..ab9bfa4 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -1,11 +1,9 @@
 #include "builtin.h"
-#include "cache.h"
-#include "refs.h"
+#include "blob.h"
 #include "object.h"
+#include "refs.h"
 #include "tag.h"
-#include "commit.h"
 #include "tree.h"
-#include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
=20
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6436bc2..eae576a 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -1,6 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "tree.h"
 #include "blob.h"
 #include "tag.h"
diff --git a/builtin-gc.c b/builtin-gc.c
index fc556ed..fae3fde 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -11,7 +11,6 @@
  */
=20
 #include "builtin.h"
-#include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
=20
diff --git a/builtin-grep.c b/builtin-grep.c
index 89489dd..aa5b973 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -3,13 +3,11 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "tree.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-#include "builtin.h"
 #include "grep.h"
=20
 #ifndef NO_EXTERNAL_GREP
diff --git a/builtin-help.c b/builtin-help.c
index 9b57a74..bdae8a3 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -3,7 +3,6 @@
  *
  * Builtin help command
  */
-#include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "common-cmds.h"
diff --git a/builtin-init-db.c b/builtin-init-db.c
index fc63d0f..97728cd 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
=20
diff --git a/builtin-log.c b/builtin-log.c
index c7a5772..5105c91 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -4,13 +4,11 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "color.h"
-#include "commit.h"
 #include "diff.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "tag.h"
 #include "reflog-walk.h"
 #include "patch-ids.h"
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 88e2697..4efd46c 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -5,10 +5,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "quote.h"
 #include "dir.h"
-#include "builtin.h"
 #include "tree.h"
 #include "parse-options.h"
=20
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..5fe2af0 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "transport.h"
 #include "remote.h"
=20
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 22008df..4516d14 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -3,12 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "blob.h"
 #include "tree.h"
-#include "commit.h"
 #include "quote.h"
-#include "builtin.h"
=20
 static int line_termination =3D '\n';
 #define LS_RECURSIVE 1
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 1eeeb4d..0139a00 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -2,10 +2,8 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
-#include "cache.h"
 #include "builtin.h"
 #include "utf8.h"
-#include "strbuf.h"
=20
 static FILE *cmitmsg, *patchfile, *fin, *fout;
=20
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 71f3b3b..ea22d8b 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -4,7 +4,6 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
-#include "cache.h"
 #include "builtin.h"
 #include "string-list.h"
=20
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 03fc1c2..4f915e8 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -1,6 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "parse-options.h"
=20
 static int show_merge_base(struct commit **rev, int rev_nr, int show_a=
ll)
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 96edb97..7589d61 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "parse-options.h"
diff --git a/builtin-merge-ours.c b/builtin-merge-ours.c
index 8f5bbaf..33b85d0 100644
--- a/builtin-merge-ours.c
+++ b/builtin-merge-ours.c
@@ -7,7 +7,6 @@
  *
  * Pretend we resolved the heads, but declare our tree trumps everybod=
y else.
  */
-#include "git-compat-util.h"
 #include "builtin.h"
=20
 static const char *diff_index_args[] =3D {
diff --git a/builtin-merge.c b/builtin-merge.c
index 4c11935..cb4c645 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -6,13 +6,11 @@
  * Based on git-merge.sh by Junio C Hamano.
  */
=20
-#include "cache.h"
-#include "parse-options.h"
 #include "builtin.h"
+#include "parse-options.h"
 #include "run-command.h"
 #include "diff.h"
 #include "refs.h"
-#include "commit.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "unpack-trees.h"
diff --git a/builtin-mv.c b/builtin-mv.c
index 01270fe..659471b 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#include "cache.h"
 #include "builtin.h"
 #include "dir.h"
 #include "cache-tree.h"
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 08c8aab..386cafe 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -1,6 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "tag.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 2000d97..fe7a8de 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1,9 +1,7 @@
 #include "builtin.h"
-#include "cache.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree.h"
 #include "delta.h"
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 2d5b2cd..99f9fab 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "progress.h"
=20
 static const char prune_packed_usage[] =3D
diff --git a/builtin-prune.c b/builtin-prune.c
index 545e9c1..caf2751 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -1,8 +1,6 @@
-#include "cache.h"
-#include "commit.h"
+#include "builtin.h"
 #include "diff.h"
 #include "revision.h"
-#include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
 #include "dir.h"
diff --git a/builtin-push.c b/builtin-push.c
index 2eabcd3..128bfd8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -1,10 +1,9 @@
 /*
  * "git push"
  */
-#include "cache.h"
+#include "builtin.h"
 #include "refs.h"
 #include "run-command.h"
-#include "builtin.h"
 #include "remote.h"
 #include "transport.h"
 #include "parse-options.h"
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 8e02738..dd4a9f6 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -4,14 +4,13 @@
  * Copyright (C) Linus Torvalds, 2005
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "object.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "dir.h"
-#include "builtin.h"
=20
 static int nr_trees;
 static struct tree *trees[MAX_UNPACK_TREES];
diff --git a/builtin-reflog.c b/builtin-reflog.c
index d95f515..fcd92e8 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -1,6 +1,4 @@
-#include "cache.h"
 #include "builtin.h"
-#include "commit.h"
 #include "refs.h"
 #include "dir.h"
 #include "tree-walk.h"
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 020af73..d0a6ebb 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "dir.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 40d5fcb..bc86e3c 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -1,14 +1,12 @@
-#include "cache.h"
+#include "builtin.h"
+#include "blob.h"
 #include "refs.h"
 #include "tag.h"
-#include "commit.h"
 #include "tree.h"
-#include "blob.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
-#include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
=20
diff --git a/builtin-revert.c b/builtin-revert.c
index 3f2614e..90fea7d 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -1,7 +1,5 @@
-#include "cache.h"
 #include "builtin.h"
 #include "object.h"
-#include "commit.h"
 #include "tag.h"
 #include "wt-status.h"
 #include "run-command.h"
diff --git a/builtin-rm.c b/builtin-rm.c
index 269d608..7fb865a 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -3,7 +3,6 @@
  *
  * Copyright (C) Linus Torvalds 2006
  */
-#include "cache.h"
 #include "builtin.h"
 #include "dir.h"
 #include "cache-tree.h"
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index b28091b..9b6662b 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -1,6 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
-#include "commit.h"
 #include "diff.h"
 #include "string-list.h"
 #include "revision.h"
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 828e6f8..02c2c5c 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -1,7 +1,5 @@
-#include "cache.h"
-#include "commit.h"
-#include "refs.h"
 #include "builtin.h"
+#include "refs.h"
=20
 static const char show_branch_usage[] =3D
 "git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-or=
der] [--more=3Dcount | --list | --independent | --merge-base ] [--topic=
s] [<refs>...] | --reflog[=3Dn[,b]] <branch>";
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index dc76c50..619b64e 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "refs.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index d6e3896..126b37a 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
=20
 /*
  * Returns the length of a line, without trailing spaces.
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index 6ae6bcc..41814bf 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "refs.h"
 #include "parse-options.h"
=20
diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..15f4ab7 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -6,7 +6,6 @@
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
=20
-#include "cache.h"
 #include "builtin.h"
 #include "refs.h"
 #include "tag.h"
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 0713bca..9707eea 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -1,8 +1,6 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#include "cache.h"
-#include "commit.h"
 #include "tar.h"
 #include "builtin.h"
 #include "quote.h"
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 9a77323..4f5495d 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -1,10 +1,8 @@
 #include "builtin.h"
-#include "cache.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
 #include "blob.h"
-#include "commit.h"
 #include "tag.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1fde893..9a006bd 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -3,11 +3,10 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
-#include "builtin.h"
 #include "refs.h"
=20
 /*
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 378dc1b..cac86ef 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -1,6 +1,5 @@
-#include "cache.h"
-#include "refs.h"
 #include "builtin.h"
+#include "refs.h"
 #include "parse-options.h"
=20
 static const char * const git_update_ref_usage[] =3D {
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 0206b41..fe29d7b 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
-#include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 0ee0a9a..070455f 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "pack.h"
 #include "pack-revindex.h"
=20
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 729a159..039fe0a 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -5,7 +5,6 @@
  *
  * Based on git-verify-tag.sh
  */
-#include "cache.h"
 #include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 9d64050..f1ce5e5 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "builtin.h"
-#include "cache.h"
 #include "tree.h"
 #include "cache-tree.h"
=20
diff --git a/diff-no-index.c b/diff-no-index.c
index 42c1dd8..cb68b8d 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -4,16 +4,14 @@
  * Copyright (c) 2008 by Junio C Hamano
  */
=20
-#include "cache.h"
+#include "builtin.h"
 #include "color.h"
-#include "commit.h"
 #include "blob.h"
 #include "tag.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "string-list.h"
=20
 static int read_directory(const char *path, struct string_list *list)
diff --git a/fast-import.c b/fast-import.c
index db44da3..e3c138f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -141,11 +141,9 @@ Format of STDIN stream:
 */
=20
 #include "builtin.h"
-#include "cache.h"
 #include "object.h"
 #include "blob.h"
 #include "tree.h"
-#include "commit.h"
 #include "delta.h"
 #include "pack.h"
 #include "refs.h"
diff --git a/git.c b/git.c
index c2b181e..b6c1884 100644
--- a/git.c
+++ b/git.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "exec_cmd.h"
-#include "cache.h"
 #include "quote.h"
 #include "run-command.h"
=20
diff --git a/help.c b/help.c
index fd87bb5..7edbc43 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "levenshtein.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 3e1bc3e..352677c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,11 +3,9 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July =
2006
  */
-#include "cache.h"
-#include "cache-tree.h"
-#include "commit.h"
-#include "blob.h"
 #include "builtin.h"
+#include "blob.h"
+#include "cache-tree.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
--=20
1.6.1.3
