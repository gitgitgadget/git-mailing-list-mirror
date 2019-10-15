Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AF301F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbfJON4U (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbfJON4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id m18so20400639wmc.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=MIKsDubBW2l7uG1zBrY8Kqax+tTUKhnBWzx56CWn35g9LPyNFm0aeJ1Z6qU221FAAt
         ql5PrLHNjxMGNWTAR0658MwZVHLno6X3f/3x289zg0GHiJujsAMUFA1djzi5kHVj72iZ
         88E5qHU0sfszkaOMfyKU4HW7yaZQdjm7TYyUpAfvOeyqYIoTRdaJ9tzkDduRz7PRmNYf
         HJg2PX5WpDJKZbtibrWGFjpeRIU7rfJQj88oHO/EINFnFGO8ZPaMASY/kLYD/DrCBK2w
         iyjOlP0mtjJZGs8KNl37XY6n8w61tWod0Izwyi1YpF7S2SXVJg3k26E0fFnT4WEO3o2C
         AT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jp9fCPiVi8uv07s6DelseXp9idVSa4eBTh9PuKubi+E=;
        b=oBnhfSe8ecYbaSdYw6b8bmHYEjEvJMBW2wGSgIBxFAo3ipDC9FYHYhrHmwwtJp0f6S
         K6UG2lw5ER2o7I0tytWG0fwy7pMnHu0olXbF+WVTq4bf0ykGFThF5sM08iaoozhYHJDY
         1LYrjAFff0wzS9AV5j3C9EWDrC4dkXDwDVijcXbPk8cHxp8n586yV1oGvFwbmoihmK8U
         hPEVokKZtDZ096uPGgH1uw3NgFJfVLyo2E2yqEopBwnDqSmA9/0MAhfq58eK8aRl5jjv
         e7FHGtCewBpcTmHcTsUtMCntWVGv8MBP4iKrGswiGfz5ks/E88iVeYhO1LKznWsDfMbL
         LVug==
X-Gm-Message-State: APjAAAUmUnLhkHdZVVqVGlctCEQkKCl4CArFeUsFGOLkxgrNa6wJoznv
        zf+ZT46CdaLRI88iMljpqXOXRHpl
X-Google-Smtp-Source: APXvYqw4wSYPM8Ly6Yu/5nXh+oMTanW5ddkNRa2Q77KjXz4L/NjsO5w1O+PFLrfXiD5PIgcDjMO4fw==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr20488525wma.130.1571147773036;
        Tue, 15 Oct 2019 06:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s12sm23775974wra.82.2019.10.15.06.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:12 -0700 (PDT)
Message-Id: <3d8f2f20077767da7f4198daaa44c6721fd01db2.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:55:54 +0000
Subject: [PATCH v4 07/17] trace2: add region in clear_ce_flags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
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

