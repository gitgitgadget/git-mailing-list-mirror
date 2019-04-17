Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7923A20248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfDQKZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:24:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so2732958wmf.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=aDmDzewQ3j0YTvnRDa1yuBOrylyvuYzUOVerSwG5a6U=;
        b=mFF+suM9jtdgz94Svyqe5Xru9/MBQCPcoeMny6QGuE6STa0THabXiMla/yCUUbcTuL
         CYgSpLcQy03uMlwqQthbDKmanTZ0/apr6f5hY0BDYT+KYA4xUAEEwyMBwve+mdgRl5XV
         NXV3c8A76KX6jQuczcarS7/IZboboqpbDbMVeLlRS/LTxTgeY2LqAJ56MwM8KSFoBnSH
         iKFe1H9yNj7PHOY0anCiM6ubjPyPlgAL2+mNINqV7NLfoQW5k/n3GNo9XP1Q+aZw+8nj
         aUuvaDvN4Y/O/wyvQtO4u2ffhUA3o4cbqervlps0K7UphztGYqL80YTX3T7M0Gmchs04
         6Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=aDmDzewQ3j0YTvnRDa1yuBOrylyvuYzUOVerSwG5a6U=;
        b=oC9xEs/6FpK0YIM1nJD794po1APwyigbuVcCXjhU8puDsZsOLECW0Te4qZsQ2YHI3f
         9yiezl7rJ1/BzbWHQmB6vKuh4ETEFzmLBU8Cw+/D84wm7TsC3Ys+WL4ObEXeV3rGEzvx
         5eIMhMtKV+jHu6U0MB3kT5Q4ump8Gtif9Nv/gb/jJoMMZqL6N/YNDLzxq9U9n+K0h927
         fauf9zuXz4dFSTkCaakLDTzTbM6q3ryYYKA0pSivWFqdD34eeuEu/SJwRDvmvwqNYcgO
         Rme3wmmL3SHjWVpWwEbt62I0uHaZ2Ad7/ZGLv0q+5is6XiRiLmYbODpmi7Cmc5VY+mfc
         avCA==
X-Gm-Message-State: APjAAAVXTmADfoQNa8G7chgYZRyFGXJH//CQMXweY+0mbECV9wQWh+Ep
        HAd8jStsVvyFfhdR6UtIV0U=
X-Google-Smtp-Source: APXvYqx8DtLhTcMxevQ+phOmBgB5J4x0pbxCU8S1YwN2MfrvKXZrZl3SnetonSnRMpl4hLaZr+YKlw==
X-Received: by 2002:a1c:cf46:: with SMTP id f67mr29680881wmg.98.1555496696946;
        Wed, 17 Apr 2019 03:24:56 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:56 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 03/10] t7604: clean up style
Date:   Wed, 17 Apr 2019 11:23:23 +0100
Message-Id: <20190417102330.24434-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417102330.24434-1-phillip.wood123@gmail.com>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Before, we had some Git commands which were upstream of the pipe. This
meant that if it produced an error, it would've gone unnoticed. Refactor
to place Git commands on their own.

Also, while we're at it, remove spaces after redirection operators.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7604-merge-custom-message.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
index 89619cf446..aba1279132 100755
--- a/t/t7604-merge-custom-message.sh
+++ b/t/t7604-merge-custom-message.sh
@@ -16,16 +16,16 @@ create_merge_msgs() {
 }
 
 test_expect_success 'setup' '
-	echo c0 > c0.c &&
+	echo c0 >c0.c &&
 	git add c0.c &&
 	git commit -m c0 &&
 	git tag c0 &&
-	echo c1 > c1.c &&
+	echo c1 >c1.c &&
 	git add c1.c &&
 	git commit -m c1 &&
 	git tag c1 &&
 	git reset --hard c0 &&
-	echo c2 > c2.c &&
+	echo c2 >c2.c &&
 	git add c2.c &&
 	git commit -m c2 &&
 	git tag c2 &&
@@ -36,14 +36,16 @@ test_expect_success 'setup' '
 test_expect_success 'merge c2 with a custom message' '
 	git reset --hard c1 &&
 	git merge -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.subject actual
 '
 
 test_expect_success 'merge --log appends to custom message' '
 	git reset --hard c1 &&
 	git merge --log -m "$(cat exp.subject)" c2 &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_cmp exp.log actual
 '
 
-- 
2.21.0

