Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671A720248
	for <e@80x24.org>; Wed, 17 Apr 2019 10:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfDQKZA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 06:25:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfDQKZA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 06:25:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so2914394wmf.2
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Bn8k5sT0dzNeTcFoUwRkAT7Kq6lFf6N9WqZnNO/8E2g=;
        b=ovHkYaNoIryBJBqO7/iz/cd/oM51A4BEL5HwHJSjSMziSOoGYn86l+PMYaflU54ciV
         dNR2NMTMY59+bgYQE1sJzg872zA1b2S+NFC6uDUMH9hKp//0OAPYcnf6HkJCy4K01/dV
         wk1Wd930mnL0E5Z4RkuqmvnpWtMPun+LM1Wb6ijmNnvPDEWI5lCIWapwen4hOUzjU3H1
         V/ml5iDfGRgGVyxXdZJC+UEXX8ZvvgySSHWDiNquff2Q5qUBRvwMOFEt05w+xr588k9Q
         rKe1+tHA5LiPXt7fe9D082h9CZCxSFxaaXE8uhDR9xdglvOHfObJWUvDNVhcgGNj4LnS
         1a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Bn8k5sT0dzNeTcFoUwRkAT7Kq6lFf6N9WqZnNO/8E2g=;
        b=R9FJV2zy4ZxRwmg8qHYfl9e9nwMOJtIcFpx42XRxnn0NupXSzqQ/9L/KWJmJnavYbG
         cwrczNaissgYfUFh8JMQEyYGq5yLOyMG4VB5oE0gIMTwU9rvrJa6WdXjQ1YTVsoBWuJ5
         2djbDMcgxcbIt0t50KXwcFqNbu306+T+NSzruscGv0xUD+kLwt2jFL4sV6isdfcewZeZ
         cZqHnQpu446+F4FdQTqvkldmB/KFnMBs7G1ln5iK2lgHyQzgUM7QTmZRRwIiCmzgugnQ
         XAjOwoPeuIFXovdNmwyvnWbLDR8ikrTPqSXA3eKcQ1gStk+AIQID7Mnnci0q2E2O7euU
         p4Lw==
X-Gm-Message-State: APjAAAWEn6IoEAniutBFsM2Q0TWnFxQkDs4ixQrPkgwb99kpd3Wg1eKf
        fCNMTuFTGv1m6jB5dFS1F+E=
X-Google-Smtp-Source: APXvYqwEPw4GqgniWsDKflMOsRQz+VGEr9VznB7h0mthIMM4YOW6lzb0ysoNf/ybMt8iuuaYGdBjsA==
X-Received: by 2002:a1c:9691:: with SMTP id y139mr30468402wmd.64.1555496698124;
        Wed, 17 Apr 2019 03:24:58 -0700 (PDT)
Received: from lindisfarne.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id a11sm53399903wrx.5.2019.04.17.03.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 03:24:57 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v10 04/10] t7502: clean up style
Date:   Wed, 17 Apr 2019 11:23:24 +0100
Message-Id: <20190417102330.24434-5-phillip.wood123@gmail.com>
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

Refactor out Git commands that were upstream of a pipe. Remove spaces
after "> ". Indent here-docs appropriately. Convert echo chains to use
the test_write_lines function. Refactor 'sign off' test to use test_cmp
instead of comparing variables.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7502-commit-porcelain.sh | 93 +++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index ca4a740da0..5733d9cd34 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -16,7 +16,8 @@ commit_msg_is () {
 # Arguments: [<prefix] [<commit message>] [<commit options>]
 check_summary_oneline() {
 	test_tick &&
-	git commit ${3+"$3"} -m "$2" | head -1 > act &&
+	git commit ${3+"$3"} -m "$2" >raw &&
+	head -n 1 raw >act &&
 
 	# branch name
 	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
@@ -68,7 +69,7 @@ test_expect_success 'output summary format for merges' '
 	git checkout recursive-a &&
 	test_must_fail git merge recursive-b &&
 	# resolve the conflict
-	echo commit-a > file1 &&
+	echo commit-a >file1 &&
 	git add file1 &&
 	check_summary_oneline "" "Merge"
 '
@@ -142,9 +143,11 @@ test_expect_success 'sign off' '
 	>positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
-	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
-	test "z$actual" = "z$expected"
+	git cat-file commit HEAD >commit.msg &&
+	sed -ne "s/Signed-off-by: //p" commit.msg >actual &&
+	git var GIT_COMMITTER_IDENT >ident &&
+	sed -e "s/>.*/>/" ident >expected &&
+	test_cmp expected actual
 
 '
 
@@ -153,8 +156,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
-	expected=$(echo one; echo; echo two; echo; echo three) &&
+	actual=$(git cat-file commit HEAD >tmp && sed -e "1,/^\$/d" tmp && rm tmp) &&
+	expected=$(test_write_lines "one" "" "two" "" "three") &&
 	test "z$actual" = "z$expected"
 
 '
@@ -163,7 +166,8 @@ test_expect_success 'verbose' '
 
 	echo minus >negative &&
 	git add negative &&
-	git status -v | sed -ne "/^diff --git /p" >actual &&
+	git status -v >raw &&
+	sed -ne "/^diff --git /p" raw >actual &&
 	echo "diff --git a/negative b/negative" >expect &&
 	test_cmp expect actual
 
@@ -189,7 +193,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim --no-status -t expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -198,7 +203,8 @@ test_expect_success 'cleanup commit messages (verbatim option,-F)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -F expect -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -207,75 +213,80 @@ test_expect_success 'cleanup commit messages (verbatim option,-m)' '
 
 	echo >>negative &&
 	git commit --cleanup=verbatim -m "$mesg_with_comment_and_newlines" -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
 
 test_expect_success 'cleanup commit messages (whitespace option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo; } >text &&
+	test_write_lines "" "# text" "" >text &&
 	echo "# text" >expect &&
 	git commit --cleanup=whitespace -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
 
 test_expect_success 'cleanup commit messages (scissors option,-F,-e)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
+	cat >text <<-\EOF &&
 
-# to be kept
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-# ------------------------ >8 ------------------------
-to be removed
-# ------------------------ >8 ------------------------
-to be removed, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	# ------------------------ >8 ------------------------
+	to be removed
+	# ------------------------ >8 ------------------------
+	to be removed, too
+	EOF
 
-	cat >expect <<EOF &&
-# to be kept
+	cat >expect <<-\EOF &&
+	# to be kept
 
-  # ------------------------ >8 ------------------------
-# to be kept, too
-EOF
+	  # ------------------------ >8 ------------------------
+	# to be kept, too
+	EOF
 	git commit --cleanup=scissors -e -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'cleanup commit messages (scissors option,-F,-e, scissors on first line)' '
 
 	echo >>negative &&
-	cat >text <<EOF &&
-# ------------------------ >8 ------------------------
-to be removed
-EOF
+	cat >text <<-\EOF &&
+	# ------------------------ >8 ------------------------
+	to be removed
+	EOF
 	git commit --cleanup=scissors -e -F text -a --allow-empty-message &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_must_be_empty actual
 '
 
 test_expect_success 'cleanup commit messages (strip option,-F)' '
 
 	echo >>negative &&
-	{ echo;echo "# text";echo sample;echo; } >text &&
+	test_write_lines "" "# text" "sample" "" >text &&
 	echo sample >expect &&
 	git commit --cleanup=strip -F text -a &&
-	git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&
+	git cat-file -p HEAD >raw &&
+	sed -e "1,/^\$/d" raw >actual &&
 	test_cmp expect actual
 
 '
 
 test_expect_success 'cleanup commit messages (strip option,-F,-e)' '
 
 	echo >>negative &&
-	{ echo;echo sample;echo; } >text &&
+	test_write_lines "" "sample" "" >text &&
 	git commit -e -F text -a &&
 	head -n 4 .git/COMMIT_EDITMSG >actual
 '
@@ -387,7 +398,7 @@ test_expect_success AUTOIDENT 'message shows committer when it is automatic' '
 '
 
 write_script .git/FAKE_EDITOR <<EOF
-echo editor started > "$(pwd)/.git/result"
+echo editor started >"$(pwd)/.git/result"
 exit 0
 EOF
 
@@ -455,7 +466,7 @@ EOF
 test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	echo >>negative &&
 	! "$SHELL_PATH" -c '\''
-	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  echo kill -TERM $$ >>.git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git commit -a'\'' &&
@@ -471,7 +482,8 @@ test_expect_success 'Hand committing of a redundant merge removes dups' '
 	test_must_fail git merge second master &&
 	git checkout master g &&
 	EDITOR=: git commit -a &&
-	git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/q" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -n -e "s/^parent //p" -e "/^$/q" raw >actual &&
 	test_cmp expect actual
 
 '
@@ -480,7 +492,8 @@ test_expect_success 'A single-liner subject with a token plus colon is not a foo
 
 	git reset --hard &&
 	git commit -s -m "hello: kitty" --allow-empty &&
-	git cat-file commit HEAD | sed -e "1,/^$/d" >actual &&
+	git cat-file commit HEAD >raw &&
+	sed -e "1,/^$/d" raw >actual &&
 	test_line_count = 3 actual
 
 '
-- 
2.21.0

