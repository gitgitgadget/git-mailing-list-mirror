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
	by dcvr.yhbt.net (Postfix) with ESMTP id CEBEF1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfFRMYK (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:24:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40697 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfFRMYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:24:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so21427233eds.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=iCYeK2NIOk2RA9Gw2WXbdf0WxZ6Hsy1fQ2uUCwakKxfHwLLIEzBPYVdlP9u328onC/
         4N8TbQUjafcv/GBmOo86L4+8FysydQOs1/FEXtPHO9orTFkG1DWpa1TLAhUquLyEyfg0
         W5e7YA6sM8NMuPqI048f5HVPSCVhBKgBEhLMXM7hTvWrG/zgKkrYeoaFzJNWvlVS0AVb
         UPxGyuOJ1aXOj01AtQ2o79n2VAeOfaLc/zLK6OcJ8lnymC+cENLs0xpFLgMNRYdTgTYa
         ouHRKqFB9TgsmHa3PKWubAbBQypKk9uoE9cFO6FLScPv3Z4EW2LQ4HR+Sl8qMkN1pRDx
         9ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dqJHfuKTPsOY8evakM7j8XeIh7DKWK6mb9bcnQXq+SE=;
        b=QSMSlmT3bc43ISNCucCsLCqGx4FgsCLe4rIR2nn8UIOtStS3hzBJKOwdC5tRF7VwrR
         drO6Lj2yT/NavJ1djM6bs4M6NeZrF+H4m1L7ETjiCyoEk16gLNuZV5Rq0LTYx3fE8jaH
         biZCATCEXUQb3GdIJ4sOK8VbvhfGFvzlJlCbUsN8a++pPU2cgQRYlh8HNranNwhPUUB/
         aPqiaxzernAG7fBXNQQX0Gy9pdUGRSe7LU99RDvftW+fl97p3zGBmqVuHsturMY0hw39
         wNFUQnlPnX31ypZpCc9/+TDGjXORhBWoKIKOjQJ5DKCW3+qJj5aL8zlyTi7UOOpQYCHL
         obZw==
X-Gm-Message-State: APjAAAWnfrNRx5+7OEXOwxXpgsaJkUeBI4lXYYDoW70XZ/tL59AfmNHu
        krVXbBqjUjloWwOxV8xws1rO0eU/
X-Google-Smtp-Source: APXvYqzgssSrvUTrt3l2vGmLt1zj6gDxv1ET4Jp7MoO4orvHVSXP0ok5mXmht6OYzPxOPLI09Namtg==
X-Received: by 2002:a17:906:a98b:: with SMTP id jr11mr35427013ejb.224.1560860641691;
        Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm2736974ejn.8.2019.06.18.05.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:24:01 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:45 GMT
Message-Id: <b23651a357db822aabb0b2e65dc962829a117645.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 08/17] msvc: define O_ACCMODE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

This constant is not defined in MSVC's headers.

In UCRT's fcntl.h, _O_RDONLY, _O_WRONLY and _O_RDWR are defined as 0, 1
and 2, respectively. Yes, that means that UCRT breaks with the tradition
that O_RDWR == O_RDONLY | O_WRONLY.

It is a perfectly legal way to define those constants, though, therefore
we need to take care of defining O_ACCMODE accordingly.

This is particularly important in order to keep our "open() can set
errno to EISDIR" emulation working: it tests that (flags & O_ACCMODE) is
not identical to O_RDONLY before going on to test specifically whether
the file for which open() reported EACCES is, in fact, a directory.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 04b4750b87..d336d80670 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -19,6 +19,8 @@
 #undef ERROR
 
 typedef int sigset_t;
+/* open for reading, writing, or both (not in fcntl.h) */
+#define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
 
 #include "compat/mingw.h"
 
-- 
gitgitgadget

