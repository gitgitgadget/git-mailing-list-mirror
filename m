Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF81C1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfA0X1N (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41672 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA0X1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so11582198edc.8
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=bRNJMImM1ImOwOyBfAtb5XNAY9IAIU2y7JPIfgnub/Zdrao64eFTkd5RIN3G/33S5O
         F8mbDY5xiUhLXzxnpUiyQZdtanMaToG3VfcO5XVSNzEwo3KVwrcKxhkHWrm5Xft7qWTA
         p3zCIllr8NpiLYtXWhYnlVJPQZEfwxWbhSF+e9rQj8njfghR2YKJ1EcC4W/E3KP7ZKfu
         L/wU3xmHcVFbumRxzgp4ca5Qwjdt3Xf1FSQL7hBF9SwKKrRNSwz/q4KOQWveBemFmcFG
         DFs+zoIUo1BiaF48a+dsrGfi6PeXfhsfyuwUI0MLxkUOOcgzJDEL2gA6xABYyaOBSJn3
         0ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qFU9SlpnDsxWdLk7t1RD4T2tVhhrbl/R3qfgIkC/7lI=;
        b=MIpmesY2kcxya7cuu5EoG/wR2IQ41DxVskxK0ZedHRkB42iYkfcpfeZNFweNjpiCQE
         XmRiIjhhHOjv4BeXHPhFXXsB6aYMgLUV+ywdmFEC+3byBGeZ6vs+lvdyMWugdE+PAIZm
         ZDL+9PJQrHyeNzvAbnMUVqbxOQD+7tgYkXQJptG0+t8ibHJoB6ej2fDQ7Pn45QoRemm2
         tmu5/XXJrxf8PgqvCV4ndrWXj2wlisKVFrQZUQn8NiZXZW8U2jxQWCDkSnWAw8L/6ilR
         b5Gc3ywn5DltB5CC6gIqjCC/xgXzF7qFKzciKLRliD+SiyWKd/L7EXbjMGy9O/9QTMcs
         UStg==
X-Gm-Message-State: AJcUukcrH6MhImJoeQTQW1vEpB650YD0GyuKiEu2zc9GBCyYFobGrtjq
        fPPrwsd/FODcYygBjiuGsC8nd82W
X-Google-Smtp-Source: AHgI3IZ0sTV9VoHCevLlVtyGjk4GZ8e0HjXQBmj4OwhHuejKAtUPYdsMnNE3pZP6OWB5tGf4XNIFEw==
X-Received: by 2002:a17:906:b3c9:: with SMTP id cg9mr1075629ejb.159.1548631621351;
        Sun, 27 Jan 2019 15:27:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z40sm13397797edz.86.2019.01.27.15.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:00 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:00 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:40 GMT
Message-Id: <4303bbd4e816a110c18ed29e8ec371ae50afaeba.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 14/21] tests: avoid calling Perl just to determine file
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

