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
	by dcvr.yhbt.net (Postfix) with ESMTP id 074281F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfFSVF7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:05:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33636 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSVF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:05:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so1335644edq.0
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=nzxUqQjDj3aV3aQLrPh6jNgJ2pAiSmfs0dHUcVqIINKoZUQ3Mpw/DQa8kmnZH9H9O+
         lcZMlJZMdOvsj6gUe99Fq+IM01Mr0G0AOSJ9liOUzPi+4H36HB5le20laJ8Tl4Ognym/
         MSWE9bPXZB12e+JDTiOKf1Zkdz4f5253YxMaYRK7ri3C3cSsqNKZu0THqN4urYeYYWxQ
         FLF70FnRkH3/eG7gC0lLUGRZzyJdcqLBQPmj2hTKwWYk8A+N4hPG7f6CbXvP2RqdFuct
         1GrTQdDWsWJYmeXo+0H2AN+7CsC13xfYWugyKanuEXkto9sOPcDMovPlbb9ZSjoxNRNR
         0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=Ew01DluFuQW3YcwgPX3Xb136dZhpdhOAbfAo6xrISIwriGeHsMDc4fk6Bj0T43paXE
         0i7hZ5rQRwQfR0FPJtQDlRYtsKqz1xvR+H4WLs7g/HOAxdPI7fHMOwjuUJSJJjXmRzMZ
         q4D+r72Ds88n1lN3IebNAv7xHmjcLpg7LpSxTl6eVQQH10Mr/nRLVnR4UndHRoZUOBW9
         25ZgTI3vtJ4eFxDW4ANTb4KoYa60GUg/F+V4jHkkVkd8ck0fS0XVyLxDXDa1+Kf7q6WJ
         Y3uSMfC+F4CoOQOLM8jxq3j4FWhnycXH1xSQtGdsIfbDa3IaKBCASwA+CEOMuTbd8ZzU
         WQyg==
X-Gm-Message-State: APjAAAW48eZnUWefo9eTf52wEEKyTyrwfCWDHhyTap3LMkgnFq+U483W
        GX7PN68pJ5wHZr/2B+Mw73+Ttqxl
X-Google-Smtp-Source: APXvYqzH6jS8iJ5v5PQa3yZOsaWft9PolZlwD4kFdZfJJxT9EK2cZ+Yeas1Q92mMXjerNYz3xJFaqQ==
X-Received: by 2002:a50:f486:: with SMTP id s6mr101046779edm.186.1560978357472;
        Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2sm6325712eda.95.2019.06.19.14.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:57 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:36 GMT
Message-Id: <aa27e7f9cbfda50a02ac6bb555f2ee6487c47625.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/20] Mark .bat files as requiring CR/LF endings
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

Just like the natural line ending for Unix shell scripts consist of a
single Line Feed, the natural line ending for (DOS) Batch scripts
consists of a Carriage Return followed by a Line Feed.

It seems that both Unix shell script interpreters and the interpreter
for Batch scripts (`cmd.exe`) are keen on seeing the "right" line
endings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index 9fa72ad450..b08a1416d8 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,6 +5,7 @@
 *.pl eof=lf diff=perl
 *.pm eol=lf diff=perl
 *.py eol=lf diff=python
+*.bat eol=crlf
 /Documentation/**/*.txt eol=lf
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
-- 
gitgitgadget

