From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH v3] Trivial fix: Make all the usage strings to use the same pattern.
Date: Tue, 22 Sep 2009 13:08:50 -0400
Message-ID: <1253639330-9185-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 19:10:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq8rx-0002G0-Is
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 19:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbZIVRJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZIVRJT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 13:09:19 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:45751 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZIVRJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 13:09:09 -0400
Received: by qyk3 with SMTP id 3so2971826qyk.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DTIm6RTUNiQ4m1Z2aUfsb4HDgLUpIWrwNsmhqMf2SjU=;
        b=aEHNvSwmiV+owxk+HBVjjQTDpaw6Ed2R4LEMtW5kQFiMgBwqOAUsQ6clmFIvF1mzGR
         snkYZVNH84Un7jjfOUXnLE5og3e4/57BFkF1XuEsgetaSfaIP8H22gFi3rYIHtHQr1W9
         4CxNoHkxBKtdPWFjV7Fah/O8C/oJgE2Cfc8ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=woeOf2UVsK6jUy6WTkeJjga5VGBG2ZY6LimgbTlYiCuobD9d3BQr7rzu75zl2AQlHM
         7Rh5wH0IeQWgwUl1MxYMMhRemp2suyS2ly/OZDmKfd/3CYQ7U9ddcck95/ZpGtltyFoq
         ikJUn6V+70U40qaaUmL8Ky/HkZguPkvhRkzjQ=
Received: by 10.224.105.31 with SMTP id r31mr934509qao.374.1253639352932;
        Tue, 22 Sep 2009 10:09:12 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 2sm135879qwi.50.2009.09.22.10.09.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 10:09:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.38.gddf44.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128951>

They follow the below pattern:
Git command: git command-name
Usage string: git_command_name_usage

Also changes "static char const * const" to "static const char * const" to
match with the definition in api-parse-options.txt.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 archive.c                    |    6 +++---
 builtin-add.c                |    4 ++--
 builtin-apply.c              |    4 ++--
 builtin-bisect--helper.c     |    6 +++---
 builtin-blame.c              |    9 +++++----
 builtin-branch.c             |    8 ++++----
 builtin-bundle.c             |    6 +++---
 builtin-cat-file.c           |   12 ++++++------
 builtin-check-attr.c         |    8 ++++----
 builtin-checkout-index.c     |    4 ++--
 builtin-checkout.c           |    4 ++--
 builtin-clean.c              |    4 ++--
 builtin-clone.c              |    4 ++--
 builtin-commit-tree.c        |    7 ++++---
 builtin-commit.c             |    8 ++++----
 builtin-config.c             |   16 ++++++++--------
 builtin-count-objects.c      |    6 +++---
 builtin-describe.c           |    4 ++--
 builtin-diff-files.c         |    6 +++---
 builtin-diff-index.c         |    6 +++---
 builtin-diff-tree.c          |    6 +++---
 builtin-diff.c               |   24 ++++++++++++------------
 builtin-fast-export.c        |    8 ++++----
 builtin-fetch-pack.c         |    6 +++---
 builtin-fetch.c              |    4 ++--
 builtin-fmt-merge-msg.c      |    6 +++---
 builtin-for-each-ref.c       |   10 +++++-----
 builtin-fsck.c               |    4 ++--
 builtin-gc.c                 |    6 +++---
 builtin-grep.c               |    4 ++--
 builtin-help.c               |    4 ++--
 builtin-init-db.c            |    6 +++---
 builtin-log.c                |   16 ++++++++--------
 builtin-ls-files.c           |    4 ++--
 builtin-ls-remote.c          |    6 +++---
 builtin-ls-tree.c            |    8 ++++----
 builtin-mailinfo.c           |    8 ++++----
 builtin-merge-base.c         |    6 +++---
 builtin-merge-file.c         |    6 +++---
 builtin-merge.c              |   10 +++++-----
 builtin-mktree.c             |    6 +++---
 builtin-mv.c                 |    8 ++++----
 builtin-name-rev.c           |    6 +++---
 builtin-pack-objects.c       |   18 +++++++++---------
 builtin-pack-refs.c          |    6 +++---
 builtin-prune-packed.c       |    4 ++--
 builtin-prune.c              |    4 ++--
 builtin-push.c               |    6 +++---
 builtin-read-tree.c          |    4 ++--
 builtin-receive-pack.c       |    8 ++++----
 builtin-reflog.c             |    4 ++--
 builtin-remote.c             |   26 +++++++++++++-------------
 builtin-rev-list.c           |    6 +++---
 builtin-rev-parse.c          |    2 +-
 builtin-revert.c             |    6 +++---
 builtin-rm.c                 |    6 +++---
 builtin-send-pack.c          |    8 ++++----
 builtin-shortlog.c           |    8 ++++----
 builtin-show-branch.c        |    6 +++---
 builtin-show-ref.c           |    4 ++--
 builtin-tar-tree.c           |    4 ++--
 builtin-unpack-objects.c     |    7 ++++---
 builtin-update-index.c       |    4 ++--
 builtin-update-server-info.c |    6 +++---
 builtin-upload-archive.c     |    5 ++---
 builtin-verify-pack.c        |    6 +++---
 builtin-verify-tag.c         |    6 +++---
 builtin-write-tree.c         |    4 ++--
 daemon.c                     |    4 ++--
 fast-import.c                |    4 ++--
 hash-object.c                |    6 +++---
 http-push.c                  |    4 ++--
 index-pack.c                 |   10 +++++-----
 merge-tree.c                 |    6 ++++--
 pack-redundant.c             |    4 ++--
 patch-id.c                   |    4 ++--
 upload-pack.c                |    5 +++--
 var.c                        |    6 +++---
 78 files changed, 265 insertions(+), 260 deletions(-)

diff --git a/archive.c b/archive.c
index 73b8e8a..51581f7 100644
--- a/archive.c
+++ b/archive.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 
-static char const * const archive_usage[] = {
+static const char * const git_archive_usage[] = {
 	"git archive [options] <tree-ish> [path...]",
 	"git archive --list",
 	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
@@ -309,7 +309,7 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
+	argc = parse_options(argc, argv, NULL, opts, git_archive_usage, 0);
 
 	if (remote)
 		die("Unexpected option --remote");
@@ -329,7 +329,7 @@ static int parse_archive_args(int argc, const char **argv,
 
 	/* We need at least one parameter -- tree-ish */
 	if (argc < 1)
-		usage_with_options(archive_usage, opts);
+		usage_with_options(git_archive_usage, opts);
 	*ar = lookup_archiver(format);
 	if (!*ar)
 		die("Unknown archive format '%s'", format);
diff --git a/builtin-add.c b/builtin-add.c
index cb6e590..a4a1976 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -13,7 +13,7 @@
 #include "diff.h"
 #include "revision.h"
 
-static const char * const builtin_add_usage[] = {
+static const char * const git_add_usage[] = {
 	"git add [options] [--] <filepattern>...",
 	NULL
 };
@@ -287,7 +287,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	git_config(add_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
-			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
+			  git_add_usage, PARSE_OPT_KEEP_ARGV0);
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
diff --git a/builtin-apply.c b/builtin-apply.c
index c8372a0..3bd5df6 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -47,7 +47,7 @@ static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
-static const char * const apply_usage[] = {
+static const char * const git_apply_usage[] = {
 	"git apply [options] [<patch>...]",
 	NULL
 };
@@ -3567,7 +3567,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
-			apply_usage, 0);
+			git_apply_usage, 0);
 
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index 5b22639..41aad99 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -3,7 +3,7 @@
 #include "parse-options.h"
 #include "bisect.h"
 
-static const char * const git_bisect_helper_usage[] = {
+static const char * const builtin_bisect_helper_usage[] = {
 	"git bisect--helper --next-all",
 	NULL
 };
@@ -18,10 +18,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage, 0);
+			     builtin_bisect_helper_usage, 0);
 
 	if (!next_all)
-		usage_with_options(git_bisect_helper_usage, options);
+		usage_with_options(builtin_bisect_helper_usage, options);
 
 	/* next-all */
 	return bisect_next_all(prefix);
diff --git a/builtin-blame.c b/builtin-blame.c
index 7512773..9fec5dd 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -21,10 +21,11 @@
 #include "parse-options.h"
 #include "utf8.h"
 
-static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
+static const char git_blame_usage[] =
+"git blame [options] [rev-opts] [rev] [--] file";
 
 static const char *blame_opt_usage[] = {
-	blame_usage,
+	git_blame_usage,
 	"",
 	"[rev-opts] are documented in git-rev-list(1)",
 	NULL
@@ -1948,10 +1949,10 @@ static void prepare_blame_range(struct scoreboard *sb,
 	if (*term == ',') {
 		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
 		if (*term)
-			usage(blame_usage);
+			usage(git_blame_usage);
 	}
 	if (*term)
-		usage(blame_usage);
+		usage(git_blame_usage);
 }
 
 static int git_blame_config(const char *var, const char *value, void *cb)
diff --git a/builtin-branch.c b/builtin-branch.c
index 9f57992..4ac81dd 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -16,7 +16,7 @@
 #include "diff.h"
 #include "revision.h"
 
-static const char * const builtin_branch_usage[] = {
+static const char * const git_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
 	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git branch [options] [-r] (-d | -D) <branchname>",
@@ -622,10 +622,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	}
 	hashcpy(merge_filter_ref, head_sha1);
 
-	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
+	argc = parse_options(argc, argv, prefix, options, git_branch_usage,
 			     0);
 	if (!!delete + !!rename + !!force_create > 1)
-		usage_with_options(builtin_branch_usage, options);
+		usage_with_options(git_branch_usage, options);
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
@@ -639,7 +639,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
 			      force_create, reflog, track);
 	else
-		usage_with_options(builtin_branch_usage, options);
+		usage_with_options(git_branch_usage, options);
 
 	return 0;
 }
diff --git a/builtin-bundle.c b/builtin-bundle.c
index 2006cc5..3d5d64e 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -9,7 +9,7 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char builtin_bundle_usage[] =
+static const char git_bundle_usage[] =
   "git bundle create <file> <git-rev-list args>\n"
   "   or: git bundle verify <file>\n"
   "   or: git bundle list-heads <file> [refname...]\n"
@@ -24,7 +24,7 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 	char buffer[PATH_MAX];
 
 	if (argc < 3)
-		usage(builtin_bundle_usage);
+		usage(git_bundle_usage);
 
 	cmd = argv[1];
 	bundle_file = argv[2];
@@ -63,5 +63,5 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
-		usage(builtin_bundle_usage);
+		usage(git_bundle_usage);
 }
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 5906842..c6b6779 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -200,7 +200,7 @@ static int batch_objects(int print_contents)
 	return 0;
 }
 
-static const char * const cat_file_usage[] = {
+static const char * const git_cat_file_usage[] = {
 	"git cat-file (-t|-s|-e|-p|<type>) <object>",
 	"git cat-file (--batch|--batch-check) < <list_of_objects>",
 	NULL
@@ -229,25 +229,25 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (argc != 3 && argc != 2)
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(git_cat_file_usage, options);
 
-	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_cat_file_usage, 0);
 
 	if (opt) {
 		if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(git_cat_file_usage, options);
 	}
 	if (!opt && !batch) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(git_cat_file_usage, options);
 	}
 	if (batch && (opt || argc)) {
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(git_cat_file_usage, options);
 	}
 
 	if (batch)
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 8bd0430..347f1fd 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
 
 static int stdin_paths;
-static const char * const check_attr_usage[] = {
+static const char * const git_check_attr_usage[] = {
 "git check-attr attr... [--] pathname...",
 "git check-attr --stdin attr... < <list-of-paths>",
 NULL
@@ -70,9 +70,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
-			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
+			     git_check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 	if (!argc)
-		usage_with_options(check_attr_usage, check_attr_options);
+		usage_with_options(git_check_attr_usage, check_attr_options);
 
 	if (read_cache() < 0) {
 		die("invalid cache");
@@ -98,7 +98,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		errstr = "Can't specify files with --stdin";
 	if (errstr) {
 		error("%s", errstr);
-		usage_with_options(check_attr_usage, check_attr_options);
+		usage_with_options(git_check_attr_usage, check_attr_options);
 	}
 
 	check = xcalloc(cnt, sizeof(*check));
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index a7a5ee1..71fc0a4 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -154,7 +154,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 		exit(128);
 }
 
-static const char * const builtin_checkout_index_usage[] = {
+static const char * const git_checkout_index_usage[] = {
 	"git checkout-index [options] [--] <file>...",
 	NULL
 };
@@ -250,7 +250,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	argc = parse_options(argc, argv, prefix, builtin_checkout_index_options,
-			builtin_checkout_index_usage, 0);
+			git_checkout_index_usage, 0);
 	state.force = force;
 	state.quiet = quiet;
 	state.not_new = not_new;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..e93b8bb 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -18,7 +18,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 
-static const char * const checkout_usage[] = {
+static const char * const git_checkout_usage[] = {
 	"git checkout [options] <branch>",
 	"git checkout [options] [<branch>] -- <file>...",
 	NULL,
@@ -608,7 +608,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, git_checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (patch_mode && (opts.track > 0 || opts.new_branch
diff --git a/builtin-clean.c b/builtin-clean.c
index 28cdcd0..3f16b9a 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -14,7 +14,7 @@
 
 static int force = -1; /* unset */
 
-static const char *const builtin_clean_usage[] = {
+static const char * const git_clean_usage[] = {
 	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
 	NULL
 };
@@ -56,7 +56,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	else
 		config_set = 1;
 
-	argc = parse_options(argc, argv, prefix, options, builtin_clean_usage,
+	argc = parse_options(argc, argv, prefix, options, git_clean_usage,
 			     0);
 
 	memset(&dir, 0, sizeof(dir));
diff --git a/builtin-clone.c b/builtin-clone.c
index bab2d84..31c54ca 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -32,7 +32,7 @@
  *  - dropping use-separate-remote and no-separate-remote compatibility
  *
  */
-static const char * const builtin_clone_usage[] = {
+static const char * const git_clone_usage[] = {
 	"git clone [options] [--] <repo> [<dir>]",
 	NULL
 };
@@ -371,7 +371,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_pid = getpid();
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
-			     builtin_clone_usage, 0);
+			     git_clone_usage, 0);
 
 	if (argc == 0)
 		die("You must specify a repository to clone.");
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 6467077..4d0e32b 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -24,7 +24,8 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char git_commit_tree_usage[] =
+"git commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -106,7 +107,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (argc < 2)
-		usage(commit_tree_usage);
+		usage(git_commit_tree_usage);
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
 
@@ -115,7 +116,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		const char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
+			usage(git_commit_tree_usage);
 
 		if (get_sha1(b, sha1))
 			die("Not a valid object name %s", b);
diff --git a/builtin-commit.c b/builtin-commit.c
index 200ffda..2602257 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -25,12 +25,12 @@
 #include "rerere.h"
 #include "unpack-trees.h"
 
-static const char * const builtin_commit_usage[] = {
+static const char * const git_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
 	NULL
 };
 
-static const char * const builtin_status_usage[] = {
+static const char * const git_status_usage[] = {
 	"git status [options] [--] <filepattern>...",
 	NULL
 };
@@ -897,7 +897,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (diff_use_color_default == -1)
 		diff_use_color_default = git_use_color_default;
 
-	argc = parse_and_validate_options(argc, argv, builtin_status_usage,
+	argc = parse_and_validate_options(argc, argv, git_status_usage,
 					  prefix, &s);
 	return dry_run_commit(argc, argv, prefix, &s);
 }
@@ -977,7 +977,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (s.use_color == -1)
 		s.use_color = git_use_color_default;
 
-	argc = parse_and_validate_options(argc, argv, builtin_commit_usage,
+	argc = parse_and_validate_options(argc, argv, git_commit_usage,
 					  prefix, &s);
 	if (dry_run) {
 		if (diff_use_color_default == -1)
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..ac59692 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 #include "parse-options.h"
 
-static const char *const builtin_config_usage[] = {
+static const char * const git_config_usage[] = {
 	"git config [options]",
 	NULL
 };
@@ -78,7 +78,7 @@ static void check_argc(int argc, int min, int max) {
 	if (argc >= min && argc <= max)
 		return;
 	error("wrong number of arguments");
-	usage_with_options(builtin_config_usage, builtin_config_options);
+	usage_with_options(git_config_usage, builtin_config_options);
 }
 
 static int show_all_config(const char *key_, const char *value_, void *cb)
@@ -317,12 +317,12 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 	config_exclusive_filename = getenv(CONFIG_ENVIRONMENT);
 
 	argc = parse_options(argc, argv, prefix, builtin_config_options,
-			     builtin_config_usage,
+			     git_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (use_global_config + use_system_config + !!given_config_file > 1) {
 		error("only one config file at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_with_options(git_config_usage, builtin_config_options);
 	}
 
 	if (use_global_config) {
@@ -353,7 +353,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	if (HAS_MULTI_BITS(types)) {
 		error("only one type at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_with_options(git_config_usage, builtin_config_options);
 	}
 
 	if (get_color_slot)
@@ -363,12 +363,12 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 
 	if ((get_color_slot || get_colorbool_slot) && types) {
 		error("--get-color and variable type are incoherent");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_with_options(git_config_usage, builtin_config_options);
 	}
 
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
-		usage_with_options(builtin_config_usage, builtin_config_options);
+		usage_with_options(git_config_usage, builtin_config_options);
 	}
 	if (actions == 0)
 		switch (argc) {
@@ -376,7 +376,7 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		case 2: actions = ACTION_SET; break;
 		case 3: actions = ACTION_SET_ALL; break;
 		default:
-			usage_with_options(builtin_config_usage, builtin_config_options);
+			usage_with_options(git_config_usage, builtin_config_options);
 		}
 
 	if (actions == ACTION_LIST) {
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 1b0b6c8..9ed17b5 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -65,7 +65,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 	}
 }
 
-static char const * const count_objects_usage[] = {
+static const char * const git_count_objects_usage[] = {
 	"git count-objects [-v]",
 	NULL
 };
@@ -83,10 +83,10 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, git_count_objects_usage, 0);
 	/* we do not take arguments other than flags for now */
 	if (argc)
-		usage_with_options(count_objects_usage, opts);
+		usage_with_options(git_count_objects_usage, opts);
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] != '/')
 		path[len++] = '/';
diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..50d2e6c 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -9,7 +9,7 @@
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
-static const char * const describe_usage[] = {
+static const char * const git_describe_usage[] = {
 	"git describe [options] <committish>*",
 	NULL
 };
@@ -327,7 +327,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_describe_usage, 0);
 	if (max_candidates < 0)
 		max_candidates = 0;
 	else if (max_candidates > MAX_TAGS)
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5b64011..7acfb55 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -9,7 +9,7 @@
 #include "revision.h"
 #include "builtin.h"
 
-static const char diff_files_usage[] =
+static const char git_diff_files_usage[] =
 "git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
@@ -34,7 +34,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q"))
 			options |= DIFF_SILENT_ON_REMOVED;
 		else
-			usage(diff_files_usage);
+			usage(git_diff_files_usage);
 		argv++; argc--;
 	}
 	if (!rev.diffopt.output_format)
@@ -48,7 +48,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1 ||
 	    3 < rev.max_count)
-		usage(diff_files_usage);
+		usage(git_diff_files_usage);
 
 	/*
 	 * "diff-files --base -p" should not combine merges because it
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 0483749..6e4e656 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -4,7 +4,7 @@
 #include "revision.h"
 #include "builtin.h"
 
-static const char diff_cache_usage[] =
+static const char git_diff_index_usage[] =
 "git diff-index [-m] [--cached] "
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
@@ -27,7 +27,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--cached"))
 			cached = 1;
 		else
-			usage(diff_cache_usage);
+			usage(git_diff_index_usage);
 	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -38,7 +38,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (rev.pending.nr != 1 ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
-		usage(diff_cache_usage);
+		usage(git_diff_index_usage);
 	if (!cached)
 		setup_work_tree();
 	if (read_cache() < 0) {
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 79cedb7..816b9a3 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -85,7 +85,7 @@ static int diff_tree_stdin(char *line)
 	return -1;
 }
 
-static const char diff_tree_usage[] =
+static const char git_diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
@@ -113,7 +113,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			read_stdin = 1;
 			continue;
 		}
-		usage(diff_tree_usage);
+		usage(git_diff_tree_usage);
 	}
 
 	if (!opt->diffopt.output_format)
@@ -128,7 +128,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	switch (nr_sha1) {
 	case 0:
 		if (!read_stdin)
-			usage(diff_tree_usage);
+			usage(git_diff_tree_usage);
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
diff --git a/builtin-diff.c b/builtin-diff.c
index ffcdd05..ae6e7e3 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -20,7 +20,7 @@ struct blobinfo {
 	unsigned mode;
 };
 
-static const char builtin_diff_usage[] =
+static const char git_diff_usage[] =
 "git diff <options> <rev>{0,2} -- <path>*";
 
 static void stuff_change(struct diff_options *opt,
@@ -67,7 +67,7 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	struct stat st;
 
 	if (argc > 1)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 
 	if (lstat(path, &st))
 		die_errno("failed to stat '%s'", path);
@@ -95,7 +95,7 @@ static int builtin_diff_blobs(struct rev_info *revs,
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
 	if (argc > 1)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 
 	if (blob[0].mode == S_IFINVALID)
 		blob[0].mode = mode;
@@ -121,7 +121,7 @@ static int builtin_diff_index(struct rev_info *revs,
 		if (!strcmp(arg, "--cached") || !strcmp(arg, "--staged"))
 			cached = 1;
 		else
-			usage(builtin_diff_usage);
+			usage(git_diff_usage);
 		argv++; argc--;
 	}
 	if (!cached)
@@ -133,7 +133,7 @@ static int builtin_diff_index(struct rev_info *revs,
 	if (revs->pending.nr != 1 ||
 	    revs->max_count != -1 || revs->min_age != -1 ||
 	    revs->max_age != -1)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 	if (read_cache_preload(revs->diffopt.paths) < 0) {
 		perror("read_cache_preload");
 		return -1;
@@ -149,7 +149,7 @@ static int builtin_diff_tree(struct rev_info *revs,
 	int swap = 0;
 
 	if (argc > 1)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 
 	/* We saw two trees, ent[0] and ent[1].
 	 * if ent[1] is uninteresting, they are swapped
@@ -172,7 +172,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 	int i;
 
 	if (argc > 1)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
@@ -219,7 +219,7 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		else if (!strcmp(argv[1], "-q"))
 			options |= DIFF_SILENT_ON_REMOVED;
 		else if (!strcmp(argv[1], "-h"))
-			usage(builtin_diff_usage);
+			usage(git_diff_usage);
 		else
 			return error("invalid option: %s", argv[1]);
 		argv++; argc--;
@@ -389,20 +389,20 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			break;
 		case 1:
 			if (paths != 1)
-				usage(builtin_diff_usage);
+				usage(git_diff_usage);
 			result = builtin_diff_b_f(&rev, argc, argv, blob, path);
 			break;
 		case 2:
 			if (paths)
-				usage(builtin_diff_usage);
+				usage(git_diff_usage);
 			result = builtin_diff_blobs(&rev, argc, argv, blob);
 			break;
 		default:
-			usage(builtin_diff_usage);
+			usage(git_diff_usage);
 		}
 	}
 	else if (blobs)
-		usage(builtin_diff_usage);
+		usage(git_diff_usage);
 	else if (ents == 1)
 		result = builtin_diff_index(&rev, argc, argv);
 	else if (ents == 2)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b0a4029..cf751a9 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -17,7 +17,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 
-static const char *fast_export_usage[] = {
+static const char * const git_fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
 	NULL
 };
@@ -591,7 +591,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	};
 
 	if (argc == 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(git_fast_export_usage, options);
 
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
@@ -601,9 +601,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.show_source = 1;
 	revs.rewrite_parents = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_fast_export_usage, 0);
 	if (argc > 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(git_fast_export_usage, options);
 
 	if (import_filename)
 		import_marks(import_filename);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..5c546f9 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -18,7 +18,7 @@ static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
 
-static const char fetch_pack_usage[] =
+static const char git_fetch_pack_usage[] =
 "git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
@@ -734,7 +734,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.no_progress = 1;
 				continue;
 			}
-			usage(fetch_pack_usage);
+			usage(git_fetch_pack_usage);
 		}
 		dest = (char *)arg;
 		heads = (char **)(argv + i + 1);
@@ -742,7 +742,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	if (!dest)
-		usage(fetch_pack_usage);
+		usage(git_fetch_pack_usage);
 
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..42d2ffc 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "sigchain.h"
 
-static const char * const builtin_fetch_usage[] = {
+static const char * const git_fetch_usage[] = {
 	"git fetch [options] [<repository> <refspec>...]",
 	NULL
 };
@@ -653,7 +653,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
 	argc = parse_options(argc, argv, prefix,
-			     builtin_fetch_options, builtin_fetch_usage, 0);
+			     builtin_fetch_options, git_fetch_usage, 0);
 
 	if (argc == 0)
 		remote = remote_get(NULL);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 9d52400..1b375e9 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -5,7 +5,7 @@
 #include "revision.h"
 #include "tag.h"
 
-static const char * const fmt_merge_msg_usage[] = {
+static const char * const git_fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
 	NULL
 };
@@ -360,10 +360,10 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
-	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
+	argc = parse_options(argc, argv, prefix, options, git_fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
-		usage_with_options(fmt_merge_msg_usage, options);
+		usage_with_options(git_fmt_merge_msg_usage, options);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index a5a83f1..37e3c38 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -881,7 +881,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static char const * const for_each_ref_usage[] = {
+static const char * const git_for_each_ref_usage[] = {
 	"git for-each-ref [options] [<pattern>]",
 	NULL
 };
@@ -913,17 +913,17 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	parse_options(argc, argv, prefix, opts, git_for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(git_for_each_ref_usage, opts);
 	}
 	if (HAS_MULTI_BITS(quote_style)) {
 		error("more than one quoting style?");
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(git_for_each_ref_usage, opts);
 	}
 	if (verify_format(format))
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(git_for_each_ref_usage, opts);
 
 	if (!sort)
 		sort = default_sort();
diff --git a/builtin-fsck.c b/builtin-fsck.c
index c58b0e3..76da573 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -564,7 +564,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
-static char const * const fsck_usage[] = {
+static const char * const git_fsck_usage[] = {
 	"git fsck [options] [<object>...]",
 	NULL
 };
@@ -591,7 +591,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	errors_found = 0;
 	read_replace_refs = 0;
 
-	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
+	argc = parse_options(argc, argv, prefix, fsck_opts, git_fsck_usage, 0);
 	if (write_lost_and_found) {
 		check_full = 1;
 		include_reflogs = 0;
diff --git a/builtin-gc.c b/builtin-gc.c
index 7d3e9cc..ecacd1c 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -17,7 +17,7 @@
 
 #define FAILED_RUN "failed to run %s"
 
-static const char * const builtin_gc_usage[] = {
+static const char * const git_gc_usage[] = {
 	"git gc [options]",
 	NULL
 };
@@ -195,9 +195,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		pack_refs = !is_bare_repository();
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
-			     builtin_gc_usage, 0);
+			     git_gc_usage, 0);
 	if (argc > 0)
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+		usage_with_options(git_gc_usage, builtin_gc_options);
 
 	if (aggressive) {
 		append_option(argv_repack, "-f", MAX_ADD);
diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..0517440 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -23,7 +23,7 @@
 #endif
 #endif
 
-static char const * const grep_usage[] = {
+static const char * const git_grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
 	NULL
 };
@@ -813,7 +813,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * unrecognized non option is the beginning of the refs list
 	 * that continues up to the -- (if exists), and then paths.
 	 */
-	argc = parse_options(argc, argv, prefix, options, grep_usage,
+	argc = parse_options(argc, argv, prefix, options, git_grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
diff --git a/builtin-help.c b/builtin-help.c
index e1eba77..bf9b5fb 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -40,7 +40,7 @@ static struct option builtin_help_options[] = {
 	OPT_END(),
 };
 
-static const char * const builtin_help_usage[] = {
+static const char * const git_help_usage[] = {
 	"git help [--all] [--man|--web|--info] [command]",
 	NULL
 };
@@ -420,7 +420,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	git_config(git_help_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
-			builtin_help_usage, 0);
+			git_help_usage, 0);
 
 	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..25448d2 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -377,7 +377,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static const char *const init_db_usage[] = {
+static const char * const git_init_db_usage[] = {
 	"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]",
 	NULL
 };
@@ -406,7 +406,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
+	argc = parse_options(argc, argv, prefix, init_db_options, git_init_db_usage, 0);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -440,7 +440,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			die_errno("cannot chdir to %s", argv[0]);
 		}
 	} else if (0 < argc) {
-		usage(init_db_usage[0]);
+		usage(git_init_db_usage[0]);
 	}
 	if (is_bare_repository_cfg == 1) {
 		static char git_dir[PATH_MAX+1];
diff --git a/builtin-log.c b/builtin-log.c
index 25e21ed..5d17d65 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -27,9 +27,9 @@ static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
-static const char * const builtin_log_usage =
-	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-	"   or: git show [options] <object>...";
+static const char * const git_log_usage =
+"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
+"   or: git show [options] <object>...";
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
@@ -74,7 +74,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
 		} else if (!strcmp(arg, "-h")) {
-			usage(builtin_log_usage);
+			usage(git_log_usage);
 		} else
 			die("unrecognized argument: %s", arg);
 	}
@@ -769,7 +769,7 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 				       output_directory));
 }
 
-static const char * const builtin_format_patch_usage[] = {
+static const char * const git_format_patch_usage[] = {
 	"git format-patch [options] [<since> | <revision range>]",
 	NULL
 };
@@ -965,7 +965,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	 * possibly a valid SHA1.
 	 */
 	argc = parse_options(argc, argv, prefix, builtin_format_patch_options,
-			     builtin_format_patch_usage,
+			     git_format_patch_usage,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
 
 	if (do_signoff) {
@@ -1217,7 +1217,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 	return -1;
 }
 
-static const char cherry_usage[] =
+static const char git_cherry_usage[] =
 "git cherry [-v] [<upstream> [<head> [<limit>]]]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
@@ -1255,7 +1255,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, "Could not find a tracked"
 					" remote branch, please"
 					" specify <upstream> manually.\n");
-			usage(cherry_usage);
+			usage(git_cherry_usage);
 		}
 
 		upstream = current_branch->merge[0]->dst;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..781cf3d 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -373,7 +373,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 	return errors;
 }
 
-static const char * const ls_files_usage[] = {
+static const char * const git_ls_files_usage[] = {
 	"git ls-files [options] [<file>]*",
 	NULL
 };
@@ -482,7 +482,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
-			ls_files_usage, 0);
+			git_ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..bc257b4 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -3,7 +3,7 @@
 #include "transport.h"
 #include "remote.h"
 
-static const char ls_remote_usage[] =
+static const char git_ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>] <repository> <refs>...";
 
 /*
@@ -66,7 +66,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				flags |= REF_NORMAL;
 				continue;
 			}
-			usage(ls_remote_usage);
+			usage(git_ls_remote_usage);
 		}
 		dest = arg;
 		i++;
@@ -74,7 +74,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!dest)
-		usage(ls_remote_usage);
+		usage(git_ls_remote_usage);
 
 	if (argv[i]) {
 		int j;
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 22008df..d701ca0 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -22,8 +22,8 @@ static const char **pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 
-static const char ls_tree_usage[] =
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
+static const char git_ls_tree_usage[] =
+"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -172,7 +172,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			}
 			/* otherwise fallthru */
 		default:
-			usage(ls_tree_usage);
+			usage(git_ls_tree_usage);
 		}
 		argc--; argv++;
 	}
@@ -182,7 +182,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_options |= LS_SHOW_TREES;
 
 	if (argc < 2)
-		usage(ls_tree_usage);
+		usage(git_ls_tree_usage);
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d498b1c..2349c95 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1003,8 +1003,8 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 	return 0;
 }
 
-static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
+static const char git_mailinfo_usage[] =
+"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -1032,12 +1032,12 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--no-scissors"))
 			use_scissors = 0;
 		else
-			usage(mailinfo_usage);
+			usage(git_mailinfo_usage);
 		argc--; argv++;
 	}
 
 	if (argc != 3)
-		usage(mailinfo_usage);
+		usage(git_mailinfo_usage);
 
 	return !!mailinfo(stdin, stdout, argv[1], argv[2]);
 }
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 54e7ec2..8b9dd4d 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -22,7 +22,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 	return 0;
 }
 
-static const char * const merge_base_usage[] = {
+static const char * const git_merge_base_usage[] = {
 	"git merge-base [-a|--all] <commit> <commit>...",
 	NULL
 };
@@ -53,9 +53,9 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_merge_base_usage, 0);
 	if (argc < 2)
-		usage_with_options(merge_base_usage, options);
+		usage_with_options(git_merge_base_usage, options);
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index afd2ea7..381946c 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -4,7 +4,7 @@
 #include "xdiff-interface.h"
 #include "parse-options.h"
 
-static const char *const merge_file_usage[] = {
+static const char * const git_merge_file_usage[] = {
 	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2",
 	NULL
 };
@@ -48,9 +48,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			merge_style = git_xmerge_style;
 	}
 
-	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_merge_file_usage, 0);
 	if (argc != 3)
-		usage_with_options(merge_file_usage, options);
+		usage_with_options(git_merge_file_usage, options);
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
 			return error("failed to redirect stderr to /dev/null: "
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..44129fa 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -35,7 +35,7 @@ struct strategy {
 	unsigned attr;
 };
 
-static const char * const builtin_merge_usage[] = {
+static const char * const git_merge_usage[] = {
 	"git merge [options] <remote>...",
 	"git merge [options] <msg> HEAD <remote>",
 	NULL
@@ -467,7 +467,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
 		argc++;
 		parse_options(argc, argv, NULL, builtin_merge_options,
-			      builtin_merge_usage, 0);
+			      git_merge_usage, 0);
 		free(buf);
 	}
 
@@ -864,7 +864,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	argc = parse_options(argc, argv, prefix, builtin_merge_options,
-			builtin_merge_usage, 0);
+			git_merge_usage, 0);
 	if (verbosity < 0)
 		show_diffstat = 0;
 
@@ -875,7 +875,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!argc)
-		usage_with_options(builtin_merge_usage,
+		usage_with_options(git_merge_usage,
 			builtin_merge_options);
 
 	/*
@@ -936,7 +936,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	}
 
 	if (head_invalid || !argc)
-		usage_with_options(builtin_merge_usage,
+		usage_with_options(git_merge_usage,
 			builtin_merge_options);
 
 	strbuf_addstr(&buf, "merge");
diff --git a/builtin-mktree.c b/builtin-mktree.c
index 098395f..ff3b0f7 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -62,7 +62,7 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char *mktree_usage[] = {
+static const char * const git_mktree_usage[] = {
 	"git mktree [-z] [--missing] [--batch]",
 	NULL
 };
@@ -139,7 +139,7 @@ static void mktree_line(char *buf, size_t len, int line_termination, int allow_m
 	append_to_tree(mode, sha1, path);
 }
 
-int cmd_mktree(int ac, const char **av, const char *prefix)
+int cmd_mktree(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
@@ -155,7 +155,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 		OPT_END()
 	};
 
-	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
+	argc = parse_options(argc, argv, prefix, option, git_mktree_usage, 0);
 
 	while (!got_eof) {
 		while (1) {
diff --git a/builtin-mv.c b/builtin-mv.c
index 1b20028..b5879bd 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -10,7 +10,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 
-static const char * const builtin_mv_usage[] = {
+static const char * const git_mv_usage[] = {
 	"git mv [options] <source>... <destination>",
 	NULL
 };
@@ -69,9 +69,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_mv_options,
-			     builtin_mv_usage, 0);
+			     git_mv_usage, 0);
 	if (--argc < 1)
-		usage_with_options(builtin_mv_usage, builtin_mv_options);
+		usage_with_options(git_mv_usage, builtin_mv_options);
 
 	source = copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
@@ -86,7 +86,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		destination = copy_pathspec(dest_path[0], argv, argc, 1);
 	} else {
 		if (argc != 1)
-			usage_with_options(builtin_mv_usage, builtin_mv_options);
+			usage_with_options(git_mv_usage, builtin_mv_options);
 		destination = dest_path;
 	}
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 06a38ac..e5e9e1b 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -171,7 +171,7 @@ static void show_name(const struct object *obj,
 		die("cannot describe '%s'", sha1_to_hex(sha1));
 }
 
-static char const * const name_rev_usage[] = {
+static const char * const git_name_rev_usage[] = {
 	"git name-rev [options] ( --all | --stdin | <commit>... )",
 	NULL
 };
@@ -238,10 +238,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, git_name_rev_usage, 0);
 	if (!!all + !!transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
-		usage_with_options(name_rev_usage, opts);
+		usage_with_options(git_name_rev_usage, opts);
 	}
 	if (all || transform_stdin)
 		cutoff = 0;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..3f7a630 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -22,7 +22,7 @@
 #include <pthread.h>
 #endif
 
-static const char pack_usage[] =
+static const char git_pack_objects_usage[] =
   "git pack-objects [{ -q | --progress | --all-progress }]\n"
   "        [--max-pack-size=N] [--local] [--incremental]\n"
   "        [--window=N] [--window-memory=N] [--depth=N]\n"
@@ -2166,7 +2166,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			char *end;
 			int level = strtoul(arg+14, &end, 0);
 			if (!arg[14] || *end)
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 			if (level == -1)
 				level = Z_DEFAULT_COMPRESSION;
 			else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -2179,26 +2179,26 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			pack_size_limit_cfg = 0;
 			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
 			if (!arg[16] || *end)
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
 			if (!arg[9] || *end)
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--window-memory=")) {
 			if (!git_parse_ulong(arg+16, &window_memory_limit))
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--threads=")) {
 			char *end;
 			delta_search_threads = strtoul(arg+10, &end, 0);
 			if (!arg[10] || *end || delta_search_threads < 0)
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 #ifndef THREADED_DELTA_SEARCH
 			if (delta_search_threads != 1)
 				warning("no threads support, "
@@ -2210,7 +2210,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			char *end;
 			depth = strtoul(arg+8, &end, 0);
 			if (!arg[8] || *end)
-				usage(pack_usage);
+				usage(git_pack_objects_usage);
 			continue;
 		}
 		if (!strcmp("--progress", arg)) {
@@ -2290,7 +2290,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			grafts_replace_parents = 0;
 			continue;
 		}
-		usage(pack_usage);
+		usage(git_pack_objects_usage);
 	}
 
 	/* Traditionally "pack-objects [options] base extra" failed;
@@ -2310,7 +2310,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		base_name = argv[i++];
 
 	if (pack_to_stdout != !base_name)
-		usage(pack_usage);
+		usage(git_pack_objects_usage);
 
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 091860b..32f59fb 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -2,7 +2,7 @@
 #include "parse-options.h"
 #include "pack-refs.h"
 
-static char const * const pack_refs_usage[] = {
+static const char * const git_pack_refs_usage[] = {
 	"git pack-refs [options]",
 	NULL
 };
@@ -15,7 +15,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_PRUNE),
 		OPT_END(),
 	};
-	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
-		usage_with_options(pack_refs_usage, opts);
+	if (parse_options(argc, argv, prefix, opts, git_pack_refs_usage, 0))
+		usage_with_options(git_pack_refs_usage, opts);
 	return pack_refs(flags);
 }
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index be99eb0..ffb1cdd 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -3,7 +3,7 @@
 #include "progress.h"
 #include "parse-options.h"
 
-static const char * const prune_packed_usage[] = {
+static const char * const git_prune_packed_usage[] = {
 	"git prune-packed [-n|--dry-run] [-q|--quiet]",
 	NULL
 };
@@ -79,7 +79,7 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, prune_packed_options,
-			     prune_packed_usage, 0);
+			     git_prune_packed_usage, 0);
 
 	prune_packed_objects(opts);
 	return 0;
diff --git a/builtin-prune.c b/builtin-prune.c
index 8459aec..a983689 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 #include "dir.h"
 
-static const char * const prune_usage[] = {
+static const char * const git_prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
 	NULL
 };
@@ -143,7 +143,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 	init_revisions(&revs, prefix);
 
-	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_prune_usage, 0);
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name = *argv++;
diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..7b7817c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -9,7 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 
-static const char * const push_usage[] = {
+static const char * const git_push_usage[] = {
 	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
@@ -191,7 +191,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, git_push_usage, 0);
 
 	if (tags)
 		add_refspec("refs/tags/*");
@@ -203,7 +203,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	rc = do_push(repo, flags);
 	if (rc == -1)
-		usage_with_options(push_usage, options);
+		usage_with_options(git_push_usage, options);
 	else
 		return rc;
 }
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 14c836b..c7edeea 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -30,7 +30,7 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static const char * const read_tree_usage[] = {
+static const char * const git_read_tree_usage[] = {
 	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]]  [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
 	NULL
 };
@@ -111,7 +111,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	newfd = hold_locked_index(&lock_file, 1);
 
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
-			     read_tree_usage, 0);
+			     git_read_tree_usage, 0);
 
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..1c2146a 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -9,7 +9,7 @@
 #include "remote.h"
 #include "transport.h"
 
-static const char receive_pack_usage[] = "git receive-pack <git-dir>";
+static const char git_receive_pack_usage[] = "git receive-pack <git-dir>";
 
 enum deny_action {
 	DENY_UNCONFIGURED,
@@ -624,14 +624,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 		if (*arg == '-') {
 			/* Do flag handling here */
-			usage(receive_pack_usage);
+			usage(git_receive_pack_usage);
 		}
 		if (dir)
-			usage(receive_pack_usage);
+			usage(git_receive_pack_usage);
 		dir = xstrdup(arg);
 	}
 	if (!dir)
-		usage(receive_pack_usage);
+		usage(git_receive_pack_usage);
 
 	setup_path();
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index e23b5ef..a1d8674 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -693,7 +693,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
  * main "reflog"
  */
 
-static const char reflog_usage[] =
+static const char git_reflog_usage[] =
 "git reflog [ show | expire | delete ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
@@ -712,5 +712,5 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
 	/* Not a recognized reflog command..*/
-	usage(reflog_usage);
+	usage(git_reflog_usage);
 }
diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..4e6a02c 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -7,7 +7,7 @@
 #include "run-command.h"
 #include "refs.h"
 
-static const char * const builtin_remote_usage[] = {
+static const char * const git_remote_usage[] = {
 	"git remote [-v | --verbose]",
 	"git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>",
 	"git remote rename <old> <new>",
@@ -79,11 +79,11 @@ static int add(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, git_remote_usage,
 			     0);
 
 	if (argc < 2)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 
 	name = argv[0];
 	url = argv[1];
@@ -540,7 +540,7 @@ static int mv(int argc, const char **argv)
 	int i;
 
 	if (argc != 3)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 
 	rename.old = argv[1];
 	rename.new = argv[2];
@@ -681,7 +681,7 @@ static int rm(int argc, const char **argv)
 	int i, result;
 
 	if (argc != 2)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 
 	remote = remote_get(argv[1]);
 	if (!remote)
@@ -984,7 +984,7 @@ static int show(int argc, const char **argv)
 	struct string_list info_list = { NULL, 0, 0, 0 };
 	struct show_info info;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, git_remote_usage,
 			     0);
 
 	if (argc < 1)
@@ -1088,7 +1088,7 @@ static int set_head(int argc, const char **argv)
 			    "delete refs/remotes/<name>/HEAD"),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, git_remote_usage,
 			     0);
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
@@ -1114,7 +1114,7 @@ static int set_head(int argc, const char **argv)
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
 			result |= error("Could not delete %s", buf.buf);
 	} else
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 
 	if (head_name) {
 		unsigned char sha1[20];
@@ -1143,11 +1143,11 @@ static int prune(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, git_remote_usage,
 			     0);
 
 	if (argc < 1)
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 
 	for (; argc; argc--, argv++)
 		result |= prune_remote(*argv, dry_run);
@@ -1234,7 +1234,7 @@ static int update(int argc, const char **argv)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, NULL, options, git_remote_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		argc = 2;
@@ -1339,7 +1339,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 	};
 	int result;
 
-	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
+	argc = parse_options(argc, argv, prefix, options, git_remote_usage,
 		PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (argc < 1)
@@ -1360,7 +1360,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 		result = update(argc, argv);
 	else {
 		error("Unknown subcommand: %s", argv[0]);
-		usage_with_options(builtin_remote_usage, options);
+		usage_with_options(git_remote_usage, options);
 	}
 
 	return result ? 1 : 0;
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..adfc2a5 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -8,7 +8,7 @@
 #include "graph.h"
 #include "bisect.h"
 
-static const char rev_list_usage[] =
+static const char git_rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
 "    --max-count=nr\n"
@@ -354,7 +354,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
-		usage(rev_list_usage);
+		usage(git_rev_list_usage);
 
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
@@ -373,7 +373,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
-		usage(rev_list_usage);
+		usage(git_rev_list_usage);
 
 	save_commit_buffer = revs.verbose_header ||
 		revs.grep_filter.pattern_list;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 45bead6..c91b056 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -302,7 +302,7 @@ static const char *skipspaces(const char *s)
 static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 {
 	static int keep_dashdash = 0, stop_at_non_option = 0;
-	static char const * const parseopt_usage[] = {
+	static const char * const parseopt_usage[] = {
 		"git rev-parse --parseopt [options] -- [<args>...]",
 		NULL
 	};
diff --git a/builtin-revert.c b/builtin-revert.c
index 151aa6a..750255f 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -25,12 +25,12 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
-static const char * const revert_usage[] = {
+static const char * const git_revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
 };
 
-static const char * const cherry_pick_usage[] = {
+static const char * const git_cherry_pick_usage[] = {
 	"git cherry-pick [options] <commit-ish>",
 	NULL
 };
@@ -46,7 +46,7 @@ static const char *me;
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
-		action == REVERT ?  revert_usage : cherry_pick_usage;
+		action == REVERT ?  git_revert_usage : git_cherry_pick_usage;
 	unsigned char sha1[20];
 	const char *arg;
 	int noop;
diff --git a/builtin-rm.c b/builtin-rm.c
index 57975db..861981d 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -10,7 +10,7 @@
 #include "tree-walk.h"
 #include "parse-options.h"
 
-static const char * const builtin_rm_usage[] = {
+static const char * const git_rm_usage[] = {
 	"git rm [options] [--] <file>...",
 	NULL
 };
@@ -158,9 +158,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_rm_options,
-			     builtin_rm_usage, 0);
+			     git_rm_usage, 0);
 	if (!argc)
-		usage_with_options(builtin_rm_usage, builtin_rm_options);
+		usage_with_options(git_rm_usage, builtin_rm_options);
 
 	if (!index_only)
 		setup_work_tree();
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..b77ae1d 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -6,7 +6,7 @@
 #include "remote.h"
 #include "send-pack.h"
 
-static const char send_pack_usage[] =
+static const char git_send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
@@ -523,7 +523,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.use_thin_pack = 1;
 				continue;
 			}
-			usage(send_pack_usage);
+			usage(git_send_pack_usage);
 		}
 		if (!dest) {
 			dest = arg;
@@ -534,14 +534,14 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	if (!dest)
-		usage(send_pack_usage);
+		usage(git_send_pack_usage);
 	/*
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
 	if ((refspecs && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
-		usage(send_pack_usage);
+		usage(git_send_pack_usage);
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4d4a3c8..a342535 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,7 +9,7 @@
 #include "shortlog.h"
 #include "parse-options.h"
 
-static char const * const shortlog_usage[] = {
+static const char * const git_shortlog_usage[] = {
 	"git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]",
 	"",
 	"[rev-opts] are documented in git-rev-list(1)",
@@ -267,20 +267,20 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_KEEP_ARGV0);
 
 	for (;;) {
-		switch (parse_options_step(&ctx, options, shortlog_usage)) {
+		switch (parse_options_step(&ctx, options, git_shortlog_usage)) {
 		case PARSE_OPT_HELP:
 			exit(129);
 		case PARSE_OPT_DONE:
 			goto parse_done;
 		}
-		parse_revision_opt(&rev, &ctx, options, shortlog_usage);
+		parse_revision_opt(&rev, &ctx, options, git_shortlog_usage);
 	}
 parse_done:
 	argc = parse_options_end(&ctx);
 
 	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
 		error("unrecognized argument: %s", argv[1]);
-		usage_with_options(shortlog_usage, options);
+		usage_with_options(git_shortlog_usage, options);
 	}
 
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..6aaa949 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -5,7 +5,7 @@
 #include "color.h"
 #include "parse-options.h"
 
-static const char* show_branch_usage[] = {
+static const char * const git_show_branch_usage[] = {
     "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
     "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
     NULL
@@ -697,7 +697,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
-			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+			   git_show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (all_heads)
 		all_remotes = 1;
 
@@ -706,7 +706,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		 * independent nor merge-base modes.
 		 */
 		if (independent || merge_base)
-			usage_with_options(show_branch_usage,
+			usage_with_options(git_show_branch_usage,
 					   builtin_show_branch_options);
 		if (reflog && ((0 < extra) || all_heads || all_remotes))
 			/*
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index c46550c..1d53216 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 
-static const char * const show_ref_usage[] = {
+static const char * const git_show_ref_usage[] = {
 	"git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] ",
 	"git show-ref --exclude-existing[=pattern] < ref-list",
 	NULL
@@ -202,7 +202,7 @@ static const struct option show_ref_options[] = {
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	argc = parse_options(argc, argv, prefix, show_ref_options,
-			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
+			     git_show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
 	if (exclude_arg)
 		return exclude_existing(exclude_existing_arg);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 8b3a35e..c34ab77 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -7,7 +7,7 @@
 #include "builtin.h"
 #include "quote.h"
 
-static const char tar_tree_usage[] =
+static const char git_tar_tree_usage[] =
 "git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
 "*** Note that this command is now deprecated; use \"git archive\" instead.";
 
@@ -45,7 +45,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 
 	switch (argc) {
 	default:
-		usage(tar_tree_usage);
+		usage(git_tar_tree_usage);
 		break;
 	case 3:
 		/* base-path */
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 685566e..d7b1b8b 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,8 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char git_unpack_usage[] =
+"git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -538,11 +539,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
-			usage(unpack_usage);
+			usage(git_unpack_usage);
 		}
 
 		/* We don't take any non-flag arguments now.. Maybe some day */
-		usage(unpack_usage);
+		usage(git_unpack_usage);
 	}
 	git_SHA1_Init(&ctx);
 	unpack_all();
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..1a3716e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -387,7 +387,7 @@ static void read_index_info(int line_termination)
 	strbuf_release(&uq);
 }
 
-static const char update_index_usage[] =
+static const char git_update_index_usage[] =
 "git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
@@ -703,7 +703,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
-				usage(update_index_usage);
+				usage(git_update_index_usage);
 			die("unknown option %s", path);
 		}
 		setup_work_tree();
diff --git a/builtin-update-server-info.c b/builtin-update-server-info.c
index 2b3fddc..12ea6f4 100644
--- a/builtin-update-server-info.c
+++ b/builtin-update-server-info.c
@@ -2,7 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 
-static const char * const update_server_info_usage[] = {
+static const char * const git_update_server_info_usage[] = {
 	"git update-server-info [--force]",
 	NULL
 };
@@ -17,9 +17,9 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     update_server_info_usage, 0);
+			     git_update_server_info_usage, 0);
 	if (argc > 0)
-		usage_with_options(update_server_info_usage, options);
+		usage_with_options(git_update_server_info_usage, options);
 
 	return !!update_server_info(force);
 }
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index c4cd1e1..e24e7c6 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -7,8 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 
-static const char upload_archive_usage[] =
-	"git upload-archive <repo>";
+static const char git_upload_archive_usage[] = "git upload-archive <repo>";
 
 static const char deadchild[] =
 "git upload-archive: archiver died with error";
@@ -27,7 +26,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	int len;
 
 	if (argc != 2)
-		usage(upload_archive_usage);
+		usage(git_upload_archive_usage);
 
 	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index b6079ae..6a380fa 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -133,7 +133,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	return err;
 }
 
-static const char * const verify_pack_usage[] = {
+static const char * const git_verify_pack_usage[] = {
 	"git verify-pack [-v|--verbose] [-s|--stat-only] <pack>...",
 	NULL
 };
@@ -153,9 +153,9 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, verify_pack_options,
-			     verify_pack_usage, 0);
+			     git_verify_pack_usage, 0);
 	if (argc < 1)
-		usage_with_options(verify_pack_usage, verify_pack_options);
+		usage_with_options(git_verify_pack_usage, verify_pack_options);
 	for (i = 0; i < argc; i++) {
 		if (verify_one_pack(argv[i], flags))
 			err = 1;
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 9f482c2..0fd981d 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 #include "parse-options.h"
 
-static const char * const verify_tag_usage[] = {
+static const char * const git_verify_tag_usage[] = {
 		"git verify-tag [-v|--verbose] <tag>...",
 		NULL
 };
@@ -100,9 +100,9 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
-			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
+			     git_verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <= i)
-		usage_with_options(verify_tag_usage, verify_tag_options);
+		usage_with_options(git_verify_tag_usage, verify_tag_options);
 
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index b223af4..6456c86 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -9,7 +9,7 @@
 #include "cache-tree.h"
 #include "parse-options.h"
 
-static const char * const write_tree_usage[] = {
+static const char * const git_write_tree_usage[] = {
 	"git write-tree [--missing-ok] [--prefix=<prefix>/]",
 	NULL
 };
@@ -35,7 +35,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
-			     write_tree_usage, 0);
+			     git_write_tree_usage, 0);
 
 	ret = write_cache_as_tree(sha1, flags, prefix);
 	switch (ret) {
diff --git a/daemon.c b/daemon.c
index 1b5ada6..8cf8f6d 100644
--- a/daemon.c
+++ b/daemon.c
@@ -18,7 +18,7 @@ static int log_syslog;
 static int verbose;
 static int reuseaddr;
 
-static const char daemon_usage[] =
+static const char git_daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--max-connections=n]\n"
 "           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
@@ -1097,7 +1097,7 @@ int main(int argc, char **argv)
 			break;
 		}
 
-		usage(daemon_usage);
+		usage(git_daemon_usage);
 	}
 
 	if (log_syslog) {
diff --git a/fast-import.c b/fast-import.c
index 7ef9865..c04b4d4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2393,7 +2393,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	return git_default_config(k, v, cb);
 }
 
-static const char fast_import_usage[] =
+static const char git_fast_import_usage[] =
 "git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
 int main(int argc, const char **argv)
@@ -2459,7 +2459,7 @@ int main(int argc, const char **argv)
 			die("unknown option %s", a);
 	}
 	if (i != argc)
-		usage(fast_import_usage);
+		usage(git_fast_import_usage);
 
 	rc_free = pool_alloc(cmd_save * sizeof(*rc_free));
 	for (i = 0; i < (cmd_save - 1); i++)
diff --git a/hash-object.c b/hash-object.c
index 9455dd0..5f3e39c 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -50,7 +50,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 	strbuf_release(&nbuf);
 }
 
-static const char * const hash_object_usage[] = {
+static const char * const git_hash_object_usage[] = {
 	"git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...",
 	"git hash-object  --stdin-paths < <list-of-paths>",
 	NULL
@@ -85,7 +85,7 @@ int main(int argc, const char **argv)
 	git_extract_argv0_path(argv[0]);
 
 	argc = parse_options(argc, argv, NULL, hash_object_options,
-			     hash_object_usage, 0);
+			     git_hash_object_usage, 0);
 
 	if (write_object) {
 		prefix = setup_git_directory();
@@ -115,7 +115,7 @@ int main(int argc, const char **argv)
 
 	if (errstr) {
 		error("%s", errstr);
-		usage_with_options(hash_object_usage, hash_object_options);
+		usage_with_options(git_hash_object_usage, hash_object_options);
 	}
 
 	if (hashstdin)
diff --git a/http-push.c b/http-push.c
index 00e83dc..473b8ee 100644
--- a/http-push.c
+++ b/http-push.c
@@ -13,7 +13,7 @@
 
 #include <expat.h>
 
-static const char http_push_usage[] =
+static const char git_http_push_usage[] =
 "git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
@@ -1849,7 +1849,7 @@ int main(int argc, char **argv)
 #endif
 
 	if (!repo->url)
-		usage(http_push_usage);
+		usage(git_http_push_usage);
 
 	if (delete_branch && nr_refspec != 1)
 		die("You must specify only one branch name when deleting a remote branch");
diff --git a/index-pack.c b/index-pack.c
index 340074f..344b2f2 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -10,7 +10,7 @@
 #include "fsck.h"
 #include "exec_cmd.h"
 
-static const char index_pack_usage[] =
+static const char git_index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
@@ -933,7 +933,7 @@ int main(int argc, char **argv)
 				verbose = 1;
 			} else if (!strcmp(arg, "-o")) {
 				if (index_name || (i+1) >= argc)
-					usage(index_pack_usage);
+					usage(git_index_pack_usage);
 				index_name = argv[++i];
 			} else if (!prefixcmp(arg, "--index-version=")) {
 				char *c;
@@ -945,17 +945,17 @@ int main(int argc, char **argv)
 				if (*c || pack_idx_off32_limit & 0x80000000)
 					die("bad %s", arg);
 			} else
-				usage(index_pack_usage);
+				usage(git_index_pack_usage);
 			continue;
 		}
 
 		if (pack_name)
-			usage(index_pack_usage);
+			usage(git_index_pack_usage);
 		pack_name = arg;
 	}
 
 	if (!pack_name && !from_stdin)
-		usage(index_pack_usage);
+		usage(git_index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die("--fix-thin cannot be used without --stdin");
 	if (!index_name && pack_name) {
diff --git a/merge-tree.c b/merge-tree.c
index f01e7c8..3a430b8 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -4,7 +4,9 @@
 #include "blob.h"
 #include "exec_cmd.h"
 
-static const char merge_tree_usage[] = "git merge-tree <base-tree> <branch1> <branch2>";
+static const char git_merge_tree_usage[] =
+"git merge-tree <base-tree> <branch1> <branch2>";
+
 static int resolve_directories = 1;
 
 struct merge_list {
@@ -343,7 +345,7 @@ int main(int argc, char **argv)
 	void *buf1, *buf2, *buf3;
 
 	if (argc != 4)
-		usage(merge_tree_usage);
+		usage(git_merge_tree_usage);
 
 	git_extract_argv0_path(argv[0]);
 
diff --git a/pack-redundant.c b/pack-redundant.c
index 69a7ab2..9cb096d 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -11,7 +11,7 @@
 
 #define BLKSIZE 512
 
-static const char pack_redundant_usage[] =
+static const char git_pack_redundant_usage[] =
 "git pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
 
 static int load_all_packs, verbose, alt_odb;
@@ -624,7 +624,7 @@ int main(int argc, char **argv)
 			continue;
 		}
 		if (*arg == '-')
-			usage(pack_redundant_usage);
+			usage(git_pack_redundant_usage);
 		else
 			break;
 	}
diff --git a/patch-id.c b/patch-id.c
index 0df4cb0..46ee1b2 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -73,12 +73,12 @@ static void generate_id_list(void)
 	flush_current_id(patchlen, sha1, &ctx);
 }
 
-static const char patch_id_usage[] = "git patch-id < patch";
+static const char git_patch_id_usage[] = "git patch-id < patch";
 
 int main(int argc, char **argv)
 {
 	if (argc != 1)
-		usage(patch_id_usage);
+		usage(git_patch_id_usage);
 
 	git_extract_argv0_path(argv[0]);
 
diff --git a/upload-pack.c b/upload-pack.c
index 38ddac2..82ed0d2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -11,7 +11,8 @@
 #include "list-objects.h"
 #include "run-command.h"
 
-static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=nn] <dir>";
+static const char git_upload_pack_usage[] =
+"git upload-pack [--strict] [--timeout=nn] <dir>";
 
 /* bits #0..7 in revision.h, #8..10 in commit.c */
 #define THEY_HAVE	(1u << 11)
@@ -748,7 +749,7 @@ int main(int argc, char **argv)
 	}
 
 	if (i != argc-1)
-		usage(upload_pack_usage);
+		usage(git_upload_pack_usage);
 
 	setup_path();
 
diff --git a/var.c b/var.c
index 125c0d1..402b5d3 100644
--- a/var.c
+++ b/var.c
@@ -6,7 +6,7 @@
 #include "cache.h"
 #include "exec_cmd.h"
 
-static const char var_usage[] = "git var [-l | <variable>]";
+static const char git_var_usage[] = "git var [-l | <variable>]";
 
 struct git_var {
 	const char *name;
@@ -53,7 +53,7 @@ int main(int argc, char **argv)
 	const char *val;
 	int nongit;
 	if (argc != 2) {
-		usage(var_usage);
+		usage(git_var_usage);
 	}
 
 	git_extract_argv0_path(argv[0]);
@@ -69,7 +69,7 @@ int main(int argc, char **argv)
 	git_config(git_default_config, NULL);
 	val = read_var(argv[1]);
 	if (!val)
-		usage(var_usage);
+		usage(git_var_usage);
 
 	printf("%s\n", val);
 
-- 
1.6.5.rc1.38.gddf44.dirty
