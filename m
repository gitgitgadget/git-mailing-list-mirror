Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE1D01F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393238AbfAPNgc (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39969 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390473AbfAPNga (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:30 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so5413083edr.7
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=f78M31hStk/N5JvwPhMSjs9jTx9EW8TkkVA6LB1wmqY=;
        b=Dhf+aNg/9Mz1h/v+uX3NcvrDbo1byjaHZU/QB7lCtIixVyJc4LSCEe+nFAh/nYK9hs
         hCaH9JTwXxfZDxXEvCm6yjw6p8/9tnYAzEK0077OMBUyY4os+DF0LJUlFTRyQ+68RXz+
         Qxgq8q/GNsFlMdTBnfZ8zGO6+AYdyIPQ7o3bssYHHlIlclI5FnYAmtHFv+poWDwYxId4
         fre80rRZondtLDmea7KinNO8SRNwM9Qj0zBKBBgMsxNiZmOFtvVkYbmkZIfVOUlM7FtK
         g6LHT3Ig2QSTCVQHVNzDpdCO5t3+6NsGgW/PZkzTDcK5p+RQxDNx4gTFhfhZRtXUYxkL
         8SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=f78M31hStk/N5JvwPhMSjs9jTx9EW8TkkVA6LB1wmqY=;
        b=iuhgV0ioio2OeV7XjSRnRPWJfpT8EqdQRZ4nTQZWlpgRM3nv/T0gU4cKYYIceSgsfP
         fRElCVhU91ciobVB/E99jBXlIyh/PrUkphrY3s7Af5qqCP3R7sSjAQHXmE2VwAGFz9tm
         f85r/XmLTvikhNdeiSZwUz4H7YSts51rYtfCW0taqnELYbmUQk7BXFv7Ka876OnXKuO8
         m/1Ju3UzhBqcuh8k8lN2Cpbxb4UR2z+0h8ebgNDNzgHDGOyfgnuchuedNMiQi9L+SCMy
         X+kFcuNOdHfcW+KMUyL5pS1v/iBh8jLv0N6fd22/pET5QYW6C/RJNFeJ3JZdpYgfyY3G
         KT1A==
X-Gm-Message-State: AJcUukfiwhRatldLXMAZrWhffeaVdZZfxBSDBfRbNbpsb/mi9IS3K0Gc
        FCJuhsjRY0NToichk8PNg5KlSTma
X-Google-Smtp-Source: ALg8bN5i/ueJVG+v1dMsrNXuliLG9fTmh4Zy4x6yJPze3DVZTs++kBV11+xt1KH81qWbDP1PeNaa1w==
X-Received: by 2002:a50:999b:: with SMTP id m27mr7596370edb.10.1547645788684;
        Wed, 16 Jan 2019 05:36:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f35sm5877344edd.80.2019.01.16.05.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:28 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:28 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:07 GMT
Message-Id: <3a77eafb44117092a97121afabac5106bf58fcdd.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 19/21] tests: optionally skip bin-wrappers/
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
index 28711cc508..3f645b083a 100644
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
index 9113ad86b4..38a0f5d96f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -294,6 +294,8 @@ do
 		test -z "$HARNESS_ACTIVE" && quiet=t; shift ;;
 	--with-dashes)
 		with_dashes=t; shift ;;
+	--no-bin-wrappers)
+		no_bin_wrappers=t; shift ;;
 	--no-color)
 		color=; shift ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
@@ -1080,16 +1082,21 @@ then
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

