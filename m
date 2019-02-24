Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CABF720248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfBXKLT (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:19 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39359 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbfBXKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:18 -0500
Received: by mail-ed1-f65.google.com with SMTP id p27so5215857edc.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UM8fr0OXySJJgyQkT/nGy1LNwfc8wqEF0ENr2nDpQAc=;
        b=jmQGhAywt+rsjJ/LwioIOeoAYj5fN7YHuKTswo2o5uiIeldXB8kAmBRggW/CraXEQT
         EIfuC7qOqgf8o42LCI4AKtHti8iVB0O6IXXvjANcwRLOum9EczZBSjAKrvmUXe+W3V75
         /leRpjPa7sWZRev+lSkhh4vMsu5lwUU6z/9izfiaTgQxnJkPRLOwd+X1hEv0VC+SBpDN
         RniM0xPrcIB2o1cFwVjfwwcd2cMsL7tImx+xfDANmP0e+nHlzfetQ+lHYnGgYlnW46rE
         8L/J4mBZqSP1qNtEZVOnugCDFc+uEJCOSRXNtYEGL3XRKVrNLrHdIu0YI2HFPEESJYGs
         UUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UM8fr0OXySJJgyQkT/nGy1LNwfc8wqEF0ENr2nDpQAc=;
        b=GyOY+KE2JLKjDmww/o5p6P3Rkg0miR78LMF1OiqR8o60jq5W1Vy6g2lTnuowqfFWmX
         QqIfetjOYp4wAkyzlBELs6vhblySt4ZOjh3Vq3xbsCtfReiWrdG+E9iL05GhOdYjY3Pg
         At2yadUOw5Mqsey93VnNrUAsWrHNBHiaK+Waz3lCa+oo9QcJW+2tflmQ/8X4ovzBKZ+r
         E2VJjPtCNFfEw6h4agKy23Qm3RNrc5aIbfhqFLbKNAKiaDfvkZ/Slz0g2PJMN4ky/sWH
         Wtkk78LOsgPJ2i5PbDBK1O9hoQcQyEgBum/Ant4BuuFnhpus7dv5PmBVWKuMwv/tUz6t
         YMjw==
X-Gm-Message-State: AHQUAub1i1HmYUEKGjdg5gboIRlIcMZ0/ueyhMaqR3ZC/z6Ope5P9naz
        buCOJPFz64ymhTSnfBa1SoJQvRe3
X-Google-Smtp-Source: AHgI3IZoA0eFlqaOQUHrN1LnadAFg0Yy5VC36JR4cdyL2D8gT48cPx2AelDEPUTumyvA2qQDHk1xCg==
X-Received: by 2002:a17:906:23f1:: with SMTP id j17mr9122425ejg.188.1551003076589;
        Sun, 24 Feb 2019 02:11:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j46sm1843254ede.6.2019.02.24.02.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:15 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:15 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:49 GMT
Message-Id: <64117cde718f0d56ebfa4c30f4d8fe2155f5cf65.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/26] bisect--helper: refer branch.buf before
 strbuf_release(...)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

move `error("...%s...", branch.buf);` before `strbuf_release(&branch);`.

add ' ' before "reset.." in error message.

Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 22e669e3b1..e672ee9f18 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -169,11 +169,12 @@ static int bisect_reset(const char *commit)
 
 		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
 		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
+			error(_("could not check out original"
+				" HEAD '%s'. Try 'git bisect"
+				" reset <commit>'."), branch.buf);
 			strbuf_release(&branch);
 			argv_array_clear(&argv);
-			return error(_("could not check out original"
-				       " HEAD '%s'. Try 'git bisect"
-				       "reset <commit>'."), branch.buf);
+			return -1;
 		}
 		argv_array_clear(&argv);
 	}
-- 
gitgitgadget

