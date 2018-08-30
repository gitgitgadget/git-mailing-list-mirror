Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8121F404
	for <e@80x24.org>; Thu, 30 Aug 2018 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbeH3RAN (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 13:00:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36122 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbeH3RAM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 13:00:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so3861756pfo.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bknMY1bGkiyqQCypmfqdWUwV5asdAgVHkM852KySpsM=;
        b=e6w/Cu5UfLBCpn9pEn4A0AsgMheOQw5ayQLRd8Y5MbWKgiA1Moc1nExDpaGBlmsqxl
         loJIUhLG3HSKTBfAFyIPLYDJ93ZddXWS1KKX73hsdIJt2oSiQA5p2yqIS2z7fmKS0vRh
         SpxmXLGSVBbYYXxZdlXCslAOukIojWk720Yzh3NLJheWLD8dZfV2/YrtncZLJjgvTDav
         y2xdbm1wofvZ0vFTkiIssq7/J3/ol1JmghVLKkBd/YYxt2Vss5xY4/ukPTG5wLMPPOqp
         XhNAPYnNb3Oq6YqsQ1g2eD1/HFQnxTe4OcXCnE4OZ5fDIonc7HER+TwLzD/uDA892rL4
         OOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bknMY1bGkiyqQCypmfqdWUwV5asdAgVHkM852KySpsM=;
        b=Qo/Y0V/MlEaNO3gPn+tQv0hYio5obTnjuZLCcBSCxAqpv6BYgBBXO7oqZzDn9707HL
         aJfoThm8QWWwxZ4uY7MXtxZndgMvd5uZoMCCxJ92nw+ewiA+F/sjl7fCPiBJD9mE3MHO
         UgbOrNKc90MuROqQLCHH1YcMY7/8duDMAMumoO8U6NtfZFTXzRy+e3DcBPpDPhcNknHc
         WzPLhbZZTEpIjpzXWUs0hmCYCefLXfzQfZN/4h5ocok+04MPPowQPOTReXFwEz2Vr1XJ
         OQoaborRVJcYiyOcQmCP21eSNGfdFjhoRQ2Zvlgurw0ZNUwWu92wHpOqzjZEgqcfG+Hn
         lrCQ==
X-Gm-Message-State: APzg51De/ZnavUJzzVBbdXdYtiJSxSp1OMZDS72QIh6ccbWNNRfPxzZA
        aLvhwTb/SapDeyYoGPKZ3Ks4m6nX
X-Google-Smtp-Source: ANB0Vdbj8eGpXRogzu+w2YgTA9Y3s/S0Iul/ZkaE+geqSPMB1KERwcQnnwaSYWYwkQpJ7FU149Dm+w==
X-Received: by 2002:a63:4757:: with SMTP id w23-v6mr9857306pgk.140.1535633890054;
        Thu, 30 Aug 2018 05:58:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u17-v6sm12127142pfa.176.2018.08.30.05.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 05:58:09 -0700 (PDT)
Date:   Thu, 30 Aug 2018 05:58:09 -0700 (PDT)
X-Google-Original-Date: Thu, 30 Aug 2018 12:58:05 GMT
Message-Id: <efa3720fb40638e5d61c6130b55e3348d8e4339e.1535633886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.28.git.gitgitgadget@gmail.com>
References: <pull.28.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit: don't use generation numbers if not needed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 3afc679b "commit: use generations in paint_down_to_common()",
the queue in paint_down_to_common() was changed to use a priority
order based on generation number before commit date. This served
two purposes:

 1. When generation numbers are present, the walk guarantees
    correct topological relationships, regardless of clock skew in
    commit dates.

 2. It enables short-circuiting the walk when the min_generation
    parameter is added in d7c1ec3e "commit: add short-circuit to
    paint_down_to_common()". This short-circuit helps commands
    like 'git branch --contains' from needing to walk to a merge
    base when we know the result is false.

The commit message for 3afc679b includes the following sentence:

    This change does not affect the number of commits that are
    walked during the execution of paint_down_to_common(), only
    the order that those commits are inspected.

This statement is incorrect. Because it changes the order in which
the commits are inspected, it changes the order they are added to
the queue, and hence can change the number of loops before the
queue_has_nonstale() method returns true.

This change makes a concrete difference depending on the topology
of the commit graph. For instance, computing the merge-base between
consecutive versions of the Linux kernel has no effect for versions
after v4.9, but 'git merge-base v4.8 v4.9' presents a performance
regression:

    v2.18.0: 0.122s
v2.19.0-rc1: 0.547s
       HEAD: 0.127s

To determine that this was simply an ordering issue, I inserted
a counter within the while loop of paint_down_to_common() and
found that the loop runs 167,468 times in v2.18.0 and 635,579
times in v2.19.0-rc1.

The topology of this case can be described in a simplified way
here:

  v4.9
   |  \
   |   \
  v4.8  \
   | \   \
   |  \   |
  ...  A  B
   |  /  /
   | /  /
   |/__/
   C

Here, the "..." means "a very long line of commits". By generation
number, A and B have generation one more than C. However, A and B
have commit date higher than most of the commits reachable from
v4.8. When the walk reaches v4.8, we realize that it has PARENT1
and PARENT2 flags, so everything it can reach is marked as STALE,
including A. B has only the PARENT1 flag, so is not STALE.

When paint_down_to_common() is run using
compare_commits_by_commit_date, A and B are removed from the queue
early and C is inserted into the queue. At this point, C and the
rest of the queue entries are marked as STALE. The loop then
terminates.

When paint_down_to_common() is run using
compare_commits_by_gen_then_commit_date, B is removed from the
queue only after the many commits reachable from v4.8 are explored.
This causes the loop to run longer. The reason for this regression
is simple: the queue order is intended to not explore a commit
until everything that _could_ reach that commit is explored. From
the information gathered by the original ordering, we have no
guarantee that there is not a commit D reachable from v4.8 that
can also reach B. We gained absolute correctness in exchange for
a performance regression.

The performance regression is probably the worse option, since
these incorrect results in paint_down_to_common() are rare. The
topology required for the performance regression are less rare,
but still require multiple merge commits where the parents differ
greatly in generation number. In our example above, the commit A
is as important as the commit B to demonstrate the problem, since
otherwise the commit C will sit in the queue as non-stale just as
long in both orders.

The solution provided uses the min_generation parameter to decide
if we should use generation numbers in our ordering. When
min_generation is equal to zero, it means that the caller has no
known cutoff for the walk, so we should rely on our commit-date
heuristic as before; this is the case with merge_bases_many().
When min_generation is non-zero, then the caller knows a valuable
cutoff for the short-circuit mechanism; this is the case with
remove_redundant() and in_merge_bases_many().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 1a6e632185..449c1f4920 100644
--- a/commit.c
+++ b/commit.c
@@ -874,6 +874,9 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 	int i;
 	uint32_t last_gen = GENERATION_NUMBER_INFINITY;
 
+	if (!min_generation)
+		queue.compare = compare_commits_by_commit_date;
+
 	one->object.flags |= PARENT1;
 	if (!n) {
 		commit_list_append(one, &result);
@@ -891,7 +894,7 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n,
 		struct commit_list *parents;
 		int flags;
 
-		if (commit->generation > last_gen)
+		if (min_generation && commit->generation > last_gen)
 			BUG("bad generation skip %8x > %8x at %s",
 			    commit->generation, last_gen,
 			    oid_to_hex(&commit->object.oid));
-- 
gitgitgadget
