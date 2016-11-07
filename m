Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6C52022A
	for <e@80x24.org>; Mon,  7 Nov 2016 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbcKGUEI (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 15:04:08 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36382 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbcKGUEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 15:04:07 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so95365615pfz.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q4eXACfwDHCf87bLzbqfJ9fgR0RSlv00FzIzsaQACcU=;
        b=Ce1jWTkCmZm9ZX23U53tEKLMGX/pageFHifOAEHOIBL2qPQOMD3OgYH8SsrPrUl1Z+
         lfqAVenDzz64OVEz3we+/BXt66MxgOfh91JV/8I/sKlchqs8yRGxpCkSUeAeTMNahbWO
         JP9xi1RYMxSeig2uvmw511F01+OQzMFwlM9r+EGIY/OIt1itcOQy6a3a7BBHQDdQB8zn
         DFY4aiHS3WbuOhD2lPe3YHLkXJZlVHNDV7wzy0ORcKZ4TwrPa/6LQ9XipPO5oln1rYyQ
         sFybwJi4kzJMnjQGLdoq9oFpN7YdElAXPmFH5vHa8jaGktm1aAHce3l/0YS/DpCk24jt
         lQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q4eXACfwDHCf87bLzbqfJ9fgR0RSlv00FzIzsaQACcU=;
        b=Vj9r89k7R3AQTsT9NjimRGaLaBTBlschMFKWYwo1afwe0jo0mMarjrd6h+h8xbEDer
         jazA7HM3XJ70Lp4cZ0KwxjM7WMpUGOzq7Z+K0EZyqbxZOWtAQWJD7ljlIPuYPGJUnetr
         uX0mIRwb4aLIwqMCzTG7kmzSz3vgzMMgHqhE+V1f/VipZEjBD+PpDyAvxQjirdzmTRXa
         4qLIlU8/0Vgr3cXsb3xx5AIqa67rR39Fke1IDD8zfA8a1FtOmylnpVHUfyC1vZXLteUL
         iy7Hac4jDV6FXRpSUL4eJnYmbG5IqWNNIMqu9J6YNHDSuJoYKlezXod0s0O4TZSEUZX+
         Je+A==
X-Gm-Message-State: ABUngvfPG4WjLimqvniEm5CdUM9d+qAHgBt/stXyD5i4998yvtJxzuLlFm0fNlkqlYtd7IG2
X-Received: by 10.98.149.140 with SMTP id c12mr16533070pfk.100.1478547339623;
        Mon, 07 Nov 2016 11:35:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id b126sm13106334pfg.90.2016.11.07.11.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 11:35:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        bburky@bburky.com, peff@peff.net, jrnieder@gmail.com
Subject: [PATCH v4 1/2] lib-proto-disable: variable name fix
Date:   Mon,  7 Nov 2016 11:35:22 -0800
Message-Id: <1478547323-47332-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1478292933-7873-1-git-send-email-bmwill@google.com>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Small fix to use '$desc' instead of '$1' in lib-proto-disable.sh.

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

