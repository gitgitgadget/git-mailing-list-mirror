From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Trivial fix: Make all the builtin usage strings to use the same pattern.
Date: Sun, 20 Sep 2009 09:17:25 -0400
Message-ID: <1253452645-3220-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 15:23:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpMO6-0004RD-3t
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 15:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZITNR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 09:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbZITNR4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 09:17:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:64583 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbZITNRw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 09:17:52 -0400
Received: by qw-out-2122.google.com with SMTP id 5so754020qwd.37
        for <git@vger.kernel.org>; Sun, 20 Sep 2009 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7hOxchKpTZB0QAxsj+U2uDEFtmNGdk5gYa5G6iDbYcw=;
        b=h/df4flhmac5ZSVo5110I0Mn+7l36qIQdtFrCJwbu5UJgdUG0QNTHDPT2gDtPzN9gd
         iUpUayXISUHGxK9r5oU+NbdLltSt70J2x+EGZA+frI4MD9LEc5MctjePOBbdLAc8TofO
         lqsUp7jImH0XZcmiQ1fpWoCg7wWpTzc1uHM4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=WMmSgE/MjuGhjujiYAjJnb21QTmuLkjy6z6W3tB1qwduym3eG6WjmISJWN8J4Qispi
         BmNukzd4HhIlSKHNh1Osu2Fe6Q8HVCKDaGULGoh+dkOaDZ18szBkZHM35WKkUo1Kn76y
         QSEIQ5OLNTcKmrRLqtwYehUxIG3YsQKfqsnIY=
Received: by 10.224.65.69 with SMTP id h5mr2790953qai.190.1253452674355;
        Sun, 20 Sep 2009 06:17:54 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 5sm4981029qwh.27.2009.09.20.06.17.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Sep 2009 06:17:53 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.37.gf5c31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128844>

They follow the pattern of file name:
File name pattern: builtin-command-name.c
Usage string pattern: builtin_command_name_usage

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 archive.c                    |    2 +-
 builtin-apply.c              |    4 ++--
 builtin-bisect--helper.c     |    6 +++---
 builtin-blame.c              |    9 +++++----
 builtin-cat-file.c           |   12 ++++++------
 builtin-check-attr.c         |    8 ++++----
 builtin-checkout.c           |    4 ++--
 builtin-clean.c              |    2 +-
 builtin-commit-tree.c        |    7 ++++---
 builtin-config.c             |    2 +-
 builtin-count-objects.c      |    6 +++---
 builtin-describe.c           |    4 ++--
 builtin-diff-files.c         |    6 +++---
 builtin-diff-index.c         |    6 +++---
 builtin-diff-tree.c          |    6 +++---
 builtin-fast-export.c        |    8 ++++----
 builtin-fetch-pack.c         |    6 +++---
 builtin-fmt-merge-msg.c      |    6 +++---
 builtin-for-each-ref.c       |   10 +++++-----
 builtin-fsck.c               |    4 ++--
 builtin-grep.c               |    4 ++--
 builtin-init-db.c            |    6 +++---
 builtin-ls-files.c           |    4 ++--
 builtin-ls-remote.c          |    6 +++---
 builtin-ls-tree.c            |    8 ++++----
 builtin-mailinfo.c           |    8 ++++----
 builtin-mailsplit.c          |    6 +++---
 builtin-merge-base.c         |    6 +++---
 builtin-merge-file.c         |    6 +++---
 builtin-mktree.c             |    6 +++---
 builtin-name-rev.c           |    6 +++---
 builtin-pack-objects.c       |   18 +++++++++---------
 builtin-pack-refs.c          |    6 +++---
 builtin-prune-packed.c       |    4 ++--
 builtin-prune.c              |    4 ++--
 builtin-push.c               |    6 +++---
 builtin-read-tree.c          |    4 ++--
 builtin-receive-pack.c       |    8 ++++----
 builtin-reflog.c             |    4 ++--
 builtin-replace.c            |   16 ++++++++--------
 builtin-rerere.c             |    4 ++--
 builtin-reset.c              |    4 ++--
 builtin-rev-list.c           |    6 +++---
 builtin-rev-parse.c          |    2 +-
 builtin-revert.c             |    6 +++---
 builtin-send-pack.c          |    8 ++++----
 builtin-shortlog.c           |    8 ++++----
 builtin-show-branch.c        |    6 +++---
 builtin-show-ref.c           |    4 ++--
 builtin-symbolic-ref.c       |    6 +++---
 builtin-tag.c                |    8 ++++----
 builtin-tar-tree.c           |    4 ++--
 builtin-unpack-objects.c     |    7 ++++---
 builtin-update-index.c       |    4 ++--
 builtin-update-ref.c         |    8 ++++----
 builtin-update-server-info.c |    6 +++---
 builtin-upload-archive.c     |    5 ++---
 builtin-verify-pack.c        |    6 +++---
 builtin-verify-tag.c         |    6 +++---
 builtin-write-tree.c         |    4 ++--
 60 files changed, 184 insertions(+), 182 deletions(-)

diff --git a/archive.c b/archive.c
index 73b8e8a..b74e69f 100644
--- a/archive.c
+++ b/archive.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
 #include "unpack-trees.h"
 
-static char const * const archive_usage[] = {
+static const char * const archive_usage[] = {
 	"git archive [options] <tree-ish> [path...]",
 	"git archive --list",
 	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [path...]",
diff --git a/builtin-apply.c b/builtin-apply.c
index c8372a0..b653831 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -47,7 +47,7 @@ static int no_add;
 static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
-static const char * const apply_usage[] = {
+static const char * const builtin_apply_usage[] = {
 	"git apply [options] [<patch>...]",
 	NULL
 };
@@ -3567,7 +3567,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
-			apply_usage, 0);
+			builtin_apply_usage, 0);
 
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
index 7512773..4adae84 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -21,10 +21,11 @@
 #include "parse-options.h"
 #include "utf8.h"
 
-static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
+static char builtin_blame_usage[] =
+"git blame [options] [rev-opts] [rev] [--] file";
 
 static const char *blame_opt_usage[] = {
-	blame_usage,
+	builtin_blame_usage,
 	"",
 	"[rev-opts] are documented in git-rev-list(1)",
 	NULL
@@ -1948,10 +1949,10 @@ static void prepare_blame_range(struct scoreboard *sb,
 	if (*term == ',') {
 		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
 		if (*term)
-			usage(blame_usage);
+			usage(builtin_blame_usage);
 	}
 	if (*term)
-		usage(blame_usage);
+		usage(builtin_blame_usage);
 }
 
 static int git_blame_config(const char *var, const char *value, void *cb)
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 5906842..c4d5c0e 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -200,7 +200,7 @@ static int batch_objects(int print_contents)
 	return 0;
 }
 
-static const char * const cat_file_usage[] = {
+static const char * const builtin_cat_file_usage[] = {
 	"git cat-file (-t|-s|-e|-p|<type>) <object>",
 	"git cat-file (--batch|--batch-check) < <list_of_objects>",
 	NULL
@@ -229,25 +229,25 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (argc != 3 && argc != 2)
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(builtin_cat_file_usage, options);
 
-	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_cat_file_usage, 0);
 
 	if (opt) {
 		if (argc == 1)
 			obj_name = argv[0];
 		else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(builtin_cat_file_usage, options);
 	}
 	if (!opt && !batch) {
 		if (argc == 2) {
 			exp_type = argv[0];
 			obj_name = argv[1];
 		} else
-			usage_with_options(cat_file_usage, options);
+			usage_with_options(builtin_cat_file_usage, options);
 	}
 	if (batch && (opt || argc)) {
-		usage_with_options(cat_file_usage, options);
+		usage_with_options(builtin_cat_file_usage, options);
 	}
 
 	if (batch)
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 8bd0430..3ccce59 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
 
 static int stdin_paths;
-static const char * const check_attr_usage[] = {
+static const char * const builtin_check_attr_usage[] = {
 "git check-attr attr... [--] pathname...",
 "git check-attr --stdin attr... < <list-of-paths>",
 NULL
@@ -70,9 +70,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, prefix, check_attr_options,
-			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
+			     builtin_check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 	if (!argc)
-		usage_with_options(check_attr_usage, check_attr_options);
+		usage_with_options(builtin_check_attr_usage, check_attr_options);
 
 	if (read_cache() < 0) {
 		die("invalid cache");
@@ -98,7 +98,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 		errstr = "Can't specify files with --stdin";
 	if (errstr) {
 		error("%s", errstr);
-		usage_with_options(check_attr_usage, check_attr_options);
+		usage_with_options(builtin_check_attr_usage, check_attr_options);
 	}
 
 	check = xcalloc(cnt, sizeof(*check));
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d050c37..91d6c5e 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -18,7 +18,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 
-static const char * const checkout_usage[] = {
+static const char * const builtin_checkout_usage[] = {
 	"git checkout [options] <branch>",
 	"git checkout [options] [<branch>] -- <file>...",
 	NULL,
@@ -608,7 +608,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
 	if (patch_mode && (opts.track > 0 || opts.new_branch
diff --git a/builtin-clean.c b/builtin-clean.c
index 28cdcd0..562f186 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -14,7 +14,7 @@
 
 static int force = -1; /* unset */
 
-static const char *const builtin_clean_usage[] = {
+static const char * const builtin_clean_usage[] = {
 	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
 	NULL
 };
diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 6467077..2bf4200 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -24,7 +24,8 @@ static void check_valid(unsigned char *sha1, enum object_type expect)
 		    typename(expect));
 }
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [-p <sha1>]* < changelog";
+static const char builtin_commit_tree_usage[] =
+"git commit-tree <sha1> [-p <sha1>]* < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -106,7 +107,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	if (argc < 2)
-		usage(commit_tree_usage);
+		usage(builtin_commit_tree_usage);
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
 
@@ -115,7 +116,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 		const char *a, *b;
 		a = argv[i]; b = argv[i+1];
 		if (!b || strcmp(a, "-p"))
-			usage(commit_tree_usage);
+			usage(builtin_commit_tree_usage);
 
 		if (get_sha1(b, sha1))
 			die("Not a valid object name %s", b);
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..8db1c4b 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 #include "parse-options.h"
 
-static const char *const builtin_config_usage[] = {
+static const char * const builtin_config_usage[] = {
 	"git config [options]",
 	NULL
 };
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 1b0b6c8..fbe0972 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -65,7 +65,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 	}
 }
 
-static char const * const count_objects_usage[] = {
+static char const * const builtin_count_objects_usage[] = {
 	"git count-objects [-v]",
 	NULL
 };
@@ -83,10 +83,10 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, opts, count_objects_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, builtin_count_objects_usage, 0);
 	/* we do not take arguments other than flags for now */
 	if (argc)
-		usage_with_options(count_objects_usage, opts);
+		usage_with_options(builtin_count_objects_usage, opts);
 	memcpy(path, objdir, len);
 	if (len && objdir[len-1] != '/')
 		path[len++] = '/';
diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..46fd6fa 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -9,7 +9,7 @@
 #define SEEN		(1u<<0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
-static const char * const describe_usage[] = {
+static const char * const builtin_describe_usage[] = {
 	"git describe [options] <committish>*",
 	NULL
 };
@@ -327,7 +327,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, describe_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_describe_usage, 0);
 	if (max_candidates < 0)
 		max_candidates = 0;
 	else if (max_candidates > MAX_TAGS)
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5b64011..edd6127 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -9,7 +9,7 @@
 #include "revision.h"
 #include "builtin.h"
 
-static const char diff_files_usage[] =
+static const char builtin_diff_files_usage[] =
 "git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
@@ -34,7 +34,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "-q"))
 			options |= DIFF_SILENT_ON_REMOVED;
 		else
-			usage(diff_files_usage);
+			usage(builtin_diff_files_usage);
 		argv++; argc--;
 	}
 	if (!rev.diffopt.output_format)
@@ -48,7 +48,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (rev.pending.nr ||
 	    rev.min_age != -1 || rev.max_age != -1 ||
 	    3 < rev.max_count)
-		usage(diff_files_usage);
+		usage(builtin_diff_files_usage);
 
 	/*
 	 * "diff-files --base -p" should not combine merges because it
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 0483749..dbbbb9a 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -4,7 +4,7 @@
 #include "revision.h"
 #include "builtin.h"
 
-static const char diff_cache_usage[] =
+static const char builtin_diff_index_usage[] =
 "git diff-index [-m] [--cached] "
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
@@ -27,7 +27,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--cached"))
 			cached = 1;
 		else
-			usage(diff_cache_usage);
+			usage(builtin_diff_index_usage);
 	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -38,7 +38,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	 */
 	if (rev.pending.nr != 1 ||
 	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
-		usage(diff_cache_usage);
+		usage(builtin_diff_index_usage);
 	if (!cached)
 		setup_work_tree();
 	if (read_cache() < 0) {
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 79cedb7..394ed35 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -85,7 +85,7 @@ static int diff_tree_stdin(char *line)
 	return -1;
 }
 
-static const char diff_tree_usage[] =
+static const char builtin_diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
@@ -113,7 +113,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 			read_stdin = 1;
 			continue;
 		}
-		usage(diff_tree_usage);
+		usage(builtin_diff_tree_usage);
 	}
 
 	if (!opt->diffopt.output_format)
@@ -128,7 +128,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	switch (nr_sha1) {
 	case 0:
 		if (!read_stdin)
-			usage(diff_tree_usage);
+			usage(builtin_diff_tree_usage);
 		break;
 	case 1:
 		tree1 = opt->pending.objects[0].item;
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b0a4029..a4a86ba 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -17,7 +17,7 @@
 #include "utf8.h"
 #include "parse-options.h"
 
-static const char *fast_export_usage[] = {
+static const char * const builtin_fast_export_usage[] = {
 	"git fast-export [rev-list-opts]",
 	NULL
 };
@@ -591,7 +591,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	};
 
 	if (argc == 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(builtin_fast_export_usage, options);
 
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
@@ -601,9 +601,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.show_source = 1;
 	revs.rewrite_parents = 1;
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_fast_export_usage, 0);
 	if (argc > 1)
-		usage_with_options (fast_export_usage, options);
+		usage_with_options(builtin_fast_export_usage, options);
 
 	if (import_filename)
 		import_marks(import_filename);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..d291c19 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -18,7 +18,7 @@ static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
 
-static const char fetch_pack_usage[] =
+static const char builtin_fetch_pack_usage[] =
 "git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
@@ -734,7 +734,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 				args.no_progress = 1;
 				continue;
 			}
-			usage(fetch_pack_usage);
+			usage(builtin_fetch_pack_usage);
 		}
 		dest = (char *)arg;
 		heads = (char **)(argv + i + 1);
@@ -742,7 +742,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	if (!dest)
-		usage(fetch_pack_usage);
+		usage(builtin_fetch_pack_usage);
 
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 9d52400..0e05038 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -5,7 +5,7 @@
 #include "revision.h"
 #include "tag.h"
 
-static const char * const fmt_merge_msg_usage[] = {
+static const char * const builtin_fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
 	NULL
 };
@@ -360,10 +360,10 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	git_config(fmt_merge_msg_config, NULL);
-	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
-		usage_with_options(fmt_merge_msg_usage, options);
+		usage_with_options(builtin_fmt_merge_msg_usage, options);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index a5a83f1..715d378 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -881,7 +881,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static char const * const for_each_ref_usage[] = {
+static char const * const builtin_for_each_ref_usage[] = {
 	"git for-each-ref [options] [<pattern>]",
 	NULL
 };
@@ -913,17 +913,17 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	parse_options(argc, argv, prefix, opts, builtin_for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(builtin_for_each_ref_usage, opts);
 	}
 	if (HAS_MULTI_BITS(quote_style)) {
 		error("more than one quoting style?");
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(builtin_for_each_ref_usage, opts);
 	}
 	if (verify_format(format))
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(builtin_for_each_ref_usage, opts);
 
 	if (!sort)
 		sort = default_sort();
diff --git a/builtin-fsck.c b/builtin-fsck.c
index c58b0e3..0857357 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -564,7 +564,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 	return err;
 }
 
-static char const * const fsck_usage[] = {
+static char const * const builtin_fsck_usage[] = {
 	"git fsck [options] [<object>...]",
 	NULL
 };
@@ -591,7 +591,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	errors_found = 0;
 	read_replace_refs = 0;
 
-	argc = parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
+	argc = parse_options(argc, argv, prefix, fsck_opts, builtin_fsck_usage, 0);
 	if (write_lost_and_found) {
 		check_full = 1;
 		include_reflogs = 0;
diff --git a/builtin-grep.c b/builtin-grep.c
index 761799d..8eb7534 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -23,7 +23,7 @@
 #endif
 #endif
 
-static char const * const grep_usage[] = {
+static const char * const builtin_grep_usage[] = {
 	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
 	NULL
 };
@@ -813,7 +813,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * unrecognized non option is the beginning of the refs list
 	 * that continues up to the -- (if exists), and then paths.
 	 */
-	argc = parse_options(argc, argv, prefix, options, grep_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
diff --git a/builtin-init-db.c b/builtin-init-db.c
index dd84cae..bf067a9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -377,7 +377,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-static const char *const init_db_usage[] = {
+static const char * const builtin_init_db_usage[] = {
 	"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]",
 	NULL
 };
@@ -406,7 +406,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, init_db_options, init_db_usage, 0);
+	argc = parse_options(argc, argv, prefix, init_db_options, builtin_init_db_usage, 0);
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
@@ -440,7 +440,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			die_errno("cannot chdir to %s", argv[0]);
 		}
 	} else if (0 < argc) {
-		usage(init_db_usage[0]);
+		usage(builtin_init_db_usage[0]);
 	}
 	if (is_bare_repository_cfg == 1) {
 		static char git_dir[PATH_MAX+1];
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index f473220..a41356a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -373,7 +373,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 	return errors;
 }
 
-static const char * const ls_files_usage[] = {
+static const char * const builtin_ls_files_usage[] = {
 	"git ls-files [options] [<file>]*",
 	NULL
 };
@@ -482,7 +482,7 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
-			ls_files_usage, 0);
+			builtin_ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 78a88f7..f35d50f 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -3,7 +3,7 @@
 #include "transport.h"
 #include "remote.h"
 
-static const char ls_remote_usage[] =
+static const char builtin_ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>] <repository> <refs>...";
 
 /*
@@ -66,7 +66,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 				flags |= REF_NORMAL;
 				continue;
 			}
-			usage(ls_remote_usage);
+			usage(builtin_ls_remote_usage);
 		}
 		dest = arg;
 		i++;
@@ -74,7 +74,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!dest)
-		usage(ls_remote_usage);
+		usage(builtin_ls_remote_usage);
 
 	if (argv[i]) {
 		int j;
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 22008df..a01eb5e 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -22,8 +22,8 @@ static const char **pathspec;
 static int chomp_prefix;
 static const char *ls_tree_prefix;
 
-static const char ls_tree_usage[] =
-	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
+static const char builtin_ls_tree_usage[] =
+"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
@@ -172,7 +172,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			}
 			/* otherwise fallthru */
 		default:
-			usage(ls_tree_usage);
+			usage(builtin_ls_tree_usage);
 		}
 		argc--; argv++;
 	}
@@ -182,7 +182,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		ls_options |= LS_SHOW_TREES;
 
 	if (argc < 2)
-		usage(ls_tree_usage);
+		usage(builtin_ls_tree_usage);
 	if (get_sha1(argv[1], sha1))
 		die("Not a valid object name %s", argv[1]);
 
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d498b1c..26c9608 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -1003,8 +1003,8 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 	return 0;
 }
 
-static const char mailinfo_usage[] =
-	"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
+static const char builtin_mailinfo_usage[] =
+"git mailinfo [-k] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
@@ -1032,12 +1032,12 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 		else if (!strcmp(argv[1], "--no-scissors"))
 			use_scissors = 0;
 		else
-			usage(mailinfo_usage);
+			usage(builtin_mailinfo_usage);
 		argc--; argv++;
 	}
 
 	if (argc != 3)
-		usage(mailinfo_usage);
+		usage(builtin_mailinfo_usage);
 
 	return !!mailinfo(stdin, stdout, argv[1], argv[2]);
 }
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index dfe5b15..ccb26ba 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -9,7 +9,7 @@
 #include "string-list.h"
 #include "strbuf.h"
 
-static const char git_mailsplit_usage[] =
+static const char builtin_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> [<mbox>|<Maildir>...]";
 
 static int is_from_line(const char *line, int len)
@@ -227,7 +227,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 		if ( arg[1] == 'd' ) {
 			nr_prec = strtol(arg+2, NULL, 10);
 			if (nr_prec < 3 || 10 <= nr_prec)
-				usage(git_mailsplit_usage);
+				usage(builtin_mailsplit_usage);
 			continue;
 		} else if ( arg[1] == 'f' ) {
 			nr = strtol(arg+2, NULL, 10);
@@ -259,7 +259,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			argp = stdin_only;
 			break;
 		default:
-			usage(git_mailsplit_usage);
+			usage(builtin_mailsplit_usage);
 		}
 	} else {
 		/* New usage: if no more argument, parse stdin */
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index 54e7ec2..99da43f 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -22,7 +22,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 	return 0;
 }
 
-static const char * const merge_base_usage[] = {
+static const char * const builtin_merge_base_usage[] = {
 	"git merge-base [-a|--all] <commit> <commit>...",
 	NULL
 };
@@ -53,9 +53,9 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_merge_base_usage, 0);
 	if (argc < 2)
-		usage_with_options(merge_base_usage, options);
+		usage_with_options(builtin_merge_base_usage, options);
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
 		rev[rev_nr++] = get_commit_reference(*argv++);
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index afd2ea7..42bd479 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -4,7 +4,7 @@
 #include "xdiff-interface.h"
 #include "parse-options.h"
 
-static const char *const merge_file_usage[] = {
+static const char * const builtin_merge_file_usage[] = {
 	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2",
 	NULL
 };
@@ -48,9 +48,9 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			merge_style = git_xmerge_style;
 	}
 
-	argc = parse_options(argc, argv, prefix, options, merge_file_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_merge_file_usage, 0);
 	if (argc != 3)
-		usage_with_options(merge_file_usage, options);
+		usage_with_options(builtin_merge_file_usage, options);
 	if (quiet) {
 		if (!freopen("/dev/null", "w", stderr))
 			return error("failed to redirect stderr to /dev/null: "
diff --git a/builtin-mktree.c b/builtin-mktree.c
index 098395f..7242a4c 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -62,7 +62,7 @@ static void write_tree(unsigned char *sha1)
 	write_sha1_file(buf.buf, buf.len, tree_type, sha1);
 }
 
-static const char *mktree_usage[] = {
+static const char * const builtin_mktree_usage[] = {
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
+	argc = parse_options(argc, argv, prefix, option, builtin_mktree_usage, 0);
 
 	while (!got_eof) {
 		while (1) {
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 06a38ac..d8913e3 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -171,7 +171,7 @@ static void show_name(const struct object *obj,
 		die("cannot describe '%s'", sha1_to_hex(sha1));
 }
 
-static char const * const name_rev_usage[] = {
+static const char * const builtin_name_rev_usage[] = {
 	"git name-rev [options] ( --all | --stdin | <commit>... )",
 	NULL
 };
@@ -238,10 +238,10 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
+	argc = parse_options(argc, argv, prefix, opts, builtin_name_rev_usage, 0);
 	if (!!all + !!transform_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
-		usage_with_options(name_rev_usage, opts);
+		usage_with_options(builtin_name_rev_usage, opts);
 	}
 	if (all || transform_stdin)
 		cutoff = 0;
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 02f9246..a778246 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -22,7 +22,7 @@
 #include <pthread.h>
 #endif
 
-static const char pack_usage[] =
+static const char builtin_pack_objects_usage[] =
   "git pack-objects [{ -q | --progress | --all-progress }]\n"
   "        [--max-pack-size=N] [--local] [--incremental]\n"
   "        [--window=N] [--window-memory=N] [--depth=N]\n"
@@ -2166,7 +2166,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			char *end;
 			int level = strtoul(arg+14, &end, 0);
 			if (!arg[14] || *end)
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 			if (level == -1)
 				level = Z_DEFAULT_COMPRESSION;
 			else if (level < 0 || level > Z_BEST_COMPRESSION)
@@ -2179,26 +2179,26 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			pack_size_limit_cfg = 0;
 			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
 			if (!arg[16] || *end)
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--window=")) {
 			char *end;
 			window = strtoul(arg+9, &end, 0);
 			if (!arg[9] || *end)
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--window-memory=")) {
 			if (!git_parse_ulong(arg+16, &window_memory_limit))
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 			continue;
 		}
 		if (!prefixcmp(arg, "--threads=")) {
 			char *end;
 			delta_search_threads = strtoul(arg+10, &end, 0);
 			if (!arg[10] || *end || delta_search_threads < 0)
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 #ifndef THREADED_DELTA_SEARCH
 			if (delta_search_threads != 1)
 				warning("no threads support, "
@@ -2210,7 +2210,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			char *end;
 			depth = strtoul(arg+8, &end, 0);
 			if (!arg[8] || *end)
-				usage(pack_usage);
+				usage(builtin_pack_objects_usage);
 			continue;
 		}
 		if (!strcmp("--progress", arg)) {
@@ -2290,7 +2290,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			grafts_replace_parents = 0;
 			continue;
 		}
-		usage(pack_usage);
+		usage(builtin_pack_objects_usage);
 	}
 
 	/* Traditionally "pack-objects [options] base extra" failed;
@@ -2310,7 +2310,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		base_name = argv[i++];
 
 	if (pack_to_stdout != !base_name)
-		usage(pack_usage);
+		usage(builtin_pack_objects_usage);
 
 	if (!pack_to_stdout && !pack_size_limit)
 		pack_size_limit = pack_size_limit_cfg;
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 091860b..3ec3c2f 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -2,7 +2,7 @@
 #include "parse-options.h"
 #include "pack-refs.h"
 
-static char const * const pack_refs_usage[] = {
+static const char * const builtin_pack_refs_usage[] = {
 	"git pack-refs [options]",
 	NULL
 };
@@ -15,7 +15,7 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_PRUNE),
 		OPT_END(),
 	};
-	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
-		usage_with_options(pack_refs_usage, opts);
+	if (parse_options(argc, argv, prefix, opts, builtin_pack_refs_usage, 0))
+		usage_with_options(builtin_pack_refs_usage, opts);
 	return pack_refs(flags);
 }
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index be99eb0..5acc130 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -3,7 +3,7 @@
 #include "progress.h"
 #include "parse-options.h"
 
-static const char * const prune_packed_usage[] = {
+static const char * const builtin_prune_packed_usage[] = {
 	"git prune-packed [-n|--dry-run] [-q|--quiet]",
 	NULL
 };
@@ -79,7 +79,7 @@ int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, prune_packed_options,
-			     prune_packed_usage, 0);
+			     builtin_prune_packed_usage, 0);
 
 	prune_packed_objects(opts);
 	return 0;
diff --git a/builtin-prune.c b/builtin-prune.c
index 8459aec..6cf3555 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 #include "dir.h"
 
-static const char * const prune_usage[] = {
+static const char * const builtin_prune_usage[] = {
 	"git prune [-n] [-v] [--expire <time>] [--] [<head>...]",
 	NULL
 };
@@ -143,7 +143,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 	init_revisions(&revs, prefix);
 
-	argc = parse_options(argc, argv, prefix, options, prune_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_prune_usage, 0);
 	while (argc--) {
 		unsigned char sha1[20];
 		const char *name = *argv++;
diff --git a/builtin-push.c b/builtin-push.c
index 3cb1ee4..64b1b6e 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -9,7 +9,7 @@
 #include "transport.h"
 #include "parse-options.h"
 
-static const char * const push_usage[] = {
+static const char * const builtin_push_usage[] = {
 	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
@@ -191,7 +191,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_push_usage, 0);
 
 	if (tags)
 		add_refspec("refs/tags/*");
@@ -203,7 +203,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	rc = do_push(repo, flags);
 	if (rc == -1)
-		usage_with_options(push_usage, options);
+		usage_with_options(builtin_push_usage, options);
 	else
 		return rc;
 }
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 14c836b..483d083 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -30,7 +30,7 @@ static int list_tree(unsigned char *sha1)
 	return 0;
 }
 
-static const char * const read_tree_usage[] = {
+static const char * const builtin_read_tree_usage[] = {
 	"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u [--exclude-per-directory=<gitignore>] | -i]]  [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]]",
 	NULL
 };
@@ -111,7 +111,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	newfd = hold_locked_index(&lock_file, 1);
 
 	argc = parse_options(argc, argv, unused_prefix, read_tree_options,
-			     read_tree_usage, 0);
+			     builtin_read_tree_usage, 0);
 
 	prefix_set = opts.prefix ? 1 : 0;
 	if (1 < opts.merge + opts.reset + prefix_set)
diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index b771fe9..42a21c9 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -9,7 +9,7 @@
 #include "remote.h"
 #include "transport.h"
 
-static const char receive_pack_usage[] = "git receive-pack <git-dir>";
+static const char builtin_receive_pack_usage[] = "git receive-pack <git-dir>";
 
 enum deny_action {
 	DENY_UNCONFIGURED,
@@ -624,14 +624,14 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 
 		if (*arg == '-') {
 			/* Do flag handling here */
-			usage(receive_pack_usage);
+			usage(builtin_receive_pack_usage);
 		}
 		if (dir)
-			usage(receive_pack_usage);
+			usage(builtin_receive_pack_usage);
 		dir = xstrdup(arg);
 	}
 	if (!dir)
-		usage(receive_pack_usage);
+		usage(builtin_receive_pack_usage);
 
 	setup_path();
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index e23b5ef..940c39a 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -693,7 +693,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
  * main "reflog"
  */
 
-static const char reflog_usage[] =
+static const char builtin_reflog_usage[] =
 "git reflog [ show | expire | delete ]";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
@@ -712,5 +712,5 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
 
 	/* Not a recognized reflog command..*/
-	usage(reflog_usage);
+	usage(builtin_reflog_usage);
 }
diff --git a/builtin-replace.c b/builtin-replace.c
index fe3a647..f855437 100644
--- a/builtin-replace.c
+++ b/builtin-replace.c
@@ -13,7 +13,7 @@
 #include "refs.h"
 #include "parse-options.h"
 
-static const char * const git_replace_usage[] = {
+static const char * const builtin_replace_usage[] = {
 	"git replace [-f] <object> <replacement>",
 	"git replace -d <object>...",
 	"git replace -l [<pattern>]",
@@ -121,21 +121,21 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, prefix, options, git_replace_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_replace_usage, 0);
 
 	if (list && delete)
 		usage_msg_opt("-l and -d cannot be used together",
-			      git_replace_usage, options);
+			      builtin_replace_usage, options);
 
 	if (force && (list || delete))
 		usage_msg_opt("-f cannot be used with -d or -l",
-			      git_replace_usage, options);
+			      builtin_replace_usage, options);
 
 	/* Delete refs */
 	if (delete) {
 		if (argc < 1)
 			usage_msg_opt("-d needs at least one argument",
-				      git_replace_usage, options);
+				      builtin_replace_usage, options);
 		return for_each_replace_name(argv, delete_replace_ref);
 	}
 
@@ -143,17 +143,17 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 	if (!list && argc) {
 		if (argc != 2)
 			usage_msg_opt("bad number of arguments",
-				      git_replace_usage, options);
+				      builtin_replace_usage, options);
 		return replace_object(argv[0], argv[1], force);
 	}
 
 	/* List refs, even if "list" is not set */
 	if (argc > 1)
 		usage_msg_opt("only one pattern can be given with -l",
-			      git_replace_usage, options);
+			      builtin_replace_usage, options);
 	if (force)
 		usage_msg_opt("-f needs some arguments",
-			      git_replace_usage, options);
+			      builtin_replace_usage, options);
 
 	return list_replace_refs(argv[0]);
 }
diff --git a/builtin-rerere.c b/builtin-rerere.c
index adfb7b5..f19a0d3 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -6,7 +6,7 @@
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 
-static const char git_rerere_usage[] =
+static const char builtin_rerere_usage[] =
 "git rerere [clear | status | diff | gc]";
 
 /* these values are days */
@@ -129,7 +129,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
 	else
-		usage(git_rerere_usage);
+		usage(builtin_rerere_usage);
 
 	string_list_clear(&merge_rr, 1);
 	return 0;
diff --git a/builtin-reset.c b/builtin-reset.c
index 73e6022..fe78fbd 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -19,7 +19,7 @@
 #include "branch.h"
 #include "parse-options.h"
 
-static const char * const git_reset_usage[] = {
+static const char * const builtin_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
 	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
@@ -217,7 +217,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_reset_usage,
 						PARSE_OPT_KEEP_DASHDASH);
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 4ba1c12..983039e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -8,7 +8,7 @@
 #include "graph.h"
 #include "bisect.h"
 
-static const char rev_list_usage[] =
+static const char builtin_rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
 "    --max-count=nr\n"
@@ -354,7 +354,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			read_revisions_from_stdin(&revs);
 			continue;
 		}
-		usage(rev_list_usage);
+		usage(builtin_rev_list_usage);
 
 	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
@@ -373,7 +373,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
-		usage(rev_list_usage);
+		usage(builtin_rev_list_usage);
 
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
index 151aa6a..918b3c2 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -25,12 +25,12 @@
  * Copyright (c) 2005 Junio C Hamano
  */
 
-static const char * const revert_usage[] = {
+static const char * const builtin_revert_usage[] = {
 	"git revert [options] <commit-ish>",
 	NULL
 };
 
-static const char * const cherry_pick_usage[] = {
+static const char * const builtin_cherry_pick_usage[] = {
 	"git cherry-pick [options] <commit-ish>",
 	NULL
 };
@@ -46,7 +46,7 @@ static const char *me;
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str =
-		action == REVERT ?  revert_usage : cherry_pick_usage;
+		action == REVERT ?  builtin_revert_usage : builtin_cherry_pick_usage;
 	unsigned char sha1[20];
 	const char *arg;
 	int noop;
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 37e528e..20a2476 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -6,7 +6,7 @@
 #include "remote.h"
 #include "send-pack.h"
 
-static const char send_pack_usage[] =
+static const char builtin_send_pack_usage[] =
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
@@ -523,7 +523,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 				args.use_thin_pack = 1;
 				continue;
 			}
-			usage(send_pack_usage);
+			usage(builtin_send_pack_usage);
 		}
 		if (!dest) {
 			dest = arg;
@@ -534,14 +534,14 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		break;
 	}
 	if (!dest)
-		usage(send_pack_usage);
+		usage(builtin_send_pack_usage);
 	/*
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
 	if ((refspecs && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
-		usage(send_pack_usage);
+		usage(builtin_send_pack_usage);
 
 	if (remote_name) {
 		remote = remote_get(remote_name);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 4d4a3c8..1ce930a 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,7 +9,7 @@
 #include "shortlog.h"
 #include "parse-options.h"
 
-static char const * const shortlog_usage[] = {
+static const char * const builtin_shortlog_usage[] = {
 	"git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]",
 	"",
 	"[rev-opts] are documented in git-rev-list(1)",
@@ -267,20 +267,20 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_KEEP_ARGV0);
 
 	for (;;) {
-		switch (parse_options_step(&ctx, options, shortlog_usage)) {
+		switch (parse_options_step(&ctx, options, builtin_shortlog_usage)) {
 		case PARSE_OPT_HELP:
 			exit(129);
 		case PARSE_OPT_DONE:
 			goto parse_done;
 		}
-		parse_revision_opt(&rev, &ctx, options, shortlog_usage);
+		parse_revision_opt(&rev, &ctx, options, builtin_shortlog_usage);
 	}
 parse_done:
 	argc = parse_options_end(&ctx);
 
 	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
 		error("unrecognized argument: %s", argv[1]);
-		usage_with_options(shortlog_usage, options);
+		usage_with_options(builtin_shortlog_usage, options);
 	}
 
 	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 3510a86..d1889ac 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -5,7 +5,7 @@
 #include "color.h"
 #include "parse-options.h"
 
-static const char* show_branch_usage[] = {
+static const char * const builtin_show_branch_usage[] = {
     "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
     "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
     NULL
@@ -697,7 +697,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	}
 
 	ac = parse_options(ac, av, prefix, builtin_show_branch_options,
-			   show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+			   builtin_show_branch_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 	if (all_heads)
 		all_remotes = 1;
 
@@ -706,7 +706,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		 * independent nor merge-base modes.
 		 */
 		if (independent || merge_base)
-			usage_with_options(show_branch_usage,
+			usage_with_options(builtin_show_branch_usage,
 					   builtin_show_branch_options);
 		if (reflog && ((0 < extra) || all_heads || all_remotes))
 			/*
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index c46550c..41844d1 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 #include "parse-options.h"
 
-static const char * const show_ref_usage[] = {
+static const char * const builtin_show_ref_usage[] = {
 	"git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] ",
 	"git show-ref --exclude-existing[=pattern] < ref-list",
 	NULL
@@ -202,7 +202,7 @@ static const struct option show_ref_options[] = {
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
 	argc = parse_options(argc, argv, prefix, show_ref_options,
-			     show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
+			     builtin_show_ref_usage, PARSE_OPT_NO_INTERNAL_HELP);
 
 	if (exclude_arg)
 		return exclude_existing(exclude_existing_arg);
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index ca855a5..72b8343 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -3,7 +3,7 @@
 #include "refs.h"
 #include "parse-options.h"
 
-static const char * const git_symbolic_ref_usage[] = {
+static const char * const builtin_symbolic_ref_usage[] = {
 	"git symbolic-ref [options] name [ref]",
 	NULL
 };
@@ -37,7 +37,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
-			     git_symbolic_ref_usage, 0);
+			     builtin_symbolic_ref_usage, 0);
 	if (msg &&!*msg)
 		die("Refusing to perform update with empty message");
 	switch (argc) {
@@ -51,7 +51,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 		create_symref(argv[0], argv[1], msg);
 		break;
 	default:
-		usage_with_options(git_symbolic_ref_usage, options);
+		usage_with_options(builtin_symbolic_ref_usage, options);
 	}
 	return 0;
 }
diff --git a/builtin-tag.c b/builtin-tag.c
index c479018..b19562b 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -13,7 +13,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 
-static const char * const git_tag_usage[] = {
+static const char * const builtin_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
 	"git tag -l [-n[<num>]] [<pattern>]",
@@ -404,7 +404,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	git_config(git_tag_config, NULL);
 
-	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
+	argc = parse_options(argc, argv, prefix, options, builtin_tag_usage, 0);
 
 	if (keyid) {
 		sign = 1;
@@ -417,10 +417,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	if ((annotate || msg.given || msgfile || force) &&
 	    (list || delete || verify))
-		usage_with_options(git_tag_usage, options);
+		usage_with_options(builtin_tag_usage, options);
 
 	if (list + delete + verify > 1)
-		usage_with_options(git_tag_usage, options);
+		usage_with_options(builtin_tag_usage, options);
 	if (list)
 		return list_tags(argv[0], lines == -1 ? 0 : lines,
 				 with_commit);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 8b3a35e..278ccac 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -7,7 +7,7 @@
 #include "builtin.h"
 #include "quote.h"
 
-static const char tar_tree_usage[] =
+static const char builtin_tar_tree_usage[] =
 "git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
 "*** Note that this command is now deprecated; use \"git archive\" instead.";
 
@@ -45,7 +45,7 @@ int cmd_tar_tree(int argc, const char **argv, const char *prefix)
 
 	switch (argc) {
 	default:
-		usage(tar_tree_usage);
+		usage(builtin_tar_tree_usage);
 		break;
 	case 3:
 		/* base-path */
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index 685566e..f571131 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -13,7 +13,8 @@
 #include "fsck.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char builtin_unpack_usage[] =
+"git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -538,11 +539,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 				len = sizeof(*hdr);
 				continue;
 			}
-			usage(unpack_usage);
+			usage(builtin_unpack_usage);
 		}
 
 		/* We don't take any non-flag arguments now.. Maybe some day */
-		usage(unpack_usage);
+		usage(builtin_unpack_usage);
 	}
 	git_SHA1_Init(&ctx);
 	unpack_all();
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 92beaaf..69133d6 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -387,7 +387,7 @@ static void read_index_info(int line_termination)
 	strbuf_release(&uq);
 }
 
-static const char update_index_usage[] =
+static const char builtin_update_index_usage[] =
 "git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
@@ -703,7 +703,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
-				usage(update_index_usage);
+				usage(builtin_update_index_usage);
 			die("unknown option %s", path);
 		}
 		setup_work_tree();
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 76ba1d5..ab8f401 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -3,7 +3,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 
-static const char * const git_update_ref_usage[] = {
+static const char * const builtin_update_ref_usage[] = {
 	"git update-ref [options] -d <refname> [<oldval>]",
 	"git update-ref [options]    <refname> <newval> [<oldval>]",
 	NULL
@@ -23,20 +23,20 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
-	argc = parse_options(argc, argv, prefix, options, git_update_ref_usage,
+	argc = parse_options(argc, argv, prefix, options, builtin_update_ref_usage,
 			     0);
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
 	if (delete) {
 		if (argc < 1 || argc > 2)
-			usage_with_options(git_update_ref_usage, options);
+			usage_with_options(builtin_update_ref_usage, options);
 		refname = argv[0];
 		oldval = argv[1];
 	} else {
 		const char *value;
 		if (argc < 2 || argc > 3)
-			usage_with_options(git_update_ref_usage, options);
+			usage_with_options(builtin_update_ref_usage, options);
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
diff --git a/builtin-update-server-info.c b/builtin-update-server-info.c
index 2b3fddc..fd6c8aa 100644
--- a/builtin-update-server-info.c
+++ b/builtin-update-server-info.c
@@ -2,7 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 
-static const char * const update_server_info_usage[] = {
+static const char * const builtin_update_server_info_usage[] = {
 	"git update-server-info [--force]",
 	NULL
 };
@@ -17,9 +17,9 @@ int cmd_update_server_info(int argc, const char **argv, const char *prefix)
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     update_server_info_usage, 0);
+			     builtin_update_server_info_usage, 0);
 	if (argc > 0)
-		usage_with_options(update_server_info_usage, options);
+		usage_with_options(builtin_update_server_info_usage, options);
 
 	return !!update_server_info(force);
 }
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index c4cd1e1..480a857 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -7,8 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 
-static const char upload_archive_usage[] =
-	"git upload-archive <repo>";
+static const char builtin_upload_archive_usage[] = "git upload-archive <repo>";
 
 static const char deadchild[] =
 "git upload-archive: archiver died with error";
@@ -27,7 +26,7 @@ static int run_upload_archive(int argc, const char **argv, const char *prefix)
 	int len;
 
 	if (argc != 2)
-		usage(upload_archive_usage);
+		usage(builtin_upload_archive_usage);
 
 	if (strlen(argv[1]) + 1 > sizeof(buf))
 		die("insanely long repository name");
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index b6079ae..6759520 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -133,7 +133,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	return err;
 }
 
-static const char * const verify_pack_usage[] = {
+static const char * const builtin_verify_pack_usage[] = {
 	"git verify-pack [-v|--verbose] [-s|--stat-only] <pack>...",
 	NULL
 };
@@ -153,9 +153,9 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, verify_pack_options,
-			     verify_pack_usage, 0);
+			     builtin_verify_pack_usage, 0);
 	if (argc < 1)
-		usage_with_options(verify_pack_usage, verify_pack_options);
+		usage_with_options(builtin_verify_pack_usage, verify_pack_options);
 	for (i = 0; i < argc; i++) {
 		if (verify_one_pack(argv[i], flags))
 			err = 1;
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 9f482c2..4f41301 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 #include "parse-options.h"
 
-static const char * const verify_tag_usage[] = {
+static const char * const builtin_verify_tag_usage[] = {
 		"git verify-tag [-v|--verbose] <tag>...",
 		NULL
 };
@@ -100,9 +100,9 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, verify_tag_options,
-			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
+			     builtin_verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <= i)
-		usage_with_options(verify_tag_usage, verify_tag_options);
+		usage_with_options(builtin_verify_tag_usage, verify_tag_options);
 
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index b223af4..013de8e 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -9,7 +9,7 @@
 #include "cache-tree.h"
 #include "parse-options.h"
 
-static const char * const write_tree_usage[] = {
+static const char * const builtin_write_tree_usage[] = {
 	"git write-tree [--missing-ok] [--prefix=<prefix>/]",
 	NULL
 };
@@ -35,7 +35,7 @@ int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, unused_prefix, write_tree_options,
-			     write_tree_usage, 0);
+			     builtin_write_tree_usage, 0);
 
 	ret = write_cache_as_tree(sha1, flags, prefix);
 	switch (ret) {
-- 
1.6.5.rc1.37.gf5c31
