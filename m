Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75DB20248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfCCOo7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:44:59 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:42459 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCCOo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:44:58 -0500
Received: by mail-ed1-f43.google.com with SMTP id j89so2122734edb.9
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/JId50HUn/LvrL2rTAb2NpNI3oTuO9EqUM8/UESUYdg=;
        b=LNrzEv5KhgReBYTZOdmHTusnAnRhO9nWo0bH24RZAHwXEw6SlJ6LHfsoDxraHFChIW
         V51Db2KblYvlXSk2mrURa+3/Ctl9Be8GoVA6G/9gY1CpxFBQaCSzCdH+y13877VzLzBF
         sjHJMG8Y8AjJf1BWXNoVJSs7bZznlMwhkh4yG3ZOc4TepH1PTNEu7b6hnDYiK1+WYsDF
         UZw28bk6EUdKLMtUY1rJrkKQdUrQoidkjjYd9eH5OknBj2KxXVB9soUbwYPOANAirU83
         xsxoZ7a0iuxSyHnMx3TRnhgLDy6MueFKlg6LmaFgmfYzxmQdeypz8fHt88pJLPHYdREV
         EaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/JId50HUn/LvrL2rTAb2NpNI3oTuO9EqUM8/UESUYdg=;
        b=PNzzDgZ/vVj7lvIwjJIrNDl2ouhKdL/w8T7z9lugiIBKUi8ubTQyakzlNvDoRbsYSd
         t1cBI63vcyYNaNerMHXgzH0WPiJCTjYhGsDLu0tIZ8JS8eROA2aZF8fxpi5vYwkJuOmd
         lZBJw+j4sXHQrqlmLz/9SqQ/q6F29Cx4ZZ9ZqwMjgKzwzYgJV5GWvfH2u911vHcVDQan
         rSP6Dw1wgZiTwOgFaD67RKYiKTijLA27MSdqRyhhccG4OUIEyApDggMNLj0BqesN9Y3h
         foAx8S5VdFuQh7s3CKos5cQ/w9/3hhiWjnHyUqNyykPppgBklNXCImSR9r2Qjld6uzr9
         NmBw==
X-Gm-Message-State: APjAAAWUzfSgVIVpqkedHlKGf+ul4WkJNayzdpWW0sGHBoi5EGuAl4zQ
        2drdh6waiyckHi+WTS72RfPp+J0M
X-Google-Smtp-Source: APXvYqzIiHvd87UBzzbjuzgl44hwgbpB3Bf/5rZCjBeOTzQ/SOMopU6QscGKZoG+IfrlACjXlSzK2w==
X-Received: by 2002:a50:baab:: with SMTP id x40mr11620945ede.244.1551624296169;
        Sun, 03 Mar 2019 06:44:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm1265250edr.7.2019.03.03.06.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:44:55 -0800 (PST)
Date:   Sun, 03 Mar 2019 06:44:55 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 14:44:53 GMT
Message-Id: <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.155.v2.git.gitgitgadget@gmail.com>
References: <pull.155.git.gitgitgadget@gmail.com>
        <pull.155.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/2] tests: introduce --stress-jobs=<N>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The --stress option currently accepts an argument, but it is confusing
to at least this user that the argument does not define the maximal
number of stress iterations, but instead the number of jobs to run in
parallel per stress iteration.

Let's introduce a separate option for that, whose name makes it more
obvious what it is about, and let --stress=<N> error out with a helpful
suggestion about the two options tha could possibly have been meant.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      | 6 ++++--
 t/test-lib.sh | 8 +++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index b61bc930c4..a496be56ef 100644
--- a/t/README
+++ b/t/README
@@ -187,11 +187,10 @@ appropriately before running "make".
 	variable to "1" or "0", respectively.
 
 --stress::
---stress=<N>::
 	Run the test script repeatedly in multiple parallel jobs until
 	one of them fails.  Useful for reproducing rare failures in
 	flaky tests.  The number of parallel jobs is, in order of
-	precedence: <N>, or the value of the GIT_TEST_STRESS_LOAD
+	precedence: the value of the GIT_TEST_STRESS_LOAD
 	environment variable, or twice the number of available
 	processors (as shown by the 'getconf' utility),	or 8.
 	Implies `--verbose -x --immediate` to get the most information
@@ -202,6 +201,9 @@ appropriately before running "make".
 	'.stress-<nr>' suffix, and the trash directory of the failed
 	test job is renamed to end with a '.stress-failed' suffix.
 
+--stress-jobs=<N>::
+	Override the number of parallel jobs. Implies `--stress`.
+
 --stress-limit=<N>::
 	When combined with --stress run the test script repeatedly
 	this many times in each of the parallel jobs or until one of
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ab7f27ec6a..6e557982a2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -142,10 +142,16 @@ do
 	--stress)
 		stress=t ;;
 	--stress=*)
+		echo "error: --stress does not accept an argument: '$opt'" >&2
+		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
+		exit 1
+		;;
+	--stress-jobs=*)
+		stress=t;
 		stress=${opt#--*=}
 		case "$stress" in
 		*[!0-9]*|0*|"")
-			echo "error: --stress=<N> requires the number of jobs to run" >&2
+			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
 			exit 1
 			;;
 		*)	# Good.
-- 
gitgitgadget
