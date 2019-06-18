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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4150D1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 12:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfFRMX7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 08:23:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42076 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfFRMX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 08:23:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id z25so21415097edq.9
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 05:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=gmtGfvRVWTSJKMgQ4K0Y9WBjtB5+FpiSrf/UOwJgK6Nbn/E/mxhWFWLOtLbaH8UHOo
         YW5OWk1YaSHY5D8y6GiEakFFzz6gHBc2HDy/wwpLX56wRjJX63tFVt24TT2lxGDqx1A9
         //qf4PPrPWXzY4ZITF6fLe85qL4/9eBGrSGb6mJ0BUH2RKwWrt9zQ4HuZ2ilvyOf+Wgb
         dTvQCa9eNe8Y1x1KjbH+CgqBeIIOKT7tfp4ZhfZVhd3kMTw/oLP8Zu3y9lT8/p8UUsgv
         jqkGlrOQvLFWq27gi+dn9oDtapK+O1kdetZFowabf8Xp6nozspCAQSmTXatKBy6GXSHU
         RMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EqWet8OWHv5Fm6Wm9fDw7t4RsdT/tqbq3V03EERpNek=;
        b=beDBC5aYwWOXmZgdT8djVHntg2bz5IQc2h7aOdZ/r4DGMcLZmZd6b/ReMgAPpozQYy
         Z7rDN9d/AlBUsYxv0SFr64CEIebu2XcOmWFjtCFxZz0aS0PrZxYSUZJCO/bLQQnw+glU
         8pNX5YKUT80vlaPn/QwyauQmd/fBU12eueFtv90WpWLWkliWRkH+IBFiAqggAtRO6Lrr
         zFNLFYCCD/HActmxEeApDgqAgrmjpB8XIbM81d9aqRg5NMOb4zRxIISTRs19chyRVChi
         Rp65nkJtd1nOPiGN26UYrWX+OjwnMy3fapJwmf1N4xWM7BnPNaxoAz2f0AWiadtGM46h
         jv8g==
X-Gm-Message-State: APjAAAVnqnqnGw3c6D7kaQH59+APS6tmT7QiCXFuW/lOgsM3rfYCbFeO
        pmOuEhfqimRQFTsPIE8sxSSEOHy8
X-Google-Smtp-Source: APXvYqyTe1v6mngcBLtJpPlsy3/D7TESpj9OWLdqlIMNhpL0jKqpESBc6T3DmrmcrFXoHa8KHSw8rw==
X-Received: by 2002:a17:906:27d5:: with SMTP id k21mr40193717ejc.101.1560860636863;
        Tue, 18 Jun 2019 05:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay25sm2744850ejb.26.2019.06.18.05.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 05:23:56 -0700 (PDT)
Date:   Tue, 18 Jun 2019 05:23:56 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 12:23:38 GMT
Message-Id: <b30429e0a498a7311701a9d7e40f4eccbc671c33.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/17] Mark .bat files as requiring CR/LF endings
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

