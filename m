Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5EB1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfA2OTg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:36 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40248 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfA2OTg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:36 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so16082980edr.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=G+miTMPSDlCEziHpvQ7tYRIC390JC7zp6Kg0iC2YKaGq2lyymWkoH2LMu4d3UK6OI7
         IQiqcUkfsGrQ8oz0e/9PYI0nfXUZ/ajhggNcai8kYRVygUlacSdCrX3g8M04E1XjX+2G
         dhD/1eVlmdG+3/Nwqf+WxcN8NAfk96UwvhOr2mX33nnKzxRR4UrvNKkhqG4tZOoCj8wB
         IYUKYJsqgicwqAsJyExDAagBHLYkLj+ZFrn5ymXgATyZfBSomqK5cl7X2UEXz661iMtr
         Di2Uac2PZ4dTYnEwWHihzX8bGD46AJ7MUfyDuFcH3PZnkW5xvW9KET1LpXbjG0Z77TdK
         Vr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=f5Lu74gpOrs6qGI6Fs9nfMmPReerN76GXNg46dKmfYkPy1h2v2T0WaPIeGheRoUCWn
         NJYiejEgvBmVECWtRo/eVHCR9HrgMsG8et5h+UlAoqbRisfqbzlb5SanaFJ7491psNJL
         p1FQhtch2nQYRsHIfKOsUkwqQB41EsAvKn2QBFO/V2r6Efeo7CZqJ2RptADCg18Qk3UI
         2Uqwv/3629G3h/CUybhLHxFJ4lJ/uscn6ufvxN3VqmnX/AXHqKkC/wp16KlG9NRXIs+w
         CjtFbSixRbstiCJrGb+MNrH3vbHnfWs/yRP6p8Yiq51buMoUxkwgudB2QALP2pt+5LQc
         YX3A==
X-Gm-Message-State: AJcUukd/fYyTzDaJ0fMjLzWXK0mGt3XcSEPu7Yi3LD/VNi2PL1Jiqfxx
        SAyAFuQkSR4uYoG5frlI0ydOqHoB
X-Google-Smtp-Source: ALg8bN4/ilj3ThHbTFgFE2wB9A+uBh8+TbaZyr+Iw9iqlnqokWGTXnc4RVT1/omQ72G53bL8Fiy0XQ==
X-Received: by 2002:a17:906:b292:: with SMTP id q18mr22412608ejz.184.1548771573949;
        Tue, 29 Jan 2019 06:19:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16sm3044355ejb.65.2019.01.29.06.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:33 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:33 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:13 GMT
Message-Id: <7a5caa2e0f9b38edb6bdcb24da8fe19c2ef373f4.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 14/21] tests: avoid calling Perl just to determine file
 sizes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is a bit ridiculous to spin up a full-blown Perl instance (especially
on Windows, where that means spinning up a full POSIX emulation layer,
AKA the MSYS2 runtime) just to tell how large a given file is.

So let's just use the test-tool to do that job instead.

This command will also be used over the next commits, to allow for
cutting out individual test cases' verbose log from the file generated
via --verbose-log.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-path-utils.c          | 12 ++++++++++++
 t/t0021-conversion.sh               |  2 +-
 t/t1050-large.sh                    |  2 +-
 t/t5315-pack-objects-compression.sh |  2 +-
 t/t9303-fast-import-compression.sh  |  2 +-
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index ae091d9b3e..30211d6d64 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -291,6 +291,18 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
+	if (argc > 2 && !strcmp(argv[1], "file-size")) {
+		int res = 0, i;
+		struct stat st;
+
+		for (i = 2; i < argc; i++)
+			if (stat(argv[i], &st))
+				res = error_errno("Cannot stat '%s'", argv[i]);
+			else
+				printf("%"PRIuMAX"\n", (uintmax_t)st.st_size);
+		return !!res;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index fd5f1ac649..e10f5f787f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -24,7 +24,7 @@ generate_random_characters () {
 }
 
 file_size () {
-	perl -e 'print -s $ARGV[0]' "$1"
+	test-tool path-utils file-size "$1"
 }
 
 filter_git () {
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 1a9b21b293..dcb4dbba67 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -8,7 +8,7 @@ test_description='adding and checking out large blobs'
 # This should be moved to test-lib.sh together with the
 # copy in t0021 after both topics have graduated to 'master'.
 file_size () {
-	perl -e 'print -s $ARGV[0]' "$1"
+	test-tool path-utils file-size "$1"
 }
 
 test_expect_success setup '
diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index 34c47dae09..df970d7584 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -7,7 +7,7 @@ test_description='pack-object compression configuration'
 # This should be moved to test-lib.sh together with the
 # copy in t0021 after both topics have graduated to 'master'.
 file_size () {
-	perl -e 'print -s $ARGV[0]' "$1"
+	test-tool path-utils file-size "$1"
 }
 
 test_expect_success setup '
diff --git a/t/t9303-fast-import-compression.sh b/t/t9303-fast-import-compression.sh
index 856219f46a..5045f02a53 100755
--- a/t/t9303-fast-import-compression.sh
+++ b/t/t9303-fast-import-compression.sh
@@ -6,7 +6,7 @@ test_description='compression setting of fast-import utility'
 # This should be moved to test-lib.sh together with the
 # copy in t0021 after both topics have graduated to 'master'.
 file_size () {
-	perl -e 'print -s $ARGV[0]' "$1"
+	test-tool path-utils file-size "$1"
 }
 
 import_large () {
-- 
gitgitgadget

