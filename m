Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FD71F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfA0X1L (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:11 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:40372 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfA0X1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:04 -0500
Received: by mail-ed1-f52.google.com with SMTP id g22so11591045edr.7
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=ia6WC85chyVZJFMn+VHX72+HsU4uTzIx5wRYvjZDUHiT6XxyCGavj7To/8YTplr7Ah
         AyMUKxtdOPWVTV3HgNx+XN2y/Egio/CdzEnCbKOvIq+zFHUymKbWlO9+jW+kDYA9JzpL
         bFcRyADK/Us5aLaUNFSelUvdoC4p0z6bPbut4OZX/ZLncZRj5BVBoEcmpUy+AzVxhoBe
         fuag7WTTp/TA1Nt3JAOZOK4d/P0L4do992KYGcT0QJhLMrKEBSw/NDD9HV9aHaLSXgcP
         C6Bw88PF+grRUBFMda9FRplLRdFutO4QfuHcVLCEKW6hSqtqW2lyuFC2QLJxMh/S3eD6
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mErgkvF3RwT1uEOg4N3negTT4Om6xVcCHQyQL+1J7Sw=;
        b=BRY6/pxdOaxhR5b7jIE/BcQqNm+Ghr4JiTxXz+7hhSBKUTyKazpYjVT9pj2oySe/eV
         QAyHA6BdwWhbJ616HWNmbYEE+HEEdER+ajG2JWgQCtkSuxdfxQHHAMcyUBUM7Tl06LzD
         YbFF1OUS1ePeGCrX9cbsveb5G5c3YsQvCryBIuglJqL3CQKoWEQx4czSNynxFDY3sxHl
         GJAsIFTV5ICUH4mQB7LeNaWLPKT45qj24Nx45CceBHJ3DxcRPcOP5o1WbxQJHBva/82d
         llUAf4xQOdfmx5iNDCrjhR47Iq7QW3uwmLj2JIDC6D3RhyDhm4n76OL33IomsSymn5nY
         VXAA==
X-Gm-Message-State: AJcUukeuhFqPtIG0fOSOe6QDgkucCLa9yjJKE8r4UUJ3SvMC4v3sDETu
        sY2OYgWzqzz39GfmXbSqCFalOm+B
X-Google-Smtp-Source: ALg8bN5YWm0NRLdhTrvUisiFCpTQ+fuwh/d2klu83Gfmd+4C7kM3FB+ynwdTS81X7/zggtCbwnLFow==
X-Received: by 2002:a17:906:258f:: with SMTP id m15-v6mr17505266ejb.191.1548631622161;
        Sun, 27 Jan 2019 15:27:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r42sm13689214edd.23.2019.01.27.15.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:01 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:01 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:41 GMT
Message-Id: <dfd3516f39d3b35ed451426d0f87cfbd93ffd06f.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 15/21] tests: include detailed trace logs with
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

