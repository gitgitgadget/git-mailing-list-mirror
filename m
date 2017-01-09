Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MIME_HEADER_CTYPE_ONLY,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_TVD_MIME_NO_HEADERS
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95B2205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 05:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161273AbdAIFnh (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 00:43:37 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36454 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935352AbdAIFm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 00:42:56 -0500
Received: by mail-qk0-f170.google.com with SMTP id 11so32198514qkl.3
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 21:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oAQWTreOY99DXr1ZPQ53ncdWiECmvWt4L+SgAdutWlU=;
        b=OvF8zzioMpSfZG3hzJz5a1Iw5nlb0bPvugvwo2xCWqr/aIPRVr78WH/eU2FfB6bkyh
         KE6muVpgCHFeJES58nktQX2G/tUGvGW9x7aApgyy5mCEJLKj0SebFVs+hqhnTDVpTGlk
         CwaVGNyp3uoaRX8ewl5iwUqctuM6pdhiaOXCABl6ErAShCwm2spSobz2hCwHi1p58poR
         6Ng+ye/5qkdQ4U1s2s2KLpordwFhO82QDoPA6R3Bq5zHWX14pOOwa4/4/WDwOUCB+duz
         /gHktXHm7RQqmz5bOm41krMBctwfPCOrxl0H/ufxmrUCWa4uIIoeZ55ZfBNVjz4XW7gp
         1K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oAQWTreOY99DXr1ZPQ53ncdWiECmvWt4L+SgAdutWlU=;
        b=J4k0hnkyft4f2pLSU1xrYK2GpPmjcmlGRnqxyUQQ4lCpz2ZXh6IdLkVR67zr6M/rLy
         ZLBbGx0kz+ku3P1T0Y+KaFEuEEx1rOGx2k7rSS7Gdp280A9NAUKKaCNO1OvE/D3VCN0O
         hppo120nrsIJ4Vbe+kpRTdq+ztiVepBTr/AOYE3i/Sh9s+pSGqZPrE8hojR/VXmTe+eT
         JRdrsZHnZezjFvnUB0YDOTDL47WeplmsvWQ4r7tFjz8R6v3uAkXsE75uTX5tI9KTrve9
         8tQhDPUPe4maCVRvvblgdvY/nDEGaqrOnq7h12fbgAmz00oV3hqU3QyxtGVVq8063EXg
         V3UA==
X-Gm-Message-State: AIkVDXIA88RPjWLledhXBXkPtTixQIyAGsn709AGVgS9eAjQ9XQwk4j8p/3KDDXwGE2OF5hu
X-Received: by 10.55.147.69 with SMTP id v66mr82133192qkd.172.1483940575123;
        Sun, 08 Jan 2017 21:42:55 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id 21sm3452763qkh.13.2017.01.08.21.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jan 2017 21:42:54 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org
Subject: [PATCH v3 02/13] t7610: update branch names to match test number
Date:   Mon,  9 Jan 2017 00:42:27 -0500
Message-Id: <20170109054238.42599-3-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com>
 <20170109054238.42599-1-hansenr@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="94eb2c08b4d6dfdc640545a2d6ee"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--94eb2c08b4d6dfdc640545a2d6ee

Rename the testNN branches so that NN matches the test number.  This
should make it easier to troubleshoot test issues.  Use $test_count to
keep this future-proof.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 82 ++++++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 6d9f21511..14090739f 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -94,7 +94,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'custom mergetool' '
-	git checkout -b test1 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -113,7 +113,7 @@ test_expect_success 'custom mergetool' '
 
 test_expect_success 'mergetool crlf' '
 	test_config core.autocrlf true &&
-	git checkout -b test2 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "" | git mergetool file1 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool file2 >/dev/null 2>&1 ) &&
@@ -134,7 +134,7 @@ test_expect_success 'mergetool crlf' '
 '
 
 test_expect_success 'mergetool in subdir' '
-	git checkout -b test3 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -161,7 +161,7 @@ test_expect_success 'mergetool on file in parent dir' '
 '
 
 test_expect_success 'mergetool skips autoresolved' '
-	git checkout -b test4 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
@@ -192,7 +192,7 @@ test_expect_success 'mergetool merges all from subdir' '
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	test_config rerere.enabled true &&
 	rm -rf .git/rr-cache &&
-	git checkout -b test5 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master >/dev/null 2>&1 &&
 	( yes "l" | git mergetool --no-prompt submod >/dev/null 2>&1 ) &&
@@ -233,7 +233,7 @@ test_expect_success 'conflicted stash sets up rerere'  '
 test_expect_success 'mergetool takes partial path' '
 	git reset --hard &&
 	test_config rerere.enabled false &&
-	git checkout -b test12 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 
@@ -308,12 +308,12 @@ test_expect_success 'mergetool keeps tempfiles when aborting delete/delete' '
 '
 
 test_expect_success 'deleted vs modified submodule' '
-	git checkout -b test6 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	git commit -m "Submodule deleted from branch" &&
-	git checkout -b test6.a test6 &&
+	git checkout -b test$test_count.a test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -329,7 +329,7 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by keeping module" &&
 
 	mv submod submod-movedaside &&
-	git checkout -b test6.b test6 &&
+	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
@@ -343,9 +343,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 
 	mv submod-movedaside submod &&
-	git checkout -b test6.c master &&
+	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test6 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -359,9 +359,9 @@ test_expect_success 'deleted vs modified submodule' '
 	git commit -m "Merge resolved by deleting module" &&
 	mv submod.orig submod &&
 
-	git checkout -b test6.d master &&
+	git checkout -b test$test_count.d master &&
 	git submodule update -N &&
-	test_must_fail git merge test6 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -377,14 +377,14 @@ test_expect_success 'deleted vs modified submodule' '
 '
 
 test_expect_success 'file vs modified submodule' '
-	git checkout -b test7 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	echo not a submodule >submod &&
 	git add submod &&
 	git commit -m "Submodule path becomes file" &&
-	git checkout -b test7.a branch1 &&
+	git checkout -b test$test_count.a branch1 &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -400,7 +400,7 @@ test_expect_success 'file vs modified submodule' '
 	git commit -m "Merge resolved by keeping module" &&
 
 	mv submod submod-movedaside &&
-	git checkout -b test7.b test7 &&
+	git checkout -b test$test_count.b test$test_count &&
 	test_must_fail git merge master &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
@@ -413,11 +413,11 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test7.c master &&
+	git checkout -b test$test_count.c master &&
 	rmdir submod && mv submod-movedaside submod &&
 	test ! -e submod.orig &&
 	git submodule update -N &&
-	test_must_fail git merge test7 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both >/dev/null 2>&1 ) &&
@@ -430,10 +430,10 @@ test_expect_success 'file vs modified submodule' '
 	test "$output" = "No files need merging" &&
 	git commit -m "Merge resolved by keeping file" &&
 
-	git checkout -b test7.d master &&
+	git checkout -b test$test_count.d master &&
 	rmdir submod && mv submod.orig submod &&
 	git submodule update -N &&
-	test_must_fail git merge test7 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "" | git mergetool file1 file2 spaced\ name subdir/file3 >/dev/null 2>&1 ) &&
 	( yes "" | git mergetool both>/dev/null 2>&1 ) &&
@@ -448,7 +448,7 @@ test_expect_success 'file vs modified submodule' '
 '
 
 test_expect_success 'submodule in subdirectory' '
-	git checkout -b test10 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	git submodule update -N &&
 	(
 		cd subdir &&
@@ -464,52 +464,52 @@ test_expect_success 'submodule in subdirectory' '
 	git add subdir/subdir_module &&
 	git commit -m "add submodule in subdirectory" &&
 
-	git checkout -b test10.a test10 &&
+	git checkout -b test$test_count.a test$test_count &&
 	git submodule update -N &&
 	(
 	cd subdir/subdir_module &&
 		git checkout -b super10.a &&
-		echo test10.a >file15 &&
+		echo test$test_count.a >file15 &&
 		git add file15 &&
 		git commit -m "on branch 10.a"
 	) &&
 	git add subdir/subdir_module &&
-	git commit -m "change submodule in subdirectory on test10.a" &&
+	git commit -m "change submodule in subdirectory on test$test_count.a" &&
 
-	git checkout -b test10.b test10 &&
+	git checkout -b test$test_count.b test$test_count &&
 	git submodule update -N &&
 	(
 		cd subdir/subdir_module &&
 		git checkout -b super10.b &&
-		echo test10.b >file15 &&
+		echo test$test_count.b >file15 &&
 		git add file15 &&
 		git commit -m "on branch 10.b"
 	) &&
 	git add subdir/subdir_module &&
-	git commit -m "change submodule in subdirectory on test10.b" &&
+	git commit -m "change submodule in subdirectory on test$test_count.b" &&
 
-	test_must_fail git merge test10.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
 	(
 		cd subdir &&
 		( yes "l" | git mergetool subdir_module )
 	) &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git reset --hard &&
 	git submodule update -N &&
 
-	test_must_fail git merge test10.a >/dev/null 2>&1 &&
+	test_must_fail git merge test$test_count.a >/dev/null 2>&1 &&
 	( yes "r" | git mergetool subdir/subdir_module ) &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.b" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.b" &&
 	git submodule update -N &&
-	test "$(cat subdir/subdir_module/file15)" = "test10.a" &&
+	test "$(cat subdir/subdir_module/file15)" = "test$test_count.a" &&
 	git commit -m "branch1 resolved with mergetool" &&
 	rm -rf subdir/subdir_module
 '
 
 test_expect_success 'directory vs modified submodule' '
-	git checkout -b test11 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	mv submod submod-movedaside &&
 	git rm --cached submod &&
 	mkdir submod &&
@@ -537,9 +537,9 @@ test_expect_success 'directory vs modified submodule' '
 	test "$(cat submod/bar)" = "master submodule" &&
 	git reset --hard >/dev/null 2>&1 && rm -rf submod-movedaside &&
 
-	git checkout -b test11.c master &&
+	git checkout -b test$test_count.c master &&
 	git submodule update -N &&
-	test_must_fail git merge test11 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	( yes "l" | git mergetool submod ) &&
 	git submodule update -N &&
@@ -547,7 +547,7 @@ test_expect_success 'directory vs modified submodule' '
 
 	git reset --hard >/dev/null 2>&1 &&
 	git submodule update -N &&
-	test_must_fail git merge test11 &&
+	test_must_fail git merge test$test_count &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
 	( yes "r" | git mergetool submod ) &&
@@ -559,7 +559,7 @@ test_expect_success 'directory vs modified submodule' '
 '
 
 test_expect_success 'file with no base' '
-	git checkout -b test13 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_must_fail git merge master &&
 	git mergetool --no-prompt --tool mybase -- both &&
 	>expected &&
@@ -568,7 +568,7 @@ test_expect_success 'file with no base' '
 '
 
 test_expect_success 'custom commands override built-ins' '
-	git checkout -b test14 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.defaults.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	test_config mergetool.defaults.trustExitCode true &&
 	test_must_fail git merge master &&
@@ -579,7 +579,7 @@ test_expect_success 'custom commands override built-ins' '
 '
 
 test_expect_success 'filenames seen by tools start with ./' '
-	git checkout -b test15 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp false &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
@@ -595,7 +595,7 @@ test_lazy_prereq MKTEMP '
 '
 
 test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToTemp' '
-	git checkout -b test16 branch1 &&
+	git checkout -b test$test_count branch1 &&
 	test_config mergetool.writeToTemp true &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
-- 
2.11.0.390.gc69c2f50cf-goog


--94eb2c08b4d6dfdc640545a2d6ee
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIS6QYJKoZIhvcNAQcCoIIS2jCCEtYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghBPMIIEXDCCA0SgAwIBAgIOSBtqDm4P/739RPqw/wcwDQYJKoZIhvcNAQELBQAwZDELMAkGA1UE
BhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExOjA4BgNVBAMTMUdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIFBhcnRuZXJzIENBIC0gU0hBMjU2IC0gRzIwHhcNMTYwNjE1MDAwMDAwWhcNMjEw
NjE1MDAwMDAwWjBMMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEiMCAG
A1UEAxMZR2xvYmFsU2lnbiBIViBTL01JTUUgQ0EgMTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBALR23lKtjlZW/17kthzYcMHHKFgywfc4vLIjfq42NmMWbXkNUabIgS8KX4PnIFsTlD6F
GO2fqnsTygvYPFBSMX4OCFtJXoikP2CQlEvO7WooyE94tqmqD+w0YtyP2IB5j4KvOIeNv1Gbnnes
BIUWLFxs1ERvYDhmk+OrvW7Vd8ZfpRJj71Rb+QQsUpkyTySaqALXnyztTDp1L5d1bABJN/bJbEU3
Hf5FLrANmognIu+Npty6GrA6p3yKELzTsilOFmYNWg7L838NS2JbFOndl+ce89gM36CW7vyhszi6
6LqqzJL8MsmkP53GGhf11YMP9EkmawYouMDP/PwQYhIiUO0CAwEAAaOCASIwggEeMA4GA1UdDwEB
/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB/wIB
ADAdBgNVHQ4EFgQUyzgSsMeZwHiSjLMhleb0JmLA4D8wHwYDVR0jBBgwFoAUJiSSix/TRK+xsBtt
r+500ox4AAMwSwYDVR0fBEQwQjBAoD6gPIY6aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9ncy9n
c3BlcnNvbmFsc2lnbnB0bnJzc2hhMmcyLmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG
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
BgEFBQcwAoY0aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NodnNtaW1lY2Ex
LmNydDAdBgNVHQ4EFgQUbPFPDSp3rGDbNu3Pb8jJO+QTw0AwHwYDVR0jBBgwFoAUyzgSsMeZwHiS
jLMhleb0JmLA4D8wTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wOwYDVR0fBDQwMjAwoC6gLIYqaHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2h2c21pbWVjYTEuY3JsMA4GA1UdDwEB/wQEAwIFoDAdBgNV
HSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwDQYJKoZIhvcNAQELBQADggEBAG7GEcPrcRoMakd1
k8cdl7NUgGsEGoTzcS1ASh1ZaKlEzGR0uHyB7QwpX1hSHCvUKMRAqe5vXqZWhVhiPNPc0792yPHo
K+K5sV1W+pF66TlYY/9qlz0IDyKlMRKyCkc77PdrXubuJjauu2WGnbDpHvVwLTqwwlR5O0OLig48
m4YUSo869xADdrGrWJ7KzroFbucLZYh3niIjVICp7fh9wtLgbX7X/akdubehYhy/l+AIMml6Zlyu
GNGCGIleyQ0bAdjjG+dKrDErUlui8wd/YplvelaTAzSvNpxcrr+2YB8UBWcYkgULkp5GDCC2guKl
rMF1mTS6N6GMxUi30sZicbMxggJeMIICWgIBATBcMEwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBH
bG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlHbG9iYWxTaWduIEhWIFMvTUlNRSBDQSAxAgwvfEOc
7N3JjQI9nAwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILht90ltRrNS0IDdBYSA
WVmiknIv0VVK6k3nLUlULhW/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTE3MDEwOTA1NDI1NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsG
CWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCMLuAPv/8uxEWGzhH0l+zCextuWj9nZpM9VtI3
Y9gKTvpXaY6/cb3F99rYasldFig9Rp8MFzfrbj5A0MKJx8jA3fpfByM/KEzS+mOTXkng09topVbD
/dAQ+auIO7XvxJ+rTeSzJPczepA5J6IygVt5eNzCk8NSPY1A9CQ+6657p6pqE7qfzxyrbJnndU1e
X0cms4X1b4xQ+RgzzIj6u+0YtpqTBEFV14Owm1IdUjDqVNy0EaHmyVIpcOHBUEepMqKZGwbeU+Ks
b8nLEW5KPcYHe2vFX9ESg1ajwKTUYBCK1V8UB/Wy3rE/8hMT0qGlk+XuiI73dQfJR/IqGnz8qp0l
--94eb2c08b4d6dfdc640545a2d6ee--
