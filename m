Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0911F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfA2OTn (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:43 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfA2OTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so16074319edd.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=mXLwNeP51t9ggiJeYVLI+Ho76F3OAWpaQN9o7Mggx3693nE8vpHHZ1HYOEhxT67PEt
         s1iGJy2YezP1SFqRKmqziXJpP2djgM75ey/Wyv162AXw51vfudhjp/YRQGrz+5OmC4Z4
         J95IoIQESZ/r4mW3kLy4iiMRCLIOaRw3l9dEo/HAYQEsy+n5mDAmE+DZ5Jmd+8pP2G6V
         EPK8n62DnB+jLNM/eRbej8Y5YNaDDKDJD24eYSmpQXD2OTkRRWKgMU0M/IgqBruTJWIQ
         KwW5Q29k+XAMEcwKr7+Qe9XY5ZrOagint1y2jJuNvgFQkvjoFxxx/ODIbSab7pox+RCf
         zOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7gtFKAG898gIOKd93T1TNRDKFMtd3jqrEAjEXx25Pgw=;
        b=KJN/jQR5PAzYMqOHWDvwf19vkx2r5AonkSBjkXoq4YgcXShh0SVZtseYR0jQ5ITTwj
         Cvs9Ha5vXX7uJftyGV1e5KlIcqClGHmuFuRrFYv5LQcAmLyz/DYpiCEdkjL3A809oopx
         knprldnSAxMx8nzKkssBfZYAUiCaL9SoY2m7FRgAb7zjkXoH5YjJ3VaGS8+SBtdyaYcw
         3wFER7wu5GLbBkjxoUHRku6qP77kNSEsT6bD7MqIeqUZn9Zs8bN7Wicyqx6f2ZzE+y4j
         bmVJ7EsAQG7yfU17hBgSg37xgQyWOYnAKT9OSrmSAuzzn7NR4Bifq2uXbJp+qDsNK3R8
         ZSiw==
X-Gm-Message-State: AJcUukdLfmm0NlmcIsIRz6lqzzbv+aTxRCqD5z/F7MOwNfe4xLGeMb7g
        o7twK+tWDX+/CfW0QgFyO8Tvrtuq
X-Google-Smtp-Source: ALg8bN5rSTmefW4pmFUmS3RHQbqMVEiZmwE0cVRIfH2RBZfGsVAzQ8F65rLqG4YMhVyP/xxIlAXkKQ==
X-Received: by 2002:a17:906:6201:: with SMTP id s1mr23134903ejk.66.1548771577615;
        Tue, 29 Jan 2019 06:19:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v43sm14761657edc.18.2019.01.29.06.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:37 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:37 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:18 GMT
Message-Id: <248473d9fa98333d2bd122a470c2a17da859c686.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 19/21] tests: optionally skip bin-wrappers/
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

