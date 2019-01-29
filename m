Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79EF1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfA2OTi (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:38 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:38509 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfA2OTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:37 -0500
Received: by mail-ed1-f43.google.com with SMTP id h50so16086741ede.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=sSnfizRVP5v836XCboiDZtNXw6WQcH93WdIt5+pF0AdXJ+dsCmjWOzfqrQJnXrCSxd
         UmMdW1YJqI8gUhRhC9gFa4O0bVjgSAfgvT1ys65u7xcFwuMqVenrSbITg9IhjG6B4R7G
         cBHrrlaWl0h3qlSENfk4hmh+7TeNuvekMAjcZRd1yUip+IRN/ExuVMeHreGM/rRikXBm
         cMrbXlLA52HYetTYX++s60ls8CO77BRSsiA33ZZGaeEqPVo4p4wACRKqXCXAR/l/PmTS
         OlygVQi+UmD2BGC8iOaUKHSqfMVBQWyYx+SOqvq8asY2VhMNyefbnj4zkNK0VWOGDeix
         WZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=iD9skkzRFRFrltMc5TeyMkcdYcht+kRV8J9UjuyLaf4O45/As/dT+WRYyJcgavmT65
         PiQFPiL2TQfnoVhP/BZSW+p7JC17Lz0NzGipPh1P/03S5TbZCBXf/7ccBYe3EDmQFfbF
         H5gil2XreqcDyHpD0eTq9wuzbOREpte5JAi53jlMu2rt1V4DW+X9DhBlHFIWvO/g3sCc
         Cp9HreHcex66rOdge/ECCnJA9I9Wq7LYn/B3dAux/75MaNrFx4wh185FpoXLSO1XIOPC
         ROQci2vXko7PhzOCt3TBsytMTYHzmGO5mOdQmukodgphkf5GSAe/Jxn0MLCeAPPfjx+S
         3fLw==
X-Gm-Message-State: AJcUukdFmfL2tPdCIO7pe8a7TDtGNPP8oFxTkoybl8xGUqG29L1k5qSr
        MomkCkmtEVDfzuAhW1DXUjGjkzTa
X-Google-Smtp-Source: ALg8bN76pyHUj0QKbxrWd+GprSdTTE1gWJk2+39GRiE/GkVlvIAgYoY8eJ7v/ZmA3t93IFZc52VqSg==
X-Received: by 2002:a17:906:4ed8:: with SMTP id i24mr22789563ejv.180.1548771574821;
        Tue, 29 Jan 2019 06:19:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f31sm15018499eda.16.2019.01.29.06.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:34 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:34 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:14 GMT
Message-Id: <2593b9ba7e396cdf84263ce6bbf192b7e91646f3.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 15/21] tests: include detailed trace logs with
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

