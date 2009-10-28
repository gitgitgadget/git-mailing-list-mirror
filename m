From: Timur Sufiev <timur@iris-comp.ru>
Subject: [PATCH I18N filenames v2 2/3] Use I18N-wrappers everywhere in Git
Date: Wed, 28 Oct 2009 21:01:39 +0300
Message-ID: <1256752900-2615-2-git-send-email-timur@iris-comp.ru>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
Cc: Timur Sufiev <timur@iris-comp.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 19:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3CqO-0005ni-5w
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 19:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbZJ1SBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZJ1SBv
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 14:01:51 -0400
Received: from [195.93.180.178] ([195.93.180.178]:58940 "EHLO
	mail.iris-comp.ru" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZJ1SBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 14:01:44 -0400
Received: from localhost (unknown [80.90.116.82])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.iris-comp.ru (Postfix) with ESMTPSA id F1598E9AE;
	Wed, 28 Oct 2009 21:01:43 +0300 (MSK)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131487>

Signed-off-by: Timur Sufiev <timur@iris-comp.ru>
---
 abspath.c               |    1 +
 attr.c                  |    1 +
 bisect.c                |    1 +
 branch.c                |    1 +
 builtin-add.c           |    1 +
 builtin-apply.c         |    1 +
 builtin-archive.c       |    1 +
 builtin-blame.c         |    1 +
 builtin-clean.c         |    1 +
 builtin-clone.c         |    1 +
 builtin-commit.c        |    1 +
 builtin-count-objects.c |    1 +
 builtin-diff.c          |    1 +
 builtin-fast-export.c   |    1 +
 builtin-fetch--tool.c   |    1 +
 builtin-fetch-pack.c    |    1 +
 builtin-fetch.c         |    1 +
 builtin-fmt-merge-msg.c |    1 +
 builtin-fsck.c          |    1 +
 builtin-gc.c            |    1 +
 builtin-grep.c          |    1 +
 builtin-help.c          |    1 +
 builtin-init-db.c       |    1 +
 builtin-ls-files.c      |    1 +
 builtin-mailinfo.c      |    1 +
 builtin-mailsplit.c     |    1 +
 builtin-merge-file.c    |    1 +
 builtin-merge.c         |    1 +
 builtin-mv.c            |    1 +
 builtin-pack-objects.c  |    1 +
 builtin-prune-packed.c  |    1 +
 builtin-prune.c         |    1 +
 builtin-reflog.c        |    1 +
 builtin-remote.c        |    1 +
 builtin-rerere.c        |    1 +
 builtin-rm.c            |    1 +
 builtin-tag.c           |    1 +
 builtin-update-index.c  |    1 +
 builtin-verify-tag.c    |    1 +
 bundle.c                |    1 +
 check-racy.c            |    1 +
 combine-diff.c          |    1 +
 commit.c                |    1 +
 config.c                |    1 +
 copy.c                  |    1 +
 daemon.c                |    1 +
 diff-lib.c              |    1 +
 diff-no-index.c         |    1 +
 diff.c                  |    1 +
 diffcore-order.c        |    1 +
 dir.c                   |    1 +
 entry.c                 |    1 +
 fast-import.c           |    1 +
 hash-object.c           |    1 +
 help.c                  |    1 +
 http.c                  |    1 +
 index-pack.c            |    1 +
 ll-merge.c              |    1 +
 lockfile.c              |    1 +
 mailmap.c               |    1 +
 merge-recursive.c       |    1 +
 pack-write.c            |    1 +
 path.c                  |    1 +
 preload-index.c         |    1 +
 read-cache.c            |    1 +
 refs.c                  |    1 +
 remote.c                |    1 +
 rerere.c                |    1 +
 server-info.c           |    1 +
 setup.c                 |    1 +
 sha1_file.c             |    1 +
 sha1_name.c             |    1 +
 shallow.c               |    1 +
 strbuf.c                |    1 +
 symlinks.c              |    1 +
 test-chmtime.c          |    1 +
 test-delta.c            |    1 +
 trace.c                 |    1 +
 transport.c             |    1 +
 unpack-trees.c          |    1 +
 wrapper.c               |    1 +
 xdiff-interface.c       |    1 +
 82 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/abspath.c b/abspath.c
index b88122c..b672c18 100644
--- a/abspath.c
+++ b/abspath.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "io-i18n.h"
 
 /*
  * Do not use this for inspecting *tracked* content.  When path is a
diff --git a/attr.c b/attr.c
index 55bdb7c..6422254 100644
--- a/attr.c
+++ b/attr.c
@@ -1,6 +1,7 @@
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "attr.h"
+#include "io-i18n.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
diff --git a/bisect.c b/bisect.c
index dc18db8..fe9fbb5 100644
--- a/bisect.c
+++ b/bisect.c
@@ -9,6 +9,7 @@
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
+#include "io-i18n.h"
 
 struct sha1_array {
 	unsigned char (*sha1)[20];
diff --git a/branch.c b/branch.c
index 05ef3f5..1569809 100644
--- a/branch.c
+++ b/branch.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
+#include "io-i18n.h"
 
 struct tracking {
 	struct refspec spec;
diff --git a/builtin-add.c b/builtin-add.c
index cb6e590..027170c 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -12,6 +12,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "io-i18n.h"
 
 static const char * const builtin_add_usage[] = {
 	"git add [options] [--] <filepattern>...",
diff --git a/builtin-apply.c b/builtin-apply.c
index f667368..7d2f4f4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "dir.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 /*
  *  --check turns on checking that the working tree matches the
diff --git a/builtin-archive.c b/builtin-archive.c
index 12351e9..528676e 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "sideband.h"
+#include "io-i18n.h"
 
 static void create_output_file(const char *output_file)
 {
diff --git a/builtin-blame.c b/builtin-blame.c
index 7512773..d349198 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -20,6 +20,7 @@
 #include "mailmap.h"
 #include "parse-options.h"
 #include "utf8.h"
+#include "io-i18n.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
diff --git a/builtin-clean.c b/builtin-clean.c
index 28cdcd0..37293f7 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -11,6 +11,7 @@
 #include "dir.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "io-i18n.h"
 
 static int force = -1; /* unset */
 
diff --git a/builtin-clone.c b/builtin-clone.c
index 5762a6f..5949438 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "io-i18n.h"
 
 /*
  * Overall FIXMEs:
diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..a124d88 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -24,6 +24,7 @@
 #include "string-list.h"
 #include "rerere.h"
 #include "unpack-trees.h"
+#include "io-i18n.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 1b0b6c8..dde93dc 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -8,6 +8,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
diff --git a/builtin-diff.c b/builtin-diff.c
index ffcdd05..49748f0 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "io-i18n.h"
 
 struct blobinfo {
 	unsigned char sha1[20];
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b0a4029..932b964 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char *fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 3dbdf7a..91b774d 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -3,6 +3,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "sigchain.h"
+#include "io-i18n.h"
 
 static char *get_stdin(void)
 {
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..aecc2f4 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "io-i18n.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/builtin-fetch.c b/builtin-fetch.c
index a35a6f8..14e7f79 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "sigchain.h"
+#include "io-i18n.h"
 
 static const char * const builtin_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 9d52400..c002968 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "tag.h"
+#include "io-i18n.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 2d88e45..67d0826 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -11,6 +11,7 @@
 #include "fsck.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
diff --git a/builtin-gc.c b/builtin-gc.c
index 093517e..e66c817 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -14,6 +14,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "io-i18n.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/builtin-grep.c b/builtin-grep.c
index 1df25b0..3f37fab 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -14,6 +14,7 @@
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
+#include "io-i18n.h"
 
 #ifndef NO_EXTERNAL_GREP
 #ifdef __unix__
diff --git a/builtin-help.c b/builtin-help.c
index e1eba77..7d54179 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -10,6 +10,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "help.h"
+#include "io-i18n.h"
 
 static struct man_viewer_list {
 	struct man_viewer_list *next;
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..61b3f28 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index c5c0407..3669d37 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static int abbrev;
 static int show_deleted;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index c90cd31..a5f6160 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "utf8.h"
 #include "strbuf.h"
+#include "io-i18n.h"
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index dfe5b15..637a0f9 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "io-i18n.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index afd2ea7..d986758 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -3,6 +3,7 @@
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char *const merge_file_usage[] = {
 	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2",
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..2759c25 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -24,6 +24,7 @@
 #include "rerere.h"
 #include "help.h"
 #include "merge-recursive.h"
+#include "io-i18n.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin-mv.c b/builtin-mv.c
index 1b20028..8ce8dfd 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "string-list.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char * const builtin_mv_usage[] = {
 	"git mv [options] <source>... <destination>",
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..2fe3e64 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "progress.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 #ifdef THREADED_DELTA_SEARCH
 #include "thread-utils.h"
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index be99eb0..30f5a8a 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "progress.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char * const prune_packed_usage[] = {
 	"git prune-packed [-n|--dry-run] [-q|--quiet]",
diff --git a/builtin-prune.c b/builtin-prune.c
index 8459aec..bfb7eee 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -6,6 +6,7 @@
 #include "reachable.h"
 #include "parse-options.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 static const char * const prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
diff --git a/builtin-reflog.c b/builtin-reflog.c
index e23b5ef..b8b637e 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "reachable.h"
+#include "io-i18n.h"
 
 /*
  * reflog expire
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..95ba635 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -6,6 +6,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 static const char * const builtin_remote_usage[] = {
 	"git remote [-v | --verbose]",
diff --git a/builtin-rerere.c b/builtin-rerere.c
index adfb7b5..d3e29e0 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -5,6 +5,7 @@
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "io-i18n.h"
 
 static const char git_rerere_usage[] =
 "git rerere [clear | status | diff | gc]";
diff --git a/builtin-rm.c b/builtin-rm.c
index 57975db..a4ba0cd 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char * const builtin_rm_usage[] = {
 	"git rm [options] [--] <file>...",
diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..fd42072 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -12,6 +12,7 @@
 #include "tag.h"
 #include "run-command.h"
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..0dab755 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -9,6 +9,7 @@
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 /*
  * Default to not allowing changes to the list of files. The
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 9f482c2..6271aaf 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include <signal.h>
 #include "parse-options.h"
+#include "io-i18n.h"
 
 static const char * const verify_tag_usage[] = {
 		"git verify-tag [-v|--verbose] <tag>...",
diff --git a/bundle.c b/bundle.c
index df95e15..46e6b9e 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,6 +7,7 @@
 #include "list-objects.h"
 #include "run-command.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
diff --git a/check-racy.c b/check-racy.c
index 00d92a1..05eeedf 100644
--- a/check-racy.c
+++ b/check-racy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "io-i18n.h"
 
 int main(int ac, char **av)
 {
diff --git a/combine-diff.c b/combine-diff.c
index 5b63af1..1d6eb1c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -7,6 +7,7 @@
 #include "xdiff-interface.h"
 #include "log-tree.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
diff --git a/commit.c b/commit.c
index fedbd5e..cbdc8c3 100644
--- a/commit.c
+++ b/commit.c
@@ -5,6 +5,7 @@
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
+#include "io-i18n.h"
 
 int save_commit_buffer = 1;
 
diff --git a/config.c b/config.c
index 2be6531..9826eff 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "exec_cmd.h"
+#include "io-i18n.h"
 
 #define MAXNAME (256)
 
diff --git a/copy.c b/copy.c
index a7f58fd..de64127 100644
--- a/copy.c
+++ b/copy.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "io-i18n.h"
 
 int copy_fd(int ifd, int ofd)
 {
diff --git a/daemon.c b/daemon.c
index 1b5ada6..42f70e5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "io-i18n.h"
 
 #include <syslog.h>
 
diff --git a/diff-lib.c b/diff-lib.c
index 0c74ef5..988baee 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -10,6 +10,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 /*
  * diff-files
diff --git a/diff-no-index.c b/diff-no-index.c
index 4ebc1db..b12ad8f 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -15,6 +15,7 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "string-list.h"
+#include "io-i18n.h"
 
 static int read_directory(const char *path, struct string_list *list)
 {
diff --git a/diff.c b/diff.c
index b0c7e61..b875429 100644
--- a/diff.c
+++ b/diff.c
@@ -13,6 +13,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "sigchain.h"
+#include "io-i18n.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..6ce4d4a 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "io-i18n.h"
 
 static char **order;
 static int order_cnt;
diff --git a/dir.c b/dir.c
index d0999ba..8bbee16 100644
--- a/dir.c
+++ b/dir.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 struct path_simplify {
 	int len;
diff --git a/entry.c b/entry.c
index 06d24f1..b01a23b 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "blob.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
diff --git a/fast-import.c b/fast-import.c
index 6faaaac..97d010d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -152,6 +152,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "io-i18n.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/hash-object.c b/hash-object.c
index 9455dd0..0f17bbd 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "exec_cmd.h"
+#include "io-i18n.h"
 
 static void hash_fd(int fd, const char *type, int write_object, const char *path)
 {
diff --git a/help.c b/help.c
index e8db31f..fcbb8c0 100644
--- a/help.c
+++ b/help.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "levenshtein.h"
 #include "help.h"
+#include "io-i18n.h"
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
diff --git a/http.c b/http.c
index 23b2a19..d064f58 100644
--- a/http.c
+++ b/http.c
@@ -1,5 +1,6 @@
 #include "http.h"
 #include "pack.h"
+#include "io-i18n.h"
 
 int data_received;
 int active_requests;
diff --git a/index-pack.c b/index-pack.c
index b4f8278..2ae89c4 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -9,6 +9,7 @@
 #include "progress.h"
 #include "fsck.h"
 #include "exec_cmd.h"
+#include "io-i18n.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
diff --git a/ll-merge.c b/ll-merge.c
index 2d6b6d6..beff7a9 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "run-command.h"
 #include "ll-merge.h"
+#include "io-i18n.h"
 
 struct ll_merge_driver;
 
diff --git a/lockfile.c b/lockfile.c
index 6851fa5..fea9f4c 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "sigchain.h"
+#include "io-i18n.h"
 
 static struct lock_file *lock_file_list;
 static const char *alternate_index_output;
diff --git a/mailmap.c b/mailmap.c
index f167c00..7239fb7 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "io-i18n.h"
 
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
diff --git a/merge-recursive.c b/merge-recursive.c
index f55b7eb..3258c49 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -19,6 +19,7 @@
 #include "attr.h"
 #include "merge-recursive.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 static struct tree *shift_tree_object(struct tree *one, struct tree *two)
 {
diff --git a/pack-write.c b/pack-write.c
index 741efcd..00d2c4a 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "csum-file.h"
+#include "io-i18n.h"
 
 uint32_t pack_idx_default_version = 2;
 uint32_t pack_idx_off32_limit = 0x7fffffff;
diff --git a/path.c b/path.c
index 047fdb0..b598190 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "io-i18n.h"
 
 static char bad_path[] = "/bad-path/";
 
diff --git a/preload-index.c b/preload-index.c
index 9289933..bfab0c3 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2008 Linus Torvalds
  */
 #include "cache.h"
+#include "io-i18n.h"
 
 #ifdef NO_PTHREADS
 static void preload_index(struct index_state *index, const char **pathspec)
diff --git a/read-cache.c b/read-cache.c
index 1bbaf1c..cc06da2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "blob.h"
+#include "io-i18n.h"
 
 /* Index extensions.
  *
diff --git a/refs.c b/refs.c
index 808f56b..53f6539 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
diff --git a/remote.c b/remote.c
index 73d33f2..780ff75 100644
--- a/remote.c
+++ b/remote.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
+#include "io-i18n.h"
 
 static struct refspec s_tag_refspec = {
 	0,
diff --git a/rerere.c b/rerere.c
index 29f95f6..dfff2ac 100644
--- a/rerere.c
+++ b/rerere.c
@@ -3,6 +3,7 @@
 #include "rerere.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
+#include "io-i18n.h"
 
 /* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
 static int rerere_enabled = -1;
diff --git a/server-info.c b/server-info.c
index 4098ca2..f074057 100644
--- a/server-info.c
+++ b/server-info.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "io-i18n.h"
 
 /* refs */
 static FILE *info_ref_fp;
diff --git a/setup.c b/setup.c
index 029371e..c87efa3 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include "io-i18n.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/sha1_file.c b/sha1_file.c
index 63981fb..3f9145f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "pack-revindex.h"
 #include "sha1-lookup.h"
+#include "io-i18n.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
diff --git a/sha1_name.c b/sha1_name.c
index 44bb62d..bee34aa 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -5,6 +5,7 @@
 #include "blob.h"
 #include "tree-walk.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 static int find_short_object_filename(int len, const char *name, unsigned char *sha1)
 {
diff --git a/shallow.c b/shallow.c
index 4d90eda..745b64f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
+#include "io-i18n.h"
 
 static int is_shallow = -1;
 
diff --git a/strbuf.c b/strbuf.c
index a6153dc..1baa78a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 int prefixcmp(const char *str, const char *prefix)
 {
diff --git a/symlinks.c b/symlinks.c
index 7b0a86d..7907186 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "io-i18n.h"
 
 /*
  * Returns the length (on a path component basis) of the longest
diff --git a/test-chmtime.c b/test-chmtime.c
index fe476cb..6471850 100644
--- a/test-chmtime.c
+++ b/test-chmtime.c
@@ -29,6 +29,7 @@
  */
 #include "git-compat-util.h"
 #include <utime.h>
+#include "io-i18n.h"
 
 static const char usage_str[] = "-v|--verbose (+|=|=+|=-|-)<seconds> <file>...";
 
diff --git a/test-delta.c b/test-delta.c
index af40a3c..24d678f 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -11,6 +11,7 @@
 #include "git-compat-util.h"
 #include "delta.h"
 #include "cache.h"
+#include "io-i18n.h"
 
 static const char usage_str[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
diff --git a/trace.c b/trace.c
index 4229ae1..616a64e 100644
--- a/trace.c
+++ b/trace.c
@@ -24,6 +24,7 @@
 
 #include "cache.h"
 #include "quote.h"
+#include "io-i18n.h"
 
 /* Get a trace file descriptor from GIT_TRACE env variable. */
 static int get_trace_fd(int *need_close)
diff --git a/transport.c b/transport.c
index 644a30a..3e898aa 100644
--- a/transport.c
+++ b/transport.c
@@ -8,6 +8,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "io-i18n.h"
 
 /* rsync support */
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 720f7a1..5bad618 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,6 +8,7 @@
 #include "progress.h"
 #include "refs.h"
 #include "attr.h"
+#include "io-i18n.h"
 
 /*
  * Error messages expected by scripts out of plumbing commands such as
diff --git a/wrapper.c b/wrapper.c
index c9be140..0a89eec 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "io-i18n.h"
 
 char *xstrdup(const char *str)
 {
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 01f14fb..dee800c 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -4,6 +4,7 @@
 #include "xdiff/xdiffi.h"
 #include "xdiff/xemit.h"
 #include "xdiff/xmacros.h"
+#include "io-i18n.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
-- 
1.6.5.1
