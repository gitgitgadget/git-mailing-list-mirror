Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806D61F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfFRSO3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45181 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbfFRSO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so22998034edv.12
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nQ2SwRtkE9V+AtvMVdTvLWMxbO5Pqf1rkl5zkihj8Fw=;
        b=WTs+VzBh/vOMTmVeq26yHdY4e8QSA86lDyQPoG6miPqBfCmmeB/Sl5YSFICHvB29nN
         uUJc4TGqfE0Rn1e8LzyYKuA/vuFNKJ+bGeQ/e32rOGsegXgzloM2luy0dq9/qwTke9mk
         ZhbJHKN7Hsf8ieqIC4d2Got9fYQOSVCgp3S+8V0EI/t/MmZ9rsIxNsq8OV4Hupck0Tmo
         rtsjrXNc/Oh5Gn09Y0YCvlBoJMkeQPPrvCrIG73ds+FCCIU1qOwn97r1p9sDZ+eODpV4
         JEGm1s9k8glO3ael+uZkpBoVGXWMxbUud7WrOgJKOth0woY4g5a02k1lfdZA5+RIXGng
         Rw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nQ2SwRtkE9V+AtvMVdTvLWMxbO5Pqf1rkl5zkihj8Fw=;
        b=UY9ZHiJ7Wf7AKndxBTbh1bvMNsrsU5Kiuj7Y4KF9l7iGuPOzlh7Y/CtJ5Ix8NgpY/N
         iobp7Jtl8nNbennrferGnidO15yLb/Ul5wsHMgW5hq7EXiYDsl2jjtBXrztTsnBNfb4G
         Eh0/qr3kx+p2FMfiEoTOQkT8h01ZHXKHklqyZ0Ub2uUU2Q5R3mhD3IavVm7E2ho6fUx1
         pfVTrdi8YZKberCuIsgRUicV2YhRzlypTgttQrDUmg3aiy2uqwmQ5u2RRMF0T71lLCFo
         GSwhNvWDvkh5dD+zmM6CU+4bAj7ukcmtwZE3yYVHm6KG8CmxLWpMgGAQUpe6NTprB5SG
         ZT1g==
X-Gm-Message-State: APjAAAXfg2ENPdQ0j+4/o7kgVBB3JOUGvN22D4RL1PXsQICkfs9Suz7r
        YEhYVDkBVxarg1suSX3/d8aU8zcE
X-Google-Smtp-Source: APXvYqxqHxE1CYPiJezFT7L7r/CunKZ69wRbbXDaGMyfhSdf7xli54m/vHRZX6yeZ9OKAbT5/qFXBQ==
X-Received: by 2002:a50:bc15:: with SMTP id j21mr125638171edh.163.1560881665336;
        Tue, 18 Jun 2019 11:14:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm5044564eda.43.2019.06.18.11.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:24 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:05 GMT
Message-Id: <62af96e62bc5a6ab4af6f6cbabbed5edbe586fc0.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 03/18] commit-graph: rename commit_compare to oid_compare
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The helper function commit_compare() actually compares object_id
structs, not commits. A future change to commit-graph.c will need
to sort commit structs, so rename this function in advance.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8f5c09363c..96b07a674e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -770,7 +770,7 @@ static void write_graph_chunk_extra_edges(struct hashfile *f,
 	}
 }
 
-static int commit_compare(const void *_a, const void *_b)
+static int oid_compare(const void *_a, const void *_b)
 {
 	const struct object_id *a = (const struct object_id *)_a;
 	const struct object_id *b = (const struct object_id *)_b;
@@ -1039,7 +1039,7 @@ static uint32_t count_distinct_commits(struct write_commit_graph_context *ctx)
 			_("Counting distinct commits in commit graph"),
 			ctx->oids.nr);
 	display_progress(ctx->progress, 0); /* TODO: Measure QSORT() progress */
-	QSORT(ctx->oids.list, ctx->oids.nr, commit_compare);
+	QSORT(ctx->oids.list, ctx->oids.nr, oid_compare);
 
 	for (i = 1; i < ctx->oids.nr; i++) {
 		display_progress(ctx->progress, i + 1);
-- 
gitgitgadget

