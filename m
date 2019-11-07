Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A4A1F4C0
	for <e@80x24.org>; Thu,  7 Nov 2019 17:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730988AbfKGRrD (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 12:47:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46564 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbfKGRrC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id b3so3993320wrs.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 09:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rE7vkFVZ8UDtVIX3IMUvbZInEo3mLccDmtQsBOxjfgE=;
        b=XumaAYMNWQxAvuH318nZEMdy3tW/IDunGlPNLunzNgXe90tG1SGFiHw3fBWT/14hr1
         5L+idVhtxVfq+aQ9pNEeG1Yp74lIW2C9nKHzJ4GPA7wb+c0B3Bz+nd5O7QV6WNgrIVbq
         a7feBYCPf/qPayZbesia5T402RPM6P7uRUSXgEFn2rKURmcs0+BLrAxAYPeJD+LR7MQO
         L44BwUVowmUHwKsbZfr7LPnCO8+caM1iCehoSTvZTDcmyRxUUegouYzLBzLEy4uUwASF
         c4RNllW1w+3Y7jeRCJZhc3rQWKEEDkIt6xNaJT8XjWMEfutRF3ZhLW2psnlnAOkkp26x
         1jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rE7vkFVZ8UDtVIX3IMUvbZInEo3mLccDmtQsBOxjfgE=;
        b=Flh6GZ37ydWRetaoY4xG8O2hrwHEyprNq7n86ts7aJ+SufHXgQAQZ9ouIifX5xEJ8R
         eedz61WCbV//Snpr8xWEV25W3J6kW2OAcHuEyfUnZpC6532yQG2yK2G2nb8QUoySYHWA
         aMQtIlPef16xTOgQSBy8c1DMnDKPVYkltyH3YCohH0yQb/XoJdhJEjjvmEXmZGLg0QZ3
         nU6T8+zBdcfHFWSVL/7dpPmOmSXZn1y5r/sSxeqSbIocqZ0TIY+YUxuMFT+2tCH74fJ6
         YHnL1tOJJY51n4XUSMFHY9VXdAaDheHrYLeRY64HObAZjDz1V5AAR4JPGrk4qnLqPqAs
         NH3g==
X-Gm-Message-State: APjAAAVoSQSZ18iGLCrB3NuJ7V1pPJs8e+LPBYzA1z9ubm6CPVwDVn6t
        DYlHo/Hi1rpONKiVmhiD08t7ujD1
X-Google-Smtp-Source: APXvYqwusMHR1DoiVAHpTe2BmAy/zOLV3I48irnQ7E08AKRJTpfnXjaL1zWU47MmOx3gNAew76WTOA==
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr1759094wrp.66.1573148820448;
        Thu, 07 Nov 2019 09:47:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p10sm2777663wmi.44.2019.11.07.09.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 09:47:00 -0800 (PST)
Message-Id: <656dba5afb818d0caa7616d0e58c9728803f8d04.1573148818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
        <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 17:46:57 +0000
Subject: [PATCH v3 1/2] progress: create GIT_PROGRESS_DELAY
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ryenus@gmail.com, stolee@gmail.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The start_delayed_progress() method is a preferred way to show
optional progress to users as it ignores steps that take less
than two seconds. However, this makes testing unreliable as tests
expect to be very fast.

In addition, users may want to decrease or increase this time
interval depending on their preferences for terminal noise.

Create the GIT_PROGRESS_DELAY environment variable to control
the delay set during start_delayed_progress(). Set the value
in some tests to guarantee their output remains consistent.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git.txt   | 4 ++++
 progress.c              | 8 +++++++-
 t/t5318-commit-graph.sh | 4 ++--
 t/t6500-gc.sh           | 3 +--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b82564d1a..1c420da208 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -544,6 +544,10 @@ other
 	a pager.  See also the `core.pager` option in
 	linkgit:git-config[1].
 
+`GIT_PROGRESS_DELAY`::
+	A number controlling how many seconds to delay before showing
+	optional progress indicators. Defaults to 2.
+
 `GIT_EDITOR`::
 	This environment variable overrides `$EDITOR` and `$VISUAL`.
 	It is used by several Git commands when, on interactive mode,
diff --git a/progress.c b/progress.c
index 0063559aab..4ad1a3c6eb 100644
--- a/progress.c
+++ b/progress.c
@@ -14,6 +14,7 @@
 #include "strbuf.h"
 #include "trace.h"
 #include "utf8.h"
+#include "config.h"
 
 #define TP_IDX_MAX      8
 
@@ -269,7 +270,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
 
 struct progress *start_delayed_progress(const char *title, uint64_t total)
 {
-	return start_progress_delay(title, total, 2, 0);
+	static int delay_in_secs = -1;
+
+	if (delay_in_secs < 0)
+		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
+
+	return start_progress_delay(title, total, delay_in_secs, 0);
 }
 
 struct progress *start_progress(const char *title, uint64_t total)
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d42b3efe39..0824857e1f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -132,7 +132,7 @@ test_expect_success 'commit-graph write progress off for redirected stderr' '
 
 test_expect_success 'commit-graph write force progress on for stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph write --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git commit-graph write --progress 2>err &&
 	test_file_not_empty err
 '
 
@@ -150,7 +150,7 @@ test_expect_success 'commit-graph verify progress off for redirected stderr' '
 
 test_expect_success 'commit-graph verify force progress on for stderr' '
 	cd "$TRASH_DIRECTORY/full" &&
-	git commit-graph verify --progress 2>err &&
+	GIT_PROGRESS_DELAY=0 git commit-graph verify --progress 2>err &&
 	test_file_not_empty err
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index c0f04dc6b0..7f79eedd1c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -103,9 +103,8 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
 '
 
 test_expect_success 'gc --no-quiet' '
-	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
+	GIT_PROGRESS_DELAY=0 git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_line_count = 1 stderr &&
 	test_i18ngrep "Computing commit graph generation numbers" stderr
 '
 
-- 
gitgitgadget

