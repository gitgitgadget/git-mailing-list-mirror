Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B3F1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGRPyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:09 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42264 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeGRPyH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:07 -0400
Received: by mail-pf0-f195.google.com with SMTP id l9-v6so2355061pff.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=w7BCC0uiO8wQOEGcgZhweviqSGiOaN3LeBr65w4FtEM=;
        b=oepnQ3R7KLtqN/oiwxgU5eopVqCah3rEpDNjCcI3IIbCG9lR6Hg2hlZLwl4vx/50gg
         TC6DqAjOxVWZPOcRXoKhFnvqFCR4ghZraC9dsAr0HKODsxDlhe6/sA5VGizcZX0P6qvg
         pVOyDpv2LdLOxHeG19tiK9I7ntHBCax+8jNmHYGyQ7W724Di1JuTxt/6ewStGbQwK5MX
         ptfHwXwEkWmyHk4rgv308x9qD12YZiSNboU0CTIXTO87lu2J0UyoXs/gL3k0o8jXHG2x
         39HLsJdyqGwsXjgfJKGJxRnueNJc8ZB/SHJnFir0NjTEWm+2kqtiPO9R4JqCCsyhKToc
         y8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=w7BCC0uiO8wQOEGcgZhweviqSGiOaN3LeBr65w4FtEM=;
        b=AVLEpfk4LRNY58+kWABOiIo8TWNx5wQT/uU6MsgC4xMjNn69scVepEtGg5ncFTaetY
         jT/myePz3cgG03JuKX1NSmNu8+nGpspItwWbnUREN3mUoVATZUfI6GKrJ6jvUt0IiCO0
         XdlK372sTw9npB1w1yIxi+ApzQ6Pqae+UZZLhWaR+D9nJQX6SyuT1BiQ3oNnBN4Qlf23
         ZlikP3Fvs3a+jhg+hBUNhxdAkmVKmwLwBY+PGTSprH2EZzKTYXytmcciNje5t/rrvRO+
         XL5kkyyKgk9dCKpV+L/5O/SkYlhgeh962viU93eHAvMiuJVkfYeV1PxsSyRfuHZIOXwc
         q3Aw==
X-Gm-Message-State: AOUpUlHv1pxY1kM7feig2VeD7l6LjOytj7wk/xxOV14enCUHacgYZTaw
        f1vSUiGwXK92Q4oM7r8nk4h6UoTN
X-Google-Smtp-Source: AAOMgpdGnK1092WWDEBWJdkOCyDeUnBhkNdh4Pc4DaNbWCLDNU9+8kVD8LroHe31snXqZGDNi1BUyw==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr6098336pgn.80.1531926945232;
        Wed, 18 Jul 2018 08:15:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id f5-v6sm6390647pgn.34.2018.07.18.08.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:44 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:44 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:30 GMT
Message-Id: <5314a5a93dfc224edd995fa12d195087c4685208.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 7/8] commit-graph: not compatible with uninitialized repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 5097c7c12..233958e10 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -60,6 +60,9 @@ static struct commit_graph *alloc_commit_graph(void)
 
 static int commit_graph_compatible(struct repository *r)
 {
+	if (!r->gitdir)
+		return 0;
+
 	prepare_commit_graft(r);
 	if (r->parsed_objects && r->parsed_objects->grafts_nr)
 		return 0;
-- 
gitgitgadget

