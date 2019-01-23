Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C46EE1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfAWOkb (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:31 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42662 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfAWOk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:29 -0500
Received: by mail-ed1-f49.google.com with SMTP id y20so1864620edw.9
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=gEmFnHqAiaM/wISAkqOZOnN7BOG6FcU3lWhJJ94KDJdjeULQb5bXCTxRdsr4W7YKX0
         IWutGywfnMWjjAYFgZ22dzusFo7cEM1Vkj7ghCM5sx8rixwO+/ElGZD5Pfh9FJ0qI+QJ
         cJn9J3N1UT7puVDWWF3bIUDkq54y1eAIdCfT0HXnYSIGRvBX/1dNTC7QvGeE7ApZYFkt
         0GnZYxVz58WOgcrqzcDf11mnSAhWrhfCXk/Kj2U1bPK5vcauat4KHr4rxyj2DlVQS5ud
         eIREMWA1Tk1XHfRtoJNqaK8CpzC2thytpE2886WJDquHR8vtUYs9V7jVfb4rCrEccrOZ
         DOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=AxIwxgdV0Jko9cjkzWvXePwkiWmZTDQo0Ua/xbgmgFcmEEz6bgkzkBYxoTizAEeatE
         gPrs4XRNzZCsgoL81jVBDSwbq9MBvu1Fv1yy02pjt8ieAPLv31nKZaJZqmOPr5GOfer1
         dBc4sp3epcrD0QUL7WUmSyw+CiOLp3ZqshR7cn7A6pF6nlHkWsVqnsrTaTJGFDwlRaa4
         Qd3LSiqxj5PdjmQvheHpxVR8lm0+Abnr/ijI9qadnqKFE0QhYeD/4aZGAXLtWWo3IJ++
         g3VKfGS1L6oC55NX/CpWt0BH7/9+ajlnmcbGlnh3/fdR18GothhQwaBLh5ra+ACZKv/8
         TRyQ==
X-Gm-Message-State: AJcUukcKd50g98DNBWTloUhgf0/31t5ZUAgiNZeJC8KDNC+bSOkiWwmt
        luusKZs4/ukycNTwWz/N7S8fan6G
X-Google-Smtp-Source: ALg8bN6fMPXfkBjwFBELyPz8+jSWwWPqLtNV/g6LDTaCUJb+o6E53osG8LyLw17wKyWhDauE8/ImgQ==
X-Received: by 2002:aa7:dd0f:: with SMTP id i15mr2854475edv.29.1548254426786;
        Wed, 23 Jan 2019 06:40:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w24-v6sm5751144eja.71.2019.01.23.06.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:26 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:26 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:06 GMT
Message-Id: <1c44d3b8b81946c66839b7e750da2336a7ec4ad3.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 15/21] tests: include detailed trace logs with
 --write-junit-xml upon failure
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

The JUnit XML format lends itself to be presented in a powerful UI,
where you can drill down to the information you are interested in very
quickly.

For test failures, this usually means that you want to see the detailed
trace of the failing tests.

With Travis CI, we passed the `--verbose-log` option to get those
traces. However, that seems excessive, as we do not need/use the logs in
almost all of those cases: only when a test fails do we have a way to
include the trace.

So let's do something different when using Azure DevOps: let's run all
the tests with `--quiet` first, and only if a failure is encountered,
try to trace the commands as they are executed.

Of course, we cannot turn on `--verbose-log` after the fact. So let's
just re-run the test with all the same options, adding `--verbose-log`.
And then munging the output file into the JUnit XML on the fly.

Note: there is an off chance that re-running the test in verbose mode
"fixes" the failures (and this does happen from time to time!). That is
a possibility we should be able to live with. Ideally, we would label
this as "Passed upon rerun", and Azure Pipelines even know about that
outcome, but it is not available when using the JUnit XML format for
now:
https://github.com/Microsoft/azure-pipelines-agent/blob/master/src/Agent.Worker/TestResults/JunitResultReader.cs

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-path-utils.c | 21 +++++++++++++++++++++
 t/test-lib.sh              | 22 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 30211d6d64..6efde6f5ba 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -303,6 +303,27 @@ int cmd__path_utils(int argc, const char **argv)
 		return !!res;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "skip-n-bytes")) {
+		int fd = open(argv[2], O_RDONLY), offset = atoi(argv[3]);
+		char buffer[65536];
+
+		if (fd < 0)
+			die_errno("could not open '%s'", argv[2]);
+		if (lseek(fd, offset, SEEK_SET) < 0)
+			die_errno("could not skip %d bytes", offset);
+		for (;;) {
+			ssize_t count = read(fd, buffer, sizeof(buffer));
+			if (count < 0)
+				die_errno("could not read '%s'", argv[2]);
+			if (!count)
+				break;
+			if (write(1, buffer, count) < 0)
+				die_errno("could not write to stdout");
+		}
+		close(fd);
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a3b2166cb5..f31a1c8f79 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -639,8 +639,19 @@ test_failure_ () {
 		junit_insert="<failure message=\"not ok $test_count -"
 		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(printf '%s\n' "$@" | sed 1d)")"
+			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+			   then
+				test-tool path-utils skip-n-bytes \
+					"$GIT_TEST_TEE_OUTPUT_FILE" $GIT_TEST_TEE_OFFSET
+			   else
+				printf '%s\n' "$@" | sed 1d
+			   fi)")"
 		junit_insert="$junit_insert</failure>"
+		if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+		then
+			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
+				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
+		fi
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
@@ -931,6 +942,11 @@ test_finish_ () {
 	echo >&3 ""
 	maybe_teardown_valgrind
 	maybe_teardown_verbose
+	if test -n "$GIT_TEST_TEE_OFFSET"
+	then
+		GIT_TEST_TEE_OFFSET=$(test-tool path-utils file-size \
+			"$GIT_TEST_TEE_OUTPUT_FILE")
+	fi
 }
 
 test_skip () {
@@ -1280,6 +1296,10 @@ then
 		date +%Y-%m-%dT%H:%M:%S)\""
 	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
 	junit_suite_start=$(test-tool date getnanos)
+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+	then
+		GIT_TEST_TEE_OFFSET=0
+	fi
 fi
 
 # Provide an implementation of the 'yes' utility
-- 
gitgitgadget

