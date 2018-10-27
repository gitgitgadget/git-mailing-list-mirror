Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B341F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeJ0PFB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36260 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeJ0PE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id s15-v6so3127361lji.3
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEJtaCxh1kaFCcVvc1f19YpqcFQabsG/6JbXRaXkR8E=;
        b=X2Y7Gf/dzHWJ4itwL3r0EollEJJVBTP3Z2WhWBo4v/e7nEelwCCTZFfSGSUM8UdPa2
         Uhr9QfEFJq+Fg3bapi1GGnz6WL398+TsLQvdK0k+uzhHyiCLxXLunUiXSVrzL6MlJbAf
         TnRkxmR44LNp3LYvl5TWaBEaGZAlIvQRPv6cWJXfjHmwDZda35ryOIm70z+/JL9/Z3rY
         W4BGKX3jeFNlqQDiZ5GO/mGuN4fpqGCXX+RY2NdL+cxO/+JwBnkeyR8DsHX0Uxv/sg40
         8ysXeyTPC9K7U1prL8UWDNlrEvmbfJj09f3X/sbhMkk37BEUNRTs73rZAPAIhncSycyV
         bC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEJtaCxh1kaFCcVvc1f19YpqcFQabsG/6JbXRaXkR8E=;
        b=V5V84EeGlpr/AFIMm/1rjB7mwoa+BLM4jyLdX3p8WOFgQ0fwome8QWInxdhblVwnP9
         xFvZ9p8U2zggNSeQOM50tOWO9zv9WS2ctByr7FR9n0/TpgCRD+RmYnf1ClmcaF6AJMig
         3EarcInZM/2IXH9psMAiU1LOHyQd67OWSJUlrkkFh0fsiMqrlXoS4Wlo6KyZwY0mAvGp
         /vacwgv9yx2w8xR3dCk0LmD354pNsHlCQ+3ZhHb2CX5EHjpwtyhmWov3s8Fp/dMTtAHV
         YB81OfhAHXvZDjG0p8JQURoSvs/IjvtsISkyOxpc9mtJOmmVUMNYHCr1jtRusiLyYO6V
         +RfA==
X-Gm-Message-State: AGRZ1gI6SeI0gTJKnmRv7e0fIZUXR7WsNHn0+1930UiqpN30cfdS5srG
        ygUwVdTpqIH9c3W7eS6yjkKkCG8u
X-Google-Smtp-Source: AJdET5fp/Czc7StcCkPN93ugjBEG51Lgw62txNWbY/RUTRP3UvSbP6E/V49CP83vJ4sienTaR84E1Q==
X-Received: by 2002:a2e:5d8f:: with SMTP id v15-v6mr4470203lje.86.1540621503330;
        Fri, 26 Oct 2018 23:25:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 58/78] config.txt: move remotes.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:31 +0200
Message-Id: <20181027062351.30446-59-pclouds@gmail.com>
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
 Documentation/config.txt         | 4 +---
 Documentation/config/remotes.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/config/remotes.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b7aafdbf17..9aa849ce8b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -395,9 +395,7 @@ include::config/receive.txt[]
 
 include::config/remote.txt[]
 
-remotes.<group>::
-	The list of remotes which are fetched by "git remote update
-	<group>".  See linkgit:git-remote[1].
+include::config/remotes.txt[]
 
 repack.useDeltaBaseOffset::
 	By default, linkgit:git-repack[1] creates packs that use
diff --git a/Documentation/config/remotes.txt b/Documentation/config/remotes.txt
new file mode 100644
index 0000000000..4cfe03221e
--- /dev/null
+++ b/Documentation/config/remotes.txt
@@ -0,0 +1,3 @@
+remotes.<group>::
+	The list of remotes which are fetched by "git remote update
+	<group>".  See linkgit:git-remote[1].
-- 
2.19.1.647.g708186aaf9

