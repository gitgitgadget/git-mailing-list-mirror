Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814C71F453
	for <e@80x24.org>; Fri,  2 Nov 2018 13:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeKBWVz (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 18:21:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34418 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeKBWVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 18:21:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id k1-v6so996016pgq.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ITjmFg+PlIsAwHo1QEhE9E61cL2wnOaGWDvxGULWtNQ=;
        b=p268/RqrBL+qILfa0QfCtE6X85feFXOsJ4Jq+wOT+wVRUffH/REJN/koiCMn6vodQJ
         u0cHtg/DjlEutTa2u1/soYncSph//UmzpQK3GQPCkhFY++3fPmDz92UuUAlFEQyis2G1
         eeBVyG7ebV7Sp/bzpB1QMcmcwcB8jEyezbQJoD874t/cMRDMrNKmWwjxP765KS+KLwaY
         CO0Zvz1P/wSpmviLG07UHeZgLrF3QgiQ+sqI6AlMEFkv9Cz2aB9lwiwp8orbdu5zDRyN
         FQOzBdScM/McP8HnhYPAC/1jHoqD/v4MnaYYTtca/nwlPKvL2YiBnhYIihR5fRnWi1D5
         lM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ITjmFg+PlIsAwHo1QEhE9E61cL2wnOaGWDvxGULWtNQ=;
        b=FJOXKBQorApo8Db77huq0oPLTYIC6ny1UDBdRd1K8IzhWQP6BAQ/jSLDwX7xI69iXK
         YbAYmnCNPyOsNlL+fxjNo7vFxclK2vt2bcRBsf+tRuE1XggSdXWl7b/NCdO51qEGpGZs
         uDmjz2MUdaQf6usQ8Swy1txUb8OiKjojxmlZ5AVEy17s5zFwNckS4jd+DJO6K8zxOKqq
         svGkaQJd5wS17CTIbpsEb47HUzPh3qQLzApajblepAloPVr0CfXgUEW33Q16u0v5V6BX
         qBGNimZz4Q3OXIv9XQ2TZQL/XzD+rDy4SXIk1SuETkfiyhGdCzfQud86Q9TXROmChxDf
         OLdA==
X-Gm-Message-State: AGRZ1gIED3NW3LLCPBF0Ef6HhFuWvAhu6OMFX2O/cd1SB1K8G/6xb4yp
        1W2k2ztkpIqxvjOqHHZYrjSTnt1j
X-Google-Smtp-Source: AJdET5dGYq3lq2ShGjMjAzWzJpcej8mnlEJvhfEsMm2Vu+0k4bvvvTXYK8F4HcFPRTYgQtacPngqDw==
X-Received: by 2002:a63:181:: with SMTP id 123-v6mr11045984pgb.149.1541164486571;
        Fri, 02 Nov 2018 06:14:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id p15-v6sm28963625pfj.72.2018.11.02.06.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 06:14:45 -0700 (PDT)
Date:   Fri, 02 Nov 2018 06:14:45 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Nov 2018 13:14:40 GMT
Message-Id: <9e570603bda528986f425cae8a9c32ba700bc29b.1541164482.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.v2.git.gitgitgadget@gmail.com>
References: <pull.60.git.gitgitgadget@gmail.com>
        <pull.60.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/3] commit-reach: implement get_reachable_subset
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
 commit-reach.h | 13 ++++++++++
 2 files changed, 83 insertions(+)

diff --git a/commit-reach.c b/commit-reach.c
index 9f79ce0a22..8ad5352752 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -688,3 +688,73 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	object_array_clear(&from_objs);
 	return result;
 }
+
+struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
+					 struct commit **to, int nr_to,
+					 unsigned int reachable_flag)
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
index 7d313e2975..bb34af0269 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -74,4 +74,17 @@ int can_all_from_reach_with_flag(struct object_array *from,
 int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		       int commit_date_cutoff);
 
+
+/*
+ * Return a list of commits containing the commits in the 'to' array
+ * that are reachable from at least one commit in the 'from' array.
+ * Also add the given 'flag' to each of the commits in the returned list.
+ *
+ * This method uses the PARENT1 and PARENT2 flags during its operation,
+ * so be sure these flags are not set before calling the method.
+ */
+struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
+					 struct commit **to, int nr_to,
+					 unsigned int reachable_flag);
+
 #endif
-- 
gitgitgadget

