Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1771F731
	for <e@80x24.org>; Mon,  5 Aug 2019 16:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHEQnq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 12:43:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34154 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfHEQno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 12:43:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so7054916wmd.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 09:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HAt+52bMUDaRPqZhlw2fu+5b/BlyOkZDEobPrailhmE=;
        b=f7WLGNl/uhfcXyyqu1E4xxMbylUGlIFxW0IT2ifGgbbXUMRocFlWcGHcTrxR2cAMTs
         UkLQ5zZJa+9tP7Fg71HwL3VDJM71Smuqgarc4Kfx9ENkbD13MUVCWd7LwjXxvo4tBHjA
         YyeUTBwkc/qETre29J4+vh2J6YGTm9bEuISK1hCgrCy19FdNm6gx2i4EoI8CjO01yez9
         ZoAYYq88XTP2ApR09S0ZKzqGdjxsOKkUcipQneYXywe1yP6axijpOavmazWgyY+QATaC
         hCeVxDweqA1SnsCFokeUrn0sOIxJqpikC7RnYL3ItpbWgPfYboaut1grFYVtTindSBFs
         2YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HAt+52bMUDaRPqZhlw2fu+5b/BlyOkZDEobPrailhmE=;
        b=AnUBQlnnsBG7ld++K02AST4QZGnaxrQlGLonKMz8eyJyHoIGJ5Ikhm0lnsEugjW4gB
         0EUnEmqx9bQSy9Bz8EBNEcQM4Wwbob90M1nWmFgyU4mOv5VkYggT5AlI3nMM3/mz1kZq
         o/a3PHgECueFrGKpGC4qp0VvapOkt58hu+fhb2wsljDuAS9iw7s+4ww+lkp57x/NZyV2
         yHEj5xBulu3LtA/pA/fMVdvLZcH2968lnXm/NGYRE+cg3WUrc+M9pJzhFaCn3JneehhM
         vuWOCBSjTdiR/9ZyzICfPi+2i7o7X5VYgR1cJPQ+bnRHb9xvXMC4zbUoDPm6sXNu7Pl6
         G4AQ==
X-Gm-Message-State: APjAAAWCIjTVMhb85MskBN+E1z9b4gbZ6LiLtaVXdMDRilMw9+hzbPBs
        y2QEpnm5ztnjPhaK3kNm3IEYVaFa
X-Google-Smtp-Source: APXvYqxQQFlIcU3rxjFis8ru4FPIJx4niI2L83JHhNgxJloPYTjMgqmlt7ATrPFdla7ze4onaWNrpg==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr18057973wma.123.1565023422301;
        Mon, 05 Aug 2019 09:43:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm61194558wmc.21.2019.08.05.09.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 09:43:41 -0700 (PDT)
Date:   Mon, 05 Aug 2019 09:43:41 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Aug 2019 16:43:39 GMT
Message-Id: <6e913ac2b6ddc080c7796e93f019243bbdce1dff.1565023420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.308.git.gitgitgadget@gmail.com>
References: <pull.308.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] commit-graph: fix bug around octopus merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@google.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In 1771be90 "commit-graph: merge commit-graph chains" (2019-06-18),
the method sort_and_scan_merged_commits() was added to merge the
commit lists of two commit-graph files in the incremental format.
Unfortunately, there was an off-by-one error in that method around
incrementing num_extra_edges, which leads to an incorrect offset
for the base graph chunk.

When we store an octopus merge in the commit-graph file, we store
the first parent in the normal place, but use the second parent
position to point into the "extra edges" chunk where the remaining
parents exist. This means we should be adding "num_parents - 1"
edges to this list, not "num_parents - 2". That is the basic error.

The reason this was not caught in the test suite is more subtle.
In 5324-split-commit-graph.sh, we test creating an octopus merge
and adding it to the tip of a commit-graph chain, then verify the
result. This _should_ have caught the problem, except that when
we load the commit-graph files we were overly careful to not fail
when the commit-graph chain does not match. This care was on
purpose to avoid race conditions as one process reads the chain
and another process modifies it. In such a case, the reading
process outputs the following message to stderr:

	warning: commit-graph chain does not match

These warnings are output in the test suite, but ignored. By
checking the stderr of `git commit-graph verify` to include
the expected progress output, it will now catch this error.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c                | 2 +-
 t/t5324-split-commit-graph.sh | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index c91e6f0fb8..1aaf02879b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1629,7 +1629,7 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
 				num_parents++;
 
 			if (num_parents > 2)
-				ctx->num_extra_edges += num_parents - 2;
+				ctx->num_extra_edges += num_parents - 1;
 		}
 	}
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 03f45a1ed9..99f4ef4c19 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -319,7 +319,9 @@ test_expect_success 'add octopus merge' '
 	git merge commits/3 commits/4 &&
 	git branch merge/octopus &&
 	git commit-graph write --reachable --split &&
-	git commit-graph verify &&
+	git commit-graph verify 2>err &&
+	test_line_count = 3 err &&
+	test_i18ngrep ! warning err &&
 	test_line_count = 3 $graphdir/commit-graph-chain
 '
 
-- 
gitgitgadget
