Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B8720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 00:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLLA2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:28:09 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:36838 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLA2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:28:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id h68so14719995qke.3
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mN4BgtUBZ4FvzSrh9D4SUZoioucnkAFI6BA+YHYFnyo=;
        b=LplTsu9Nj4eBwyvtRKj9kPKqbwqO6tZQ1rVZOK8YDV9QV0cR6klTxEtlfqSWzlIjvM
         FUzwjY3W37fAtNCp3iaN2BC+9CyX3lULSAv/0oV06gWkdWoM+qp2FBIqAHnimZVXrroT
         K1qLmAfnPRiCPv7DnA8iwKpWKB+CDt6B9sjHxoVEEICGJphzwhYxLWJso7oHEItqsXiR
         DGekXC17DeHE8nPYJQTEDi9pjbufu8zVW2X1H+hwAG5vWv6sFZZkiI4o3iOwjq5U+Bvw
         oNu2+AYpSLdthcPOjCYiKEr6zTCnWxCfHy0RQrStLrnmDGfQZT1RlkoznoFL4uWZMbiZ
         0fDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mN4BgtUBZ4FvzSrh9D4SUZoioucnkAFI6BA+YHYFnyo=;
        b=OQfJJC05zHrKMdG1BWiJ5laSHE1KdAkerekHl0FlOHGEYv6PMdJ1/OyK13r8H3WQXg
         0sz0P+cgAcg/3nw25pmpAu9DN0wwxZbN51uqVd8aXEYv4g5HON+BxclCA142QP/LuT1J
         aPIr5peJyF3bLXxHF7/gFek2Q2OO3klg7d0853PjL1Y+quRTzI5ojIY/Heuo2rvXDSVG
         bd1WPvzIUxcoaNGfFOKI4MDop93BEfm34KOvlog4AX2AoxUozGtukhwPv6fjpAk4uiLr
         KIal26y1XgYBHTjLkeqVMeGanTKbIsJyCtW23yh8WGvBkH9yuCffY2fZ6/bpOqFEuACn
         bjuA==
X-Gm-Message-State: AA+aEWZ2zS8v47VwUIg6lruTW/+XD6BNL9ZUMKjFePMuOAnjtjWoFC9r
        EkdukKPf04W9YYcYrjfIeHpXG8wrCHgP1z7DnJO57Ezr4p6IQfZMS0gx5Yh50ykaB4IOYQMjyFj
        SmfTa/Gk+Xcx6k9jSHz4wFAJoPhp9H899BBhYpGX5q6aHPVIfCWtxdsD1Yw3+/acqxcoamhNF89
        Tc
X-Google-Smtp-Source: AFSGD/VV01EV1npHZ8XC1ZKZvRPczolk6FbBvUHZ9V/ktV182J/t1si8kD883kOo2hzZrcx00uBNobO5FAMUFIjMlDq5
X-Received: by 2002:ac8:2a78:: with SMTP id l53mr13741642qtl.44.1544574487014;
 Tue, 11 Dec 2018 16:28:07 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:27:56 -0800
In-Reply-To: <cover.1544573604.git.jonathantanmy@google.com>
Message-Id: <33bae6445998e4928aa45c15726667590947c422.1544573604.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211212135.21126-2-avarab@gmail.com> <cover.1544573604.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/3] squash this into your patch
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5539-fetch-http-shallow.sh | 12 ++++++++----
 t/t5541-http-push-smart.sh    | 10 ++++++++--
 t/t5551-http-fetch-smart.sh   | 23 +++++++++++++++--------
 t/t5570-git-daemon.sh         |  2 +-
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shallow.sh
index 5fbf67c446..996ce060cd 100755
--- a/t/t5539-fetch-http-shallow.sh
+++ b/t/t5539-fetch-http-shallow.sh
@@ -67,7 +67,8 @@ test_expect_success 'no shallow lines after receiving ACK ready' '
 		cd clone &&
 		git checkout --orphan newnew &&
 		test_commit new-too &&
-		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" git fetch --depth=2 &&
+		GIT_TRACE_PACKET="$TRASH_DIRECTORY/trace" env --unset=GIT_TEST_PROTOCOL_VERSION \
+			git fetch --depth=2 &&
 		grep "fetch-pack< ACK .* ready" ../trace &&
 		! grep "fetch-pack> done" ../trace
 	)
@@ -114,7 +115,8 @@ test_expect_success 'shallow clone exclude tag two' '
 '
 
 test_expect_success 'fetch exclude tag one' '
-	git -C shallow12 fetch --shallow-exclude one origin &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git -C shallow12 fetch --shallow-exclude one origin &&
 	git -C shallow12 log --pretty=tformat:%s origin/master >actual &&
 	test_write_lines three two >expected &&
 	test_cmp expected actual
@@ -128,14 +130,16 @@ test_expect_success 'fetching deepen' '
 	test_commit two &&
 	test_commit three &&
 	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
-	git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone --depth 1 $HTTPD_URL/smart/shallow-deepen.git deepen &&
 	mv "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" .git &&
 	test_commit four &&
 	git -C deepen log --pretty=tformat:%s master >actual &&
 	echo three >expected &&
 	test_cmp expected actual &&
 	mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-deepen.git" &&
-	git -C deepen fetch --deepen=1 &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git -C deepen fetch --deepen=1 &&
 	git -C deepen log --pretty=tformat:%s origin/master >actual &&
 	cat >expected <<-\EOF &&
 	four
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 5475afc052..20f1308578 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -45,14 +45,20 @@ test_expect_success 'no empty path components' '
 	# In the URL, add a trailing slash, and see if git appends yet another
 	# slash.
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
+	# Other protocol versions may make different requests, so perform this
+	# clone with protocol v0.
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&
 
 	check_access_log exp
 '
 
 test_expect_success 'clone remote repository' '
 	rm -rf test_repo_clone &&
-	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
+	# Other protocol versions may make different requests, so perform this
+	# clone with protocol v0.
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone $HTTPD_URL/smart/test_repo.git test_repo_clone &&
 	(
 		cd test_repo_clone && git config push.default matching
 	)
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8630b0cc39..56fd9351a6 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -43,7 +43,8 @@ test_expect_success 'clone http repository' '
 	< Cache-Control: no-cache, max-age=0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=true git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
+	GIT_TRACE_CURL=true env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
 	sed -e "
@@ -92,7 +93,7 @@ test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
 	git push public &&
-	(cd clone && git pull) &&
+	(cd clone && env --unset=GIT_TEST_PROTOCOL_VERSION git pull) &&
 	test_cmp file clone/file
 '
 
@@ -143,7 +144,8 @@ test_expect_success 'clone from auth-only-for-push repository' '
 test_expect_success 'clone from auth-only-for-objects repository' '
 	echo two >expect &&
 	set_askpass user@host pass@host &&
-	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
 	expect_askpass both user@host &&
 	git --git-dir=half-auth log -1 --format=%s >actual &&
 	test_cmp expect actual
@@ -151,7 +153,8 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 
 test_expect_success 'no-op half-auth fetch does not require a password' '
 	set_askpass wrong &&
-	git --git-dir=half-auth fetch &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git --git-dir=half-auth fetch &&
 	expect_askpass none
 '
 
@@ -187,7 +190,8 @@ test_expect_success 'create namespaced refs' '
 '
 
 test_expect_success 'smart clone respects namespace' '
-	git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git clone "$HTTPD_URL/smart_namespace/repo.git" ns-smart &&
 	echo namespaced >expect &&
 	git --git-dir=ns-smart/.git log -1 --format=%s >actual &&
 	test_cmp expect actual
@@ -214,7 +218,8 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
-	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
+	env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
 	tail -3 cookies.txt | sort >cookies_tail.txt &&
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
@@ -306,7 +311,8 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
+	test_must_fail env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'test allowanysha1inwant with unreachable' '
@@ -325,7 +331,8 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
-	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
+	test_must_fail env --unset=GIT_TEST_PROTOCOL_VERSION \
+		git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
 
 	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
 	git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..4a2a937bb0 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -190,7 +190,7 @@ test_expect_success 'daemon log records all attributes' '
 	EOF
 	>daemon.log &&
 	GIT_OVERRIDE_VIRTUAL_HOST=localhost \
-		git -c protocol.version=1 \
+		env --unset=GIT_TEST_PROTOCOL_VERSION git -c protocol.version=1 \
 			ls-remote "$GIT_DAEMON_URL/interp.git" &&
 	grep -i extended.attribute daemon.log | cut -d" " -f2- >actual &&
 	test_cmp expect actual
-- 
2.19.0.271.gfe8321ec05.dirty

