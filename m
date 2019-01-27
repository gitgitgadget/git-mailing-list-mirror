Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AAA71F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA0X1O (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:14 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44156 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfA0X1C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:02 -0500
Received: by mail-ed1-f44.google.com with SMTP id y56so11584397edd.11
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=kTSv1COUear/65ZncuMu4tj439uyVxbx2gw4JkZmtufr7o6huXGs9PxeVX6ciYy0IH
         pY1J/rDiAPK9cz4wAzRzTodUvaZF/7/qTW4R/+fqbZKyhQMe3gJOjxciuklcFqIlNAVx
         slu+Me2E79C6KcyxalSjyC+bcyVkwnheT38dRGou3Lz+rOohQlM+r2G9xBEJitQjzKDr
         FfsUPsVvZJKSEPrIiRQLlPZH96wDIlWtxYlPjG1X9Xso4RktYuO6PEe4Z623fQ9U7G1D
         QsTBtNc59HvjRISJgNxnPSV7tYQYB2qi48ih58yjdqubGutxfJu9HkFVLzjokKSqDsRi
         JKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yIFmvH39JP873kVuTr99FvXDnugqBCZqKax9pCZMHbE=;
        b=tL94/+1PEOasrhvCgswyDi8fb9FzUKEx9GoJEsGhT3A4AnqMEAxKhDnyI8QXrnHmhn
         tDoCIm/c4z+lmxymRnUjoeEZ4DJ4EkO4AuSe1z9C/o6qozSCmEnbi16zfYywgwjsXmx9
         uGYNpvLmigjFVI951W/8JYuV1WmnoaHmBJ4EQdsMckOpDiBwReP0ScqoLIKt4ngErMgm
         YT7i5Y1TMJWJI3Hg5tT0E8Tnqgo1Q8CWZa0fCCVczW03U6/8abAxMhcvzQ7ZSnMaUNhu
         T7Tb8vf69Rc2LI7iIj6EcrpRmFN+HjZn0wIuxPZ81O6ShVZfrAx05Ul17P/1tEv9c6/U
         Suaw==
X-Gm-Message-State: AJcUuketH63OKXkLgM8bXL6GGrsxpOCHaAXaxbwlTjJn0oEECAbGCP3B
        oeNm4AX5ywiuObdk8Etb0pax7Nmu
X-Google-Smtp-Source: ALg8bN7QHzPC1rWFioDCkxxufH3OLMOP2vBHpJcLIWMmKtOoE5xm1cKLrZNO+LUUfnxpCcwAoexQdw==
X-Received: by 2002:a17:906:a3c8:: with SMTP id ca8-v6mr17434026ejb.88.1548631620140;
        Sun, 27 Jan 2019 15:27:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c53sm14352818ede.26.2019.01.27.15.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:59 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:59 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:39 GMT
Message-Id: <eda46863e85f9b03a983697102cb4716c614f3ee.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 13/21] README: add a build badge (status of the Azure
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

