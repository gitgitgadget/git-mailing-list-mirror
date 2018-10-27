Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5098B1F454
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeJ0PFU (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37320 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeJ0PFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:05:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so3112639lja.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0e2lZHeK9iEmiu7N+qqQksewfHAyMzEEbeT4sZFtoTQ=;
        b=f6DW5K5rV4voULwVwTWOCrbEjZcY4DwksC5dGHWHe1AnPG7SGvlfBMSU+KNsnGmT8r
         17Xgy+5cO+XkBYWvQkjlSuhYciQZ4e2UfD4a6HkP6Q1Up1DlrNVt2DquMH6gnFrRAhNb
         lNSKZa8B2oUf1p61wh7HxEZxcDlGPtl+SBc2xJQhqrdIffSBiAMueINngK5YdtxZHE5i
         uQ0id5uyK59Lb5AWRJbd8rUTdpc/jRGD3Hxb9F+GB1DiXMaTYyVtz+MQD3YmQWKCaA5P
         BmZUfL9ufppKWjKyh8KI2O7aUx7FLQtYldKxGJlf3LFKf1QF9HTzwll7VNhNQm3NpbfH
         /dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0e2lZHeK9iEmiu7N+qqQksewfHAyMzEEbeT4sZFtoTQ=;
        b=OR0/JXNhA5uO/vfbuBRiFgMNgljW625AMARmYEjw9aIhhGkUVzAj0ic6qmkoz51s47
         V08ObsS/OSi/Sa42TCU5g+BQl+b9zWpFNw6nBLee7Xt+qwwMmlvZC/5QrZyhFceuWNpN
         O6XZQP4zhe00xUjm7OGf5eO4IyuFBW5n/Zz69RuD7FZG5Yp2OzcQQOcEu6cCQQ3w0KTJ
         Hz5Wiyi5yoHRJwFnUR6miA9zzpR76owqM6sWuHo0QSHJrhqnyWS6QytkgRxd/dPbssec
         WLL1S3LK6plEe0CZNlylNSDFaFN6zxq6dQ4YGVXj7v4IRvFYZucXTDUCmaIUlRuj50i2
         nm7A==
X-Gm-Message-State: AGRZ1gJm7ePJwqySnmccdgfhqTixXmG7Ka7yJoGIh75j4agsOvyITH5r
        dH2HlgVM7HAN0yJoaUkdCGljDNF8
X-Google-Smtp-Source: AJdET5cMFHntbmRIlNhnSy7k++SnORA7BhxYBbZxoSJ3GoCKH9PAlCRxBaSzETZ9k3l76cln5nQNfQ==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr4123888ljh.103.1540621523143;
        Fri, 26 Oct 2018 23:25:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:22 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 76/78] config.txt: move web.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:49 +0200
Message-Id: <20181027062351.30446-77-pclouds@gmail.com>
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
 Documentation/config.txt     | 5 +----
 Documentation/config/web.txt | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/config/web.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eacaaa2deb..10617d0a10 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -433,10 +433,7 @@ include::config/user.txt[]
 
 include::config/versionsort.txt[]
 
-web.browser::
-	Specify a web browser that may be used by some commands.
-	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
-	may use it.
+include::config/web.txt[]
 
 worktree.guessRemote::
 	With `add`, if no branch argument, and neither of `-b` nor
diff --git a/Documentation/config/web.txt b/Documentation/config/web.txt
new file mode 100644
index 0000000000..beec8d1303
--- /dev/null
+++ b/Documentation/config/web.txt
@@ -0,0 +1,4 @@
+web.browser::
+	Specify a web browser that may be used by some commands.
+	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
+	may use it.
-- 
2.19.1.647.g708186aaf9

