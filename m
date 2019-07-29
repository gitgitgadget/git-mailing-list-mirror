Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B597D1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfG2UIW (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:22 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51571 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbfG2UIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:17 -0400
Received: by mail-wm1-f43.google.com with SMTP id 207so54990971wma.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rJs8zLNJc5W3EABytVF5MZ2gJQf9eTWKZGXO/abrFIY=;
        b=NrD8bLPTFh/+sg/IfPu6XHu8ObUKuq9Diu/xNRke9xQIUrhdXpQ6EvnJvlEKPhRsBI
         yD162FJejegDjbNLe5i6IHpH+I2TmBRXKbJtlQn/H5LDXcaX7YifChlYBHqLVzZEEq2M
         Cabtm4n132aW3wKIWH3cKo/+iMbTJB8JrDlUfOv3c6FJUhZLWrjzSsTmjJkMip5silRt
         boq/s6KOqtIlj0KGlomA8r9SjMQ8HfPCcl9MIRl+MRBdGoSo4V5s83Di8OhOa2S3fYsk
         RY2rbk6Tbm1sb0ylaHX7pqAV5T1brjoKQg/J/UXkblyJij0mjgoXJW/soHLqP1mEV3S4
         h5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rJs8zLNJc5W3EABytVF5MZ2gJQf9eTWKZGXO/abrFIY=;
        b=In2KGwnmm5XVulMxG14PZv6BX7pSG64meEL7dnYKVUMr2tGD1Tb2K+qU0NAUUKP8cI
         GpMj+PO6//AoqAruQ7a/sOujJwFKZm8LmfFqT+pojYpSk2ffJrIf3mmAkuWKUwextVNx
         oOIKkw4uCAv8DjLkUcyu9Hqyu/4IGuz42UHFZuPi+rI78xnb8x54IyND4KlHkVZyczz4
         1UkUKDQdKo+w3UyEAdBTU0HtsRt/oFpFRqlBE7rY8bTExvUzhdAyo0EHoqbBQxv2Ubx/
         Jlca9JeLarg0Vq6i12k6R6W7aJq6uJUCml5OQHdsWuHIReCT1xSdwTsLNhb9I+5oMvRC
         +L3A==
X-Gm-Message-State: APjAAAU9CkYlNBdfoOy/QYjFfNax1BwIdpAft+lbhzAVcSfUhVCWIJQJ
        JzYD8VaDX+RQk1By8FsvvbdnDT0U
X-Google-Smtp-Source: APXvYqzwoqP4WV5gHseChB7yCeXY9iKv8h5OJgu8TAApxWqLsyyUJL80+5WCKVJRJzVfnWBB3kzKFw==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr48021521wmf.47.1564430895662;
        Mon, 29 Jul 2019 13:08:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b15sm78135700wrt.77.2019.07.29.13.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:15 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:15 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:57 GMT
Message-Id: <3f862bf87845899852504158113cdd9143820a09.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 21/23] .gitignore: ignore Visual Studio's
 temporary/generated files
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index e7bb15d301..fcfb708b9e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -233,4 +233,7 @@
 *.manifest
 Debug/
 Release/
+/UpgradeLog*.htm
+/git.VC.VC.opendb
+/git.VC.db
 *.dSYM
-- 
gitgitgadget

