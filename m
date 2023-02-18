Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D07C61DA4
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 19:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjBRTVn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 14:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBRTVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 14:21:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595C15CAC
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 11:21:39 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n1so1285621plc.11
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyl+cr9wG+M+7pOdKGYnE/5YJ6qS9gHmH7hLMDfdeO4=;
        b=i5i8i0pC6t4d2VadBLMXZC3c0fi1Vu5b6PAyuRqTkuWWx4NGCqsUTIPG1eVLK7Eo7A
         rqjeXZuFO9lva5HtVnR+Kc9APIlII7lnKUEUeZJ97V6gCfyvxeqp8ti9WjLZs0MPMJO9
         n/1eIOp3qx7xos5tZ5BuOfSDxMHI1MwS2NhHmqo0RRZA1p6yWzH5EaUmSLebqFK4Lsj7
         Uhtjjp/p62iNGUhrqYWAmvjC44YtWhmX8M6QuldCCN790CBHdjD8Ah/YrnyqAhrxYlB/
         TgpiKyl8GLWG3h6fZQVkowP4OzaVQ4rJH8PiYS1co4GOKuFEV4ISwunbSsDlj6cAGpop
         +hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kyl+cr9wG+M+7pOdKGYnE/5YJ6qS9gHmH7hLMDfdeO4=;
        b=cAmjw091ALP3YM7pucOTiHb7xukUP7/n+uSdUokGQ2okicdi9kv5JispTbI0pgLilY
         rxPlsVzXMM2QvoufQPu30fw9r+eeMaY8x+RynoRuExjNTSD6CndhjtuB0l6DQiea3UQk
         D7QoOmaGAvGJginJqSVmrFASgkeU/FZt1rycJ9AAh6mFV53Iokdk1koB3sgNMVaifcuO
         33Dc91rfdJPlkywgEMvGKU5e3kOjWU/vqc9Q6X1MJu6ymE5x0Z8wKTcL1dsnTAvUw7VW
         P8xgl0YVC/8hFs/FOVkU7s0GJfmAKMydgg7PjhJJLey6aUhdlO+RBterfyeYSNC7xfTu
         xpqQ==
X-Gm-Message-State: AO0yUKVQF+DHUON5tPCFUvapZckLAdw+EeJS4jy91mU1mmRiIp5ibKHv
        0Hc4YlCYRLm0hnMhSq825MpUCjDIY1KKjQ==
X-Google-Smtp-Source: AK7set/4T/RJzLng1VyqQqQ0IV5KuWFwHXQys7UiS0mII5BpQ5CP9LcOPLT0Ir6qwkUtjDEoCqQ8tQ==
X-Received: by 2002:a17:90a:a002:b0:234:d42:1628 with SMTP id q2-20020a17090aa00200b002340d421628mr1217462pjp.10.1676748098207;
        Sat, 18 Feb 2023 11:21:38 -0800 (PST)
Received: from localhost.localdomain ([103.46.200.200])
        by smtp.gmail.com with ESMTPSA id cm22-20020a17090afa1600b00233fa06085asm3703014pjb.50.2023.02.18.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 11:21:37 -0800 (PST)
From:   ashutosh.pandeyhlr007@gmail.com
To:     git@vger.kernel.org
Cc:     Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
Subject: [PATCH] t2015-checkout-unborn.sh: changes the style for cd
Date:   Sun, 19 Feb 2023 00:51:28 +0530
Message-Id: <20230218192128.7963-1-ashutosh.pandeyhlr007@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>

the `cd` followed the old style which wasn't consistent with the rest of
the test suite, so this commit makes it consistent with the current
style of the test suite for `cd` in  subshell.

Signed-off-by: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
---
this is my first time contributing to git I want to participate in 
this year's GSoC and I'm looking for some microprojects the ones
that are listed on the website are mostly done so if anyone can 
suggest some beginners level microprojects that would be great.

 t/t2015-checkout-unborn.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/t2015-checkout-unborn.sh b/t/t2015-checkout-unborn.sh
index 9425aae639..fdc4149f15 100755
--- a/t/t2015-checkout-unborn.sh
+++ b/t/t2015-checkout-unborn.sh
@@ -9,11 +9,12 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success 'setup' '
 	mkdir parent &&
-	(cd parent &&
-	 git init &&
-	 echo content >file &&
-	 git add file &&
-	 git commit -m base
+	(
+		cd parent &&
+	 	git init &&
+	 	echo content >file &&
+	 	git add file &&
+	 	git commit -m base
 	) &&
 	git fetch parent main:origin
 '

base-commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
-- 
2.39.2

