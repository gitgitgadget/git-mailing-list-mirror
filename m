Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D65B1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393230AbfAPNg1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:27 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34798 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393225AbfAPNgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:25 -0500
Received: by mail-ed1-f44.google.com with SMTP id b3so5465888ede.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=UhWs255EXZkjxkH4rgnOJcm9p55An8s5kc4nMHx2s5UFvuuCUbNBN+t9Kcc9poj8ze
         SpX4niUzbM68pOCw36Tl7qLq7llPcQkwfspoCSBDowxaTKsMLPCvgk9ILsNp1xrAn2lH
         JIk+IYDeTeODYZCRNSWRH7h+uOEWdTsXpjwhHGjUl0bVVnHVGmvUDhL6D+Hc8CpnFbOu
         78qoI/HZuYYY4n7h7pjqfWheEDRpGdqfrvzNGA7ZD4j1gITFGpwsWwTeLBpsPheiAF2k
         wlOa0smfWhEAWlA2kSUS9VKY1S/9dSyMxMY01qfSQaUVZb4SZrU+gm57RKLe0IMeLjwK
         1GqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=Bl9yxXKLmV0NI2XQOl9y9GIMtMko+4WDSZe+BOtBUGwobQaskyCNWkHRoLlWNrvgJ3
         1XMRPBPF1rwHuFcZbEKz67ExZ9925wShRRnF1arxz1SZ4jAVmJcJD0KCtH4Oy30ZkC/h
         YMkXXtIvkXmFSLjMAibL6bksj5BhJFaM/IR2OlZtIrUiE73HGYyzMUwyGBndUjk2hp7d
         19NMR2QQ6v4qe1WwOPmDFKAZyL2qXNAuQrwseCcbG1TWoGmBded09xBlviYdpWbYSzUK
         6pN2CiM61sEBtEpL4n7YQiU4f1qFoN/6FPSI+X2RT9dT+gTM9rUnS0LwoYPpNjte5Ome
         bwrA==
X-Gm-Message-State: AJcUukfF6j+DJKblbREHrh4w9xw8yPBUORyaNWgbRgGqBUJDP3SFSLgm
        vWRNRj+ClvzhSh5TnsjmAc0/4y0b
X-Google-Smtp-Source: ALg8bN5xrYhRo5T+8vlHZs8MsmqdmucpDv64UMXFU04/lQUJdiszR7M+k9QspZrJNtNpTNzBR0cHXg==
X-Received: by 2002:a50:a974:: with SMTP id m49mr7740921edc.220.1547645783527;
        Wed, 16 Jan 2019 05:36:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d27-v6sm3028218eja.20.2019.01.16.05.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:23 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:23 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:01 GMT
Message-Id: <df326039d9b76a1cdce7040d53e2faf4e6890c3a.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 13/21] README: add a build badge (status of the Azure
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
index f920a42fad..764c480c66 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,5 @@
+[![Build Status](https://dev.azure.com/git/git/_apis/build/status/test-git.git)](https://dev.azure.com/git/git/_build/latest?definitionId=2)
+
 Git - fast, scalable, distributed revision control system
 =========================================================
 
-- 
gitgitgadget

