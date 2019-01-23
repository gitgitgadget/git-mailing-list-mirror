Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2CF1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfAWOkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41374 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfAWOkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:32 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so1862728edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=B+cetceaZfHJjzANQVVEavDr7BTNiXh5dsprzjT4lP+wcdLRFssjya1jFx30440jbH
         KSAk7zeifamtrVOvfDl7FtRWIC0+e5FUzUR+NdLmlKolQvBbbYY4kL7FWdNMbW2kGzw0
         bFlPQMuUoRh//cH0o/a3sDMt9MjgFVmlXYUJHZXv6kh8GH3ACCksuv+w9/KsrVMTcrqc
         sn7c6TWJg0oTcnI73NPpkycWiMT8p6lgFWLMbvnckyRJ6HL+GiULL4pn/2dWltjQE2Uq
         Uw6GldpOhytLhr0u3EVQKAIQscc6inPoUMX5XPWhnfs5slgN5Cj1ac7Mvuvm0ivKv5AD
         Htjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=EuXLadJhTYVfeDKTFzrE8JRMtMVsARx1XX+qSOulHMMwCkT5u5J6SHcBUYlXWJmAzm
         DmbaDfpXdEUvjNztrKWNqPACG/JNUOD+2NjVog0ANH5IiTc7gUgel+he5hykXr3nEOTK
         hEAj8nmKq2Y7zpyVZK8enXOSvHxHdCdHLIQyPs6w4H2glZXq0dOYP+i1Sri9gJTnLTQy
         pOMFB20zqA2ZxfXGFVY+4CSvKuM4T/GuD4yUvRFVz4jKO8lmxpXr05PeoVDFs+ia8qGS
         zIFEz6+9a5EN0dXH4+fp7gPQ1stZKEaJU6WHq8uUG7gh24H+zMlIfYFQzY/CH3ArhIwB
         +8Bw==
X-Gm-Message-State: AJcUukcqQFj4DkFTkhxjv/F/uab6iKrPuzs5rtrwKOtp+EH3q9UnF1bl
        3Ynr9f/6FPPHRwpeHYDcmtj22Z+B
X-Google-Smtp-Source: ALg8bN47ov1CzuyXPuFkL5rFlV2OsjxainBqxhz8ooEZEg9TLB6dxgi8iEFTJteOHsFpnCoNg5hTKg==
X-Received: by 2002:a50:e0cb:: with SMTP id j11mr2962416edl.195.1548254430333;
        Wed, 23 Jan 2019 06:40:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11sm9867050edq.51.2019.01.23.06.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:29 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:29 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:10 GMT
Message-Id: <a198885b76cc34d636ff2d746123c9cc9ae6ab27.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 19/21] tests: optionally skip bin-wrappers/
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

This speeds up the tests by a bit on Windows, where running Unix shell
scripts (and spawning processes) is not exactly a cheap operation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      |  9 +++++++++
 t/test-lib.sh | 19 +++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/t/README b/t/README
index 11ce7675e3..063530234f 100644
--- a/t/README
+++ b/t/README
@@ -170,6 +170,15 @@ appropriately before running "make".
 	implied by other options like --valgrind and
 	GIT_TEST_INSTALLED.
 
+--no-bin-wrappers::
+	By default, the test suite uses the wrappers in
+	`../bin-wrappers/` to execute `git` and friends. With this option,
+	`../git` and friends are run directly. This is not recommended
+	in general, as the wrappers contain safeguards to ensure that no
+	files from an installed Git are used, but can speed up test runs
+	especially on platforms where running shell scripts is expensive
+	(most notably, Windows).
+
 --root=<directory>::
 	Create "trash" directories used to store all temporary data during
 	testing under <directory>, instead of the t/ directory.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index c790e98fd2..25e649c997 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -111,6 +111,8 @@ do
 		test -z "$HARNESS_ACTIVE" && quiet=t ;;
 	--with-dashes)
 		with_dashes=t ;;
+	--no-bin-wrappers)
+		no_bin_wrappers=t ;;
 	--no-color)
 		color= ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
@@ -1214,16 +1216,21 @@ then
 	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
-	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
-	if ! test -x "$git_bin_dir/git"
+	if test -n "$no_bin_wrappers"
 	then
-		if test -z "$with_dashes"
+		with_dashes=t
+	else
+		git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
+		if ! test -x "$git_bin_dir/git"
 		then
-			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+			if test -z "$with_dashes"
+			then
+				say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
+			fi
+			with_dashes=t
 		fi
-		with_dashes=t
+		PATH="$git_bin_dir:$PATH"
 	fi
-	PATH="$git_bin_dir:$PATH"
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-- 
gitgitgadget

