Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F761F453
	for <e@80x24.org>; Tue, 16 Oct 2018 22:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJQG3T (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 02:29:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJQG3S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 02:29:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id a5-v6so11509405pgv.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 15:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NU/Iu8Ji8N1MpF5ITTmj/BX7u15ZcGZShg5sidDyG0g=;
        b=YeZeqJZEPBm6YgjlBkt23DPQt/AYKq7tpuYi5ExuIvEd9KhZMgi0LDACuEWI1GAn9a
         HE0phWRDrPlEZnyGNSqwfXQ7EtFFGjbwgxhBmMTLEBr3o6jIndkV4VUAiIVU1GK4yX4q
         iD6ony3H69o8FJRYWyki5HoyJ6qT4EY78+he0MoEzyNvkeaM4pVJfifKJCSnVwnCFn09
         cRmdfrbr9JPDgPebDHUnvd6K5inmCwjrtX8SZqVH+seYz0hq4/QabriWCnWUozFQaW45
         C/wGdK6GkkRYbw8/L9II1c4kiyMFU38399e560brSVDWM9Tpybs7YOVd/2VjETiZwH7d
         4o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NU/Iu8Ji8N1MpF5ITTmj/BX7u15ZcGZShg5sidDyG0g=;
        b=T544mOIFhSTm22LiBWnIvG/2DHdodF3hE6UX4ryJjmFnph4ysaK2/GbGYRQ3jAYQ1M
         SsOOBx+T9BTZemUtjeztNmPTOgt60Si0yjsadUzveLOVgWNrI+vE6FOXl7uAsaV8rHEK
         8K1H/A5GF+ePj1YuhVKHJyaL6FaWK0JGtiR29q1lQbbNDkOH0ctEK6FcvSIcraBga7EF
         jugSgMjfOIyxLCfx51FIp/CShiBR9et5ncDxvHEcZBQiHJ9f2usbThJcGd63tOH9/kv1
         i+tfI66ooqZHCBMqCN+wcwpRpRjiFb/ZegcD7zg61OXpcNBp81QvSIi3qNn9zX2elFqy
         i4Yg==
X-Gm-Message-State: ABuFfoiHYrN3ZtsskfhTleFVv4QI1Of3iLFaH8csexV4MZm/OZzzVws5
        nlpEbZ3nYDmbK92ai1QidIBlrwY9
X-Google-Smtp-Source: ACcGV62kAZCwP0c+yomoS1syYVWa9FVRBry1CY49qoAi3WDll6H1dPY7zarKiuJKgR6LV1L+XbBWnw==
X-Received: by 2002:a65:4103:: with SMTP id w3-v6mr22389833pgp.284.1539729404792;
        Tue, 16 Oct 2018 15:36:44 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id e2-v6sm16496554pgv.25.2018.10.16.15.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:36:43 -0700 (PDT)
Date:   Tue, 16 Oct 2018 15:36:43 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 22:36:30 GMT
Message-Id: <f3e291665dae94b7347621ec78721f7e0dcc86d8.1539729393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.v4.git.gitgitgadget@gmail.com>
References: <pull.25.v3.git.gitgitgadget@gmail.com>
        <pull.25.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 5/7] commit/revisions: bookkeeping before refactoring
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

There are a few things that need to move around a little before
making a big refactoring in the topo-order logic:

1. We need access to record_author_date() and
   compare_commits_by_author_date() in revision.c. These are used
   currently by sort_in_topological_order() in commit.c.

2. Moving these methods to commit.h requires adding the author_slab
   definition to commit.h.

3. The add_parents_to_list() method in revision.c performs logic
   around the UNINTERESTING flag and other special cases depending
   on the struct rev_info. Allow this method to ignore a NULL 'list'
   parameter, as we will not be populating the list for our walk.
   Also rename the method to the slightly more generic name
   process_parents() to make clear that this method does more than
   add to a list (and no list is required anymore).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c   | 11 +++++------
 commit.h   |  8 ++++++++
 revision.c | 18 ++++++++++--------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/commit.c b/commit.c
index d0f199e122..861a485e93 100644
--- a/commit.c
+++ b/commit.c
@@ -655,11 +655,10 @@ struct commit *pop_commit(struct commit_list **stack)
 /* count number of children that have not been emitted */
 define_commit_slab(indegree_slab, int);
 
-/* record author-date for each commit object */
-define_commit_slab(author_date_slab, timestamp_t);
+implement_shared_commit_slab(author_date_slab, timestamp_t);
 
-static void record_author_date(struct author_date_slab *author_date,
-			       struct commit *commit)
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit)
 {
 	const char *buffer = get_commit_buffer(commit, NULL);
 	struct ident_split ident;
@@ -684,8 +683,8 @@ fail_exit:
 	unuse_commit_buffer(commit, buffer);
 }
 
-static int compare_commits_by_author_date(const void *a_, const void *b_,
-					  void *cb_data)
+int compare_commits_by_author_date(const void *a_, const void *b_,
+				   void *cb_data)
 {
 	const struct commit *a = a_, *b = b_;
 	struct author_date_slab *author_date = cb_data;
diff --git a/commit.h b/commit.h
index 2b1a734388..977d397356 100644
--- a/commit.h
+++ b/commit.h
@@ -8,6 +8,7 @@
 #include "gpg-interface.h"
 #include "string-list.h"
 #include "pretty.h"
+#include "commit-slab.h"
 
 #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
 #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
@@ -328,6 +329,13 @@ extern int remove_signature(struct strbuf *buf);
  */
 extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/* record author-date for each commit object */
+define_shared_commit_slab(author_date_slab, timestamp_t);
+
+void record_author_date(struct author_date_slab *author_date,
+			struct commit *commit);
+
+int compare_commits_by_author_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/revision.c b/revision.c
index 2dcde8a8ac..36458265a0 100644
--- a/revision.c
+++ b/revision.c
@@ -768,8 +768,8 @@ static void commit_list_insert_by_date_cached(struct commit *p, struct commit_li
 		*cache = new_entry;
 }
 
-static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
-		    struct commit_list **list, struct commit_list **cache_ptr)
+static int process_parents(struct rev_info *revs, struct commit *commit,
+			   struct commit_list **list, struct commit_list **cache_ptr)
 {
 	struct commit_list *parent = commit->parents;
 	unsigned left_flag;
@@ -808,7 +808,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			if (p->object.flags & SEEN)
 				continue;
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		return 0;
 	}
@@ -847,7 +848,8 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 		p->object.flags |= left_flag;
 		if (!(p->object.flags & SEEN)) {
 			p->object.flags |= SEEN;
-			commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
+			if (list)
+				commit_list_insert_by_date_cached(p, list, cached_base, cache_ptr);
 		}
 		if (revs->first_parent_only)
 			break;
@@ -1091,7 +1093,7 @@ static int limit_list(struct rev_info *revs)
 
 		if (revs->max_age != -1 && (commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
-		if (add_parents_to_list(revs, commit, &list, NULL) < 0)
+		if (process_parents(revs, commit, &list, NULL) < 0)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
@@ -2913,7 +2915,7 @@ static struct commit *next_topo_commit(struct rev_info *revs)
 
 static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
 {
-	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+	if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
 		if (!revs->ignore_missing_links)
 			die("Failed to traverse parents of commit %s",
 			    oid_to_hex(&commit->object.oid));
@@ -2979,7 +2981,7 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 	for (;;) {
 		struct commit *p = *pp;
 		if (!revs->limited)
-			if (add_parents_to_list(revs, p, &revs->commits, &cache) < 0)
+			if (process_parents(revs, p, &revs->commits, &cache) < 0)
 				return rewrite_one_error;
 		if (p->object.flags & UNINTERESTING)
 			return rewrite_one_ok;
@@ -3312,7 +3314,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 				try_to_simplify_commit(revs, commit);
 			else if (revs->topo_walk_info)
 				expand_topo_walk(revs, commit);
-			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
+			else if (process_parents(revs, commit, &revs->commits, NULL) < 0) {
 				if (!revs->ignore_missing_links)
 					die("Failed to traverse parents of commit %s",
 						oid_to_hex(&commit->object.oid));
-- 
gitgitgadget

