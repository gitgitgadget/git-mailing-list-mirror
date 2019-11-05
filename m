Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3919D1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbfKERHo (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:44 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40380 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbfKERHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:43 -0500
Received: by mail-wr1-f52.google.com with SMTP id i10so1619707wrs.7
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DHULzxZP2V7GdewIpMWb5iqsCv321Bcc37PLGegbMtg=;
        b=eN9r4Sd9KFt8ItzZ5bJk8GqjmEKweL6lCo5oykXehsNW3mEKvLy2trA6sKoT+yEroU
         g1U2H2wEPNle1LEbN2Xl+2LAzjjboE7oDp5Kcszu4Fec8EkfNH/splpeUncyHgHWrUoq
         SfL9cfe8dOguwLASMz8KNqiTb8fBUcpSl5/rnz779h+36OvTWpAAHe/xY57BtKKQ83R6
         EzHnF+25ggk31EMi1zDP52kTpCHaQga61m5T2HNghG4IUXOmxcQCBthGhxHi85APni6N
         MKMkeaOeexrHchKdI+cRVCoya8NQedN7KQcm6W4PO9LKtGgHhVRoRjfYJOyFHNDwvSyZ
         ZCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DHULzxZP2V7GdewIpMWb5iqsCv321Bcc37PLGegbMtg=;
        b=ukGZoiZUaeE7b+TYHCwrowwenIEOWe39Cie1VL5bYYYl1YQvFEHjtcSx9pxDaO2YQB
         TYugKMYey7bOn+gFyMfRgWFenlCTpSOHEQiWPMHITmyg8GmHqHoY4/LZYKiDDnmZQrEW
         UtPMgfVJEYBcZMg7Ayq5Z4J2iiPFRVmvpurVvLxaQjklnb9Q6mgDoQdwKmEhzDuMVjp3
         wmqh1qPEJFaJmjjT6O2p38jxr8XqR43kdZvLaxqPcOnlgLNsPYHZ19ONQt4nSuLfPXcP
         hCqtWs1mcDVV4YlWFz/0A1uVqzhj8MB8d72sWAF46t2jJpwhDQ7M61lIk7JH4v9eQvSU
         hTDw==
X-Gm-Message-State: APjAAAUsAnnBRs2ZiedG93n21DObYZppXx9ELN/phKddZxhlFH0vlBj5
        57lARLTx+DVZH9bG/wnPYL0Bj78r
X-Google-Smtp-Source: APXvYqxlD4HZpHwRWsIxvERUhqXVExoyYth5zAONRjerkrbckNkChaKwAq3W8AbbjqnsF1dXuZjsfA==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr19952915wru.251.1572973659659;
        Tue, 05 Nov 2019 09:07:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm11718141wrq.72.2019.11.05.09.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:39 -0800 (PST)
Message-Id: <a2e17dbc92a037b9bb21de8bc26dfbe8fbeaa763.1572973653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:25 +0000
Subject: [PATCH v2 06/11] Fix spelling errors in names of tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1050-large.sh                 |  6 +++---
 t/t4041-diff-submodule-option.sh | 20 ++++++++++----------
 t/t4057-diff-combined-paths.sh   |  2 +-
 t/t4205-log-pretty-formats.sh    |  2 +-
 t/t5535-fetch-push-symref.sh     |  2 +-
 t/t5702-protocol-v2.sh           |  6 +++---
 t/t7004-tag.sh                   |  2 +-
 t/t7508-status.sh                |  2 +-
 t/t7513-interpret-trailers.sh    |  2 +-
 t/t9001-send-email.sh            |  2 +-
 t/t9301-fast-import-notes.sh     |  2 +-
 t/t9902-completion.sh            |  4 ++--
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index dcb4dbba67..d3b2adb28b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -194,15 +194,15 @@ test_expect_success 'pack-objects with large loose object' '
 	test_cmp huge actual
 '
 
-test_expect_success 'tar achiving' '
+test_expect_success 'tar archiving' '
 	git archive --format=tar HEAD >/dev/null
 '
 
-test_expect_success 'zip achiving, store only' '
+test_expect_success 'zip archiving, store only' '
 	git archive --format=zip -0 HEAD >/dev/null
 '
 
-test_expect_success 'zip achiving, deflate' '
+test_expect_success 'zip archiving, deflate' '
 	git archive --format=zip HEAD >/dev/null
 '
 
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 619bf97098..f852136585 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -284,7 +284,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
 	test_must_be_empty actual
 '
 
-test_expect_success 'submodule contains untracked and modifed content' '
+test_expect_success 'submodule contains untracked and modified content' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -294,7 +294,7 @@ test_expect_success 'submodule contains untracked and modifed content' '
 	test_cmp expected actual
 '
 
-test_expect_success 'submodule contains untracked and modifed content (untracked ignored)' '
+test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -303,19 +303,19 @@ test_expect_success 'submodule contains untracked and modifed content (untracked
 	test_cmp expected actual
 '
 
-test_expect_success 'submodule contains untracked and modifed content (dirty ignored)' '
+test_expect_success 'submodule contains untracked and modified content (dirty ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'submodule contains untracked and modifed content (all ignored)' '
+test_expect_success 'submodule contains untracked and modified content (all ignored)' '
 	echo new > sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'submodule contains modifed content' '
+test_expect_success 'submodule contains modified content' '
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -369,7 +369,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
 	test_must_be_empty actual
 '
 
-test_expect_success 'modified submodule contains untracked and modifed content' '
+test_expect_success 'modified submodule contains untracked and modified content' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -381,7 +381,7 @@ test_expect_success 'modified submodule contains untracked and modifed content'
 	test_cmp expected actual
 '
 
-test_expect_success 'modified submodule contains untracked and modifed content (untracked ignored)' '
+test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -392,7 +392,7 @@ test_expect_success 'modified submodule contains untracked and modifed content (
 	test_cmp expected actual
 '
 
-test_expect_success 'modified submodule contains untracked and modifed content (dirty ignored)' '
+test_expect_success 'modified submodule contains untracked and modified content (dirty ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules=dirty --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
@@ -402,13 +402,13 @@ test_expect_success 'modified submodule contains untracked and modifed content (
 	test_cmp expected actual
 '
 
-test_expect_success 'modified submodule contains untracked and modifed content (all ignored)' '
+test_expect_success 'modified submodule contains untracked and modified content (all ignored)' '
 	echo modification >> sm1/foo6 &&
 	git diff-index -p --ignore-submodules --submodule=log HEAD >actual &&
 	test_must_be_empty actual
 '
 
-test_expect_success 'modified submodule contains modifed content' '
+test_expect_success 'modified submodule contains modified content' '
 	rm -f sm1/new-file &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
diff --git a/t/t4057-diff-combined-paths.sh b/t/t4057-diff-combined-paths.sh
index dff36b77ec..4f4b541658 100755
--- a/t/t4057-diff-combined-paths.sh
+++ b/t/t4057-diff-combined-paths.sh
@@ -33,7 +33,7 @@ test_expect_success 'trivial merge - combine-diff empty' '
 '
 
 
-test_expect_success 'only one trully conflicting path' '
+test_expect_success 'only one truly conflicting path' '
 	git checkout side &&
 	for i in $(test_seq 2 9)
 	do
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f42a69faa2..2f251b27d0 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -640,7 +640,7 @@ test_expect_success 'pretty format %(trailers:key=foo) multiple keys' '
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:key=nonexistant) becomes empty' '
+test_expect_success '%(trailers:key=nonexistent) becomes empty' '
 	git log --no-walk --pretty="x%(trailers:key=Nacked-by)x" >actual &&
 	echo "xx" >expect &&
 	test_cmp expect actual
diff --git a/t/t5535-fetch-push-symref.sh b/t/t5535-fetch-push-symref.sh
index 8ed58d27f2..e8f6d233ff 100755
--- a/t/t5535-fetch-push-symref.sh
+++ b/t/t5535-fetch-push-symref.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='avoiding conflicting update thru symref aliasing'
+test_description='avoiding conflicting update through symref aliasing'
 
 . ./test-lib.sh
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 96f58e40b6..e73067d23f 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -32,7 +32,7 @@ test_expect_success 'list refs with git:// using protocol v2' '
 	test_cmp expect actual
 '
 
-test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+test_expect_success 'ref advertisement is filtered with ls-remote using protocol v2' '
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
@@ -154,7 +154,7 @@ test_expect_success 'list refs with file:// using protocol v2' '
 	test_cmp expect actual
 '
 
-test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+test_expect_success 'ref advertisement is filtered with ls-remote using protocol v2' '
 	test_when_finished "rm -f log" &&
 
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
@@ -225,7 +225,7 @@ test_expect_success 'fetch with file:// using protocol v2' '
 	grep "fetch< version 2" log
 '
 
-test_expect_success 'ref advertisment is filtered during fetch using protocol v2' '
+test_expect_success 'ref advertisement is filtered during fetch using protocol v2' '
 	test_when_finished "rm -f log" &&
 
 	test_commit -C file_parent three &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 80eb13d94e..bc4da011f7 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1420,7 +1420,7 @@ test_expect_success \
 get_tag_header reuse $commit commit $time >expect
 echo "An annotation to be reused" >> expect
 test_expect_success \
-	'overwriting an annoted tag should use its previous body' '
+	'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
 	GIT_EDITOR=true git tag -f -a reuse &&
 	get_tag_msg reuse >actual &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 4e676cdce8..482ce3510e 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1571,7 +1571,7 @@ test_expect_success '"status.showStash=true" weaker than "--no-show-stash"' '
 	test_cmp expected_without_stash actual
 '
 
-test_expect_success 'no additionnal info if no stash entries' '
+test_expect_success 'no additional info if no stash entries' '
 	git stash clear &&
 	git -c status.showStash=true status >actual &&
 	test_cmp expected_without_stash actual
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index f19202b509..6602790b5f 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1234,7 +1234,7 @@ test_expect_success 'with simple command' '
 	test_cmp expected actual
 '
 
-test_expect_success 'with command using commiter information' '
+test_expect_success 'with command using committer information' '
 	git config trailer.sign.ifExists "addIfDifferent" &&
 	git config trailer.sign.command "echo \"\$GIT_COMMITTER_NAME <\$GIT_COMMITTER_EMAIL>\"" &&
 	cat complex_message_body >expected &&
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 997f90b42b..bd94779611 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1260,7 +1260,7 @@ test_expect_success $PREREQ 'sendemail.identity: --no-identity clears previous i
 	grep "To: default@example.com" stdout
 '
 
-test_expect_success $PREREQ 'sendemail.identity: bool identity variable existance overrides' '
+test_expect_success $PREREQ 'sendemail.identity: bool identity variable existence overrides' '
 	git -c sendemail.identity=cloud \
 		-c sendemail.xmailer=true \
 		-c sendemail.cloud.xmailer=false \
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index dadc70b7d5..ca223dca98 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -275,7 +275,7 @@ $whitespace
     third note for first commit
 EXPECT_END
 
-test_expect_success 'add concatentation notes with M command' '
+test_expect_success 'add concatenation notes with M command' '
 
 	git fast-import <input &&
 	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e4af70aff1..53dc785a64 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -378,7 +378,7 @@ test_expect_success '__gitdir - finds repo' '
 '
 
 
-test_expect_success '__gitdir - returns error when cant find repo' '
+test_expect_success '__gitdir - returns error when cannot find repo' '
 	(
 		__git_dir="non-existing" &&
 		test_must_fail __gitdir >"$actual"
@@ -945,7 +945,7 @@ test_expect_success 'setup for filtering matching refs' '
 	rm -f .git/FETCH_HEAD
 '
 
-test_expect_success '__git_refs - dont filter refs unless told so' '
+test_expect_success '__git_refs - do not filter refs unless told so' '
 	cat >expected <<-EOF &&
 	HEAD
 	master
-- 
gitgitgadget

