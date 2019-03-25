Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 111D620248
	for <e@80x24.org>; Mon, 25 Mar 2019 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfCYVlm (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 17:41:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42180 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbfCYVll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 17:41:41 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so3265783edc.9
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BP76jTJdByM/fdbtiRuBrvCC+1FJojFLsQX5d9YrhuI=;
        b=ldGJdSCebG/2aU4dzcUJHH/T62Uho4t4xGjQ0T9eIUauc59V95KMGOscQ/pm8VAYPM
         dNhU1+OHq/lt7CBGSyG/9mu6pMIUOFekYwnU2gGDq+qQJnPLl0JHT7dqSMzhmQIRn+4m
         LFnFta10QXXyj8Vj70R6X7DBGAAGn3h3H2GIx5A6lA2+MwyrApcSddAJjtM94nfv63UJ
         PGx9vVqSQAz0I+dIXvN5DDoOhVk0+djaKHilM679AbsM7CE4cjydW74+wR5XOjgOaF4/
         eYuIJ5CNPvgMakg9AYuH0hLvK1JdOU3syTKD9TvwmyxEJ0d3L6wHjI+/Bzdg2aqMZDpp
         33oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BP76jTJdByM/fdbtiRuBrvCC+1FJojFLsQX5d9YrhuI=;
        b=QVKgN06xhaiyqJQE2den3n9insERkByd29VQnBv41GWjpIN8wMEaQcsq1ACUFkt5Vw
         PH9tW3ABzNDl5XHeBu+7mq7y6kpuGQ1ElVyMwJ4KKcQMa9kg1jCKVg+1YokIMnBFqf+m
         9RE90zVm1mPMPYlOp3z5EzbrNi4idSLcMv+iL4B1KNhHw5z7TtVI9U0KMJ7XRQ1TTai7
         dE0WnqTCbuLQbx696VMV8RaJgAbjxuTwjv7OCSzPiPLt57482XNNmLiNx5+1lMvd0aXy
         z/aaqqS7l6g9vSZFetrmF/ptsAYtMZjrt5r5sqNXzLY+0wu7W/tqeRIderoFE2jqkp2z
         59Gw==
X-Gm-Message-State: APjAAAXXP+5h35lHiLKoIinCrUYuNS9WUMv9ViYlKsi3j7rY8t7srYw6
        Uau23efymenzr6pHDq9dVUu59i+b
X-Google-Smtp-Source: APXvYqxCGtmfIuyZ6iXMVkZ5or+tMYnDGs8E+k0CVN75S3pHz2/q9X5O/lB6rKt+fERcJG/JKje2nw==
X-Received: by 2002:a17:906:5584:: with SMTP id y4mr15462710ejp.36.1553550099661;
        Mon, 25 Mar 2019 14:41:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y12sm3311744eju.43.2019.03.25.14.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 14:41:39 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:41:39 -0700 (PDT)
X-Google-Original-Date: Mon, 25 Mar 2019 21:41:34 GMT
Message-Id: <b26aa40c618842a1a7ba41108104084f61db9b6b.1553550094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.162.v2.git.gitgitgadget@gmail.com>
References: <pull.162.git.gitgitgadget@gmail.com>
        <pull.162.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/5] check-docs: fix for setups where executables have an
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, for example, executables (must) have the extension `.exe`.
Our `check-docs` target was not prepared for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c7b884cd38..2cd650e7b9 100644
--- a/Makefile
+++ b/Makefile
@@ -3074,7 +3074,7 @@ ALL_COMMANDS += git-gui git-citool
 .PHONY: check-docs
 check-docs::
 	$(MAKE) -C Documentation lint-docs
-	@(for v in $(ALL_COMMANDS); \
+	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
 	do \
 		case "$$v" in \
 		git-merge-octopus | git-merge-ours | git-merge-recursive | \
@@ -3104,7 +3104,7 @@ check-docs::
 		    -e 's/\.txt//'; \
 	) | while read how cmd; \
 	do \
-		case " $(ALL_COMMANDS) " in \
+		case " $(patsubst %$X,%,$(ALL_COMMANDS)) " in \
 		*" $$cmd "*)	;; \
 		*) echo "removed but $$how: $$cmd" ;; \
 		esac; \
-- 
gitgitgadget
