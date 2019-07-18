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
	by dcvr.yhbt.net (Postfix) with ESMTP id E36F41F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbfGRNTU (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33482 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbfGRNTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so28741402wru.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hku9jaOYCPh/VIAjzFkLvA7T0bv0+a/Vv/In5VsUblU=;
        b=ZHuroJMDHtj/9LPGh7vXVdkTid8MGilr2C4Cj1VpOqB/fNi6DCvzFfeCSYbCibS868
         C4JZGgB3j2iTClI7fEYMDAo+OndNLKG1LAgRdCPKYR8aCqq5Zd3D3K97cvu3Iq1sQb4l
         2+kVVyt/wwKRp9elVl88r8EVgzJje2vfyrHAIDafUG/wZ5tWbZoaWHjWhdZZ5OYaVUo6
         xPpc2xePR93zjlb7HKUB9X7O3ipa8xfTO3GyZQdiH0Ty2Hq8GFKin8iTR/nPhCN6ytLK
         QTw73CLwKAeUpQDUN8YTGKgNHAe34j38+N+phxTxl9Bv1ChqsgrAVCVVSP7Yx37HAmWG
         pyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hku9jaOYCPh/VIAjzFkLvA7T0bv0+a/Vv/In5VsUblU=;
        b=H52+b/cjCmJOCsQRYZdDE23iqKs6prsO2LZHEqrKC/ca5oP3Pq60hJF3zyVjtfVJwH
         HJ39crttaCXAnII35aah6fzO05/HPy9zLaTe5DyCqMGCO6E+kdKyOHfbstefUF2OhT+V
         Hqr+NV+2zGV+K2hsAIn/w/GFTFC5w9E7VUEmJ19kK0JxBt8o7UrO//PGH0q+ScBHaGga
         XyTu5aLFlevIMeDBlDf6NtvNay0DEVfyJgRHD17wxJlH3IktPu/4NHMj/Cl6sI0Z7lkU
         7NSzUxmkqOLuvTscVbz7IuFkBGfbbQzgWRb08feSS4cv90r9YRmcY3h3sX808YwmwQ2s
         8Qhw==
X-Gm-Message-State: APjAAAVHmaewR/sn8VAb/GP06bFcWMQbKmwW0uuJYm0akl0G2HTe/NHl
        T6e+PbcVOqlKHjfqZQP/2Z7IaEaQ
X-Google-Smtp-Source: APXvYqyww9YdU4umB3yjOZVjGln+/ayYWcBqEg38oUTpWYImGt1y5lnqvlWxsrkwceaCeZ3OqztZOA==
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr8636328wrq.173.1563455954608;
        Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm29552206wrv.90.2019.07.18.06.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:14 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:55 GMT
Message-Id: <44f0f3235e3cf801a19e2be30384a9e48a0aa3d6.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 20/24] .gitignore: touch up the entries regarding Visual
 Studio
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Add the Microsoft .manifest pattern, and do not anchor the 'Debug'
and 'Release' entries at the top-level directory, to allow for
multiple projects (one per target).

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index e096e0a51c..e7bb15d301 100644
--- a/.gitignore
+++ b/.gitignore
@@ -230,6 +230,7 @@
 *.ipdb
 *.dll
 .vs/
-/Debug/
-/Release/
+*.manifest
+Debug/
+Release/
 *.dSYM
-- 
gitgitgadget

