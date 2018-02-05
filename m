Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF861F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeBFAB4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:01:56 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34727 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751089AbeBFABy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:01:54 -0500
Received: by mail-pg0-f66.google.com with SMTP id s73so137880pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/iXQjbqFe5EAQJeFbpCIWF3M+Os+sBfR8jVkhbYDicQ=;
        b=SibFqEZktyEt3DMpa26z19uU1H9ZSD6DcPArqozeF8ZPKJ6uGtyYJ739V1Q1XnAUSj
         K8U7vCw0UV3x+61tBnivjVQOByiql2MGdUyb9g2/XLJevYdM/ooZDimG5I8Zt9sUtM64
         droK4ooCiANLhJPFFyLpBAZ5BkpKW9s8tk39vFldJl1CD0ENRO13dyjIZGmZlirQqmrR
         xlSkVP8GxDtngUksmm4K6mw90CUH3WJRUtwzEA4hTbkkgbxUKSy02v39L1P9x23qUvZ4
         pL2WJpxFLPfUaP2fXRHcSo2XonNm8LNZbefRW5VISpCn5rSpdMOtqke+HDQTgzzEVVdy
         finA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/iXQjbqFe5EAQJeFbpCIWF3M+Os+sBfR8jVkhbYDicQ=;
        b=hEEk0MGmeiZndpr8SlwRTe6SWqlFMXmtwWGwqA67MNumuEvGNMAhI0Uc+kGMWtP22O
         3sszvOqQTo3QaV/w34JkD+2W6dB6aO6mQc8t/0bANEn31GFZXT8EsNcCCM0AKOShXRp0
         zPdUtHpwACvYedymOoklHHXyI6PfsygxB9pMGDMD5xcJ7+Px29GIPFDXq1CREDPlMnp5
         GVZkv2hrc95ZVDz3qPG2WOk95Kkj+PgDGeNAwtS6H2CYTlY7UajBIlSFYfKDYkQ6kOPY
         F0P5R/m4q3e5GSkmbnEFHJG1k0MB2IbcubV0CSp2cBBzX+vMvy7N3hD1fsHBRbLScAqk
         g5Ag==
X-Gm-Message-State: APf1xPBvn+HY1pt+SmEUaQ3DDOmSRsWdZNK2hGmh5UiGJLdkSG58Pb4T
        tnSIgrq4nKMMyZcSzlP3J38s41XaWe8=
X-Google-Smtp-Source: AH8x226DRUuyqZLxcZ1ulYqybar4NMAgsbImuG0iTMRJ56QoNToY/ow+iuVKwYWoQhFGtkLVClburg==
X-Received: by 10.98.228.5 with SMTP id r5mr494249pfh.193.1517875313549;
        Mon, 05 Feb 2018 16:01:53 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z125sm18508989pfz.27.2018.02.05.16.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:01:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 039/194] replace_object.c: rename to use dash in file name
Date:   Mon,  5 Feb 2018 15:55:00 -0800
Message-Id: <20180205235735.216710-19-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is more consistent with the project style. The majority of
Git's source files use dashes in preference to underscores in their file
names.

Noticed while adding a header corresponding to this file.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Makefile                             | 2 +-
 replace_object.c => replace-object.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename replace_object.c => replace-object.c (100%)

diff --git a/Makefile b/Makefile
index 1a9b23b679..84aeabe320 100644
--- a/Makefile
+++ b/Makefile
@@ -873,7 +873,7 @@ LIB_OBJS += refs/packed-backend.o
 LIB_OBJS += refs/ref-cache.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += remote.o
-LIB_OBJS += replace_object.o
+LIB_OBJS += replace-object.o
 LIB_OBJS += repository.o
 LIB_OBJS += rerere.o
 LIB_OBJS += resolve-undo.o
diff --git a/replace_object.c b/replace-object.c
similarity index 100%
rename from replace_object.c
rename to replace-object.c
-- 
2.15.1.433.g936d1b9894.dirty

