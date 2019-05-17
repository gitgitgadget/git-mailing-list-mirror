Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7EC1F461
	for <e@80x24.org>; Fri, 17 May 2019 00:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEQA1p (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:27:45 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44117 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEQA1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:27:45 -0400
Received: by mail-io1-f66.google.com with SMTP id f22so4071781iol.11
        for <git@vger.kernel.org>; Thu, 16 May 2019 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B6y3JbC+8GI3yBYgmkZrXfj27vjNdfGLt2/pFiPw6Gk=;
        b=TEKHAjp0oqDHeTQ9EckGBc4maCd8Kyy1ZXiNDQg4MqAIzIvfYq6OCILc3t2Is+mnrZ
         hYXSoCzhHtTZyd205579sWvOaUkvGI3lFpEORk7Jc1H9zTgzgpKgAfrZT+AiqGH2tWEf
         qTNAQexZxoLgaSPRLPqDv+vCtElp1CjWjg8BeIqvWGBJtK4tHfQZPinT2EJGa4XBbXS+
         tPZVMvhFmkBS4OTNPAp35fN3XJATxixnbSpNZwefvrp0BdSmSUT2faMhyJfsy2WGh1WR
         LQKTMuO6L6scW2ARULNjTHMJ89rX/DABCeqDXyXAkY1fHyNfSZwitNQYiHKFIT1K88s8
         1azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B6y3JbC+8GI3yBYgmkZrXfj27vjNdfGLt2/pFiPw6Gk=;
        b=qK61j3F7zcOJ9XNmwJGVwDvD39QfJcbwV/Gjas48rXNA9jz2I1FYu76LTKXDtOknG7
         HHedzr815KyKTFDFhxLsXWfbQAnZ99aQ7We9kex28D/LUHpnxgSNI17rEM0OxWKxb7+V
         U+DSQ4cHm0YauyCQ7ZQOMIQryFgjQuF5SUVXVnaLwQrSRKJymAb54DYWWJQ8XlH6bDvR
         biJ886XLSd7Sl6DTC0tiKizC/mIrApdczhqVbwihUrB9Yflc4X75C7KviVAE7ylMuyJy
         uCLV7pVRb0hHl0cd6oyD6ASK72oCxIW8FAiXOGVjVCEqNhlsLMEi6AX/9cIJGi42/Pw5
         2QgQ==
X-Gm-Message-State: APjAAAV71hCjoN0AN3Oh44w9n2l9WtFD66tv4QFAcL8qjJxf7nI8flAh
        vngjDI+bCV7WRZeafy+yL1r0/+cv
X-Google-Smtp-Source: APXvYqyHxePNLQFyeIBtbXy8E7zNyWUXZn0FDTtx1b7IE8Rlp+lXk+Z2UEFUQ0RAFEcePdJLluP1TQ==
X-Received: by 2002:a5d:9947:: with SMTP id v7mr6198294ios.25.1558052863032;
        Thu, 16 May 2019 17:27:43 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id w139sm1803551ita.43.2019.05.16.17.27.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 17:27:42 -0700 (PDT)
Date:   Thu, 16 May 2019 20:27:40 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] t4014: clean up style
Message-ID: <4ca24ea17652fbd3dd3b960cb4c3e03abf9689b5.1558052674.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <cover.1558052674.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git's tests, there is typically no space between the redirection
operator and the filename. Remove these spaces.

Since output is silenced when running without `-v` and debugging
output is useful with `-v`, remove redirections to /dev/null.

Change here-docs from `<<\EOF` to `<<-\EOF` so that they can be indented
along with the rest of the test case.

Finally, refactor to remove Git commands upstream of pipe. This way, if
an invocation of a Git command fails, the return code won't be lost.
Keep upstream non-Git commands since we have to assume a base level of
sanity.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 614 +++++++++++++++++++++-------------------
 1 file changed, 319 insertions(+), 295 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b6e2fdbc44..3423f974bc 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -34,7 +34,8 @@ test_expect_success setup '
 	git commit -m "Side changes #3 with \\n backslash-n in it." &&
 
 	git checkout master &&
-	git diff-tree -p C2 | git apply --index &&
+	git diff-tree -p C2 >patch &&
+	git apply --index <patch &&
 	test_tick &&
 	git commit -m "Master accepts moral equivalent of #2"
 
@@ -77,7 +78,7 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	git checkout -b merger master &&
 	test_tick &&
 	git merge --no-ff slave &&
-	cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
+	cnt=$(git format-patch -3 --stdout >patch && grep "^From " patch | wc -l) &&
 	test $cnt = 3
 '
 
@@ -85,21 +86,22 @@ test_expect_success "format-patch result applies" '
 
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success "format-patch --ignore-if-in-upstream result applies" '
 
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'commit did not screw up the log message' '
 
-	git cat-file commit side | grep "^Side .* with .* backslash-n"
+	git cat-file commit side >actual &&
+	grep "^Side .* with .* backslash-n" actual
 
 '
 
@@ -112,7 +114,8 @@ test_expect_success 'format-patch did not screw up the log message' '
 
 test_expect_success 'replay did not screw up the log message' '
 
-	git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n"
+	git cat-file commit rebuild-1 >actual &&
+	grep "^Side .* with .* backslash-n" actual
 
 '
 
@@ -122,8 +125,8 @@ test_expect_success 'extra headers' '
 " &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>
 " &&
-	git format-patch --stdout master..side > patch2 &&
-	sed -e "/^\$/q" patch2 > hdrs2 &&
+	git format-patch --stdout master..side >patch2 &&
+	sed -e "/^\$/q" patch2 >hdrs2 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs2 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs2
 
@@ -134,7 +137,7 @@ test_expect_success 'extra headers without newlines' '
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "Cc: S E Cipient <scipient@example.com>" &&
 	git format-patch --stdout master..side >patch3 &&
-	sed -e "/^\$/q" patch3 > hdrs3 &&
+	sed -e "/^\$/q" patch3 >hdrs3 &&
 	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs3 &&
 	grep "^Cc: S E Cipient <scipient@example.com>\$" hdrs3
 
@@ -144,8 +147,8 @@ test_expect_success 'extra headers with multiple To:s' '
 
 	git config --replace-all format.headers "To: R E Cipient <rcipient@example.com>" &&
 	git config --add format.headers "To: S E Cipient <scipient@example.com>" &&
-	git format-patch --stdout master..side > patch4 &&
-	sed -e "/^\$/q" patch4 > hdrs4 &&
+	git format-patch --stdout master..side >patch4 &&
+	sed -e "/^\$/q" patch4 >hdrs4 &&
 	grep "^To: R E Cipient <rcipient@example.com>,\$" hdrs4 &&
 	grep "^ *S E Cipient <scipient@example.com>\$" hdrs4
 '
@@ -153,72 +156,82 @@ test_expect_success 'extra headers with multiple To:s' '
 test_expect_success 'additional command line cc (ascii)' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch5
+	git format-patch --cc="S E Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs5
 '
 
 test_expect_failure 'additional command line cc (rfc822)' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch5 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
+	git format-patch --cc="S. E. Cipient <scipient@example.com>" --stdout master..side >patch5 &&
+	sed -e "/^\$/q" patch5 >hdrs5 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs5 &&
+	grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" hdrs5
 '
 
 test_expect_success 'command line headers' '
 
 	git config --unset-all format.headers &&
-	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch6 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>\$" patch6
+	git format-patch --add-header="Cc: R E Cipient <rcipient@example.com>" --stdout master..side >patch6 &&
+	sed -e "/^\$/q" patch6 >hdrs6 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>\$" hdrs6
 '
 
 test_expect_success 'configuration headers and command line headers' '
 
 	git config --replace-all format.headers "Cc: R E Cipient <rcipient@example.com>" &&
-	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch7 &&
-	grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch7 &&
-	grep "^ *S E Cipient <scipient@example.com>\$" patch7
+	git format-patch --add-header="Cc: S E Cipient <scipient@example.com>" --stdout master..side >patch7 &&
+	sed -e "/^\$/q" patch7 >hdrs7 &&
+	grep "^Cc: R E Cipient <rcipient@example.com>,\$" hdrs7 &&
+	grep "^ *S E Cipient <scipient@example.com>\$" hdrs7
 '
 
 test_expect_success 'command line To: header (ascii)' '
 
 	git config --unset-all format.headers &&
-	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch8
+	git format-patch --to="R E Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc822)' '
 
-	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
+	git format-patch --to="R. E. Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_failure 'command line To: header (rfc2047)' '
 
-	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side | sed -e "/^\$/q" >patch8 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch8
+	git format-patch --to="R Ä Cipient <rcipient@example.com>" --stdout master..side >patch8 &&
+	sed -e "/^\$/q" patch8 >hdrs8 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs8
 '
 
 test_expect_success 'configuration To: header (ascii)' '
 
 	git config format.to "R E Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: R E Cipient <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc822)' '
 
 	git config format.to "R. E. Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs9
 '
 
 test_expect_failure 'configuration To: header (rfc2047)' '
 
 	git config format.to "R Ä Cipient <rcipient@example.com>" &&
-	git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" patch9
+	git format-patch --stdout master..side >patch9 &&
+	sed -e "/^\$/q" patch9 >hdrs9 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
 # check_patch <patch>: Verify that <patch> looks like a half-sane
@@ -231,52 +244,52 @@ check_patch () {
 
 test_expect_success 'format.from=false' '
 
-	git -c format.from=false format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
+	git -c format.from=false format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
 	check_patch patch &&
-	! grep "^From: C O Mitter <committer@example.com>\$" patch
+	! grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from=true' '
 
-	git -c format.from=true format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: C O Mitter <committer@example.com>\$" patch
+	git -c format.from=true format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: C O Mitter <committer@example.com>\$" hdrs
 '
 
 test_expect_success 'format.from with address' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-from overrides format.from' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --no-from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--from overrides format.from' '
 
-	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side |
-	sed -e "/^\$/q" >patch &&
-	check_patch patch &&
-	! grep "^From: F R Om <from@example.com>\$" patch
+	git -c format.from="F R Om <from@example.com>" format-patch --from --stdout master..side >patch &&
+	sed -e "/^\$/q" patch >hdrs &&
+	check_patch hdrs &&
+	! grep "^From: F R Om <from@example.com>\$" hdrs
 '
 
 test_expect_success '--no-to overrides config.to' '
 
 	git config --replace-all format.to \
 		"R E Cipient <rcipient@example.com>" &&
-	git format-patch --no-to --stdout master..side |
-	sed -e "/^\$/q" >patch10 &&
-	check_patch patch10 &&
-	! grep "^To: R E Cipient <rcipient@example.com>\$" patch10
+	git format-patch --no-to --stdout master..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	check_patch hdrs10 &&
+	! grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
 '
 
 test_expect_success '--no-to and --to replaces config.to' '
@@ -284,31 +297,31 @@ test_expect_success '--no-to and --to replaces config.to' '
 	git config --replace-all format.to \
 		"Someone <someone@out.there>" &&
 	git format-patch --no-to --to="Someone Else <else@out.there>" \
-		--stdout master..side |
-	sed -e "/^\$/q" >patch11 &&
-	check_patch patch11 &&
-	! grep "^To: Someone <someone@out.there>\$" patch11 &&
-	grep "^To: Someone Else <else@out.there>\$" patch11
+		--stdout master..side >patch11 &&
+	sed -e "/^\$/q" patch11 >hdrs11 &&
+	check_patch hdrs11 &&
+	! grep "^To: Someone <someone@out.there>\$" hdrs11 &&
+	grep "^To: Someone Else <else@out.there>\$" hdrs11
 '
 
 test_expect_success '--no-cc overrides config.cc' '
 
 	git config --replace-all format.cc \
 		"C E Cipient <rcipient@example.com>" &&
-	git format-patch --no-cc --stdout master..side |
-	sed -e "/^\$/q" >patch12 &&
-	check_patch patch12 &&
-	! grep "^Cc: C E Cipient <rcipient@example.com>\$" patch12
+	git format-patch --no-cc --stdout master..side >patch12 &&
+	sed -e "/^\$/q" patch12 >hdrs12 &&
+	check_patch hdrs12 &&
+	! grep "^Cc: C E Cipient <rcipient@example.com>\$" hdrs12
 '
 
 test_expect_success '--no-add-header overrides config.headers' '
 
 	git config --replace-all format.headers \
 		"Header1: B E Cipient <rcipient@example.com>" &&
-	git format-patch --no-add-header --stdout master..side |
-	sed -e "/^\$/q" >patch13 &&
-	check_patch patch13 &&
-	! grep "^Header1: B E Cipient <rcipient@example.com>\$" patch13
+	git format-patch --no-add-header --stdout master..side >patch13 &&
+	sed -e "/^\$/q" patch13 >hdrs13 &&
+	check_patch hdrs13 &&
+	! grep "^Header1: B E Cipient <rcipient@example.com>\$" hdrs13
 '
 
 test_expect_success 'multiple files' '
@@ -338,7 +351,7 @@ test_expect_success 'reroll count (-v)' '
 check_threading () {
 	expect="$1" &&
 	shift &&
-	(git format-patch --stdout "$@"; echo $? > status.out) |
+	(git format-patch --stdout "$@"; echo $? >status.out) |
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
 	perl -ne '
@@ -353,12 +366,12 @@ check_threading () {
 			print;
 		}
 		print "---\n" if /^From /i;
-	' > actual &&
+	' >actual &&
 	test 0 = "$(cat status.out)" &&
 	test_cmp "$expect" actual
 }
 
-cat >> expect.no-threading <<EOF
+cat >>expect.no-threading <<EOF
 ---
 ---
 ---
@@ -369,7 +382,7 @@ test_expect_success 'no threading' '
 	check_threading expect.no-threading master
 '
 
-cat > expect.thread <<EOF
+cat >expect.thread <<EOF
 ---
 Message-Id: <0>
 ---
@@ -386,7 +399,7 @@ test_expect_success 'thread' '
 	check_threading expect.thread --thread master
 '
 
-cat > expect.in-reply-to <<EOF
+cat >expect.in-reply-to <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -406,7 +419,7 @@ test_expect_success 'thread in-reply-to' '
 		--thread master
 '
 
-cat > expect.cover-letter <<EOF
+cat >expect.cover-letter <<EOF
 ---
 Message-Id: <0>
 ---
@@ -427,7 +440,7 @@ test_expect_success 'thread cover-letter' '
 	check_threading expect.cover-letter --cover-letter --thread master
 '
 
-cat > expect.cl-irt <<EOF
+cat >expect.cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -459,7 +472,7 @@ test_expect_success 'thread explicit shallow' '
 		--in-reply-to="<test.message>" --thread=shallow master
 '
 
-cat > expect.deep <<EOF
+cat >expect.deep <<EOF
 ---
 Message-Id: <0>
 ---
@@ -477,7 +490,7 @@ test_expect_success 'thread deep' '
 	check_threading expect.deep --thread=deep master
 '
 
-cat > expect.deep-irt <<EOF
+cat >expect.deep-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -500,7 +513,7 @@ test_expect_success 'thread deep in-reply-to' '
 		--in-reply-to="<test.message>" master
 '
 
-cat > expect.deep-cl <<EOF
+cat >expect.deep-cl <<EOF
 ---
 Message-Id: <0>
 ---
@@ -524,7 +537,7 @@ test_expect_success 'thread deep cover-letter' '
 	check_threading expect.deep-cl --cover-letter --thread=deep master
 '
 
-cat > expect.deep-cl-irt <<EOF
+cat >expect.deep-cl-irt <<EOF
 ---
 Message-Id: <0>
 In-Reply-To: <1>
@@ -606,7 +619,7 @@ test_expect_success 'cover-letter inherits diff options' '
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
   This is an excessively long subject line for a message due to the
     habit some projects have of not having a short, one-line subject at
     the start of the commit message, but rather sticking a whole
@@ -619,12 +632,12 @@ EOF
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^\$/q" < 0000-cover-letter.patch > output &&
+	sed -e "1,/A U Thor/d" -e "/^\$/q" <0000-cover-letter.patch >output &&
 	test_cmp expect output
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 index $before..$after 100644
 --- a/file
 +++ b/file
@@ -646,7 +659,7 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
-cat > expect << EOF
+cat >expect <<EOF
 
 diff --git a/file b/file
 index $before..$after 100644
@@ -662,7 +675,7 @@ EOF
 test_expect_success 'format-patch -p suppresses stat' '
 
 	git format-patch -p -2 &&
-	sed -e "1,/^\$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" <0001-This-is-an-excessively-long-subject-line-for-a-messa.patch >output &&
 	test_cmp expect output
 
 '
@@ -717,7 +730,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 '
 
 test_expect_success 'format-patch --in-reply-to' '
-	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" > patch8 &&
+	git format-patch -1 --stdout --in-reply-to "baz@foo.bar" >patch8 &&
 	grep "^In-Reply-To: <baz@foo.bar>" patch8 &&
 	grep "^References: <baz@foo.bar>" patch8
 '
@@ -738,20 +751,20 @@ test_expect_success 'format-patch --notes --signoff' '
 	sed "1,/^---$/d" out | grep "test message"
 '
 
-echo "fatal: --name-only does not make sense" > expect.name-only
-echo "fatal: --name-status does not make sense" > expect.name-status
-echo "fatal: --check does not make sense" > expect.check
+echo "fatal: --name-only does not make sense" >expect.name-only
+echo "fatal: --name-status does not make sense" >expect.name-status
+echo "fatal: --check does not make sense" >expect.check
 
 test_expect_success 'options no longer allowed for format-patch' '
-	test_must_fail git format-patch --name-only 2> output &&
+	test_must_fail git format-patch --name-only 2>output &&
 	test_i18ncmp expect.name-only output &&
-	test_must_fail git format-patch --name-status 2> output &&
+	test_must_fail git format-patch --name-status 2>output &&
 	test_i18ncmp expect.name-status output &&
-	test_must_fail git format-patch --check 2> output &&
+	test_must_fail git format-patch --check 2>output &&
 	test_i18ncmp expect.check output'
 
 test_expect_success 'format-patch --numstat should produce a patch' '
-	git format-patch --numstat --stdout master..side > output &&
+	git format-patch --numstat --stdout master..side >output &&
 	test 5 = $(grep "^diff --git a/" output | wc -l)'
 
 test_expect_success 'format-patch -- <path>' '
@@ -763,20 +776,22 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
-git_version="$(git --version | sed "s/.* //")"
+git_version="$(git --version >version && sed "s/.* //" version)"
 
 signature() {
 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
 }
 
 test_expect_success 'format-patch default signature' '
-	git format-patch --stdout -1 | tail -n 3 >output &&
+	git format-patch --stdout -1 >patch &&
+	tail -n 3 patch >output &&
 	signature >expect &&
 	test_cmp expect output
 '
 
 test_expect_success 'format-patch --signature' '
-	git format-patch --stdout --signature="my sig" -1 | tail -n 3 >output &&
+	git format-patch --stdout --signature="my sig" -1 >patch &&
+	tail -n 3 patch >output &&
 	signature "my sig" >expect &&
 	test_cmp expect output
 '
@@ -1167,282 +1182,282 @@ append_signoff()
 
 test_expect_success 'signoff: commit with no body' '
 	append_signoff </dev/null >actual &&
-	cat <<\EOF | sed "s/EOL$//" >expected &&
-4:Subject: [PATCH] EOL
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat <<-\EOF | sed "s/EOL$//" >expected &&
+	4:Subject: [PATCH] EOL
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: commit with only subject' '
 	echo subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: commit with only subject that does not end with NL' '
 	printf subject | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: no existing signoffs' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	body
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: no existing signoffs and no trailing NL' '
 	printf "subject\n\nbody" | append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: some random signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: my@house
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: misc conforming footer elements' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
-Tested-by: Some One <someone@example.com>
-Bug: 1234
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-15:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: my@house
+	(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+	Tested-by: Some One <someone@example.com>
+	Bug: 1234
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	15:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: some random signoff-alike' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-Fooled-by-me: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	body
+	Fooled-by-me: my@house
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: not really a signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-I want to mention about Signed-off-by: here.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:I want to mention about Signed-off-by: here.
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	I want to mention about Signed-off-by: here.
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:I want to mention about Signed-off-by: here.
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: not really a signoff (2)' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-My unfortunate
-Signed-off-by: example happens to be wrapped here.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:Signed-off-by: example happens to be wrapped here.
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	My unfortunate
+	Signed-off-by: example happens to be wrapped here.
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:Signed-off-by: example happens to be wrapped here.
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Signed-off-by: my@house
-Signed-off-by: your@house
+	Signed-off-by: my@house
+	Signed-off-by: your@house
 
-A lot of houses.
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: my@house
-10:Signed-off-by: your@house
-11:
-13:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	A lot of houses.
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: my@house
+	10:Signed-off-by: your@house
+	11:
+	13:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: the same signoff at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: the same signoff at the end, no trailing NL' '
 	printf "subject\n\nSigned-off-by: C O Mitter <committer@example.com>" |
 		append_signoff >actual &&
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: the same signoff NOT at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-Signed-off-by: my@house
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-12:Signed-off-by: my@house
-EOF
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: my@house
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	12:Signed-off-by: my@house
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: tolerate garbage in conforming footer' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Tested-by: my@house
-Some Trash
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-13:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Tested-by: my@house
+	Some Trash
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	13:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: respect trailer config' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual &&
 
 	test_config trailer.Myfooter.ifexists add &&
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
 test_expect_success 'signoff: footer begins with non-signoff without @ sign' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Reviewed-id: Noone
-Tested-by: my@house
-Change-id: Ideadbeef
-Signed-off-by: C O Mitter <committer@example.com>
-Bug: 1234
-EOF
-	cat >expected <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Reviewed-id: Noone
+	Tested-by: my@house
+	Change-id: Ideadbeef
+	Signed-off-by: C O Mitter <committer@example.com>
+	Bug: 1234
+	EOF
+	cat >expected <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expected actual
 '
 
@@ -1458,42 +1473,42 @@ test_expect_success 'cover letter using branch description (1)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (2)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (3)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (4)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter master.. >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (5)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 HEAD >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter using branch description (6)' '
 	git checkout rebuild-1 &&
 	test_config branch.rebuild-1.description hello &&
 	git format-patch --stdout --cover-letter -2 >actual &&
-	grep hello actual >/dev/null
+	grep hello actual
 '
 
 test_expect_success 'cover letter with nothing' '
@@ -1547,7 +1562,8 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
 	git format-patch master..side &&
-	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
 '
 
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
@@ -1560,13 +1576,21 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 
 test_expect_success 'format-patch --base' '
 	git checkout side &&
-	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
-	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
+	git format-patch --stdout --base=HEAD~3 -1 >patch &&
+	tail -n 7 patch >actual1 &&
+	git format-patch --stdout --base=HEAD~3 HEAD~.. >patch &&
+	tail -n 7 patch >actual2 &&
 	echo >expected &&
 	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
-	signature >> expected &&
+	git show --patch HEAD~2 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \$1}" <patch.id.raw >patch.id &&
+	echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&
+	git show --patch HEAD~1 >patch &&
+	git patch-id --stable <patch >patch.id.raw &&
+	awk "{print \$1}" <patch.id.raw >patch.id &&
+	echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&
+	signature >>expected &&
 	test_cmp expected actual1 &&
 	test_cmp expected actual2
 '
-- 
2.21.0.1049.geb646f7864

