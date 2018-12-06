Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CE81211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 21:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLFVdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 16:33:46 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:33824 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeLFVda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 16:33:30 -0500
Received: by mail-io1-f73.google.com with SMTP id y19so1669199ioq.1
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 13:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xJNcYyDOx38JQ5xlhfWUeo3KE5CnOL2y/0m3vLsGZfM=;
        b=b+qkIuRqaaLe1tpEPmTlfyF3XekfCcveCr240kNbyBmxouX0uPXCvOD+OCxn79g8eD
         t/LmWo0fuzUrh36HaBH5xP81unfe349W9KK2qNBrXkUm76zVfckt38oRAGNcQj8AUkwE
         yAWcVjMSvBda+b6wdg045PmZHTqkB6tiSWhxOlxEPoz44utrBkaIWQNcaRL/8lBV2ip2
         CH3YtPPOBnngSlZW2Y2Hd/W1Wmz5Ne0o5LqOGtr9oWJgOfMiIyaGYY1pJeS7JC0cGich
         DfWrptsYPr21P4vZLSuyi95CmcDpkPqBDEw4cwC/ruL738ppaXySe1oqp03+b1a+pZdp
         qKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xJNcYyDOx38JQ5xlhfWUeo3KE5CnOL2y/0m3vLsGZfM=;
        b=Ffdj4p+L0MClBMejDb8VXSoZYQ3laeDqUYlWlb+qZSQoG4Fvxz/Mfe9jnlKlrEsR9v
         v1eKUKKi4/3puHjcF0Kx/Dz25/BtthjeR+H2juqXWyr2fx6jxXs6qcO7bPXvu52eZXQS
         C7KkbvspU6Wqcyt4j8r0XJn/+iY0ioiojTJWNBsWZMBVGjvFKi+7x7KBfRxSj2mbvPYO
         sVss1+wKspdRvwL2f40IhUshQH9KoUM/YXl2ZMPtASRByEuPzEqdBcObY8erMrEnDVBc
         yzviuWs2H0lXEFlAjAJkgljU3d4HQc3H9Xjn4DJtlQ6MND656x3Sj9dufyDFo1RNJLe+
         j3IQ==
X-Gm-Message-State: AA+aEWZrb3Vmd3Up2QIeglx7C8CbCpSpLkBWSUegdmUO4xa8vPUpQzyr
        uddzdJXkNo0XAUKxOgRFrc1HaYNY8iK5KOoc/bSw1bbeJEJHNcLHQG/cJgbdTFroDWI+C7W0+rg
        tvLgTgIOe8iTvXP/du9JbzW8BizfywxMdD7FPd8q/aelIBuxuWEtOIt5P/80=
X-Google-Smtp-Source: AFSGD/Utb+1HdqlQ4ZPN4fEdA+j6okg/ww4qr5j4Zll7/QjrtHo/FxYy2P5NTVN8wvLdZrdNiszbZIERD2DW
X-Received: by 2002:a24:5f49:: with SMTP id r70mr25872itb.22.1544132009334;
 Thu, 06 Dec 2018 13:33:29 -0800 (PST)
Date:   Thu,  6 Dec 2018 13:33:15 -0800
Message-Id: <20181206213315.64423-1-matvore@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] terminology tweak: prune -> path limiting
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, jrn@google.com,
        matvore@comcast.net, dstolee@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the codebase, "prune" is a highly overloaded term, and it caused me a
lot of trouble to figure out what it meant when it was used in the
context of path limiting. Stop using the word "prune" when we really
mean "path limiting."

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/technical/api-history-graph.txt |  5 +-
 builtin/add.c                                 |  4 +-
 builtin/diff.c                                |  8 +-
 builtin/fast-export.c                         |  2 +-
 builtin/log.c                                 |  2 +-
 builtin/rev-list.c                            |  2 +-
 diff-lib.c                                    |  6 +-
 revision.c                                    | 90 ++++++++++---------
 revision.h                                    |  4 +-
 t/t7811-grep-open.sh                          |  2 +-
 tree-walk.c                                   | 10 +--
 wt-status.c                                   |  4 +-
 12 files changed, 72 insertions(+), 67 deletions(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index d0d1707c8c..f9a100f88c 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -100,8 +100,9 @@ Limitations
   on all parents of that commit.  Parents must not be skipped, or the graph
   output will appear incorrect.
 +
-`graph_update()` may be used on a pruned set of commits only if the parent list
-has been rewritten so as to include only ancestors from the pruned set.
+`graph_update()` may be used on a pruned (e.g. path-limited) set of commits only
+if the parent list has been rewritten so as to include only ancestors from the
+pruned set.
 
 * The graph API does not currently support reverse commit ordering.  In
   order to implement reverse ordering, the graphing API needs an
diff --git a/builtin/add.c b/builtin/add.c
index f65c172299..4abd8ebba8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -113,14 +113,14 @@ int add_files_to_cache(const char *prefix,
 	repo_init_revisions(the_repository, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	if (pathspec)
-		copy_pathspec(&rev.prune_data, pathspec);
+		copy_pathspec(&rev.path_limits, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	clear_pathspec(&rev.prune_data);
+	clear_pathspec(&rev.path_limits);
 	return !!data.add_errors;
 }
 
diff --git a/builtin/diff.c b/builtin/diff.c
index f0393bba23..9010b3228a 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -74,8 +74,8 @@ static int builtin_diff_b_f(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	GUARD_PATHSPEC(&revs->prune_data, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
-	path = revs->prune_data.items[0].match;
+	GUARD_PATHSPEC(&revs->path_limits, PATHSPEC_FROMTOP | PATHSPEC_LITERAL);
+	path = revs->path_limits.items[0].match;
 
 	if (lstat(path, &st))
 		die_errno(_("failed to stat '%s'"), path);
@@ -421,8 +421,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die(_("unhandled object '%s' given."), name);
 		}
 	}
-	if (rev.prune_data.nr)
-		paths += rev.prune_data.nr;
+	if (rev.path_limits.nr)
+		paths += rev.path_limits.nr;
 
 	/*
 	 * Now, do the arguments look reasonable?
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9e283482ef..6a675b5737 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1143,7 +1143,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		import_marks(import_filename);
 	lastimportid = last_idnum;
 
-	if (import_filename && revs.prune_data.nr)
+	if (import_filename && revs.path_limits.nr)
 		full_tree = 1;
 
 	get_tags_and_duplicates(&revs.cmdline);
diff --git a/builtin/log.c b/builtin/log.c
index 45aa376a59..f8554d7fa1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -690,7 +690,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 				      struct setup_revision_opt *opt)
 {
 	if (rev->diffopt.flags.default_follow_renames &&
-	    rev->prune_data.nr == 1)
+	    rev->path_limits.nr == 1)
 		rev->diffopt.flags.follow_renames = 1;
 
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3a2c0c23b6..edb0799533 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -517,7 +517,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_delayed_progress(show_progress, 0);
 
-	if (use_bitmap_index && !revs.prune) {
+	if (use_bitmap_index && !revs.path_limiting) {
 		if (revs.count && !revs.left_right && !revs.cherry_mark) {
 			uint32_t commit_count;
 			int max_count = revs.max_count;
diff --git a/diff-lib.c b/diff-lib.c
index 23c8d351b3..431bed0e5a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -110,7 +110,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
 
-		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
+		if (!ce_path_match(istate, ce, &revs->path_limits, NULL))
 			continue;
 
 		if (ce_stage(ce)) {
@@ -477,7 +477,7 @@ static int oneway_diff(const struct cache_entry * const *src,
 
 	if (ce_path_match(revs->diffopt.repo->index,
 			  idx ? idx : tree,
-			  &revs->prune_data, NULL)) {
+			  &revs->path_limits, NULL)) {
 		do_oneway_diff(o, idx, tree);
 		if (diff_can_quit_early(&revs->diffopt)) {
 			o->exiting_early = 1;
@@ -543,7 +543,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 	struct rev_info revs;
 
 	repo_init_revisions(opt->repo, &revs, NULL);
-	copy_pathspec(&revs.prune_data, &opt->pathspec);
+	copy_pathspec(&revs.path_limits, &opt->pathspec);
 	revs.diffopt = *opt;
 
 	if (diff_cache(&revs, tree_oid, NULL, 1))
diff --git a/revision.c b/revision.c
index 13e0519c02..156a89b7f0 100644
--- a/revision.c
+++ b/revision.c
@@ -488,7 +488,7 @@ static int rev_compare_tree(struct rev_info *revs,
 		 * tagged commit by specifying both --simplify-by-decoration
 		 * and pathspec.
 		 */
-		if (!revs->prune_data.nr)
+		if (!revs->path_limits.nr)
 			return REV_TREE_SAME;
 	}
 
@@ -616,14 +616,14 @@ static unsigned update_treesame(struct rev_info *revs, struct commit *commit)
 static inline int limiting_can_increase_treesame(const struct rev_info *revs)
 {
 	/*
-	 * TREESAME is irrelevant unless prune && dense;
+	 * TREESAME is irrelevant unless path_limiting && dense;
 	 * if simplify_history is set, we can't have a mixture of TREESAME and
 	 *    !TREESAME INTERESTING parents (and we don't have treesame[]
 	 *    decoration anyway);
 	 * if first_parent_only is set, then the TREESAME flag is locked
 	 *    against the first parent (and again we lack treesame[] decoration).
 	 */
-	return revs->prune && revs->dense &&
+	return revs->path_limiting && revs->dense &&
 	       !revs->simplify_history &&
 	       !revs->first_parent_only;
 }
@@ -638,7 +638,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	/*
 	 * If we don't do pruning, everything is interesting
 	 */
-	if (!revs->prune)
+	if (!revs->path_limiting)
 		return;
 
 	if (!get_commit_tree(commit))
@@ -786,7 +786,7 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 
 	/*
 	 * If the commit is uninteresting, don't try to
-	 * prune parents - we want the maximal uninteresting
+	 * path limit parents - we want the maximal uninteresting
 	 * set.
 	 *
 	 * Normally we haven't parsed the parent
@@ -1511,8 +1511,8 @@ static void prepare_show_merge(struct rev_info *revs)
 	struct commit_list *bases;
 	struct commit *head, *other;
 	struct object_id oid;
-	const char **prune = NULL;
-	int i, prune_num = 1; /* counting terminating NULL */
+	const char **limiting_paths = NULL;
+	int i, limiting_paths_num = 1; /* counting terminating NULL */
 	struct index_state *istate = revs->repo->index;
 
 	if (get_oid("HEAD", &oid))
@@ -1535,19 +1535,20 @@ static void prepare_show_merge(struct rev_info *revs)
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_stage(ce))
 			continue;
-		if (ce_path_match(istate, ce, &revs->prune_data, NULL)) {
-			prune_num++;
-			REALLOC_ARRAY(prune, prune_num);
-			prune[prune_num-2] = ce->name;
-			prune[prune_num-1] = NULL;
+		if (ce_path_match(istate, ce, &revs->path_limits, NULL)) {
+			limiting_paths_num++;
+			REALLOC_ARRAY(limiting_paths, limiting_paths_num);
+			limiting_paths[limiting_paths_num-2] = ce->name;
+			limiting_paths[limiting_paths_num-1] = NULL;
 		}
 		while ((i+1 < istate->cache_nr) &&
 		       ce_same_name(ce, istate->cache[i+1]))
 			i++;
 	}
-	clear_pathspec(&revs->prune_data);
-	parse_pathspec(&revs->prune_data, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
-		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "", prune);
+	clear_pathspec(&revs->path_limits);
+	parse_pathspec(&revs->path_limits, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
+		       PATHSPEC_PREFER_FULL | PATHSPEC_LITERAL_PATH, "",
+		       limiting_paths);
 	revs->limited = 1;
 }
 
@@ -1736,14 +1737,14 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 }
 
 static void read_pathspec_from_stdin(struct rev_info *revs, struct strbuf *sb,
-				     struct argv_array *prune)
+				     struct argv_array *limiting_paths)
 {
 	while (strbuf_getline(sb, stdin) != EOF)
-		argv_array_push(prune, sb->buf);
+		argv_array_push(limiting_paths, sb->buf);
 }
 
 static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct argv_array *prune)
+				      struct argv_array *limiting_paths)
 {
 	struct strbuf sb;
 	int seen_dashdash = 0;
@@ -1769,7 +1770,7 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 			die("bad revision '%s'", sb.buf);
 	}
 	if (seen_dashdash)
-		read_pathspec_from_stdin(revs, &sb, prune);
+		read_pathspec_from_stdin(revs, &sb, limiting_paths);
 
 	strbuf_release(&sb);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -1884,7 +1885,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->simplify_history = 0;
 		revs->simplify_by_decoration = 1;
 		revs->limited = 1;
-		revs->prune = 1;
+		revs->path_limiting = 1;
 		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
 	} else if (!strcmp(arg, "--date-order")) {
 		revs->sort_order = REV_SORT_BY_COMMIT_DATE;
@@ -2338,7 +2339,7 @@ static void NORETURN diagnose_missing_default(const char *def)
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *opt)
 {
 	int i, flags, left, seen_dashdash, got_rev_arg = 0, revarg_opt;
-	struct argv_array prune_data = ARGV_ARRAY_INIT;
+	struct argv_array path_limits = ARGV_ARRAY_INIT;
 	const char *submodule = NULL;
 
 	if (opt)
@@ -2356,7 +2357,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
-				argv_array_pushv(&prune_data, argv + i + 1);
+				argv_array_pushv(&path_limits, argv + i + 1);
 			seen_dashdash = 1;
 			break;
 		}
@@ -2387,7 +2388,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 				}
 				if (revs->read_from_stdin++)
 					die("--stdin given twice?");
-				read_revisions_from_stdin(revs, &prune_data);
+				read_revisions_from_stdin(revs, &path_limits);
 				continue;
 			}
 
@@ -2416,32 +2417,32 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j], j == i);
 
-			argv_array_pushv(&prune_data, argv + i);
+			argv_array_pushv(&path_limits, argv + i);
 			break;
 		}
 		else
 			got_rev_arg = 1;
 	}
 
-	if (prune_data.argc) {
+	if (path_limits.argc) {
 		/*
 		 * If we need to introduce the magic "a lone ':' means no
 		 * pathspec whatsoever", here is the place to do so.
 		 *
-		 * if (prune_data.nr == 1 && !strcmp(prune_data[0], ":")) {
-		 *	prune_data.nr = 0;
-		 *	prune_data.alloc = 0;
-		 *	free(prune_data.path);
-		 *	prune_data.path = NULL;
+		 * if (path_limits.nr == 1 && !strcmp(path_limits[0], ":")) {
+		 *	path_limits.nr = 0;
+		 *	path_limits.alloc = 0;
+		 *	free(path_limits.path);
+		 *	path_limits.path = NULL;
 		 * } else {
-		 *	terminate prune_data.alloc with NULL and
-		 *	call init_pathspec() to set revs->prune_data here.
+		 *	terminate path_limits.alloc with NULL and
+		 *	call init_pathspec() to set revs->path_limits here.
 		 * }
 		 */
-		parse_pathspec(&revs->prune_data, 0, 0,
-			       revs->prefix, prune_data.argv);
+		parse_pathspec(&revs->path_limits, 0, 0,
+			       revs->prefix, path_limits.argv);
 	}
-	argv_array_clear(&prune_data);
+	argv_array_clear(&path_limits);
 
 	if (revs->def == NULL)
 		revs->def = opt ? opt->def : NULL;
@@ -2475,14 +2476,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
-	if (revs->prune_data.nr) {
-		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
-		/* Can't prune commits with rename following: the paths change.. */
+	if (revs->path_limits.nr) {
+		copy_pathspec(&revs->pruning.pathspec, &revs->path_limits);
+		/*
+		 * Can't path-limit commits with rename following; the paths
+		 * change.
+		 */
 		if (!revs->diffopt.flags.follow_renames)
-			revs->prune = 1;
+			revs->path_limiting = 1;
 		if (!revs->full_diff)
 			copy_pathspec(&revs->diffopt.pathspec,
-				      &revs->prune_data);
+				      &revs->path_limits);
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges = 0;
@@ -2845,7 +2849,7 @@ static void simplify_merges(struct rev_info *revs)
 	struct commit_list *yet_to_do, **tail;
 	struct commit *commit;
 
-	if (!revs->prune)
+	if (!revs->path_limiting)
 		return;
 
 	/* feed the list reversed */
@@ -3361,7 +3365,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
-	if (revs->prune && revs->dense) {
+	if (revs->path_limiting && revs->dense) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
 			int n;
@@ -3446,7 +3450,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	enum commit_action action = get_commit_action(revs, commit);
 
 	if (action == commit_show &&
-	    revs->prune && revs->dense && want_ancestry(revs)) {
+	    revs->path_limiting && revs->dense && want_ancestry(revs)) {
 		/*
 		 * --full-diff on simplified parents is no good: it
 		 * will show spurious changes from the commits that
diff --git a/revision.h b/revision.h
index 7987bfcd2e..88b7451362 100644
--- a/revision.h
+++ b/revision.h
@@ -87,7 +87,7 @@ struct rev_info {
 	/* Basic information */
 	const char *prefix;
 	const char *def;
-	struct pathspec prune_data;
+	struct pathspec path_limits;
 
 	/*
 	 * Whether the arguments parsed by setup_revisions() included any
@@ -111,7 +111,7 @@ struct rev_info {
 
 	/* Traversal flags */
 	unsigned int	dense:1,
-			prune:1,
+			path_limiting:1,
 			no_walk:2,
 			remove_empty_trees:1,
 			simplify_history:1,
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index d1ebfd88c7..79af1b7187 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -23,7 +23,7 @@ enum grep_pat_token {
 	test_commit add-user revision.c "
 	}
 	if (seen_dashdash)
-		read_pathspec_from_stdin(revs, &sb, prune);
+		read_pathspec_from_stdin(revs, &sb, limiting_paths);
 	strbuf_release(&sb);
 }
 
diff --git a/tree-walk.c b/tree-walk.c
index 79bafbd1a2..b60170b6b4 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -365,10 +365,10 @@ static void free_extended_entry(struct tree_desc_x *t)
 	}
 }
 
-static inline int prune_traversal(struct name_entry *e,
-				  struct traverse_info *info,
-				  struct strbuf *base,
-				  int still_interesting)
+static inline int path_limit_traversal(struct name_entry *e,
+				       struct traverse_info *info,
+				       struct strbuf *base,
+				       int still_interesting)
 {
 	if (!info->pathspec || still_interesting == 2)
 		return 2;
@@ -461,7 +461,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		}
 		if (!mask)
 			break;
-		interesting = prune_traversal(e, info, &base, interesting);
+		interesting = path_limit_traversal(e, info, &base, interesting);
 		if (interesting < 0)
 			break;
 		if (interesting) {
diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..b0a3efea4b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -603,7 +603,7 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
-	copy_pathspec(&rev.prune_data, &s->pathspec);
+	copy_pathspec(&rev.path_limits, &s->pathspec);
 	run_diff_files(&rev, 0);
 }
 
@@ -639,7 +639,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
 	rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
-	copy_pathspec(&rev.prune_data, &s->pathspec);
+	copy_pathspec(&rev.path_limits, &s->pathspec);
 	run_diff_index(&rev, 1);
 }
 
-- 
2.17.1

