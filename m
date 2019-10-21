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
	by dcvr.yhbt.net (Postfix) with ESMTP id AF7F31F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfJUN4m (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45830 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUN4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so9141668wrs.12
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=LIMogeRrJBStiml1i72o2K1ZI6soO3tSkstfApd+NCCFrUgLvuFIDeAvIn5DS6nCov
         HFMiQITa8lcqBaEk69WVoHlr2TIbAEhfjJuMl2Z4bcDfQokkmjLQ85eqw3d7cl4MFHtj
         LLjeWbDuKoBl/FJGdg68oXUuJn3xUnzG5x98yFgZ+njlWyWnsL2vexPZB+wZnMzk2dKk
         eY7wGhOcQeeYYiCoM6gV70xLd87vIWMSe3rDUlXsulH5xkXdSGsI5RZkMYWepKAAsdAT
         wJLhN3Fjh4vgK0qlMnWq8zc3PjrXvK5uM9CJaUAxzACQlV3Ty/aNo9pKppsRWcb16RXU
         qOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=ipQH/CrhlsmQdEPrvKN8P6MOMF5icvKVQ9uegddJSCpaZKK9qUfzo++QrtyWC8xRVE
         ogWUugedZfS8wU3zYjAo91Kgu3YcacuxhPymYgF8/D2OGsEnL74RbUGC2Dsc4/qb5AHO
         tXVFCUxOdPdcFoOb5SdEbtWTHrGVmaJr0qxo7yIPRGF4BSqNrDk1A2NGrlUl0RZHQSXo
         PONN+9tQlgNgLSbOAtdHCNhjde9P99v1pB/JBKu/UJ2q4RfJ3aEOKrHZv87r+zL+cMSV
         QCTy3d1yeClqBzTeERLiG7MFonoVa1az1YI8l6cMnU/uzbDF2GlNjpSzse3USrhT2Sx4
         ZoNw==
X-Gm-Message-State: APjAAAXsJoGUbUStHmk1hknCqLnH7OqDLz+NLcTBBqik958RKkKNHAnK
        Nq3qTrG5ZuqTkhFo6u2BNYw8rRCf
X-Google-Smtp-Source: APXvYqx7I2dHm0yvqyikfvZHiYrwXupLebr8Y+Xm30Yo6N5oHjJzzqlGwJzW4gPjFIXXPoo28iNrhw==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr20145846wrj.268.1571666194613;
        Mon, 21 Oct 2019 06:56:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm13808906wme.39.2019.10.21.06.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:34 -0700 (PDT)
Message-Id: <44b0245e65f54cbcec743184886d64a6b5ad87cf.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:16 +0000
Subject: [PATCH v5 07/17] trace2: add region in clear_ce_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

When Git updates the working directory with the sparse-checkout
feature enabled, the unpack_trees() method calls clear_ce_flags()
to update the skip-wortree bits on the cache entries. This
check can be expensive, depending on the patterns used.

Add trace2 regions around the method, including some flag
information, so we can get granular performance data during
experiments. This data will be used to measure improvements
to the pattern-matching algorithms for sparse-checkout.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 unpack-trees.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..01a05ff66d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1407,15 +1407,23 @@ static int clear_ce_flags(struct index_state *istate,
 			  struct pattern_list *pl)
 {
 	static struct strbuf prefix = STRBUF_INIT;
+	char label[100];
+	int rval;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(istate,
+	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
+		  (unsigned long)select_mask, (unsigned long)clear_mask);
+	trace2_region_enter("unpack_trees", label, the_repository);
+	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0);
+	trace2_region_leave("unpack_trees", label, the_repository);
+
+	return rval;
 }
 
 /*
-- 
gitgitgadget

