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
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CD91F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfFSVGP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39156 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730584AbfFSVGM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so1282165edv.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qcyS8YGsoGXGwJUmX0IUCggwXAEadBUw1CFX8LLJFY4=;
        b=qvVs35dTWGXudNEb4m9dEhjrltNTeHdjEmWG7kEO8qGnuX0rdFA0tkES+fvhwFk1JD
         0D+6k0hzGec+75mek38gGNUL1vRvTY71pypmqIfcKdVIJzmjYytOA9tg2aD7jGEnnv90
         TKGCaJtINVa7GdYUh0BLtj1L8N1odkaP0mtMSI3QV/IOvUe1BpwdtORCEIhLbd7o4fkZ
         fQAFqOeuYYEfSZVZ82xfu+vcQGoT/py53JYDKXU8MUi8jOGjTIrT+Hn9aqYET/qrlm23
         Ndvx8aFNwBkqZNzJf4QkFF7AM+yUxi1HYoyyE8BGuki6hvrSry9yUjYAe0By3kDFNraF
         WX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qcyS8YGsoGXGwJUmX0IUCggwXAEadBUw1CFX8LLJFY4=;
        b=pKQus0ggzQ7NPJ3d+dhB1wpRxzCxH0omqxfZaP09dlfN+GOcTQKo8YAeD5Or5mAS7Q
         0PmmkpOYTmATkmSpKj2zsl6fkfzopGweu6pHheka0y+V1DNkbvhsqbV523xYOJZVDDjH
         3cxqhBW8B8K4fumJU8uQIzoSDYVF6QLqUNu9ZUhNKkIoCn/FHgyffhRcUQQzJGECJb8r
         ys7EUtPAWGHdvX/PPK03rzrXlsfEM5hGvgKxTkIUqEMJze2jzlhKnJ0h4vgHdBpGM19i
         Wl+D8zhutBSMATF7yzFEMYsM9jKl7l7vsm7Uja6I3R9rjy8bCBhTuJfNFxMeV7Lb54yd
         lXgA==
X-Gm-Message-State: APjAAAUzVZmRfBC9TKOYryhkHbWU4giNp9RWuch74n82TfoiJ0jQkC/E
        2aeVR2rf56ws0C4N+d3cGXwp8YL5
X-Google-Smtp-Source: APXvYqzGEDPemN/y4JAbPjTz7h3Mcbb9Z4d+XGkO4rBieotUqKsajVw2V9zyxup5NLi5rPlN1F1aTw==
X-Received: by 2002:a17:906:69c4:: with SMTP id g4mr20569661ejs.9.1560978370023;
        Wed, 19 Jun 2019 14:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e19sm3508343eja.91.2019.06.19.14.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:06:09 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:06:09 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:53 GMT
Message-Id: <51a20ff2dfb864fb5fb209386764e62d71bf1069.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 19/20] msvc: avoid debug assertion windows in Debug Mode
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
index d01e88c2f8..433838391f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2437,6 +2437,10 @@ int wmain(int argc, const wchar_t **wargv)
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

