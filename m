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
	by dcvr.yhbt.net (Postfix) with ESMTP id 116961F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfFRMYN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43660 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbfFRMYI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so21384684edr.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Q55omSQAoNEWR6wUDtxGTM9P344QhaAyp1sKl/hGck=;
        b=Mm3wjKe97VYk41qTfpluoG9V4OE+wl5bBqQ2mYA9Cfrz8RR2ADn8Zi9DG6X6EWddmj
         xZGrI9SOVp3FxIHQqq0qBCEAXhKW/HNAqJYpjCNGgl6j9Ki19mdYGsUBU7xerH66gqYC
         zIzxvA9+LJ1aj7zrMzzvdi2IigQA4kfvit1BwlM52NYMZx7LobCjZ8tV8+4AzqGnBc1O
         /3Uixm+mCAKDPntlYl190qZbYkXZuiBpJIEY4I/ulGeAFTcAIobfECN8fNysKqP5w2vk
         74xjLCRukpyxRfzPXOerONzzZR2rkYFLXeCDBVBf0KME8JFO2HblhcP4mKAtWVLbZY7/
         fdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Q55omSQAoNEWR6wUDtxGTM9P344QhaAyp1sKl/hGck=;
        b=rhA+7NtzIErSY3AwDLzs4DYhps9ZpnuB6IvjHnNJJTmcqT4cGx0WY55q0yA/k5YZGl
         B+Re7c0dj4bjA8cu6y+tU9fuWbl7pxLWCaJLTFtTyBLe9+cYeapaIvGWP087/54hfswu
         ErCMT3BACtDYUxz+3jE3rp3OW2MI1airdChT7JWzmKc2u2jeLnJZTVonErJqMMyLgMvZ
         PalzM2acrgNPOp+xikw82vDCVACGAB6sM9fIBgN4tbW9sRFjvXdEta+/lzyuMcNCjgm2
         mBfwA1NMhpbLf+Ne9Jh8s/wdKWvKHiQcJj+MidOlfaBsb9p85IktQbaN98H36v7bk/kz
         JZZQ==
X-Gm-Message-State: APjAAAV4fjtbfWFZArO791pc25ReKSo6sP8N733tmaaK3iRrPmDWi0jt
        y1vM+H3UaVYw1lEZY3EayXOAmtKn
X-Google-Smtp-Source: APXvYqxnkEZn3AhVhj3XJRSf/sxJrQ40hCBMnA3YfVZNOPhOoF+P6k+SUat2N7cwrTGNnbdLZOMDqg==
X-Received: by 2002:aa7:c313:: with SMTP id l19mr9642612edq.258.1560860647108;
        Tue, 18 Jun 2019 05:24:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm2775368ejc.62.2019.06.18.05.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:06 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:06 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:53 GMT
Message-Id: <831d603e2518894fe66b70089a296b5d11a9870f.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 16/17] msvc: avoid debug assertion windows in Debug Mode
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

For regular debugging, it is pretty helpful when a debug assertion in a
running application triggers a window that offers to start the debugger.

However, when running the test suite, it is not so helpful, in
particular when the debug assertions are then suppressed anyway because
we disable the invalid parameter checking (via invalidcontinue.obj, see
the comment in config.mak.uname about that object for more information).

So let's simply disable that window in Debug Mode (it is already
disabled in Release Mode).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8b56aa5773..cdb99b940e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2438,6 +2438,10 @@ int wmain(int argc, const wchar_t **wargv)
 	trace2_initialize_clock();
 
 #ifdef _MSC_VER
+#ifdef _DEBUG
+	_CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_DEBUG);
+#endif
+
 #ifdef USE_MSVC_CRTDBG
 	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
 #endif
-- 
gitgitgadget

