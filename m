Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1951F406
	for <e@80x24.org>; Sat,  6 Jan 2018 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeAFSqm (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 13:46:42 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43178 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751509AbeAFSqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 13:46:40 -0500
Received: by mail-pl0-f65.google.com with SMTP id z5so5113296plo.10
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 10:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ssyvDSUHeK0AZXY0v0mkf9eEWxAWzx2eWz7+CaT++AM=;
        b=Yjpt6i8RWIwHJg4baQVQAFzUCe69RQvIhSSYGZZfH3aoIxOBehSJfAC8CoDXwFCrDP
         6GSGmnv6QGpilsC50RdyF91m5Qg4suPvUhLpKypHEwe8fn15iZFzxZemBrO/XvUy+sFg
         Mjp1paF1C3fjn0NWU9EATqAZ2ObXXGO0qUjEJ2ajgF+p3JSg2JjZPvQIE6J3WH4OAYze
         WM1jOKVOMeavo2WTDohxcjGtDKA9QtrrIjFruuDEuv20GqqHj1o03iYK8X33+tLV71hC
         CoLclZIeoNd5VosVtYYokkldfdaT2Co/lnS8ta1x0OkhMwChhii2y96qBhQWYhjnhG7q
         Tw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ssyvDSUHeK0AZXY0v0mkf9eEWxAWzx2eWz7+CaT++AM=;
        b=DlTJEDoVWc2B9x/b5xzL9FG2yEVOiwGf4bhB7qtsi6Q5vWS7LdV1gsbN7kpppX6WCU
         M2O2FOJqmeKfKxE/NCt6gsk/g2nPwsUolw7hLmCvyZQ9iEEZNyxAq70gWqIYx5M2ZOs+
         Ke2mSvahiH0RGYLV3hlSo7MYhuHZ0fO4DDlSRjp4+FVuoEgjyfyXeoczDyLuGgysk2lk
         nmVekZpkmEU9NYXgYsFj75a74BS7AF0LUWO1EG/VkE5KSKp72cKouXnOaUSD7hcBIo1V
         /NviudsOB758TcL0eXW9Mlf1eg9GuWhWw7GsYdqnI9pLN2zMYwvVJj9ZCa9KHe6ks/gn
         uhew==
X-Gm-Message-State: AKGB3mIxiViSfPoYmWVBohEfZ7HZPkLiUD+Ryd+FBwXiDDaJV6LDiU2b
        7fQhnc1wwby7ygAIFF8MBlbRF4cr
X-Google-Smtp-Source: ACJfBovfwmoRwNFT+stx47SoHJ4BzEUeIhymFocWc+QhYwSEKlRiRPFs/1x3TfaOkGp2VoiuJ53WjQ==
X-Received: by 10.84.232.4 with SMTP id h4mr7069307plk.203.1515264399763;
        Sat, 06 Jan 2018 10:46:39 -0800 (PST)
Received: from localhost.localdomain ([117.246.198.31])
        by smtp.gmail.com with ESMTPSA id j14sm21141273pfj.93.2018.01.06.10.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jan 2018 10:46:38 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] Doc/gitsubmodules: clearly specify advantage of submodule
Date:   Sun,  7 Jan 2018 00:16:08 +0530
Message-Id: <20180106184614.20115-3-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index bf46b0fb5..cb795c6b6 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -57,7 +57,7 @@ Submodules can be used for at least two different use cases:
     * Size of the git repository:
       In its current form Git scales up poorly for large repositories containing
       content that is not compressed by delta computation between trees.
-      However you can also use submodules to e.g. hold large binary assets
+      Therefore you can use submodules to hold large binary assets
       and these repositories are then shallowly cloned such that you do not
       have a large history locally.
     * Transfer size:
-- 
2.16.0.rc0.223.g4a4ac8367

