Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B412A1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbfJDPJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40268 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389570AbfJDPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so7646607wru.7
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=P3717Ci4fvGPollwCHc4nS+nQN1ejbLY8JovryStB+moYp1Z17N0eorLW9alav+6fN
         yXBNNhsXCHl6tTi3lf9uhG/Psgu6tQXDFTr4A9Gn4MEJxpA7G8fe27WQ+YuiUqzbdVNU
         5q3QBZJhYotHlilWA8RA4E66G1F6WhomCQnEWaW7kLPD69I1ABKgd6dfw9IhG4Xatwt6
         JV67RVu0s1DLgyGOMVei62W6EgdNYxbbKSfxxjHIR3lHT6JmOcwlYInRltMWMYWYsR+K
         Us0ofosL1AlZStmuvws2Ax5+zipdTksvDT82jBKbixUoFVDBfar+wv5QcxXE5VSZAllH
         cv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1WrFUOjNOCYQ9G5fl078OoTy2uTYYjpRxw5Us+PnBoc=;
        b=JHjotXpQ9GGZiTYYWvS3CVV2O/Ucg+mHpIOKgq8MNXj0xB1LY09YYXLse+Buyp4WIu
         YbgF0HiD7mW48/r4or7cFQK2XX+aF4MBgFYlDeZC8lw26oaYNvmJXl6bBBeYZW0Ze6Ao
         1dDRuXunqRp241o+skma9ZQIwfRtscOov1Ld6vckLwlIXYRcVqjzAcpHrKK1H6SCCrfH
         /tjARmM2vrFFiHn7mxgkYKZLmC0Fa3oTfJCgBH08v0xe9rBY0pqMb+zKPiO/FgYXuTAa
         4fnXI4+cFw3lmTN9AgQziKAIH2eTkuJBuZ9qNcIIpApbt943LKaIzMJhZNG5rqS4l55S
         FM+A==
X-Gm-Message-State: APjAAAXLfc4th4NJSnwGoF8TfnNPQOgJyaM5cfOiE5HgzmtBat5f7+or
        rMqwub/oIm9Expz5eFEK3eLnsG/D
X-Google-Smtp-Source: APXvYqylBgNJCI/Rg4CJtSAzDJ9drktp8JoI/P+kZnjVdxlVQxszKS4Iaxfcur7tGGp7kmYg7XVWFg==
X-Received: by 2002:adf:d1a8:: with SMTP id w8mr7581132wrc.271.1570201776452;
        Fri, 04 Oct 2019 08:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm7064307wrt.7.2019.10.04.08.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:35 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:35 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:21 GMT
Message-Id: <4495c392fd47db0b66c93b6d3d512ec606038471.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 12/13] ci: really use shallow clones on Azure Pipelines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This was a left-over from the previous YAML schema, and it no longer
works. The problem was noticed while editing `azure-pipelines.yml` in VS
Code with the very helpful "Azure Pipelines" extension (syntax
highlighting and intellisense for `azure-pipelines.yml`...).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index c329b7218b..55ee23ad0f 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -1,6 +1,5 @@
-resources:
-- repo: self
-  fetchDepth: 1
+variables:
+  Agent.Source.Git.ShallowFetchDepth: 1
 
 jobs:
 - job: windows_build
-- 
gitgitgadget

