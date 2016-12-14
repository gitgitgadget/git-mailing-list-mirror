Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0217420451
	for <e@80x24.org>; Wed, 14 Dec 2016 01:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754651AbcLNBmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 20:42:22 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34488 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbcLNBmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 20:42:20 -0500
Received: by mail-pg0-f53.google.com with SMTP id x23so2018603pgx.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 17:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=pAXTlh4I8bBy3rLsaYHB0/s5JOiuBtCzfH910L+W/MhiNQUd5MUoDpaGwZl8xFRGuV
         1g9fwOsa9TvNxOafnLiM+k4pZFUWFZv+48kUc6vv+5ymk3BbH4RjwyyYvMdn1mXVG8Op
         02j0uSKkNxc03Vx3Q+4ga9PFFzTJYi7fYmr5oqbLYSjnhkdRY6iAdkpE1A52a7KxS8hG
         3S/Rr1UGA7+W4X52WPqexh0QBZCFtZxk8YVkTcdiig2hDQIogLvdA6V00B26Yokkx0Ei
         cOAkiNGrGYOuyFahuyC60/9EkSmewJ8sA+8Kj2Pjxwo3kq7GvoNO8uzmA2WGIjz8d8sM
         +tBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=SLjlDc2yq3qcxFtPIAIsQoJ/UA9YjkPo36yNeOf4wFG6KQdbD/xUaj93kc4TJjClTm
         QuSmrnsgOzbBw5MQzZiUcDOBKkwROxinQKIOmBRo/iJqsp0vH1OhYzaAYH4CuKRrMlaW
         MDYmLe6WkVeSC9p21nZ1Xdixk+Vyj1wl4eO51PnqmJo/CCdq9c3erisfsWItSqBymSvL
         h67QFsT72j7avelgqV2PDY03rp+3pXdQQeYfm97bNfhh5G8WPBjCVffrgDzuf68KuExx
         eDP5g8lwWxtzoR3kKUSHPz5+/jGzbE6LP7gz5r5ZGON338ZG80EOstqmj9HsYESZpbkZ
         YFlQ==
X-Gm-Message-State: AKaTC03mc/oZfzgYeyPQnw/q/uk190uVRHrOKzG+88cQoDj+uEo1biTY2s3nqR/+u2EvOy/M
X-Received: by 10.99.98.2 with SMTP id w2mr182834483pgb.59.1481679700003;
        Tue, 13 Dec 2016 17:41:40 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b12sm82462599pfb.78.2016.12.13.17.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 17:41:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: [PATCH v9 1/5] lib-proto-disable: variable name fix
Date:   Tue, 13 Dec 2016 17:40:33 -0800
Message-Id: <1481679637-133137-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481679637-133137-1-git-send-email-bmwill@google.com>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_proto function assigns the positional parameters to named
variables, but then still refers to "$desc" as "$1". Using $desc is
more readable and less error-prone.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/lib-proto-disable.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index b0917d9..be88e9a 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -9,7 +9,7 @@ test_proto () {
 	proto=$2
 	url=$3
 
-	test_expect_success "clone $1 (enabled)" '
+	test_expect_success "clone $desc (enabled)" '
 		rm -rf tmp.git &&
 		(
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -18,7 +18,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "fetch $1 (enabled)" '
+	test_expect_success "fetch $desc (enabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -27,7 +27,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "push $1 (enabled)" '
+	test_expect_success "push $desc (enabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=$proto &&
@@ -36,7 +36,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "push $1 (disabled)" '
+	test_expect_success "push $desc (disabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=none &&
@@ -45,7 +45,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "fetch $1 (disabled)" '
+	test_expect_success "fetch $desc (disabled)" '
 		(
 			cd tmp.git &&
 			GIT_ALLOW_PROTOCOL=none &&
@@ -54,7 +54,7 @@ test_proto () {
 		)
 	'
 
-	test_expect_success "clone $1 (disabled)" '
+	test_expect_success "clone $desc (disabled)" '
 		rm -rf tmp.git &&
 		(
 			GIT_ALLOW_PROTOCOL=none &&
-- 
2.8.0.rc3.226.g39d4020

