Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 782791F45F
	for <e@80x24.org>; Fri, 10 May 2019 20:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEJUXQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 16:23:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39063 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfEJUXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 16:23:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id e24so6720467edq.6
        for <git@vger.kernel.org>; Fri, 10 May 2019 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4QNvdvHWjuYSMULHK1kCc0ynrC23uWd54jQ9w+ujNfw=;
        b=N5rRi7MM+W+InpEKVwDj8kjKDw4bzh9fWRfXyfT444Wg4NLkPzjk7uV64JdyRHn4Y1
         M0IpzJ5BzSWPNB4QUnbQ1Jh4vI3WwEwSrEh+/Xj74tDq9jolnVOJ26u4nAE6njv3rjPM
         SGM6VC03+e1MDCy2Nn4XP8xM3YVlQjSpZj4iTgvJFJyr1r5/UEGYuRQKKqxeEdHHpDri
         iYu4yw6HqddZTI3EOapgMogvdxd74VtiCpawEQi7HXyyuePYFAZZeM/XW7K7MwKEGwUc
         7ic0EFVNSRnzxkV9RTyxWzw7JYaI9nTxdeaqHCM3J9aEQRALVY6W4YIE8RSphxv3gIoq
         GWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4QNvdvHWjuYSMULHK1kCc0ynrC23uWd54jQ9w+ujNfw=;
        b=MPReTa5g/BunEoZIs/qSmL9A5OPq4ccPES2m27qG7cS+5mAIKookU6RAvskVV4nNv2
         vhmKP01A0dVLX7iq7G1wAwaD4RCu5EmXEo4mJwxdM676beWPjNgFvj7BYF+QrHMy1d0P
         LBnIOs2AInGNc8UDgyj2rDSyfac8Up/+EsSnHmcWct1rbPBM4KYL0SAo8rTLkAid58F3
         xK/+GUvrpMyJk3yt2LnFR0e2uJMF2SF/uhwEmK1zmTc0I7Ejz7Sq3hGLCzd0Cvvvk1Mg
         MEI3fstLEv31ZnFkHKkjR5T25RHhJJCfcE7zZR3KPCqMNQAjGVGvAXJYLPjwwg8SCtOA
         fhaQ==
X-Gm-Message-State: APjAAAXKf2Lq4B0TKM7dxhTyBugq3MgDJlcggGVShuse+W4Fd47qfq+b
        /QoqDNEapY0DtqqJ49H2Z5tfFTTa
X-Google-Smtp-Source: APXvYqzWDeqgY0ADrxtPpZo6l/qpcfcl6utB3EmqXQsVQ+NPeJTEiTP/2yCab62Rt5DkgewKm/ZSxA==
X-Received: by 2002:a50:ba1a:: with SMTP id g26mr13736092edc.90.1557519794608;
        Fri, 10 May 2019 13:23:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25sm66423ede.44.2019.05.10.13.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 13:23:14 -0700 (PDT)
Date:   Fri, 10 May 2019 13:23:14 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 20:23:11 GMT
Message-Id: <ec9eed5c88b062b7bdfdb5f82b3716f1341ce01c.1557519792.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.188.git.gitgitgadget@gmail.com>
References: <pull.188.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] status: fix display of rebase -ir's `label` command
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

The argument of a `label` command does *not* want to be turned into an
abbreviated SHA-1.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 1f564b12d2..5fc7de6027 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1197,7 +1197,9 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 	int i;
 
 	if (starts_with(line->buf, "exec ") ||
-	    starts_with(line->buf, "x "))
+	    starts_with(line->buf, "x ") ||
+	    starts_with(line->buf, "label ") ||
+	    starts_with(line->buf, "l "))
 		return;
 
 	split = strbuf_split_max(line, ' ', 3);
-- 
gitgitgadget
