Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD901F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeJOR4p (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id y18-v6so8957519pge.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yFkau5tDO8LmM1081q0gbLHr4nrIvvPiu6EaqDQgqgI=;
        b=Cfa+RVJD5QJWjiGKimNWCmzRDBcqvcnWV+9oU+ZDR31LPNZ3cMqx2irtasf/8GBM/T
         FGBtXyb8qae8IMAetsijX2kr68Mt675Vk/EpKqUthvh8BeZfzY1hvjwDwpplMY26urGk
         /EhBYmRGNhGwdlJ0e70nPmKGoul+ttBEcJWvwk3Zax6lwDC3iQ1F93K6mIafJcxeBVQT
         i7MNUEN8G4a2r0eeZWFE/OscQUSaEqAm/adXFYXz0DcZQQBESDhyb9o8lrF12SYc3naQ
         5kKysrkOLkcDVv23eD6tTkeaB7c+PXNKLKp+u4TnO067NBNj9aX8LCA//j7/y8XK+dni
         O/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yFkau5tDO8LmM1081q0gbLHr4nrIvvPiu6EaqDQgqgI=;
        b=HPZvUS+kyvM/0nwRfiV7n+Q6Y9hD6o/Aw4jjFbRfFDjMmcloBBr1TYH0gTx7N5i1ab
         y1p/VTCPV6xwqThrWKzQlAkcoLpCqEqiUYg6yCrwVdPJsp2t72m8hQVZixpdvLuzwdLf
         TfooL1zcHP8VUlrM0jTz/0OYxwb3m/bAv+SHsvHv4mYYdOMsPJT19tqW400OPl2yNqhE
         DamTCqR+gxS7Q8dk0NdjoB2J2Rbq3VZAU0TuDHWRy0YknWIegmDeUNaB8K/Ide2920pl
         Oq5Q9hAzy9cLMGm0Walp4iSqPT0XpxJCwFf7DNGcieKn0gOTyqKChTU+rsYbzLLYaY6h
         72vA==
X-Gm-Message-State: ABuFfoj2VQ/EX8k/WZTqlzbciEq41bPDxU2iS07h9m1m2Cc0db+l8B4K
        40m+pCHiGbeYuyXGjlniffwE8nVf
X-Google-Smtp-Source: ACcGV60x5WdD6YLnZqGGc2gA8kiBPl45AAvHLXbCkOU5+SX3rJuAgLY2F0k7f0xSw9BZzxxVOvwhhw==
X-Received: by 2002:a63:680a:: with SMTP id d10-v6mr15301433pgc.7.1539598329248;
        Mon, 15 Oct 2018 03:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j64-v6sm11556849pge.15.2018.10.15.03.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:08 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:08 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:49 GMT
Message-Id: <12d6137f8d2ccc2041bed8d56d88a09b1db0fd77.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/13] tests: introduce `test_atexit`
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

When running the p4 daemon or `git daemon`, we want to kill it at the
end of the test script.

So far, we do this "manually".

However, in the next few commits we want to teach the test suite to
optionally re-run scripts with different options, therefore we will have
to have a consistent way to stop daemons.

Let's introduce `test_atexit`, which is loosely modeled after
`test_when_finished` (but has a broader scope: rather than running the
commands after the current test case, run them when the test script
finishes, and also run them when the `--immediate` option is in effect).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0000-basic.sh        | 18 ++++++++++++++++++
 t/test-lib-functions.sh | 29 +++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 3 files changed, 51 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 391f910c6a..8c5faa6ce1 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -821,6 +821,24 @@ test_expect_success 'tests clean up even on failures' "
 	EOF
 "
 
+test_expect_success 'test_atexit is run' "
+	test_must_fail run_sub_test_lib_test \
+		atexit-cleanup 'Run atexit commands' -i <<-\\EOF &&
+	test_expect_success 'tests clean up even after a failure' '
+		> ../../clean-atexit &&
+		test_atexit rm ../../clean-atexit &&
+		> ../../also-clean-atexit &&
+		test_atexit rm ../../also-clean-atexit &&
+		> ../../dont-clean-atexit &&
+		(exit 1)
+	'
+	test_done
+	EOF
+	test_path_exists dont-clean-atexit &&
+	test_path_is_missing clean-atexit &&
+	test_path_is_missing also-clean-atexit
+"
+
 test_expect_success 'test_oid setup' '
 	test_oid_init
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 78d8c3783b..d7dd0c1be9 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -891,6 +891,35 @@ test_when_finished () {
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
 
+# This function can be used to schedule some commands to be run
+# unconditionally at the end of the test script, e.g. to stop a daemon:
+#
+#	test_expect_success 'test git daemon' '
+#		git daemon &
+#		daemon_pid=$! &&
+#		test_atexit "kill $daemon_pid" &&
+#		hello world
+#	'
+
+test_atexit () {
+	# We cannot detect when we are in a subshell in general, but by
+	# doing so on Bash is better than nothing (the test will
+	# silently pass on other shells).
+	test "${BASH_SUBSHELL-0}" = 0 ||
+	error "bug in test script: test_atexit does nothing in a subshell"
+	test_atexit_cleanup="{ $*
+		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
+}
+
+test_atexit_handler () {
+	test : != "$test_atexit_cleanup" || return 0
+
+	setup_malloc_check
+	test_eval_ "$test_atexit_cleanup"
+	test_atexit_cleanup=:
+	teardown_malloc_check
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7ed0013f6d..6f9c1f5300 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -413,6 +413,7 @@ test_external_has_tap=0
 
 die () {
 	code=$?
+	test_atexit_handler || code=$?
 	if test -n "$GIT_EXIT_OK"
 	then
 		exit $code
@@ -826,9 +827,12 @@ write_junit_xml_testcase () {
 	junit_have_testcase=t
 }
 
+test_atexit_cleanup=:
 test_done () {
 	GIT_EXIT_OK=t
 
+	test -n "$immediate" || test_atexit_handler
+
 	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
 	then
 		test -n "$junit_have_testcase" || {
-- 
gitgitgadget

