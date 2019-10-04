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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58DCD1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfJDPJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33612 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbfJDPJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so9834554wme.0
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=aChO4mDdhq0lHf4t5DwH5Rk8os9Uzbvsc8gYqGxD04jm5Ag48aguODSEfslx+6OhST
         Os5JPnJ59KAuCLOCePh3AnR7HjLNkSb44GUr+2r7EBn/gvRVH5p0U2KlzZOfPicEYOvD
         6Lo9rFULdT0o7tb8S+kADElkpC3ZXpBtzUuAeIp+nVQl5DvLqPznPTmmCO5f5/ryqihI
         rMAveYPDdXSA4d9Mi8fUz8pNFLpEdVQt8F4oGloVgc988FA3uRzF4bHyZeyRabAfsgfL
         rUf63lkqf6/eFNYiO1ergi6h++pAbDICKSuDj3eYlVmFDq4OKOecFimCIV2u37Bh+X+l
         y0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vvWfyWe/pSI2Q4yl+6HpmxNLfmif9NwMsTGV9UJkH8c=;
        b=Y0vd2Jt1fPZ1V+YLuYOo1l/xGc3OzIzIN7nzE11bGwh3L0akJmVWLZ9EDq+i5pWVMR
         YKVJj4uMLToxCo7AS41NiASA508nyvFiEORr12KVunvohlHdGeN7lhvv2PsE7nNcOb1t
         Sl7QpSoDlbIN+eFfO6zhWuravVOhYG9SeMpreAd+/jaiFaHAZc8OWLBBTMdkUBCq0G8r
         f7bsO4GsDLZ2rX+SXR/pwGpjsQPOwpCqsLBJY3BjBdMUI30rLqr5bXDzLu8LUiSQhI/i
         qe9AE7wpZjp/AvZ6v/facLKBDJuEKfLO+Z0eenMMl6WQENGibyC8CDAl4+ZsxrGeGi4b
         kfJA==
X-Gm-Message-State: APjAAAVCjR4iqJ7W5sOFuO7SUgEiMdlMHJ96czV2ceUFT4gPcdyAtfIr
        Vi37UtT0dGqGqcpdRgLKGA0Gkpzd
X-Google-Smtp-Source: APXvYqw7vaE9ock/zuSTprMUBsjgZfgGU8R3YzJGrOLlm5echdF2aiZXx48dHjF8KXmET1DyIcaOmA==
X-Received: by 2002:a1c:9988:: with SMTP id b130mr11715794wme.164.1570201766024;
        Fri, 04 Oct 2019 08:09:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5sm5366715wrt.75.2019.10.04.08.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:10 GMT
Message-Id: <4d0b38125a13d85963be5e524becf48271893e2b.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 01/13] push: do not pretend to return `int` from
 `die_push_simple()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This function is marked as `NORETURN`, and it indeed does not want to
return anything. So let's not declare it with the return type `int`.
This fixes the following warning when building with MSVC:

	C4646: function declared with 'noreturn' has non-void return type

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 021dd3b1e4..d216270d5f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -143,8 +143,8 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static NORETURN int die_push_simple(struct branch *branch,
-				    struct remote *remote)
+static NORETURN void die_push_simple(struct branch *branch,
+				     struct remote *remote)
 {
 	/*
 	 * There's no point in using shorten_unambiguous_ref here,
-- 
gitgitgadget

