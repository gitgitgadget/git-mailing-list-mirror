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
	by dcvr.yhbt.net (Postfix) with ESMTP id C98C61F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 12:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfKOMgd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 07:36:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55663 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfKOMgb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 07:36:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so9507946wmb.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=egjDdnZjtOAgHkbz5V54VeouNoBxPkgOvpgATvnzIVs=;
        b=tF+Gb6H0KBC89UZBH9RkqpJ3RYrY8DvS914Ha7cvFoBqXV3jvta1NikOELcq3/hemq
         ByWs2C7K2+xqTQQwprs8DfW6bVDLmeFnjfW1zPQ9yUxYvBNIZboswQgL3Oz+k9f0ZJGe
         o8BZqf3MhHzErYMKOd2ACI9J9PlLctbIysgtoLBTz7mBzjUQvVADtZUlHB8rGEtWhFIZ
         juj/e+O+e52NrtK1JGLfiCprtHfTTOLhHVwS2Cu8eDnQeu6Zz5MK3/BA2/YMs8Se/lZ/
         UjljCeK0LQJYHCRiTMJlAn1SGiiNB8SmcWkYi67xek9pJ3DIZora0MSNoizw1Al8TyyK
         6YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=egjDdnZjtOAgHkbz5V54VeouNoBxPkgOvpgATvnzIVs=;
        b=TSy3mKuGplTeAaRbNKhYnVtXivRDEkywzoqW65dGTb1cuAW9c+GGZNFDC67HNNmE64
         TGsxR/CkTJJWkL7J0Rn2aJvXK2uSThRICmxhkPINfjdPMFrO+CnzjQ1bnaieHgl8vrSu
         h07huhEYOpn7l2t3Q2gLawHuIukzTTFdgO+SgaJJNRgocsG2zj8tve2cs5zCb0xeynSk
         C1fjk7nMnKJ9nKTrSiXHjKJHqZdCqeZ3yWagC5M8EUbYH12YVofazApKAmFHU9aGiDti
         /RHrUyyT3v5L53PKlWXAtXzGPmINxEUqxUWxY5cJaJYsXt3AGNdZQWuj8/WtRnyTKCqg
         rMAQ==
X-Gm-Message-State: APjAAAVXIHT8kk5IaBjzv+JCgxmHnty4wXSvKKUvXgqCNeHgq+N1xHJB
        LgGUFgSwGiVDk5a88xCCrVOIrIlC
X-Google-Smtp-Source: APXvYqw1FTtMmpHZw3QNrKGZICT3JrjybWr1bi7c8NFMYDBwh8jMUIC2Wvs2RX9SvwxciljUGw9/WA==
X-Received: by 2002:a1c:9d89:: with SMTP id g131mr11552483wme.81.1573821389408;
        Fri, 15 Nov 2019 04:36:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14sm10909868wrv.17.2019.11.15.04.36.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:36:28 -0800 (PST)
Message-Id: <dbcb340ededd67322506fd0459dad4200d7bd4ef.1573821382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com>
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 12:36:22 +0000
Subject: [PATCH 8/8] built-in add -i: offer the `quit` command
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

We do not really want to `exit()` here, of course, as this is safely
libified code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f33075b202..40bec9acbe 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1067,6 +1067,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		{ "add untracked", run_add_untracked },
 		{ "patch", run_patch },
 		{ "diff", run_diff },
+		{ "quit", NULL },
 		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
@@ -1118,17 +1119,22 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	res = run_status(&s, ps, &files, &opts);
 
 	for (;;) {
+		struct command_item *util;
+
 		i = list_and_choose(&s, &commands, &main_loop_opts);
-		if (i == LIST_AND_CHOOSE_QUIT) {
+		if (i < 0 || i >= commands.items.nr)
+			util = NULL;
+		else
+			util = commands.items.items[i].util;
+
+		if (i == LIST_AND_CHOOSE_QUIT || (util && !util->command)) {
 			printf(_("Bye.\n"));
 			res = 0;
 			break;
 		}
-		if (i != LIST_AND_CHOOSE_ERROR) {
-			struct command_item *util =
-				commands.items.items[i].util;
+
+		if (util)
 			res = util->command(&s, ps, &files, &opts);
-		}
 	}
 
 	prefix_item_list_clear(&files);
-- 
gitgitgadget
