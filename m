Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818441F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbeISWRS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 18:17:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36506 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeISWRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 18:17:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so1835916lfe.3
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Zez/TIRK/Luf9/6QxWYF04NYNe+LsiN577D5m0A0mE=;
        b=nHkHoATWi147wA0B/rLm4w1bBVejk8bqTBgg/R4M2N7nz277+qUVRY3uqzsfsk0RoH
         7BMUbABqfK3XizI1KGBmb5dtume2Em/bgu5+nMmsYTUZbTNh6hyCAxL9rakdfqN4CPa3
         a14oHKy5F8vBzHuADaSxHjJodm2BeiLvQRTMmLzP4M5HIZez55fFdEbm59jzLdSMJ+L3
         HlL9zjR9NI0MKe+wSpyg0w+WYt6R/1OCIftwjDOL+PwHFUR+kVKwS4JWEc8soUCNFWBO
         m/C7eeKQbQiWM7i1w6J1Fm9NBYvKeYrx2mI7ge/wtx4zZZPLMQG0mojzogftj1zTN0Ch
         qmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Zez/TIRK/Luf9/6QxWYF04NYNe+LsiN577D5m0A0mE=;
        b=CWn/nHqz0RqAlOMfAHEP0gzS/3RWo0+sxLar2NG7Wj49YbN+eja6DO4TVduAsf7A9n
         BoVvaz01qgkTZNSqZKFepTsFw/aObYuZlr88O4W1MuKZX8v5EGI0TzNG6Jf1pl3Fjmh0
         D1DvBG9+eZXsNRmNMn3q74oYNAaZ6U9Wy9ApRiUTloGaD6qurzfIi3f8vOtcph04ljvO
         bT0QjLrpfBjDbuCs+/cT6mXhckR8dQUs9kJPm83rlEF0XFJ2FV/DjrnI3jgkP6jD2NqH
         pUJvJnEQPWrZ4ta0Do53FJ/BaefdXqZS58NtVwZDmF681W6b8ub8BhMd0xQwx2XTX7p/
         TlHQ==
X-Gm-Message-State: APzg51ApndYijrAbPzaJv4+GuZbO7dm0NYpq9+e/FoMTSl3NwLNdf52V
        aNtEnLhLB54Wgh6HsgXFYTbnwoUd
X-Google-Smtp-Source: ANB0VdaI1A/LReSeSeBsVdcCwGjq1o7u+n2Ngj7TIh/8/9EoFsTGrCdBlXoK2BjlVLZwnXHw2MH/0Q==
X-Received: by 2002:a19:518a:: with SMTP id g10-v6mr6674288lfl.63.1537375114290;
        Wed, 19 Sep 2018 09:38:34 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d13-v6sm1144261lfi.74.2018.09.19.09.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 09:38:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/2] Doc: use `--type=bool` instead of `--bool`
Date:   Wed, 19 Sep 2018 18:38:18 +0200
Message-Id: <e81bbd0e714221aac47b387e7d1e1572af32aa8f.1537375024.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After fb0dc3bac1 (builtin/config.c: support `--type=<type>` as preferred
alias for `--<type>`, 2018-04-18) we have a more modern way of spelling
`--bool`.

Update all instances except those that explicitly document the
"historical options" in git-config.txt. The other old-style
type-specifiers already seem to be gone except for in that list of
historical options.

Tweak the grammar a little in config.txt while we are there.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config.txt     | 2 +-
 Documentation/git-config.txt | 4 ++--
 Documentation/git.txt        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 112041f407..088cbefecc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -225,7 +225,7 @@ boolean::
 	false;; Boolean false literals are `no`, `off`, `false`,
 		`0` and the empty string.
 +
-When converting value to the canonical form using `--bool` type
+When converting a value to its canonical form using the `--type=bool` type
 specifier, 'git config' will ensure that the output is "true" or
 "false" (spelled in lowercase).
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 8e240435be..9d8cea72dd 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -442,9 +442,9 @@ For URLs in `https://weak.example.com`, `http.sslVerify` is set to
 false, while it is set to `true` for all others:
 
 ------------
-% git config --bool --get-urlmatch http.sslverify https://good.example.com
+% git config --type=bool --get-urlmatch http.sslverify https://good.example.com
 true
-% git config --bool --get-urlmatch http.sslverify https://weak.example.com
+% git config --type=bool --get-urlmatch http.sslverify https://weak.example.com
 false
 % git config --get-urlmatch http https://weak.example.com
 http.cookieFile /tmp/cookie.txt
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 74a9d7edb4..08e533d62b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -76,7 +76,7 @@ Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
 `foo.bar` to the boolean true value (just like `[foo]bar` would in a
 config file). Including the equals but with an empty value (like `git -c
 foo.bar= ...`) sets `foo.bar` to the empty string which `git config
---bool` will convert to `false`.
+--type=bool` will convert to `false`.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
-- 
2.19.0.216.g2d3b1c576c

