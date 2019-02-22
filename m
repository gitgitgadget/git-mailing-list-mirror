Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A384820248
	for <e@80x24.org>; Fri, 22 Feb 2019 22:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBVWZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 17:25:10 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:38792 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBVWZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:09 -0500
Received: by mail-ed1-f53.google.com with SMTP id h58so3100380edb.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 14:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=NTWf5ZYUGsdWZkBXHr7//TgteW7qaR5am2DNzTh3HGXbm8357pKRINF/YYGFzzig0w
         gdeb1C1+/grjP2D1+tJZl0hxglqomLo4xenM5SZ3hOFKcvIRg2siUYy7Hhaj/r032nbY
         QFh/c1BuF4tyfPImuzOgEAMfSghkq70biC79+hRv4M00ql8T+IAES7TKg2U5svaLxUTe
         GXpgv6GSYQ34Y4qlGoaNyi6NrC5di3/2J5XrlEejMb231xlVHSBQ/Mx1Xai3uZUYUF3L
         GfP8GILgTKNgtyqs4nJgQHpQumkFgl8WzzaqjGzK12cpcT4NNBMgnX/W/DRhPPLAyU5Q
         tL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=Av60ocAH5CW4N/SRtFLp67A3ZVat6gAY8DXHLrsZYFpxLDf98Jc9Xo0o7uFrHznzxq
         Lz6Fwl3tcfS+JX96BEnBGF7GgMNN2FBR6BygDgGSxqqTTEoD7SyAQQT0SDBXwj712rMD
         Kc8tCUJ+feNs8sYsofm7Y/sKmVeBeBJcC+Rei6eve5UrvAeCi2/W9rLVNEEF+nohLWvJ
         770TYjJ4Yb62NVaenVJOiqQUuIUuVdAw7RsgNQftl64rUWNGQvzw4ScH8/N9eLKC2eoP
         PUceWHCIsSrR/gESj21YZTH01WESgwr21QlaHttGRsC6tZ5ut/lfx8OlpMeh9oCdclSP
         IY1Q==
X-Gm-Message-State: AHQUAubprCgrS8MX+PDeCxo2qCXQ7ysMkmvou1G7zlVDuZF5PugwuPGm
        n/06CmmbKh7YY7In+rd6huRrml5h
X-Google-Smtp-Source: AHgI3IZ9OMrEiV7e7SOS+8+/DBmkshNT9FE2+omlj6FWm6SOTtyKUfOC6qK3URXVxdCDGQidc+xtJA==
X-Received: by 2002:a50:91ac:: with SMTP id g41mr5000747eda.249.1550874305480;
        Fri, 22 Feb 2019 14:25:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n19sm418349eja.38.2019.02.22.14.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:25:05 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:25:05 -0800 (PST)
X-Google-Original-Date: Fri, 22 Feb 2019 22:24:49 GMT
Message-Id: <ec7d7cd4c773eeb29dc8c371c5d9eb223c70e509.1550874298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v7.git.gitgitgadget@gmail.com>
References: <pull.108.v6.git.gitgitgadget@gmail.com>
        <pull.108.v7.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v7 06/15] trace2:data: add trace2 sub-process classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 classification for long-running processes
started in sub-process.c

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sub-process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sub-process.c b/sub-process.c
index 8d2a1707cf..3f4af93555 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -88,6 +88,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->out = -1;
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = subprocess_exit_handler;
+	process->trace2_child_class = "subprocess";
 
 	err = start_command(process);
 	if (err) {
-- 
gitgitgadget

