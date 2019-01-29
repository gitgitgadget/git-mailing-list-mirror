Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7CC1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfA2OTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:35 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:46870 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfA2OTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:34 -0500
Received: by mail-ed1-f50.google.com with SMTP id o10so16042153edt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=hN7ArrCZGA1ao8rHF0YmDQU5ttwdEUe7NGXDz8fTTO9ETFojR6O9DGCIO9kUrorUXV
         nCcKVcACS2ruItmohPz75I6VL4wnO/6SmZPX240Jw/Gq+SY4Btl78J2bz6JoQHOogKZf
         //QeKCN2C7seUpRKcl4uiWrLyQ4XS1SyY+gyR0xiKVMhP5NBTtzDi/4CUigyThDlq81J
         kKsNdViGiuqugvXV0GMe3LDnRyKV2TQWjz++jSLLA136uSUQqQnHsA6PdGuFXjMCAiHw
         Jbeofz6welDX/iffk6FnO6k6naLmKciU5Tfz12rVEdpFav7YvRNNtj6Rg8rrQrI1edqv
         P1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=tg2w63SnaWU0KCrl2IIB9+UuDHz27kwi1fz5pcMfGjJ7Rb46KkwHbHaELXoxknf1Sc
         CxqezGHoOD0Y+/3KCGgYsFQOYVnim92l7RRh2faKNhY2IKH1njDOoh32JZbPY45yiw80
         uDb0JHcJWuAFhBW56/4r2wcsdAapUaia58GZloGNaxjp/cgFD9yXDtADuiIgf4AialuY
         zMw9lGKZRfxv3ZFkhAgtmhZcvgmemEx96OwujlgqkEzUh47s3iV2q5+b2PuQkr3T0byt
         2ACCF2wfI08aDDpqf7j/1OZpag1/VKKOowlWUsSGNhPb9nWijEtlPivYlSt/FRPXOAdi
         5yGQ==
X-Gm-Message-State: AJcUukfWHN/b5JCQb18n1ZoTK34LiQWw9++mWwNX2M7G5RsaHz/uRzka
        TulaHvqriAbcyEimxioNnE1zGst+
X-Google-Smtp-Source: ALg8bN5MjK2xH6gPs9wZO4Qf40QynQ3Z+ntwobI3dJS/TWJn/B9SvZ7cGOE7DXD12L5vQrXL6f8BeA==
X-Received: by 2002:a50:9226:: with SMTP id i35mr26265649eda.8.1548771573214;
        Tue, 29 Jan 2019 06:19:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g40sm14339722edg.39.2019.01.29.06.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:32 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:32 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:12 GMT
Message-Id: <b6316e1f7dee45d576eb04cbde2f35f09e8e56c3.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 13/21] README: add a build badge (status of the Azure
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

