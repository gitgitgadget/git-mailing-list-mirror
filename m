Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C27B1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393244AbfAPNgm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:42 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35321 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393227AbfAPNg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:27 -0500
Received: by mail-ed1-f42.google.com with SMTP id x30so5448724edx.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YWWVkd3zsvRM1u9QD3+kA6vezpKuExOYkyGwHgrrNPA=;
        b=sPUAz/FAqh+0HrBokgMoPnOs3mOSCKyHtZUxHG69Eoitto01E5AijzGApVsV/oQk8I
         OAtZVbTNXvToPAMhvOmL+GjKDzTvG76HXQ5+RVlqB+jZsKVL1ACJuOgf9wUsk9sFlFkd
         ra/SBIo14s0JeWicF8DltD3isQ+1GdRIWGz2e6oc1rq6Svy1dfm02Viv6isSKA9BTmkt
         meSQF3JX/2PwfzZiQKKd9DemG6Zj8+yqG1zrXgqdNa3MEcEJTuFDifgroztHBEi7oqlo
         K4dqfi+/DWdsLkBODRwqOcdTG1GsYc+/9U9uuSPVzy/kypjn776R1d/eITLhzQsIdyiD
         Eh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YWWVkd3zsvRM1u9QD3+kA6vezpKuExOYkyGwHgrrNPA=;
        b=SEk9pwFjUhTJIZSzdA1qOZrjtLGJ/g2kEcF2D17GsO5zamXA58TaAa4Qy34kWPj3vz
         rNziegPULv2b1/PS8VJHgecPdiSjRwj4XcwampHTVo9CA8+75tnBdZUzJDmSS8eZT20s
         W9d6f1wxtbIobPaxlrEavkZrvDoxS4XrFyj14VpxFriQpMKHfQoqwjjII+cd6FnVFxhU
         0lSjk6EaBMAKhfL+6QzZ2qhDekmGyYyWtBBW1uFXYs6dAZg8I8kJwCJ6iGC84X2j7qqC
         Qt10VJvH+XxvZSa67zsiEuZqwoPtRNXoNeC17q7JmDSPdEoF/suTypVhyZ5xWR/snCgA
         e7Pw==
X-Gm-Message-State: AJcUuke7clDyhNDGgTZmfRUTm8Zpj+rvNcod67SKf8Ymv7eRZkUFvEbU
        YrgF14qW+TNPbid90xMwFzL+NUek
X-Google-Smtp-Source: ALg8bN7ebWyZRXQf4j6ZijiWjbnz2m8M6ig1/o9r5z1lQalY/ZYqVaKpj/IeqS3KEUY88AWagNA24Q==
X-Received: by 2002:a17:906:9413:: with SMTP id q19-v6mr6800396ejx.208.1547645785214;
        Wed, 16 Jan 2019 05:36:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13-v6sm3031521ejk.50.2019.01.16.05.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:24 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:36:03 GMT
Message-Id: <f678b105f81ec60f64c0f19e3cc7a8ef151ed52e.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 15/21] tests: include detailed trace logs with
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
 t/test-lib.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index e9782b6b32..f5371f505a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -503,8 +503,18 @@ test_failure_ () {
 		junit_insert="<failure message=\"not ok $test_count -"
 		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(printf '%s\n' "$@" | sed 1d)")"
+			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+			   then
+				cut -c "$GIT_TEST_TEE_OFFSET-" <"$GIT_TEST_TEE_OUTPUT_FILE"
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
@@ -872,6 +882,11 @@ write_junit_xml_testcase () {
 	write_junit_xml "$(printf '%s\n' \
 		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
 	junit_have_testcase=t
+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+	then
+		GIT_TEST_TEE_OFFSET=$(test-tool path-utils file-size \
+			"$GIT_TEST_TEE_OUTPUT_FILE")
+	fi
 }
 
 test_done () {
@@ -1153,6 +1168,11 @@ then
 		date +%Y-%m-%dT%H:%M:%S)\""
 	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
 	junit_suite_start=$(test-tool date getnanos)
+	if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
+	then
+		GIT_TEST_TEE_OFFSET=0
+		GIT_TEST_TEE_ERR_OFFSET=0
+	fi
 fi
 
 # Provide an implementation of the 'yes' utility
-- 
gitgitgadget

