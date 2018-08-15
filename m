Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C76B71F404
	for <e@80x24.org>; Wed, 15 Aug 2018 14:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeHOR0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 13:26:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37870 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHOR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 13:26:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so589336pfo.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7SNNyvJMB0O7u+63WqzXwe7dkuB2Wi8bsWX99SU7L5U=;
        b=EtwGS0IlqOG6d6QmrBx8Nd/qYjAZ8D8qunr4bv2R6DKSD1O/BzMrvN7fJLt7QcKfQu
         2w/mFo2Rv/aFrlPTeHbSgvw7kS0n1sv1Ayi1PbtFgZkbb8XwAvfcAbtzcAtw/tJ1sr6f
         0WS15MDB/JfoJkpIarmKueHGmnz7mgqMLhLw2mwzqlxZtIuF9Wr2BNsVO0gPUM+PZJl8
         zaKA8gsC63a6F0yY+xPvjsTuB6FsqVYSwDoorjp7/Sffb8JbKFZyeKO+quHwLuumLrNG
         31aK7HmYgwElIRHkV7qoSee2lcx3eNLhmsjph2szhwyZ12TQp8as4vtSgpVXf6Gjml6p
         xVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7SNNyvJMB0O7u+63WqzXwe7dkuB2Wi8bsWX99SU7L5U=;
        b=doFQnSDAvmJprUrFV4w7GR7eXxg/G81IkaieB+v0KdbieVWqURuHgQLX7dUe/cQ0eN
         o+qJskOEe6EjpPyC/2QqhWPLM8iNIFCJ1eW5sMP5lxeB+iraKyQDz+7bkjdW0IIGjzIf
         4z0Znx+vbWNFZfLjB1oaOt9wa93mz4NoFWoXp1H0U+J6BYxBEQUPmDxr7n3SGA5DrJwK
         6s7coKbT47PU2lcURAckQNGdyITeZtCVk1Xuihy22RBT2P87mv/nILolQj2y1Zx5Ni+t
         HmGQE8WM0Le7wbnr1a+0mOnmLUkWTecOG0N9zbhg53ZZdheaCXlpSDazQ9uxWNuOoxTN
         vBKw==
X-Gm-Message-State: AOUpUlFivLtL/b9MRLXRgOZn77tOKqAU/TwOqFYlyVoFh7g3VvAK65NS
        ZBzVUl0Hsn3g7bNOje/xD7D+7ttf
X-Google-Smtp-Source: AA+uWPynEF0LKFiHkh94sRnb4SBv3dzjndIGlYfLekHjnS5dibFAjvF8jwpngvNyqNjzlYS6VQX/hw==
X-Received: by 2002:aa7:84c2:: with SMTP id x2-v6mr20626479pfn.220.1534343625298;
        Wed, 15 Aug 2018 07:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l79-v6sm50988601pfb.111.2018.08.15.07.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:33:44 -0700 (PDT)
Date:   Wed, 15 Aug 2018 07:33:44 -0700 (PDT)
X-Google-Original-Date: Wed, 15 Aug 2018 14:33:40 GMT
Message-Id: <d0d1d49d6f3e741e9c048041a2f467742bce4bdc.1534343621.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.19.git.gitgitgadget@gmail.com>
References: <pull.19.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] chainlint: fix for core.autocrlf=true
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

The `chainlint` target compares actual output to expected output, where
the actual output is generated from files that are specifically checked
out with LF-only line endings. So the expected output needs to be
checked out with LF-only line endings, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/.gitattributes b/t/.gitattributes
index 3bd959ae5..9d09df5a6 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -1,4 +1,5 @@
 t[0-9][0-9][0-9][0-9]/* -whitespace
+/chainlint/*.expect eol=lf
 /diff-lib/* eol=lf
 /t0110/url-* binary
 /t3900/*.txt eol=lf
-- 
gitgitgadget
