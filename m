Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC311F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAWOk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:29 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37280 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfAWOk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:27 -0500
Received: by mail-ed1-f50.google.com with SMTP id h15so1880525edb.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=LS2nl8XhZuSt04amVh11fNE6ktVe4idpSWO/2WSZgy1bYVmnmnHV2Tv5LAuQdUWTjk
         sZITMeMUX6fdgzNG3/bESGht0hofhBuvmQZyRZq4yWbhMQeETFT1KfghiWTkBMj+sNef
         LvUoBCYc8uiBzxCySfUwExuz3snrB9KGFzN1GJyg+Rjt9K+g3RO8bDvUsWg7Fhi3qfMC
         /RfLB95N8848Ws/0NU8Wo7Myf87aS3/vPSsaRWMq9UgbgA4d5hTkYW1xbxzck8XuOTCh
         2TcRHQpZB8JywU5ksnQA+PY5UFxBY5O5M1OcMAV7pLOufXmHCKUNmOeDQOlHDX/ZWxnz
         j2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=JEU614/rzZq49HZ6k6asP6DUbA5v/kC8gXVlrcU5g8AGbPS+0WRCrGMGZz4tQ2HlHW
         Ui3uecaE3V2KKu662bGimomvdKvjwL9m4N+Wgu3tO7fj5JJZOKhXLU3WmIBA8iZF1l85
         1WrXdpA3p/5m26lEXmqqwvRNnjBd4jCGmg+fCnzKjZwIz0msVFqcRGpDbbqDSG1XD7+P
         feJ+7ka2SZgCBMTt29yd+Ql9C6POqcOglrsscl4vCp6DCkXeR+FPjA7pk5MHhdJ4/xZH
         zLJMGbabAbDO4OlQIIY38EC9Bcm2jhzTe7R96VsFDU89iEMGXA9Z3lPEd4KRAUsuTTvS
         IkjQ==
X-Gm-Message-State: AJcUukf1gPtsvSYMtJRWSmsar29SdIn9rzNmbALDxYyns/ObUm/y11H2
        jPCcCxq/OtTGm1rk6iE1cOcn6SxJ
X-Google-Smtp-Source: ALg8bN5zeOQtx3ghlEXzx64BcVecsRsP5NAQoyCGasyrW1SJlBfPxnIbvfPQD67W6LArQhrLOrJdlA==
X-Received: by 2002:a50:9063:: with SMTP id z32mr2984330edz.133.1548254425909;
        Wed, 23 Jan 2019 06:40:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-v6sm5527651ejx.57.2019.01.23.06.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:25 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:25 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:05 GMT
Message-Id: <3083041e33a3b0c63af621e9b6bc704e288c401f.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 14/21] tests: avoid calling Perl just to determine file
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

