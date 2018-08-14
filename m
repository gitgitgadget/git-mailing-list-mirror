Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8BCB1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeHNNtD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:49:03 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34244 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNtD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:49:03 -0400
Received: by mail-pf1-f171.google.com with SMTP id k19-v6so9104909pfi.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y4O3xlGdk96I5e7200Gf0G5dYZLsYJdJE8X1rI6pPE0=;
        b=Xmf6pef41gZAhJoU7H91Rk57It3zfngq3gxcoXYsrO73daFoOvsrRmW/ZLTz4YPMAo
         yPDV9aoTiKIvm63CU6xGMlNMALMdZAyVndPqBiNrGC2NiHj8E2ZsxAACP/2jgeESxQmc
         4EbcIJAh/5kfc6jS2nqtQCPfe/xmG7WhcL/K85/4piGp1KJASMuUL9Ip97nWBsNgOXJO
         MR4FJFkGEgQpo6WH1p+Y3gvejBkaFBx7/8YMk1UsW1V75hNvbwKTju2meat7CNIriUTM
         NY38omuZUf1NNxbMhn5zFi4Xq1nmUNxHQ66LfgYd4ts/uywNL1USqZAj0sMNoay+TdAV
         CJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y4O3xlGdk96I5e7200Gf0G5dYZLsYJdJE8X1rI6pPE0=;
        b=uF0wXJOnt8RYeVMqtEqC+ItxKCr1YQIqEhGT7lyjdYF6gnuODOnpE3U527JOIk/XqE
         rzYGn1ZomUJG3g4UZ2KwUgWiitUmPiAF96Md/QQYdPqsOhZ4Ii/fGipoxmFgtP+NonR1
         h43o5W5Cz2DFQft+FwXjDp3SvVm2RsDtByuTKz6ykexual5VOpIE3XAj9eeB+sKNtY17
         GQqEzErxxZ0oPLuIF1EEL1voiwPa0rhV4NOh36i8CxHlSNqzozD+0e3X2jKHCWB3gYs6
         quMqvNxZ9cj7Obbdq46b8kUPr+XruL1jtRWSu8UUv16gPXUZINYhNae1R84myOsfjz5W
         hD/A==
X-Gm-Message-State: AOUpUlFJ2TTrk23aCPjOIyvjg8TnAVpnj3kHIoaX6XZnENe0Y/VkWbfO
        /Aot3h0oxPyOGEMQTG4Ye6OImK05
X-Google-Smtp-Source: AA+uWPx6Uy949ImiAx8es5qkYGHDBPyCRWvphZF7FRDU1e2u7KtRzrl+abRCh/TrLAOb8/Enu+xkcA==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr19966596pgh.369.1534244542723;
        Tue, 14 Aug 2018 04:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id w72-v6sm40673051pfa.26.2018.08.14.04.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 04:02:21 -0700 (PDT)
Date:   Tue, 14 Aug 2018 04:02:21 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Aug 2018 11:02:17 GMT
Message-Id: <becaf4374a1f8e56a4a26203d74ba64560a465da.1534244538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.18.git.gitgitgadget@gmail.com>
References: <pull.18.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mark_colliding_entries(): fix incorrect #if...#endif
 guard
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

The way the guard was put, the code was declaring an unused variable on
Windows. No need to do that, so let's fix it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 entry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index c70340df8..2bce13352 100644
--- a/entry.c
+++ b/entry.c
@@ -402,11 +402,9 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 static void mark_colliding_entries(const struct checkout *state,
 				   struct cache_entry *ce, struct stat *st)
 {
+#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
 	int i;
 
-	ce->ce_flags |= CE_MATCHED;
-
-#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
 	for (i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
@@ -422,6 +420,8 @@ static void mark_colliding_entries(const struct checkout *state,
 		}
 	}
 #endif
+
+	ce->ce_flags |= CE_MATCHED;
 }
 
 /*
-- 
gitgitgadget
