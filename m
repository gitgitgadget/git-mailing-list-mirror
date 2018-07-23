Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A461F597
	for <e@80x24.org>; Mon, 23 Jul 2018 13:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbeGWOyP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 10:54:15 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:41791 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeGWOyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 10:54:14 -0400
Received: by mail-pl0-f53.google.com with SMTP id w8-v6so256911ply.8
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/gK+7vB63iu3xbqyNOcBljPoPjsz8CnoZH1JDiH8aVY=;
        b=ZZ+5P5Vx9pcDM6tIUoa9aOajYFrgc4y3MlwHfaqIGABkWdNLddvEiklAkqXoorBHvE
         kIkvvNe8Edx8gK8jK8Swp3xvZ3gvQNA9fE044aLTd1RZ8fY9KL1dRkADjVP4K5LHllhG
         wkPPMsVrjV29kwi64GhVNUDFE/uYIH/j3yaaZV9YfTlMGwXbvPOd1q6n+bCMsaeHiyHK
         523PGFOI428qPlS5J95cgiL1JZO+UjJeClDvWkrJtl1k5QZACevUPnChGfXXDv41rHN0
         nGP2NAw1RsKfafcQzq3hZa7EMeTvxG1wQUknuKDnUDytBcCAkBEh0yeFeHzbEPb7GBgs
         GseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/gK+7vB63iu3xbqyNOcBljPoPjsz8CnoZH1JDiH8aVY=;
        b=IoBDb1VR1CGUhEnKdg3ENA7rP6vrLbelZVHelg15qv14WTTVPJo7nQ/URQ4cB+nDJ1
         mVxBwtnU+6y0IHujLXAJcy6HvmP1qfb/N452TIiNOVZ1GhLzMqw0TuKdU8wnSot5Qi7f
         MvZAqgn3Gmr+gECYZNEgDnXsl+Wfr2QspI2uT/4uE4MxdZRAFbHsNHaYr7DBkKq1zosw
         qgCnstUw7cc1ecJHKM7fTLUMW/hGMudHbcq2tVPv8QaxbKfZ3QQPb0/snCJ04Z6hixyD
         Ge6Dr7TdtwVZ6JG23QACLjX6i6Ybg6JoiBMdxXAv+MskS/k0XZMCrQUe7LAfnp/LVqeB
         OBPw==
X-Gm-Message-State: AOUpUlHmioL0RAWri7POkq0h62vc4Vn7LTpvV3DLsas0+zWAiuITm29V
        6wNsh8DqfH7NALnMeMrkvtbC9MMf
X-Google-Smtp-Source: AAOMgpfuUdhtyUgQTvQ8a/pjd9wq34OhgJ4ch4B979CJTVKXXXeU0hEuEJ5h2boGWMbdzbAmdsCTOg==
X-Received: by 2002:a17:902:654b:: with SMTP id d11-v6mr12935704pln.8.1532353972734;
        Mon, 23 Jul 2018 06:52:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id r81-v6sm19687508pfa.18.2018.07.23.06.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:52:52 -0700 (PDT)
Date:   Mon, 23 Jul 2018 06:52:52 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Jul 2018 13:52:39 GMT
Message-Id: <de49c4bf264e31ab6d76b23f3590ef6466cb8936.1532353966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2.git.gitgitgadget@gmail.com>
References: <pull.2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/9] cache.h: extract enum declaration from inside a struct
 declaration
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

While it is technically possible, it is confusing. Not only the user,
but also VS Code's intellisense.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 89a107a7f..2380136f6 100644
--- a/cache.h
+++ b/cache.h
@@ -1425,18 +1425,20 @@ extern void *read_object_with_reference(const struct object_id *oid,
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
+enum date_mode_type {
+	DATE_NORMAL = 0,
+	DATE_RELATIVE,
+	DATE_SHORT,
+	DATE_ISO8601,
+	DATE_ISO8601_STRICT,
+	DATE_RFC2822,
+	DATE_STRFTIME,
+	DATE_RAW,
+	DATE_UNIX
+};
+
 struct date_mode {
-	enum date_mode_type {
-		DATE_NORMAL = 0,
-		DATE_RELATIVE,
-		DATE_SHORT,
-		DATE_ISO8601,
-		DATE_ISO8601_STRICT,
-		DATE_RFC2822,
-		DATE_STRFTIME,
-		DATE_RAW,
-		DATE_UNIX
-	} type;
+	enum date_mode_type type;
 	const char *strftime_fmt;
 	int local;
 };
-- 
gitgitgadget

