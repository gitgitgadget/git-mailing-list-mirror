Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E9C1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbfI3Vzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:55:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41973 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfI3Vzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:55:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id h7so13037503wrw.8
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U4gkM8z00G+ULvSXoPJuRz3JmlhFgs9IdSuoCkDNNQc=;
        b=A0WFeu89jsHNv3ETUnU8OglqZxEZi1/1kjF5CcIicLaltTuZ/cYFuJCK65QlJKn8Zi
         uFNSLvUgjg8E5j6IdJKxlI+KB+oUPxGcx/O0aEnjFL2MIOGDP8lSKWve7//MPO+RrMDv
         uIZpMxzzoYxcUO+mU+6RdjF46DQ9bZNItWd15gZupLAimC9ljzOXMHb7w/FwVFDtZQdw
         nFxtq6TJxkuPHbPUkP9ZFk9b0Pu8uuFScve5sgphbMWO1dSoaC+jd75IBnxn2P9CY2oC
         hhvDFDz7+X6kfPAfaYb3jK5MY5zY0evaIhYmfz13yXP2Mu9SJhk9DwpdpjQRpym/y3nZ
         ViDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U4gkM8z00G+ULvSXoPJuRz3JmlhFgs9IdSuoCkDNNQc=;
        b=n8SgIH8BnX7++qTL51R4XysIW22GEL4bTqxfNwY5WoDeLiLD7mtAZctp+fhAUt/rQj
         SbKXmUNYhXbcK/VkT2xqMj1AHMuPr4xVI9eR1APjYIKTUH84vOogzpfR8KJ8xiij62wE
         C9E+AX8obMvff7yDPVJY+Cr4+WRri6MAMYAgd4QTIzGl9rJChc0fGhGU2x14pGtACQ1j
         z5HkpN8EO2V2Qg04nuQWVkLu3TIYO7/c5TwHgWaao597sEKn5aqU2n9ffH15N+kE7CHD
         8zdAA4CzzDcBsM35tSVGmYVo6waYdxqYiDd9IzQuZhN0yH5fDCfsff8OvR0PBkfXkwcC
         8r/Q==
X-Gm-Message-State: APjAAAWsA6Yl8SoH0xL3lYkUGIbcn4F8LdDgR6g+OVbTNCQmAB6hO8Z0
        42YNWG5nZrC2KAUlcUFA2XVUUmag
X-Google-Smtp-Source: APXvYqwERWmH1mq96YP/kRzRzJ8IeoESwTFlCerLLvLttSgclimm7kHtsQguPQRCAY1WCfXz9gS/dg==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr15039383wro.329.1569864116038;
        Mon, 30 Sep 2019 10:21:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm13369727wrt.21.2019.09.30.10.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:21:55 -0700 (PDT)
Date:   Mon, 30 Sep 2019 10:21:55 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 17:21:52 GMT
Message-Id: <442140438aa0363c53cbfe1fe07219730f042e48.1569864113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.352.v2.git.gitgitgadget@gmail.com>
References: <pull.352.git.gitgitgadget@gmail.com>
        <pull.352.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] diffcore_rename(): use a stable sort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

During Git's rename detection, the file names are sorted. At the moment,
this job is performed by `qsort()`. As that function is not guaranteed
to implement a stable sort algorithm, this can lead to inconsistent
and/or surprising behavior: a rename might be detected differently
depending on the platform where Git was run.

The `qsort()` in MS Visual C's runtime does _not_ implement a stable
sort algorithm, and it even leads to an inconsistency leading to a test
failure in t3030.35 "merge-recursive remembers the names of all base
trees": a different code path than on Linux is taken in the rename
detection of an ambiguous rename between either `e` to `a` or
`a~Temporary merge branch 2_0` to `a` during a recursive merge,
unexpectedly resulting in a clean merge.

Let's use the stable sort provided by `git_stable_qsort()` to avoid this
inconsistency.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diffcore-rename.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9624864858..9042936aba 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -585,7 +585,7 @@ void diffcore_rename(struct diff_options *options)
 	stop_progress(&progress);
 
 	/* cost matrix sorted by most to least similar pair */
-	QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
+	STABLE_QSORT(mx, dst_cnt * NUM_CANDIDATE_PER_DST, score_compare);
 
 	rename_count += find_renames(mx, dst_cnt, minimum_score, 0);
 	if (detect_rename == DIFF_DETECT_COPY)
-- 
gitgitgadget
