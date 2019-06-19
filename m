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
	by dcvr.yhbt.net (Postfix) with ESMTP id 88BF61F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfFSVGF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36348 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbfFSVGC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so1315401edq.3
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4f07BskVjja2sCXYPOMaiA7HIs4U1rV1+oT5jx14NzA=;
        b=XtgGMGLwS9m8yuMAfZ6yjXzU8Q6ZFkOzNAjZwYstSQQDiwpLKL7ni0VZE++xGJiMhv
         5BAToe2hFShb6oFbDRX8V0w7Jf/zYS4uSoD4qLn3JilwXv3eZYQuYURQfw+Yh1UNG/kB
         xU5BrVO8NxK3u53mHFJWIW/JRAPJJYVQbKC7kaA7BAGXTEUm6OFWyLrQ/76MJ+3/cNXq
         bvVy8cvcPK0jRNCRl9jtQB6RFCBtexBEyy8LPyO6bKiwstGzC4rO/KqbV2Q3NqKvZG7A
         wpQJc7BCL7C4XuScmdkPF14nxlyDvTC3CZdPQ2qKuI00bohurksp5WuwZpGITzBwYBoo
         8WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4f07BskVjja2sCXYPOMaiA7HIs4U1rV1+oT5jx14NzA=;
        b=pFbL4Htsci01F06gOQ+hVvm1HbpNeYxUTxAhqz0N4T4BHmBDfi+ik5qAjvvHHFq9d8
         ImHS0TpRspTfex9sUW8dZWQuvH/AsD7VvnSxXuR1Al1nvyTon8VKRe9SEH5fME05BLsE
         //RBW4AqXpFWZ2CQnjEEBkGg51ZF6frViGIVnUsjjbrx2Mbh6/XeRK4ktz4KHdkj6per
         NTdAFhMSN/2aop5xJXIQJ7fBFWVhj/f9M4iVSvkluyHMG+aAMMw1yHtTCD8cyLS+dKpC
         tKOSVvOYLmhbFIEorNkwTqnaDlu97Q5lgGFuSnxDK819IGTI1Ycj9xA8AANCQaIJ3uil
         8MxA==
X-Gm-Message-State: APjAAAU7/4BGIbc4Y864bypZ4+TDU9yjoMcs8aQauuob9SJ0HCK2AhEK
        mwc6tWpdpgcSq0E4ZcVCZbkESY4W
X-Google-Smtp-Source: APXvYqwxy4mu5iRNa1McTFTjXuftF5C4ZfbWoqy26dOI5EnGbE4FM1ZC989QZYRRNqpN12z2fHo8Mw==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr59351738ejd.234.1560978361051;
        Wed, 19 Jun 2019 14:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5sm5639432edh.3.2019.06.19.14.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:00 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:41 GMT
Message-Id: <5c383985a19f8d7edff4a496021c99849840c8be.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/20] msvc: fix dependencies of compat/msvc.c
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

The file compat/msvc.c includes compat/mingw.c, which means that we have
to recompile compat/msvc.o if compat/mingw.c changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 6ddece0350..473613a20d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -414,6 +414,8 @@ else
 	BASIC_CFLAGS += -Zi -MDd
 endif
 	X = .exe
+
+compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
-- 
gitgitgadget

