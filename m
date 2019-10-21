Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50661F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 20:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbfJUUAD (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 16:00:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41013 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfJUUAC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 16:00:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so15376740wrm.8
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=I6SlOdXpn7EjazwJaaM9VEbPIripxYipJI5nDijyPQc=;
        b=ZWs9SXkWTXy/CbNL+KfjtJ1A8Nfyt+lEvngEz+L0mH5LisdBCFnYt9AxLa3tAxBSD0
         D0VlD46RER/WinD7sCAs5kflFa6b46dq2gnsnZr3SC9k76HvA2Fu7Hzx20+q17YSisK8
         77SNbK/cxBr8ddMx8wD1VXS/8/FDkEURFDfDNf6LNeLQbqGO8hLSuIyg5Ka2lllz2RKz
         qmlhtPIMOi5meFUQ5Tcp8eUHpEVnWUV90LveSZiy0pcjFG9sneKt2Mb4vLR6LbOBpM25
         5tRQzU0YyX90fRchQslqgE3Tl3tB0ySZR8y48arnf1F0jYF2FyAQrvDAbDyaPapXZ0nD
         139g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=I6SlOdXpn7EjazwJaaM9VEbPIripxYipJI5nDijyPQc=;
        b=CIlVugLr5moex+MofQmU5DYTUVxdRypvAmwPmKUT7NxJrntW75IBtuDhWqz1LW5tM2
         S+r6WYI8MR5cTZWQByl23GhQIBa+LG+EJOCZc9kKo1fZ4vreK+OcBHp7Bb4UjqBmZcN8
         kCeIXzRE8engY+tIsuj2WAyKo1ZT9D5SNMY3t9gsxjNBsK5Zu08F+WMa96auEYdfWW2X
         DKQ+mShHP2LPNwd1qwBRuDBYlY4XfqAOXI5dBsTAHlR2zIvCgYNFQgtfFHzY4iWgclQh
         4t5L+0L5H1wTmJ54nriPKrewTj3zUFD7tNDVIn25NQm0teDW2JdlTMbB2nd/42J400l6
         rhBA==
X-Gm-Message-State: APjAAAX4Eyw0EGTrRaJjty4sejsRS1G1n1RbPJJkvzRT6Bh8Kz7AXNq9
        WAv/O7Es21SpexzW8oXSxfpTqdAM
X-Google-Smtp-Source: APXvYqyteRWTxgYf/WAkovSPct4cPoV6ekqXLx+PdXPm9GPwO74wAYFBSjYUzlZ+QYKYVHfEfQXmSA==
X-Received: by 2002:adf:f306:: with SMTP id i6mr18063wro.209.1571688000663;
        Mon, 21 Oct 2019 13:00:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm2785019wmj.42.2019.10.21.13.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 13:00:00 -0700 (PDT)
Message-Id: <6fba3b1c76d6e28c1ef4fd6c933bd73531e6cb7e.1571687999.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
References: <pull.410.git.1571603970.gitgitgadget@gmail.com>
        <pull.410.v2.git.1571687999.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 19:59:57 +0000
Subject: [PATCH v2 1/2] ci(visual-studio): use strict compile flags, and
 optimization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To make full use of the work that went into the Visual Studio build &
test jobs in our CI/PR builds, let's turn on strict compiler flags. This
will give us the benefit of Visual C's compiler warnings (which, at
times, seem to catch things that GCC does not catch, and vice versa).

While at it, also turn on optimization; It does not make sense to
produce binaries with debug information, and we can use any ounce of
speed that we get (because the test suite is particularly slow on
Windows, thanks to the need to run inside a Unix shell, which
requires us to use the POSIX emulation layer provided by MSYS2).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 9f099b9529..457c6fee31 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -157,7 +157,7 @@ jobs:
     displayName: 'Download git-sdk-64-minimal'
   - powershell: |
       & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        make vcxproj
+        make NDEBUG=1 DEVELOPER=1 vcxproj
       "@
       if (!$?) { exit(1) }
     displayName: Generate Visual Studio Solution
-- 
gitgitgadget

