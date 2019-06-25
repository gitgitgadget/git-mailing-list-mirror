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
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F1E1F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfFYOtb (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35252 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731181AbfFYOtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id w20so19944011edd.2
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cX9jL+CBENQtJWnsnsmDqn7UC5K6XEyfSeVCLeRfihA=;
        b=dlNcl6ETKYgrHD89amNBz3ld+1ANHAmhh9krUa746fIkm90pozqGOMcWQZoJSlHHui
         Nd05vjt2Z7rxxF8jUSjppm9W9uHKRHqw8mNTKWHp9O8voz6W/Rf4ghMCHulo+XWtDS49
         rAr0NM+0DsjJ9KWNZBUhHVzd9Ym5S/Ldv2ggf2NRv2IEBALrxx4t9al3UeFT5Txt5eWC
         41512OCkY80srP3RGVJeM+bYficLfNw8z/5banATXL8jVTPPKktmW6aGfMMmFkLnbRe8
         eSs8IFI2TgHyS76xgsCGV8eovObYJeQ9QeDB3VYsp6UwFI50Amn1luyZd0ATbNIzuK/N
         sCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cX9jL+CBENQtJWnsnsmDqn7UC5K6XEyfSeVCLeRfihA=;
        b=qGy/Jc4ET5Z43TpgVhpAzm2XNvuKfPx3mesbT/fhY+7ZsIZ2COt6i8Hd4oVkGcotog
         DScD7hGu03ykxV0OEj+7fFn2oGcD3MW8ELNhfwVQOGTV/9Jq6mpyfX8AFuVVd88Ml3/l
         1ybY6jGH/Mh60Q98JtApFOtCKU5qUFecIu+nepxXk37WLx9tL+O7/AvNVi3evi3JuGhW
         9pJTvTf8X91qnrtp7SUrscvMvzCIZ3y2qJRdzt/EiEQWK/VYkzl/6oAgfWfeJPb6Sl2g
         X0xBA7LIf/vVUDxuMrnskRnQzI7Jt3JtBF+YxbXtEY34r7lIDbqwPD0YEupgm1U5KEaC
         mgpA==
X-Gm-Message-State: APjAAAXrW/jho2yEblrQ9b8hYirHhw0EGq3AfnhEb6MoOw9brIL5/+rl
        BnhsvUgK1lWhrNrMu18rrx9qpq34
X-Google-Smtp-Source: APXvYqzoSy1zXsDKlwiBmVgEScjuhHeOdsEfrALIVhV8Vt0+A31JVBLEpncE4XgV2ZTogeqzs7zqfA==
X-Received: by 2002:a17:906:2557:: with SMTP id j23mr119618365ejb.228.1561474169653;
        Tue, 25 Jun 2019 07:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17sm291419ejb.36.2019.06.25.07.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:28 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:28 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:07 GMT
Message-Id: <9d4d6ae7db55309ff99c34237b64d7edae2dbbd6.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 01/20] mingw: fix a typo in the msysGit-specific section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The msysGit project (i.e. Git for Windows 1.x' SDK) is safely dead for
*years* already. This is probably the reason why nobody caught this typo
until Carlo Arenas spotted a copy-edited version of it nearby.

It is probably about time to rip out the remainders of msysGit/MSys1
support, but that can safely wait a bit longer, and we can at least fix
the typo for now.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index b71688eeb7..9fc053cac0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -571,7 +571,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
-	COMPAT_CLFAGS += -D__USE_MINGW_ACCESS
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
 else
 	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
 		# MSys2
-- 
gitgitgadget

