Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3891D1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 14:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbeJ3XJp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 19:09:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35038 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbeJ3XJp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 19:09:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so5729363pgu.2
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jj0SQsDFcUMKE5MPGJTxJ1/g7UyA4IupC/2yyqhmhJQ=;
        b=awRn8Ep3rI3E2K7twReZ8rkFqA3qwEiiecVUOvKM3xh9hNqLVuW8bhghw9KZ5Bm2Od
         iJPscPr/UKJ+93DDOOuTmSuRyJpoV4irFyMMSa+LnLSAvpEvKUJU7JM5EElC8PK12d02
         Ad8P/hN6cfl5Clp/RMgX5hNOtJztZfMXGjmZu4FQjd07qy9Zf3Znch/j5huAQWPJsrTY
         HcCks/9fQjsbq+aUOdJte8R6G4LSs2eMXjS3lgvawB4TBg4VSFEk13Py0Kc5tlET+c9V
         wzJBiz00e3potWytwwJA7w5Y84UCHAqDbD9UFYu8ZTT3kta/mwZPkx7DecIuBnC7PeXV
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jj0SQsDFcUMKE5MPGJTxJ1/g7UyA4IupC/2yyqhmhJQ=;
        b=Rq7/+4TFcIA8LfpUwz5XzSCEr/pR7NCqzmRAwg9O/9WtTp0H4SykAz046ITspB81hs
         inWISxWWc1q5gkXgzilNp3tCV5npk27YOOUcsc5ZVQDHNgmWMjBVUgYkdRvBPAeqcaNk
         xrfNAySeWzr5VFnygsbJ9SyfmdHKFiI+D4BGlDVlFHPBOl2f+9gHsqBdnTzSiGQcCkka
         9c6Mv+rNQToKB4vzUeMFzkVEEf7UeYq4Nxx/m9Fk1aw4YI4jST4L3BgGXjtFCbnoHmPE
         NOIi8o4kBfdpfOUYdLcmBdp/mczuyRVJtuK9Vk6+f6/1fITgtv7XWBssyh2nk62y6WJs
         IjPg==
X-Gm-Message-State: AGRZ1gJVJgh+qUsNd6kShgtcH/2MG6gq9BC5pwmCD6Q4XG6j4/P8dKKT
        EWSKKP7Nt6xjZiF/n/O0gd7xbixm
X-Google-Smtp-Source: AJdET5ceV41Uj/C6nWestWAFWdkwPBwYRTw27FkfCv9QsnCsDTorwZZ71/xsERpebvFco01Ej4Vg8Q==
X-Received: by 2002:a63:ba48:: with SMTP id l8mr17789320pgu.72.1540908965168;
        Tue, 30 Oct 2018 07:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id m16-v6sm22019628pff.173.2018.10.30.07.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 07:16:04 -0700 (PDT)
Date:   Tue, 30 Oct 2018 07:16:04 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 14:15:58 GMT
Message-Id: <4c0c5c9143a757ee5187ae6fca9a76f29b6c6ae2.1540908961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] commit-reach: implement get_reachable_subset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, newren@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing reachability algorithms in commit-reach.c focus on
finding merge-bases or determining if all commits in a set X can
reach at least one commit in a set Y. However, for two commits sets
X and Y, we may also care about which commits in Y are reachable
from at least one commit in X.

Implement get_reachable_subset() which answers this question. Given
two arrays of commits, 'from' and 'to', return a commit_list with
every commit from the 'to' array that is reachable from at least
one commit in the 'from' array.

The algorithm is a simple walk starting at the 'from' commits, using
the PARENT2 flag to indicate "this commit has already been added to
the walk queue". By marking the 'to' commits with the PARENT1 flag,
we can determine when we see a commit from the 'to' array. We remove
the PARENT1 flag as we add that commit to the result list to avoid
duplicates.

The order of the resulting list is a reverse of the order that the
commits are discovered in the walk.

There are a couple shortcuts to avoid walking more than we need:

1. We determine the minimum generation number of commits in the
   'to' array. We do not walk commits with generation number
   below this minimum.

2. We count how many distinct commits are in the 'to' array, and
   decrement this count when we discover a 'to' commit during the
   walk. If this number reaches zero, then we can terminate the
   walk.

Tests will be added using the 'test-tool reach' helper in a
subsequent commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-reach.h | 10 ++++++++
 2 files changed, 80 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 9f79ce0a2..a98532ecc 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -688,3 +688,73 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	object_array_clear(&from_objs);
 	return result;
 }
+
+struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
+					 struct commit **to, int nr_to,
+					 int reachable_flag)
+{
+	struct commit **item;
+	struct commit *current;
+	struct commit_list *found_commits = NULL;
+	struct commit **to_last = to + nr_to;
+	struct commit **from_last = from + nr_from;
+	uint32_t min_generation = GENERATION_NUMBER_INFINITY;
+	int num_to_find = 0;
+
+	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
+
+	for (item = to; item < to_last; item++) {
+		struct commit *c = *item;
+		
+		parse_commit(c);
+		if (c->generation < min_generation)
+			min_generation = c->generation;
+
+		if (!(c->object.flags & PARENT1)) {
+			c->object.flags |= PARENT1;
+			num_to_find++;
+		}
+	}
+
+	for (item = from; item < from_last; item++) {
+		struct commit *c = *item;
+		if (!(c->object.flags & PARENT2)) {
+			c->object.flags |= PARENT2;
+			parse_commit(c);
+
+			prio_queue_put(&queue, *item);
+		}
+	}
+
+	while (num_to_find && (current = prio_queue_get(&queue)) != NULL) {
+		struct commit_list *parents;
+
+		if (current->object.flags & PARENT1) {
+			current->object.flags &= ~PARENT1;
+			current->object.flags |= reachable_flag;
+			commit_list_insert(current, &found_commits);
+			num_to_find--;
+		}
+
+		for (parents = current->parents; parents; parents = parents->next) {
+			struct commit *p = parents->item;
+
+			parse_commit(p);
+
+			if (p->generation < min_generation)
+				continue;
+
+			if (p->object.flags & PARENT2)
+				continue;
+
+			p->object.flags |= PARENT2;
+			prio_queue_put(&queue, p);
+		}
+	}
+
+	clear_commit_marks_many(nr_to, to, PARENT1);
+	clear_commit_marks_many(nr_from, from, PARENT2);
+
+	return found_commits;
+}
+
diff --git a/commit-reach.h b/commit-reach.h
index 7d313e297..43bd50a70 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -74,4 +74,14 @@ int can_all_from_reach_with_flag(struct object_array *from,
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
 
+
+/*
+ * Return a list of commits containing the commits in the 'to' array
+ * that are reachable from at least one commit in the 'from' array.
+ * Also add the given 'flag' to each of the commits in the returned list.
+ */
+struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
+					 struct commit **to, int nr_to,
+					 int reachable_flag);
+
 #endif
-- 
gitgitgadget

