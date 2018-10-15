Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15D31F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeJOR4v (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42921 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id c8-v6so9058473plo.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KzlLIGxx9+aqELb0V5crwgVyly++qKQCjMv9vKGoJAE=;
        b=OIozRRVGW8uw7Sb9vq5eBhW28mLigrmqi0HHYRMfwfSYKh53/S2W5w8KyK8WXAVjCB
         Wbddbul4bcvmu+HDfspbxq6H+KgAbXjjqt2tUkeMzeVQ2esB7wUG5rvRfBJ2kD5MVOkH
         a0FQlf6l0HXsaVno09gN5P9m2Tm0anlqu7995ynKSSp//FC4vnOuk6D3jhZ9z3hiNll3
         OyDFlJvFiA0Zje65rtg6lyX8z0oHuB58Apx9Kmj1gUS7TxKjvZT0eat3NINAQQEEl61X
         9c2k4oMYwaDyM5VuQBdIqT6J6T/lmiPBfiSbJ63Kz4tXmUN4UEguIqcwNEfwU7wxKe3U
         1u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KzlLIGxx9+aqELb0V5crwgVyly++qKQCjMv9vKGoJAE=;
        b=HaoEzKJ7hVrdc8Wpet0lSxDQ7VgUBxAkIbevixT3hSOj2FuCPCrtDbUFqGBRwPhNJA
         /h1g7H8YUKn4A60VEQdNqXWqiGbpgS596MGVD/4ExBmqyQfutZBJ4Z8kfMPUpTimKG+I
         bW+0mXtmXbAcYhxgP85DlqD+kGId+04mfj+xzVAjwyVzFg2ddQDHPiJuctXw/vw1Fj3I
         NkLrGV+qGKb3DEg+uEyLPpx42WQcNlRgbZ6dwR4vtli3WuUQ60ysaNx6J9MKJapS6w45
         6BxKRufS2DPL0TFiNuNYwNzXCmAZfvt5CFX+HJXahN0eTcdDsDImhSZ3miyeSPSI/wYB
         Mblg==
X-Gm-Message-State: ABuFfoiEsRvoGQgn47KeUlYndBJvWGCoizhG3OjI9XTFQULxy10YAGMP
        UXlH+sT/JqwX+sq2O4uDJ1c1wdnA
X-Google-Smtp-Source: ACcGV62O/XE4b35IkwDmNwtgUHfKe+uwhLpgRUb1gqWMi2Jz6sP00IYJP+T/+Arka3gdW5FhZQDWcQ==
X-Received: by 2002:a17:902:5993:: with SMTP id p19-v6mr16427307pli.260.1539598336460;
        Mon, 15 Oct 2018 03:12:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id c2-v6sm12160099pfn.95.2018.10.15.03.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:15 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:15 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:54 GMT
Message-Id: <d112b3fe86e2d5168161cd3edf9616ff7bec3319.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 12/13] README: add a build badge (status of the Azure
 Pipelines build)
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

Just like so many other OSS projects, we now also have a build badge.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 README.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.md b/README.md
index f920a42fad..bf4780c22d 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,5 @@
+[![Build Status](https:/dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
+
 Git - fast, scalable, distributed revision control system
 =========================================================
 
-- 
gitgitgadget

