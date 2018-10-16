Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4C11F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJQG3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39436 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQG3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so2699057plb.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kxsxfuatUGnB3bzwSX68mZcKrbJkiLhKQcgRuUNHX/w=;
        b=uu5NqKlbDTFEBwUCY96nW273ELyakiol5JJQf8xPfFBocsW0DSg9J3CMcHI9umKtzb
         1gkvVd8Un3Utcmo528HutO5hilhc+4bk0YQVHiU2UpuqAhdHfmOsmc8yfQodHKzi3ut4
         U/eifHbQ9FNFBG0VFA5voSjVII8dOg8lvokc+u1WVs0ndNhupH57RY8bmbu4BOUhpfeV
         XwyxDM49m/45BTMD0uRfKzk9a4f1MaA86THQeexn09U0LcJrmIFcQA5T6HdF3YkzzBgm
         bPaGUFnx4/Dq4rZgj6Y5cD9XqQ7cgYeuftI84gOm9P1j5thltTt0iC6UPtdRVP1sTHIl
         Zdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kxsxfuatUGnB3bzwSX68mZcKrbJkiLhKQcgRuUNHX/w=;
        b=iSLl0svTXWTmGNaj63Q8GB/V9OPONfHhU/GnX7RKt0GIYgwZvp3vVsM07b8K/LeFIk
         cyWld+u1djddXvrgnS4hiw61CFVXjsV6Jd2/FzhttfnUToE+kOwTF41JE/7gdAY7wyLc
         iTG7tSXA+BIPOwdEcwu58k1wNXV8FHINpkTr6CFiqMHLH5geIcv4gOtzl4C9BK0Zb+6J
         WZKhmXAKI59wJjG+OkjVS231k9guMgFxZi4LjyiIUqV33dyFkqrF6QxkNcFmINrcguu/
         1Y7X6bKXfYBxaXW1v+x0VO+B44UN3ELLvUaL/j+KAp4a0eHF8Sh/ZNbtKFVgFL/v6zKV
         jqqQ==
X-Gm-Message-State: ABuFfohd8WVlyPyZK7emPb3ZHs4qMNz60v4HS0WdbTwMn+5g59M/81mf
        yOW8OpljnHTM5vQ0GZCX2SIgsbA5
X-Google-Smtp-Source: ACcGV60HyYPvCfcZjK8ffwnqBkOGvJ3aqKaa54Vm0toUI2mZxAZKiVw/Xwc9DNGh8kugZ7eZE8D8Gw==
X-Received: by 2002:a17:902:848f:: with SMTP id c15-v6mr22718778plo.119.1539729403345;
        Tue, 16 Oct 2018 15:36:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o131-v6sm24468079pgo.53.2018.10.16.15.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:42 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:42 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:29 GMT
Message-Id: <cd9eef96885a811196ab0b851a98de4455b950ab.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 4/7] revision.c: begin refactoring --topo-order logic
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

