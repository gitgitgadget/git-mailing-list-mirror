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
	by dcvr.yhbt.net (Postfix) with ESMTP id 944221F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFSVF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:05:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35330 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFSVF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:05:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so1322755edr.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cX9jL+CBENQtJWnsnsmDqn7UC5K6XEyfSeVCLeRfihA=;
        b=HE2IXD+9Nk0xtLaoZA02JTnBnPqyiG1689aLl0lLhMAAmoCSXIfNAGbovut+9mwgr3
         mJW2wXSShJicP4a9HBe9Rg92KaQlMFu7K6kqPJE2rlDEnMddmrM6dANdrvPctefy339S
         fCko8IUtE0ibGxtjz21VYBogoWr+prYgR2SGxlq/zvZgH8XJT1XVNI8drf14cKJm47GX
         EcPEp3MiGHZW9BPiBngDbNRRmZ8p/fULFD4ZEXXf5WswRZlsWtCBV0b8JNiWD4u2fsnz
         HojUAUlf2j9IIW5WqUWajrHKW1PJtVFhcLv+Fi5mfFPC3WkwBAVwSq0YowGboNjTy7BS
         5uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cX9jL+CBENQtJWnsnsmDqn7UC5K6XEyfSeVCLeRfihA=;
        b=Q9UxcRoGEAPyaCLpYmuB1cdoNSO9/LE0wmdn6lJfkVCnecXQob318VQDIp49F2vYdy
         2fW/o7bHlHryNhUKoqKO2e/cW7wiCQtDat9SexQp6KnxiVae5doBd/TgrWuTxkfnJScZ
         r9eAJM56KSpA7QQRoq/e9CihwA158WZVQq+oWApkQ67MeljPTLAMC0jtMGhmBp/vHj/3
         5aoyUeF4Baed18ol4rn7IsV3OwLJwN7WuIArQQhdpOckcEjKNRTtCYWpXViQTGCo9mm2
         XXq0uHG3ESs6NzonNutRWFENp8M8MuNRo42v4/VVWkxTphKwCLGWeZ46RU62GoKihD8k
         OWWA==
X-Gm-Message-State: APjAAAVW2hMxiawVS55F83zBafCFKyD9UhsvHSYd0L4stpg3qqliceKr
        9k7kZzsDVl7F3K/w2XVWQaFgJICa
X-Google-Smtp-Source: APXvYqxn9n/Q4GkwPmI/rQJg8vC4WxprcuogArLNl8EZ5h+f0J9BplJFZAKr4LM5ub6pzFO9C9zfVw==
X-Received: by 2002:a50:a5b7:: with SMTP id a52mr90884303edc.237.1560978356720;
        Wed, 19 Jun 2019 14:05:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm3409353eja.37.2019.06.19.14.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:56 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:56 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:35 GMT
Message-Id: <9d4d6ae7db55309ff99c34237b64d7edae2dbbd6.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 01/20] mingw: fix a typo in the msysGit-specific section
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

