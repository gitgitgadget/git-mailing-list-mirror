Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9B4211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbeK3B3h (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:29:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbeK3B3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so1016030pgs.2
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7YVmjDXk40ugiQlDntLjqH9e5LvYDUL8GIbea7sq3o8=;
        b=K4GpW1TxwE8xq9Ur0mgTx1Q2x+Sss9DjWnzYCAjfKJ2V72YEsA4c7UBQ3kqZ7DmQ3B
         ChHI4Gd94UNjieUJaaQkR2Htpqg8UaqPSm2YHKGB5eaz9YQCHiGI0NObWq/gaTBeY0PR
         wGhJ1ibjLdZpgN14DHkHDjL8GvE7iJInkUaz7/eORwJ3KG3dpZBsC9/mNdPXVAQE5wru
         f6sTxD2z+/SsRYkhBg/5js1os9gsu/xzDogRU8kNe0KoTnVrfmMZRMLvRmNiqf1/3F7r
         TdXZ/q+msS4jYZ6ELOfvR6D6cwBxUHf+PvBjDJTzO6rytxcCslZf0JyMYvNq82mTqxmL
         TJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7YVmjDXk40ugiQlDntLjqH9e5LvYDUL8GIbea7sq3o8=;
        b=j+Rw0nX6iiaEvfk+qDGnI4Quqlnx9Y79afGpMDiPqZqMX0t9GkfPtciw3mjTFYGb6e
         59b9GrhGdHYJPu4+VcEN2Us1wwKcqheUQ7G9VWcOeDoLrYdXtvEM0IFXCw6ivNAPFEGs
         CMc/+dERMBe7sWHYQc43WkwthjSl94/VjBQUwRAMX3bGtkt+bA2hB6UD8MW6FaiM1uyk
         wzBBl3PzgYcWiSFfx2IJTsBlX7HMZ65i1hfx6yqPX3ZNV6Q9hICoEO/w19vgjdaE9jfr
         ipSan5jcuV8BK4C5AC23hTWJDPpnwzY37ZZEeMkHgpfv+9gtcUbUxDJZlQg7yvEkfgNg
         gzQg==
X-Gm-Message-State: AA+aEWYOATc0HT2HS4aG6hQsIsxCYf7Rb53ePPRzkpL4Qqc3LH2Bb0OT
        wMIeZn7kWIS84cPTHU8qXGkBhI8Y
X-Google-Smtp-Source: AFSGD/UzXO1j/UEJQws3/mlFHlkRFUyA2AqZpPXloEiOGGyut6uXXIlQw/YQOQQSQyf6oDixdgy5Ag==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr1388933pgg.16.1543501443872;
        Thu, 29 Nov 2018 06:24:03 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id u137sm6917734pfc.140.2018.11.29.06.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:03 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:03 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:54 GMT
Message-Id: <4527addacb6cb663e463859c6661918ea47768cd.1543501438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
        <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/6] list-objects: consume sparse tree walk
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When creating a pack-file using 'git pack-objects --revs' we provide
a list of interesting and uninteresting commits. For example, a push
operation would make the local topic branch be interesting and the
known remote refs as uninteresting. We want to discover the set of
new objects to send to the server as a thin pack.

We walk these commits until we discover a frontier of commits such
that every commit walk starting at interesting commits ends in a root
commit or unintersting commit. We then need to discover which
non-commit objects are reachable from  uninteresting commits.

The mark_edges_unintersting() method in list-objects.c iterates on
the commit list and does the following:

* If the commit is UNINTERSTING, then mark its root tree and every
  object it can reach as UNINTERESTING.

* If the commit is interesting, then mark the root tree of every
  UNINTERSTING parent (and all objects that tree can reach) as
  UNINTERSTING.

At the very end, we repeat the process on every commit directly
given to the revision walk from stdin. This helps ensure we properly
cover shallow commits that otherwise were not included in the
frontier.

The logic to recursively follow trees is in the
mark_tree_uninteresting() method in revision.c. The algorithm avoids
duplicate work by not recursing into trees that are already marked
UNINTERSTING.

Add a new 'sparse' option to the mark_edges_uninteresting() method
that performs this logic in a slightly new way. As we iterate over
the commits, we add all of the root trees to an oidset. Then, call
mark_trees_uninteresting_sparse() on that oidset. Note that we
include interesting trees in this process. The current implementation
of mark_trees_unintersting_sparse() will walk the same trees as
the old logic, but this will be replaced in a later change.

The sparse option is not used by any callers at the moment, but
will be wired to 'git pack-objects' in the next change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bisect.c               |  2 +-
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  2 +-
 http-push.c            |  2 +-
 list-objects.c         | 55 +++++++++++++++++++++++++++++++++++++++---
 list-objects.h         |  4 ++-
 revision.c             |  3 +++
 7 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 487675c672..842f8b4b8f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -656,7 +656,7 @@ static void bisect_common(struct rev_info *revs)
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 	if (revs->tree_objects)
-		mark_edges_uninteresting(revs, NULL);
+		mark_edges_uninteresting(revs, NULL, 0);
 }
 
 static void exit_if_skipped_commits(struct commit_list *tried,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 411aefd687..5f70d840a7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3135,7 +3135,7 @@ static void get_object_list(int ac, const char **av)
 
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
-	mark_edges_uninteresting(&revs, show_edge);
+	mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (!fn_show_object)
 		fn_show_object = show_object;
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 2880ed37e3..9663cbfae0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -543,7 +543,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	if (revs.tree_objects)
-		mark_edges_uninteresting(&revs, show_edge);
+		mark_edges_uninteresting(&revs, show_edge, 0);
 
 	if (bisect_list) {
 		int reaches, all;
diff --git a/http-push.c b/http-push.c
index cd48590912..ea52d6f9f6 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1933,7 +1933,7 @@ int cmd_main(int argc, const char **argv)
 		pushing = 0;
 		if (prepare_revision_walk(&revs))
 			die("revision walk setup failed");
-		mark_edges_uninteresting(&revs, NULL);
+		mark_edges_uninteresting(&revs, NULL, 0);
 		objects_to_send = get_delta(&revs, ref_lock);
 		finish_all_active_slots();
 
diff --git a/list-objects.c b/list-objects.c
index c41cc80db5..4fbdeca0a4 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -222,25 +222,72 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 	}
 }
 
-void mark_edges_uninteresting(struct rev_info *revs, show_edge_fn show_edge)
+static void add_edge_parents(struct commit *commit,
+			     struct rev_info *revs,
+			     show_edge_fn show_edge,
+			     struct oidset *set)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		struct tree *tree = get_commit_tree(parent);
+
+		if (!tree)
+			continue;
+
+		oidset_insert(set, &tree->object.oid);
+
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		tree->object.flags |= UNINTERESTING;
+
+		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
+			parent->object.flags |= SHOWN;
+			show_edge(parent);
+		}
+	}
+}
+
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse)
 {
 	struct commit_list *list;
+	struct oidset set;
 	int i;
 
+	if (sparse)
+		oidset_init(&set, 16);
+
 	for (list = revs->commits; list; list = list->next) {
 		struct commit *commit = list->item;
 
-		if (commit->object.flags & UNINTERESTING) {
+		if (sparse) {
+			struct tree *tree = get_commit_tree(commit);
+
+			if (commit->object.flags & UNINTERESTING)
+				tree->object.flags |= UNINTERESTING;
+
+			oidset_insert(&set, &tree->object.oid);
+			add_edge_parents(commit, revs, show_edge, &set);
+		} else if (commit->object.flags & UNINTERESTING) {
 			mark_tree_uninteresting(revs->repo,
 						get_commit_tree(commit));
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |= SHOWN;
 				show_edge(commit);
 			}
-			continue;
+		} else {
+			mark_edge_parents_uninteresting(commit, revs, show_edge);
 		}
-		mark_edge_parents_uninteresting(commit, revs, show_edge);
 	}
+
+	if (sparse) {
+		mark_trees_uninteresting_sparse(revs->repo, &set);
+		oidset_clear(&set);
+	}
+
 	if (revs->edge_hint_aggressive) {
 		for (i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
diff --git a/list-objects.h b/list-objects.h
index ad40762926..a952680e46 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -10,7 +10,9 @@ typedef void (*show_object_fn)(struct object *, const char *, void *);
 void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
 
 typedef void (*show_edge_fn)(struct commit *);
-void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
+void mark_edges_uninteresting(struct rev_info *revs,
+			      show_edge_fn show_edge,
+			      int sparse);
 
 struct oidset;
 struct list_objects_filter_options;
diff --git a/revision.c b/revision.c
index 3a62c7c187..f9eb6400f1 100644
--- a/revision.c
+++ b/revision.c
@@ -109,6 +109,9 @@ void mark_trees_uninteresting_sparse(struct repository *r,
 	while ((oid = oidset_iter_next(&iter))) {
 		struct tree *tree = lookup_tree(r, oid);
 
+		if (!tree)
+			continue;
+
 		if (tree->object.flags & UNINTERESTING) {
 			/*
 			 * Remove the flag so the next call
-- 
gitgitgadget

