Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6C761FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757199AbcLAU0a (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:30 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36139 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbcLAU02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:28 -0500
Received: by mail-pf0-f182.google.com with SMTP id 189so47885616pfz.3
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=m8cdBTKmmJQ9uAIG7maDS/LN9oULuOw5CSz6Lz0feJKXqLZ1D8CNTg6bjYaW76pVXb
         usMeYdPL8wIwrzDU4OzaDpYQcNMTV4ldj83oBVnPTvw0BurDUUKyMpZ90Zj6FU5XVTrA
         qDOwEP5lGD5i86H3/+yXnpdvJzP0DqPjAqj07mR4jKFZAFxdAiGgGo4rQhSvb4xoJXBr
         ZGhvGSPzRbtZWtJr+GEKXtIFH+q36yw0OAwV2tNJWGrqDpxrE0sXwigG+Ucr4UW6ZlpW
         nGeZaYYGImgzKGs+GZyLGcOvwTGpsGmk6sKqVzQBDDTmVV8D4UAdFCF42K/e/Pb6DK5G
         UkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/RBcGb5OHvuIvrdbxQjfFZ1vz6FsLtbdbbcLHTNi6E=;
        b=K7gCGWbKl82ooj49Ts8Ere9hl9Sr5nN2tWxQnqysLu9AMl/0oI5QkfpIOXoKN6KOH+
         zpfkAN33oQ/S5lPbDv9zIbMacBBqUy0KjxYV47Nyaw5rrxeWEGQD6TDVCYZARJD7zzJl
         wkwZ81SSDdAd6nn3zN8Hiza7DLlZq4cAqwtdJ7TNWBsLziK1li6BKe7fHt7unxFjt1Ee
         a0wFxvxEjyoRoSQt8cfDjbUhRxO9F/YTyaXlL+tEr1PV8vfgebeqJd6275fKdg0mkjTV
         O/rU+ioIv6bJiczKdWyezrnWlPMObmxuVxYbdQgE+pxcr4JuxiSr84Ma6d1JstssLEJB
         3SSA==
X-Gm-Message-State: AKaTC000bV0Dcf/+FBLjmTAe2+S+4fYdEPZwl8BcQ/bak9KEqote7UaCzXShqSf/yJWjALMb
X-Received: by 10.99.96.85 with SMTP id u82mr72989333pgb.47.1480623987066;
        Thu, 01 Dec 2016 12:26:27 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id 16sm2230074pfy.4.2016.12.01.12.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:26 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, peff@peff.net,
        sbeller@google.com, bburky@bburky.com, jrnieder@gmail.com
Subject: [PATCH v7 1/4] lib-proto-disable: variable name fix
Date:   Thu,  1 Dec 2016 12:25:56 -0800
Message-Id: <1480623959-126129-2-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1480623959-126129-1-git-send-email-bmwill@google.com>
References: <1480621447-52399-1-git-send-email-bmwill@google.com>
 <1480623959-126129-1-git-send-email-bmwill@google.com>
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

