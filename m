Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C3F1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeF3JJQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:09:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35738 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbeF3JIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id i125-v6so9056577lji.2
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Haw8whwjgk/gV3yNZjD/4QyMhaN01iu7jfpZUaFm8r4=;
        b=pevLFTDsWGUcBXfsIrEm1+IXyLpDbcFJk+ayLesP7GnYP/kjmFf3Al5RNL001mEwE8
         WEuB6P70cPirYiLFULkNa+D8YGzH5ZXkz4gdTUmfNerqKEmIcnbUoF6fJhRz0i0XwQVh
         W9j711wr+KAu/R0XzN2jlUxBHg89OBulS8m8oD4Z3S8OcrdJterFeqxbl2aaZVmSx70e
         CylNXR8cAOUn26x5M3P6i04F61XnCQQgkmbERDCREcWYAf99P/+/LgJ/7cjeJjfSImX8
         bsNwsOH0i0J+60wvdSw8eFgkn5Ywg2g8yRIbwG3XwY/YxGBxyv60K73eg9rw2qr07mhh
         GzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Haw8whwjgk/gV3yNZjD/4QyMhaN01iu7jfpZUaFm8r4=;
        b=c4dhJHg7FM1SLaQwrp+yIrrjqOm0YIDvgLPUcP6Ku+WHFKR8gJUC3RBy1Saeo40GRi
         fnXAGHBSHnlcNaOci6lzSIIXVxTKSezzU1WWqdFKqDnU/HA/F6buim/9bI3SXAtbrY5/
         ecYoRHVyzfYfm6myb1MuNr2n5zWX8GWv4kU67cCeoEUbI0EzrVqlZN9kVqP9SqM4jkTU
         JnyiYxpCX3/6Gw3YXL9T9DF6urRt9+DSL23vwhIGh8dbKm9ZseXB+eM3RkWaHNVx7Se0
         OtSaZmmaikiyzwadrMp5IRtRnRtfTqWfa3YYYtbuW1CwT5GIYIaAca56Fvh98XjnRA/n
         Z2xA==
X-Gm-Message-State: APt69E3ByCrg6yfWugxnt+/1jKPRoXqClVm9s+KjBQ+hlyCpR/VNk2R5
        fReeMr6RMh2TL87P4+/9eRvCAw==
X-Google-Smtp-Source: AAOMgpddonCzf5Nnr/hK95IFXx3yjcupda4Z0/16/xtcuqDtnIp+XPtTGRKB1TOBdDD6tuo1DSvbcA==
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr2623249lji.10.1530349725496;
        Sat, 30 Jun 2018 02:08:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 18/23] refspec.c: mark more strings for translation
Date:   Sat, 30 Jun 2018 11:08:13 +0200
Message-Id: <20180630090818.28937-19-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refspec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refspec.c b/refspec.c
index c66351743b..f529092fd6 100644
--- a/refspec.c
+++ b/refspec.c
@@ -134,7 +134,7 @@ void refspec_item_init_or_die(struct refspec_item *item, const char *refspec,
 			      int fetch)
 {
 	if (!refspec_item_init(item, refspec, fetch))
-		die("invalid refspec '%s'", refspec);
+		die(_("invalid refspec '%s'"), refspec);
 }
 
 void refspec_item_clear(struct refspec_item *item)
-- 
2.18.0.rc2.476.g39500d3211

