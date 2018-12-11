Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4369A20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 05:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeLKFQG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 00:16:06 -0500
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:45608 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbeLKFQF (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 00:16:05 -0500
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id WaIlgX4jV8nS7WaOpgGvm1; Tue, 11 Dec 2018 05:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1544505363;
        bh=YMhbJ5ythbgfaN6icKt8HXwjBtoOyL1SVt9UgN6tIj4=;
        h=Received:Received:Date:From:Reply-To:To:Message-ID:Subject:
         MIME-Version:Content-Type;
        b=APLHX08J++KJh4sdpBBhGhidWGeULPieme21fM+TfLkRX9XSFCdbzrLpUVJ+mMsAT
         xVilKnycN224vGwEZDdLdZgUf6Kf2+OAIN9m6HNnkXClYRBnbsDzUFfwttdeAZ0Z38
         pd/3SMHbrPDnGW5DpI90BDOfSPTBOzRIg9ptSXWdYaV0tyMc5C7zcOyfA3lgnH+Y26
         FoH/KaJs9nu/QsPTs99GQCMWqHz++hC0HQtmZlb1QWUebUTW0JcI49U+lAYHFRwnWM
         qr6uZAP/nbMwtcC5Enz79M46F87rpiD6DaZ3Rsk938qOf22oRIqmKBN8VNwNb9HccM
         16QNJrS0EmZwQ==
Received: from oxapp-hoc-61o.email.comcast.net ([96.118.243.254])
        by resomta-po-10v.sys.comcast.net with ESMTPS
        id WaOogrgJ4hDEOWaOogYVqo; Tue, 11 Dec 2018 05:16:03 +0000
Date:   Mon, 10 Dec 2018 21:16:02 -0800 (PST)
From:   MATTHEW DEVORE <matvore@comcast.net>
Reply-To: MATTHEW DEVORE <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>,
        dstolee@microsoft.com, pclouds@gmail.com, Jeff King <peff@peff.net>
Message-ID: <247509408.3503.1544505362525@connect.xfinity.com>
In-Reply-To: <xmqq1s6oon7a.fsf@gitster-ct.c.googlers.com>
References: <20181206213315.64423-1-matvore@google.com>
 <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
 <CAMfpvhKh3xewUY-g9oVJq1o=G3w9EspoQUHc1edHUx3AD4OWfg@mail.gmail.com>
 <xmqq1s6oon7a.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH] terminology tweak: prune -> path limiting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev38
X-Originating-IP: 2601:647:4b00:531b:5498:1316:d27c:dd4f
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4wfCOoEkl6Sd4naTXrof2RgQe0j/sUh1pnRxkMjm2zikukmFVEdwXGAt1i6Qc4oV/75Nh61Szxw3PawgH7KjZXP6RyA1k+NUhWODPSgaMSAqhftH/TFclw
 zIm79u8oLO4XJYOHuEDjL7m70hKSjnMhZVEeE6ZP42CqLPMCk5rSDBIP3pDNyuBKTcDCXoUg/fuZ7GgWcL9pT28X4avQubBZTtPW8MvBKbkk3F9JK4ItU/5R
 G8TAMZ8pZIuKA8vIY+C2fLvwJ9JREjI3DEmCwqcQxyS3McbR1jir1lhUSV7YkZFOp+xCDzVx083zZ+aWfH28ASMY20NBn6jtTyhkJ6YssqNNkk5zLtmZcfFg
 +mepOyjJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On December 10, 2018 at 5:40 PM Junio C Hamano <gitster@pobox.com> wrote:
> So I think it is a good idea to get rid of prune_data and make it
> clear it is no longer a generic thing but cannot be anything but a
> pathspec.  I am not sure what the bit should be called, though.  It
> is a bit to enable any history simplification and not limited to
> pathspec limiting (e.g. simplify-by-decoration enables it, too).
> 

How about the below patch? I used "can_ignore_commits" as the bit name, which - as the commit msg states - reflects the terminology used in get_commit_action and related functions.

Subject: [PATCH] terminology tweak: prune -> path limiting

In the codebase, "prune" is a highly overloaded term, and it caused me a
lot of trouble to figure out what it meant when it was used in the
context of path limiting and stripping commits from history.

Rename two identifiers: prune_data (which used to be a void* argument to
a function called prune_fn) to path_limits, which correctly describes
its current use; and prune to can_ignore_commits, which describes well
what it means and parallels the terminology used in the
get_commit_action function.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/technical/api-history-graph.txt |  5 +-
 builtin/add.c                                 |  4 +-
 builtin/diff.c                                |  8 +-
 builtin/fast-export.c                         |  2 +-
 builtin/log.c                                 |  2 +-
 builtin/rev-list.c                            |  2 +-
 diff-lib.c                                    |  6 +-
 revision.c                                    | 92 ++++++++++---------
 revision.h                                    |  4 +-
 t/t7811-grep-open.sh                          |  2 +-
 tree-walk.c                                   | 10 +-
 wt-status.c                                   |  4 +-
 12 files changed, 73 insertions(+), 68 deletions(-)

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
index 3a2c0c23b6..f6ce622dd1 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -517,7 +517,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (show_progress)
 		progress = start_delayed_progress(show_progress, 0);
 
-	if (use_bitmap_index && !revs.prune) {
+	if (use_bitmap_index && !revs.can_ignore_commits) {
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
index 13e0519c02..9525c9f161 100644
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
+	 * TREESAME is irrelevant unless can_ignore_commits && dense;
 	 * if simplify_history is set, we can't have a mixture of TREESAME and
 	 *    !TREESAME INTERESTING parents (and we don't have treesame[]
 	 *    decoration anyway);
 	 * if first_parent_only is set, then the TREESAME flag is locked
 	 *    against the first parent (and again we lack treesame[] decoration).
 	 */
-	return revs->prune && revs->dense &&
+	return revs->can_ignore_commits && revs->dense &&
 	       !revs->simplify_history &&
 	       !revs->first_parent_only;
 }
@@ -636,9 +636,9 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	int relevant_parents, nth_parent;
 
 	/*
-	 * If we don't do pruning, everything is interesting
+	 * If we don't do commit pruning, everything is interesting
 	 */
-	if (!revs->prune)
+	if (!revs->can_ignore_commits)
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
+		revs->can_ignore_commits = 1;
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
+			revs->can_ignore_commits = 1;
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
+	if (!revs->can_ignore_commits)
 		return;
 
 	/* feed the list reversed */
@@ -3361,7 +3365,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	}
 	if (!commit_match(commit, revs))
 		return commit_ignore;
-	if (revs->prune && revs->dense) {
+	if (revs->can_ignore_commits && revs->dense) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
 			int n;
@@ -3446,7 +3450,7 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 	enum commit_action action = get_commit_action(revs, commit);
 
 	if (action == commit_show &&
-	    revs->prune && revs->dense && want_ancestry(revs)) {
+	    revs->can_ignore_commits && revs->dense && want_ancestry(revs)) {
 		/*
 		 * --full-diff on simplified parents is no good: it
 		 * will show spurious changes from the commits that
diff --git a/revision.h b/revision.h
index 7987bfcd2e..b19d5536f1 100644
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
+			can_ignore_commits:1,
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
