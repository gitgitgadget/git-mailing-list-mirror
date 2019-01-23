Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EDA1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfAWOkl (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:41 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41420 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfAWOk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:26 -0500
Received: by mail-ed1-f54.google.com with SMTP id a20so1862478edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=KkvXPAOaUzCUowYT6x1+JBShs+ZWnq2OUOD5ukrQYhijAtrpCnyI/4VCSGULBZGQki
         LH+KcUt+0+PdB2hwFTSuEIw0HCHASr9stTSwE7qNA+RdPnXDzeVVwdCTa7G0kR6EmEWn
         wc0jSvR7GAErodYotlypTSV0USI633eUOVMwSxJjoubGBEDI4gCpjTJ3SwhwpMxjGjLY
         SiPawTi+S8+Lz7Gx+5XbBQPAO0Xim4ksOOVacmrylHGoVGUKbtI2oPHc7urgO6EPdy9x
         FjiAJ7ZarcYBGigx1VIBGMfA3ukTKGE4AwU587HnjqGdCL6QyXoHaMpDqyqdxrqeR+1L
         kE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=m9uaFQlwkFyzfNIUxVxDN6GcOnMbEHNoz3gSWxV6fPfLBybkof02sdLm8DeHAfSUNK
         zWFdogS+G1+UfGqLYZ77+rbuMZJz67lodwKEwwffTHKacOVkxgvcz/YmkjdOSb9KWgps
         cubiMI9eih3lQPwk300LZ/L5Hh2e1LTPysZyIomBxgD9sv+tOlvjd0skOwhk6rbRIZRc
         uIo3L6FQ2zqOcChOw+Ys/5A6sAdd5s+IOG/WWo/J7AgU7u13w4YXQS09r58rWzgvph+g
         22uN8obJ2TLEr+d5255hWB57FyUYlp4I8YjUJZKfwOhoYXcewMHGvHeXNB/nnhcUzrEW
         YWtQ==
X-Gm-Message-State: AJcUukfgL2ke6NbWCpVD7fUneqEWiSBp91hBtys1RrAYP+tFSRicXzcr
        vPVIS4ryg3JaVAj9kvcRo3a3j/J8
X-Google-Smtp-Source: ALg8bN7aikDSyUtNpiRRrgeKGicuAU/28VFawNP0WbnaaNxYZrnSGJnDkpJT7j7Rd8H28qY7bHkGqw==
X-Received: by 2002:a50:d6c5:: with SMTP id l5mr2972368edj.145.1548254425013;
        Wed, 23 Jan 2019 06:40:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-v6sm5515410eja.6.2019.01.23.06.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:24 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:24 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:04 GMT
Message-Id: <5d593acee5742a82c74f24f8e3f04ba3a8bc6d42.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 13/21] README: add a build badge (status of the Azure
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

