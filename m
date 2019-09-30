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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF911F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfI3Jzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:55:44 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42343 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbfI3Jzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:55:41 -0400
Received: by mail-wr1-f44.google.com with SMTP id n14so10483219wrw.9
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XYXaIeL7Z2OEQPuvIovvmDL7JcKKrIbPABA50H0G2Lc=;
        b=qkDsRfYr18iFddKUsY4zL+RmqqOFYBzGBfYv12UAmOL/BuM7Kon3SRrQEGXKBs4T7S
         bni2DFuqCndtpDVx/+3EgnCn/Y7Zt+1rGYRLNTN1HQQ2WwlCXgzownLf4OYWY1MCB/kI
         fG+52JUmKAcToOLBC3kb/48MlXflKPBaTJXTvBq/HZpY+8dmJfMLZJF3TlHv5d4pXK2W
         kp3pX949iUDPWnjyZ13k7313jTf+mbaLhygN5KtPdgnrq76lcOb/O3dYsOg5EjqPNShH
         MReT45+HMuvzwxVmYiqpdVvVMS0gDFESA6EX715u3nHPr1LPulkqt6EhBDAqhTR+IFKo
         MJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XYXaIeL7Z2OEQPuvIovvmDL7JcKKrIbPABA50H0G2Lc=;
        b=tygANBnHgUL8k5dAQOo/Bc72jALV9C5NC4tiDVCsQsS4AXHHwe/sJlZHq5yeBnBiSR
         XZ5x97Ptd/cQXRaJWLNqbmFJlDhE132COiZykyml5VfaKS2ESHcU/Svv2Qd61WMko7+M
         M6SSnLGztVRJwAXZOGmwiw0nn2tg+D2tsrzBlK12ge8KNyCp8oxgfkAkmsRvHEZyka7c
         9Xe5Tc4Q5e/eAGlxBmtvo6IbTKQEYWXbBBYW+qTh691YmC5INLzMW1cxaOHPw2VG8tmb
         9Kz0XqVg8SVnQhjjKh2GYO49nxIkNcZjHVI0B0vz6j1obxNvu+vc2PZvlfTZW47v4ChT
         IB7g==
X-Gm-Message-State: APjAAAW+8NFHdX3a4oQRQIg934eOkx2aBSiMmiWn8LzIKVHCT/lk4Hhe
        LV5PPsF/NS7bOGTi70VTXgJE4yfJ
X-Google-Smtp-Source: APXvYqw7LT2O/BFZ4REg1C8/BHqa2jbqXMZZxvbz4b+ZmxwJ/CaOQ57so+tg5qH25c423kcQ0DeiUQ==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr12141132wrq.375.1569837338893;
        Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3sm13130644wmi.30.2019.09.30.02.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:55:38 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:55:27 GMT
Message-Id: <7be13d19e1000adc0d5f02e67a799b1b87524322.1569837330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.v2.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
        <pull.288.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/13] tests: let --immediate and --write-junit-xml play
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

