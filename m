Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4DC41F597
	for <e@80x24.org>; Sat,  4 Aug 2018 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeHEAUj (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 20:20:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43694 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeHEAUj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 20:20:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so4999577pfi.10
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yyPJxGzepmssn0tT9pBtbmt/0KM1x7TKR1oFnGDNiK8=;
        b=qta3NJctL/L1vTNkve9WYpJkt8RVEXkIP5q/Vu8fpdp7+wIVBvjp/I7LAy2W9b6d8E
         nS4pmfvOoa8JSiwc9Ijitrm9mzYK4MYt7OmLS1r6fJGtijkHGQLMV1hIKEik1HfgW9i9
         dhlknhpS6zBoOMKqJddkPqvOxtaQp9kROjTWl/7hWVcFO+nmEjD8oqmw3tcG1byblVRP
         bAWjIPR/1RshUaHRYhht5m4r4wCVCzh1RfliJXIRbLYDvKMQIWm4z/tFnt1bPwonFuiS
         qGTa0tPej5K+zLN831qyircO/PB7L4Y7cxeq+g9pgKzGGBx9v37ZBVogfB5TFFw69N+4
         fDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yyPJxGzepmssn0tT9pBtbmt/0KM1x7TKR1oFnGDNiK8=;
        b=c8ghHHL6kJvo4WR6oImcqbEToHMGYxW5zSoMrzCA4oQ9qORjZO98HlKogH7zKzm/fV
         xCGZQDFf5KmysbCw//4iCQcfyNDposayVyJo/ppI8yUrGaKWJk7Lr90ZvzVnuOEZ91TV
         U270BipE+EUvQcYpx8s26iKV1QgCBnD9S0m/OBi1a9hIehPRbwzn+vQavjhp8BTz1ZPJ
         nU4IBn8E+q/6kADH2VncnafgLPa3Dvru+k5LSvjm4dhaBRDJ9vaWuWl9HRw1Nbf0ILyU
         /V6uyQ9x+C7x1PJtkAIATODJBFPDV9haFvBd23h/O0VUqFxNpyR85UQCUPzkqvT/MQm/
         YVpw==
X-Gm-Message-State: AOUpUlE/ZGU30boQZevq51DT8DegOF1t7Y97LZ3PRlNxjxWVeHzoRxfY
        LZWJFJMh6geVcpvX4tHk8UPLEZnU
X-Google-Smtp-Source: AAOMgpcOWsRWYk9jOc6/r2AFkgs4GLn1nWrbCGXgM2ebg5Ewwr5MwTMnkFybqBZAF9vkXuvhcXlnbQ==
X-Received: by 2002:a62:249c:: with SMTP id k28-v6mr2856877pfk.195.1533421109023;
        Sat, 04 Aug 2018 15:18:29 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z4-v6sm16622016pfl.11.2018.08.04.15.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:18:28 -0700 (PDT)
Date:   Sat, 04 Aug 2018 15:18:28 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 22:18:20 GMT
Message-Id: <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.15.git.gitgitgadget@gmail.com>
References: <pull.15.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] line-log: convert an assertion to a full BUG() call
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The assertion in question really indicates a bug, when triggered, so we
might just as well use the sanctioned method to report it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index bc7ef69d6..0e09df9db 100644
--- a/line-log.c
+++ b/line-log.c
@@ -72,7 +72,9 @@ void range_set_append(struct range_set *rs, long a, long b)
 		rs->ranges[rs->nr-1].end = b;
 		return;
 	}
-	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);
+	if (rs->nr > 0 && rs->ranges[rs->nr-1].end > a)
+		BUG("append %ld-%ld, after %ld-%ld?!?", a, b,
+		    rs->ranges[rs->nr-1].start, rs->ranges[rs->nr-1].end);
 	range_set_append_unsafe(rs, a, b);
 }
 
-- 
gitgitgadget
