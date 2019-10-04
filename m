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
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A961F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389746AbfJDPJj (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 11:09:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38249 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389736AbfJDPJh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 11:09:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 3so6247328wmi.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XYXaIeL7Z2OEQPuvIovvmDL7JcKKrIbPABA50H0G2Lc=;
        b=fr9/bJ3mUYucCM06cw5K5LjgQQeeHaalQ60R3PAaG7zDgl3N2VVbJu49oFKXA20qaq
         FeXTNsu+ZDGlWfQuQkCHwzZh3kDGlkdioIhz32cfDpQbcSNgSlhCKvig20sz05IhZNJg
         gk/wMBuu9K9lVfqoKq8zNLixDDk9m97w+jkQyHhzJL7+0QzQBGY8Igo9K7J+n6a1WD+G
         WO+hqApFs3487XsRBAziguOGO39+cE2oDJ/GvPkt2/1sQLt+H44lSqwVlW7Clql8XfQA
         r0s+ii/eadfa3jwBDEyqy2jNok31hWKUYMPrWAsUgQclQnDdbLwwtYQ3MmHahGgJs7Sy
         gGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XYXaIeL7Z2OEQPuvIovvmDL7JcKKrIbPABA50H0G2Lc=;
        b=U7xqZ9eqMnjuIBNPswjlnuasMEB2Nl3a09WgDvt6AsF0e3nj/334f91ooZGE+AzgAk
         wCTx5P5doleiCBEiObh6s3TMcUNhPgCv0lAS6WCt0zGAEVmQQo200IfkIklfxOD/7wRr
         Mu4tX5NhMVqaBrwgK6QpBlJbP20MT44/08fnMZ1As7i8DFLA4IV7wjRlmkvstK3uyWgK
         HyYig5FxRl0w88xOALVB+fKfuZtA3i32YdPhy1o2gGm8zdFOTrn6+fR8QiSYIB0+nt4C
         Vvoet8ZFmBby/rcJjAfqHTkgPpwj4b4LCxEWWm1iLNq6Y2JJw+WYwP0uEIv/AGQjjii6
         yQnA==
X-Gm-Message-State: APjAAAWuu1XfahzxUVp6ox9xDGYM5Waw1ZCR0aGRD8BrnP3DtjrDrQuD
        Q0pU9TPhATUOCqN9jeNCNpkOmVPT
X-Google-Smtp-Source: APXvYqz52ybjnD8YjPTKgyuZMGsdp+HCUc6n+G5qp5HKmzmY2WeTB/oeD7ABxiSwGsn7kGbrBMHUlw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr10599149wmc.136.1570201775225;
        Fri, 04 Oct 2019 08:09:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm6576357wrm.42.2019.10.04.08.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 08:09:34 -0700 (PDT)
Date:   Fri, 04 Oct 2019 08:09:34 -0700 (PDT)
X-Google-Original-Date: Fri, 04 Oct 2019 15:09:20 GMT
Message-Id: <0644a2f8da8d04d505d3c70224ca806b52523daf.1570201763.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/13] tests: let --immediate and --write-junit-xml play
 well together
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When the `--immediate` option is in effect, any test failure will
immediately exit the test script. Together with `--write-junit-xml`, we
will want the JUnit-style `.xml` file to be finalized (and not leave the
XML incomplete). Let's make it so.

This comes in particularly handy when trying to debug via Azure
Pipelines, where the JUnit-style XML is consumed to present the test
results in an informative and helpful way.

While at it, also handle the `error()` code path.

The only remaining code path that sets `GIT_EXIT_OK` happens whenever
the trash directory could not be set up, i.e. long before the JUnit XML
was written, therefore we should _not_ try to finalize that XML in that
case.

It is tempting to change the `immediate` code path to just hand off to
`error`, simplifying the code in the process. That would, however,
result in a change of behavior (an additional error message) in the test
suite, which is outside of the purview of the current patch series: its
goal is to allow building Git with Visual Studio and testing it with a
portable version of Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d1ba33745a..86b5e6133b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -567,6 +567,7 @@ export TERM
 
 error () {
 	say_color error "error: $*"
+	finalize_junit_xml
 	GIT_EXIT_OK=t
 	exit 1
 }
@@ -695,7 +696,7 @@ test_failure_ () {
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
-	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -1063,6 +1064,25 @@ write_junit_xml_testcase () {
 	junit_have_testcase=t
 }
 
+finalize_junit_xml () {
+	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
+	then
+		test -n "$junit_have_testcase" || {
+			junit_start=$(test-tool date getnanos)
+			write_junit_xml_testcase "all tests skipped"
+		}
+
+		# adjust the overall time
+		junit_time=$(test-tool date getnanos $junit_suite_start)
+		sed "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
+			<"$junit_xml_path" >"$junit_xml_path.new"
+		mv "$junit_xml_path.new" "$junit_xml_path"
+
+		write_junit_xml "  </testsuite>" "</testsuites>"
+		write_junit_xml=
+	fi
+}
+
 test_atexit_cleanup=:
 test_atexit_handler () {
 	# In a succeeding test script 'test_atexit_handler' is invoked
@@ -1085,21 +1105,7 @@ test_done () {
 	# removed, so the commands can access pidfiles and socket files.
 	test_atexit_handler
 
-	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
-	then
-		test -n "$junit_have_testcase" || {
-			junit_start=$(test-tool date getnanos)
-			write_junit_xml_testcase "all tests skipped"
-		}
-
-		# adjust the overall time
-		junit_time=$(test-tool date getnanos $junit_suite_start)
-		sed "s/<testsuite [^>]*/& time=\"$junit_time\"/" \
-			<"$junit_xml_path" >"$junit_xml_path.new"
-		mv "$junit_xml_path.new" "$junit_xml_path"
-
-		write_junit_xml "  </testsuite>" "</testsuites>"
-	fi
+	finalize_junit_xml
 
 	if test -z "$HARNESS_ACTIVE"
 	then
-- 
gitgitgadget

