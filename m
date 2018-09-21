Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA371F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391010AbeIUX32 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:29:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35211 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUX32 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:29:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id 205-v6so5423122pgd.2
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kxsxfuatUGnB3bzwSX68mZcKrbJkiLhKQcgRuUNHX/w=;
        b=L4qmnI1hA11rtu7I8rno84o5UJKl+YVKqLoli9C7ErUQMuZq/7VqlnMPSE2iCSHNtQ
         CX2R683gc/cCq6VR4g29paWv9m2LTyM4bi3IcU3PE0jn41xmcQFhmlloXOwErtGBIMgT
         kicmQBhiylFL5SOm9jzlbbIw/HiS8HHEkVL8xSdWzLLnMDsJS8hPBIcJtsWb5zeZe6Qv
         Txgo0C35jwj8zkKTeM7Tu3G2DAIJMHZr70scQ1OoCqs2amDMs9dF6K/A4GlbW9FvJ+XP
         C/h58SYAf2ACXEnXt9bFkHjC6TA2PPjQVBJuMqynoy3W7nqq4UZCbNsEoDqlKJWwA2aD
         xq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kxsxfuatUGnB3bzwSX68mZcKrbJkiLhKQcgRuUNHX/w=;
        b=Cs+g+hKtNDyWskG4MjEqvy8itathXUheMaR9A9sv4I7E4vVaOkeGqLi6NEYBi4AnaW
         Xv2YckrsciC7WHr/1Y/fgvsCTi88i5MjWDmOfQ4motQY/eHSHF1x/7D6lNz5/Bx0aXBw
         H0hUomuGKDIGFimOHIcE8ZywP3I7G/mSUk7FnpgocaC5PtLqd/hsgvY/i5L8WZ8ZWcaW
         rxObxFTrFaGXG2gox5RojwS626nL326nvyYxLoGzINxiNPlpUTrOw67kuTSDcYflnV4c
         7mUfV9EPj5XsWBW5qCEFVoWKvYI2aouEfLRZaqSH5Pi5gyp6TFx2v7OPVJPG99NqCKdy
         3oEA==
X-Gm-Message-State: APzg51AO6FmT265/g8i5V7/1qR2s8QMbs95P3pYaz6egtp7Cy6eMdf7Y
        l+RGkxRoyPD+xxruEqYFKNR3l8F4
X-Google-Smtp-Source: ANB0Vda6bdKYN+GiPilTDM0rcrrjXRgqD6Jw+tdVDkAwpt2xyWvSBD6DmOvPXZ1uRfoZR9vKeF39Qw==
X-Received: by 2002:a63:68c7:: with SMTP id d190-v6mr9540223pgc.135.1537551572924;
        Fri, 21 Sep 2018 10:39:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r17-v6sm44809823pff.50.2018.09.21.10.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:39:32 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:39:32 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 17:39:20 GMT
Message-Id: <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v3.git.gitgitgadget@gmail.com>
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When running 'git rev-list --topo-order' and its kin, the topo_order
setting in struct rev_info implies the limited setting. This means
that the following things happen during prepare_revision_walk():

* revs->limited implies we run limit_list() to walk the entire
  reachable set. There are some short-cuts here, such as if we
  perform a range query like 'git rev-list COMPARE..HEAD' and we
  can stop limit_list() when all queued commits are uninteresting.

* revs->topo_order implies we run sort_in_topological_order(). See
  the implementation of that method in commit.c. It implies that
  the full set of commits to order is in the given commit_list.

These two methods imply that a 'git rev-list --topo-order HEAD'
command must walk the entire reachable set of commits _twice_ before
returning a single result.

If we have a commit-graph file with generation numbers computed, then
there is a better way. This patch introduces some necessary logic
redirection when we are in this situation.

In v2.18.0, the commit-graph file contains zero-valued bytes in the
positions where the generation number is stored in v2.19.0 and later.
Thus, we use generation_numbers_enabled() to check if the commit-graph
is available and has non-zero generation numbers.

When setting revs->limited only because revs->topo_order is true,
only do so if generation numbers are not available. There is no
reason to use the new logic as it will behave similarly when all
generation numbers are INFINITY or ZERO.

In prepare_revision_walk(), if we have revs->topo_order but not
revs->limited, then we trigger the new logic. It breaks the logic
into three pieces, to fit with the existing framework:

1. init_topo_walk() fills a new struct topo_walk_info in the rev_info
   struct. We use the presence of this struct as a signal to use the
   new methods during our walk. In this patch, this method simply
   calls limit_list() and sort_in_topological_order(). In the future,
   this method will set up a new data structure to perform that logic
   in-line.

2. next_topo_commit() provides get_revision_1() with the next topo-
   ordered commit in the list. Currently, this simply pops the commit
   from revs->commits.

3. expand_topo_walk() provides get_revision_1() with a way to signal
   walking beyond the latest commit. Currently, this calls
   add_parents_to_list() exactly like the old logic.

While this commit presents method redirection for performing the
exact same logic as before, it allows the next commit to focus only
on the new logic.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 revision.c | 42 ++++++++++++++++++++++++++++++++++++++----
 revision.h |  4 ++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index e18bd530e4..2dcde8a8ac 100644
--- a/revision.c
+++ b/revision.c
@@ -25,6 +25,7 @@
 #include "worktree.h"
 #include "argv-array.h"
 #include "commit-reach.h"
+#include "commit-graph.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -2454,7 +2455,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->diffopt.objfind)
 		revs->simplify_history = 0;
 
-	if (revs->topo_order)
+	if (revs->topo_order && !generation_numbers_enabled(the_repository))
 		revs->limited = 1;
 
 	if (revs->prune_data.nr) {
@@ -2892,6 +2893,33 @@ static int mark_uninteresting(const struct object_id *oid,
 	return 0;
 }
 
+struct topo_walk_info {};
+
+static void init_topo_walk(struct rev_info *revs)
+{
+	struct topo_walk_info *info;
+	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
+	info = revs->topo_walk_info;
+	memset(info, 0, sizeof(struct topo_walk_info));
+
+	limit_list(revs);
+	sort_in_topological_order(&revs->commits, revs->sort_order);
+}
+
+static struct commit *next_topo_commit(struct rev_info *revs)
+{
+	return pop_commit(&revs->commits);
+}
+
+static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
+{
+	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+		if (!revs->ignore_missing_links)
+			die("Failed to traverse parents of commit %s",
+			    oid_to_hex(&commit->object.oid));
+	}
+}
+
 int prepare_revision_walk(struct rev_info *revs)
 {
 	int i;
@@ -2928,11 +2956,13 @@ int prepare_revision_walk(struct rev_info *revs)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
 		return 0;
-	if (revs->limited)
+	if (revs->limited) {
 		if (limit_list(revs) < 0)
 			return -1;
-	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->sort_order);
+		if (revs->topo_order)
+			sort_in_topological_order(&revs->commits, revs->sort_order);
+	} else if (revs->topo_order)
+		init_topo_walk(revs);
 	if (revs->line_level_traverse)
 		line_log_filter(revs);
 	if (revs->simplify_merges)
@@ -3257,6 +3287,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 		if (revs->reflog_info)
 			commit = next_reflog_entry(revs->reflog_info);
+		else if (revs->topo_walk_info)
+			commit = next_topo_commit(revs);
 		else
 			commit = pop_commit(&revs->commits);
 
@@ -3278,6 +3310,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
 
 			if (revs->reflog_info)
 				try_to_simplify_commit(revs, commit);
+			else if (revs->topo_walk_info)
+				expand_topo_walk(revs, commit);
 			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
diff --git a/revision.h b/revision.h
index 2b30ac270d..fd4154ff75 100644
--- a/revision.h
+++ b/revision.h
@@ -56,6 +56,8 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+struct topo_walk_info;
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -245,6 +247,8 @@ struct rev_info {
 	const char *break_bar;
 
 	struct revision_sources *sources;
+
+	struct topo_walk_info *topo_walk_info;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
gitgitgadget

