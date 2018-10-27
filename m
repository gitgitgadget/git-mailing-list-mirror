Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B2E81F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeJ0PEz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45249 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeJ0PEz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so2470291lfi.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NS1HfjorPQpbryitWHwOpE6pP5rkH2B4Kg9deze+BJM=;
        b=fE8h0PO9MuxvFmuiDEL1xG7uVqX6C89KLSglG8UVqXvT0M/8kZsv3bxZR0GpLgkL2/
         O/RIS3OisXFCTAznkJDoyif927wEnIBDaSoN0QXHS9oEAzGEwIVQBvc5t14AqWqAVqbD
         UkjkoSW9ijEbp8xYidX3mWqYxH9JBkX7H0qGzXGdxww+MTyoOUvQRTLLC1ZP08LXhGGI
         X6zNLUU4r3xk6GJC5PN9r9QGca2YsttN0WxquH1tY/yyZYpjvrV/g04/rL5mF5uZ+WjK
         e0ps9iqwvlsUPBF7Xg1cKg/+djBzNzVwADGN3dt6VZzXx6G23jIG8u58q1vXpphClM9Z
         QGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NS1HfjorPQpbryitWHwOpE6pP5rkH2B4Kg9deze+BJM=;
        b=JlaCXMmSgU0LMh/ByeqhXRGrl4u+R8MHxqaWXoU519F00pJSIhRReV1rMPZUFn5CvI
         nRLQfnriJfjYxp2zF7Man9MVPzbhvBWSbhWwrK+3IN85xBkTedVoD4g7kWq7czhEolcx
         uBAZbXdugjS01z9KGmqIhDE5HI8jF+3qli94nQWnsH/kwqXp3pnNEq6QHMeUYeDlno+V
         dVL0ucUu+2R+ncWYD7ObzAd7omDzUJwROxGLfbCogsVU2aoqHQxaClrp+qETYFDnzLrH
         706j64u4LsCxvlvRTunxONzgw0zMi7sOm3CvbLSpOXA0srTym7cbh+AT79dvrvWXrwb6
         X4OA==
X-Gm-Message-State: AGRZ1gL5GDgIdrZgQ/FASY16mMn/ZWF3OS321grSSmy6wR4OXgBIgiEg
        3ks8t2uwlkHtS0XlL+Vx+VRVE0sP
X-Google-Smtp-Source: AJdET5db1jL4j3M8bq878vCySDM3lrQTylYZ5f+n9qUYDGVJeazJHi4Ek3x9ifiEVB3r7ZUp9Khp6w==
X-Received: by 2002:a19:6e0b:: with SMTP id j11-v6mr3666582lfc.118.1540621499279;
        Fri, 26 Oct 2018 23:24:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 55/78] config.txt: move rebase-config.txt to config/
Date:   Sat, 27 Oct 2018 08:23:28 +0200
Message-Id: <20181027062351.30446-56-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt                               | 2 +-
 Documentation/{rebase-config.txt => config/rebase.txt} | 0
 Documentation/git-rebase.txt                           | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/{rebase-config.txt => config/rebase.txt} (100%)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a6934fd87b..0079cb31ff 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,7 +389,7 @@ include::config/pull.txt[]
 
 include::config/push.txt[]
 
-include::rebase-config.txt[]
+include::config/rebase.txt[]
 
 include::receive-config.txt[]
 
diff --git a/Documentation/rebase-config.txt b/Documentation/config/rebase.txt
similarity index 100%
rename from Documentation/rebase-config.txt
rename to Documentation/config/rebase.txt
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 432baabe33..e98d1ac8ae 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -203,7 +203,7 @@ Alternatively, you can undo the 'git rebase' with
 CONFIGURATION
 -------------
 
-include::rebase-config.txt[]
+include::config/rebase.txt[]
 
 OPTIONS
 -------
-- 
2.19.1.647.g708186aaf9

