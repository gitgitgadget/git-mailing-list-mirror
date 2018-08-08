Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3B6208ED
	for <e@80x24.org>; Wed,  8 Aug 2018 11:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeHHOJY (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 10:09:24 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40932 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHHOJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 10:09:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so980242pgp.7
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 04:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b8dpuJWag9zzrQhymts6+3eIFUod/cHyKdtlXcZXzgw=;
        b=NnwCBPhrk0g4mvSealUXnn3J4klfky+GenTb4MWPUAlUMcYrQyRGv/hZa/G8plkBbH
         kN+syVr0YcHDHQw9ty7mJZU3iw6CSPch6YE3oDcnzp5c31aXOKWWgHEvB+lx/kguJX0P
         nh5YCtfVemzxA05rvDhr4cKC2qZz/sKP+skSbzh2pZznAgroUBWc+VpwA5bup9/e0K1h
         UZbMqFny85uUS8L3bOJWfv0mQY2XYGBCKzPUeIr980c49ILowlThMxerewesYylYphEl
         2+Q0pLjDH/FMzsj4Y6znczgL2jBmPH7D8CJUCbWKQxHS+mdNqym2C8EQUxMIKCNUnQzW
         cqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b8dpuJWag9zzrQhymts6+3eIFUod/cHyKdtlXcZXzgw=;
        b=mU66/HROEogGZaDerLbbT7gR/5Lp8m6cg1ovm/6mtitp/fvA56b1zKHNgUkF9uatSu
         flPf9du2+4eyqli6L9YGB0QKeWB+0wUWA1f6jw4iVbvIUlUs/Na4dx1pNOK7cYcaCtyS
         pYe1069eq6gIA37U60FdMa3VKhCa5YZN57zd2dJklHko/NCb8OQe6xfjCoX+AJtX2BRF
         ibaLaM0JMXJ+3ExJHq3rW1Ye3g5rimJ6VXxAIkaf+L4e5/gi2vzIH0NION7ZplhYGov5
         VW7rVHh49Lm3VRSO1Nxyh3gi/iARg3LIsl4g1MNHZJw4U5xypwPRf5vcoQ2bHFUcTtDy
         c/8Q==
X-Gm-Message-State: AOUpUlF71A5JRi6Yjb/XxACinF5OxlzXxkEQ27ZBdp2nhSvjBDgI6SLI
        mha66OOvPP7TZEvv3Qn7UzBiYXrJ
X-Google-Smtp-Source: AA+uWPxXsoaDePZMkaZkcIbIZU5uYiz5TrErZUB6j/l3gjL+ODk8fgUpf32MpdklTJzoww114d9z/w==
X-Received: by 2002:a63:7d48:: with SMTP id m8-v6mr2330037pgn.0.1533729001210;
        Wed, 08 Aug 2018 04:50:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z5-v6sm5211101pfh.83.2018.08.08.04.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 04:50:00 -0700 (PDT)
Date:   Wed, 08 Aug 2018 04:50:00 -0700 (PDT)
X-Google-Original-Date: Wed, 08 Aug 2018 11:49:55 GMT
Message-Id: <d9fa5b855ba2805d5afced4795c7d6e87f7e41b7.1533728995.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.16.git.gitgitgadget@gmail.com>
References: <pull.16.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] remote-curl: remove spurious period
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We should not interrupt. sentences in the middle.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 99b0bedc6..fb28309e8 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -714,7 +714,7 @@ retry:
 
 	} else if (use_gzip && 1024 < rpc->len) {
 		/* The client backend isn't giving us compressed data so
-		 * we can try to deflate it ourselves, this may save on.
+		 * we can try to deflate it ourselves, this may save on
 		 * the transfer time.
 		 */
 		git_zstream stream;
-- 
gitgitgadget
