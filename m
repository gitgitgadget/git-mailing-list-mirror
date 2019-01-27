Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 007B91F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfA0X1J (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35016 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfA0X1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:06 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so11634308edx.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=Y8lp5jB43rH4f2IwTAcVRXuJzwBpJGaAAl1zIuINrk7Z41ajr7S7Hf2m1EyPIhii/d
         cQqtmMQ0uhMLfhPViF8xoESp/Q4HLUtuCBFJYrBSK/2uIx5r0sDvV6urD+O/qggvtYJO
         19VEt/y8PqzicMUHPWYo1M6+oHJbGmS1BD+oJdJq47dA1NYI54n27kmQAc24O2BMkl3a
         XXYzWAwOX7hYgnEXWdduQotK7zwvkrDqZEjuGcEjZxqVtDjfu4UfwO+2LALpU+XDTaEa
         VdNm7KQ3n7ZTHMqV1aH8PwjvsenryILFUvUQbj8AYxTx9/kd1Ctr49WmTGPZAhgkNZYz
         jGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=Ef1lwAlCv8oxI2LJS+fzHrWhN/jdrmYmxfMZKQRiMAfWz3y5JBn+6RQPKfMICIMGpC
         29hLz0UUekbEbnl3NFgqEsi5T7Z5Wrc2ipsKliocYlW1uT2RPXA4AL425SfwfNK3U6ed
         KeVTOrM1G9YesqtiJCCubS8TN0SmQH6eAS+Vsf8QGt0H23pWRTkp3bx9sfPGDRit/l5t
         1LDBXkPlcMWvmm1cQdYeJoLzDpOx2DvF/fTWk4jhU3lTE0GhCHvr9jRjyDS6Dmev5evA
         RUGVygEKomwoaug+yZLL3fzh98ieLTNA04iJFmnyx7aoVBEj3vSPxlcU88TDZMWetQfA
         wpmA==
X-Gm-Message-State: AJcUukesrubFpfQD9qTpn5sWd+u2uTcgeKNRRCqOplqvrwPj+oiwvKfx
        Yt8nAhqvX9UsftY9vK90rlqHBFo5
X-Google-Smtp-Source: ALg8bN4ra0e8LlsoqZWiMcCdTH17He5JvIwxgg9BKpbEjsPsUWC2Nc55Z1eFqC14AivPRvvw6fuzQg==
X-Received: by 2002:a50:8a45:: with SMTP id i63mr19754149edi.262.1548631625165;
        Sun, 27 Jan 2019 15:27:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r51sm13635907eda.64.2019.01.27.15.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:04 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:04 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:45 GMT
Message-Id: <6a8adbe8baedd166f13d4fa74bce712165168f1b.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 19/21] tests: optionally skip bin-wrappers/
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

