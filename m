Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E341F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeJOR4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:49 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37630 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:49 -0400
Received: by mail-pg1-f180.google.com with SMTP id c10-v6so8945687pgq.4
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MNwt14ajK0Mfe3nbcyzjOF8rPdvapSkedNcN49vcCPU=;
        b=nhmz0Pb5mzDL4sS5WEyKVoM4TMOgWoGQkTouYyJ4tHtTR140PVMfOsf0rnN5eDvl+n
         Mj+wR2q5wI1Bd5z/3Y5PXTH8S9ptMIFpM79HXtRoXDzpai5UyTWE/vFgiuVauOYr6UyK
         11TIvubDyL3Gl4N3b0Mqqc7NMSFJ2zWKgx+8KlVEhmRrCsZUSV9B5QrVWAnomxOZ/FEF
         ls9rBJd6SxdFMhGfwiiv/hvEYWltKjHdCjksnDPi/TXFPzUkb6+YopgoN6plvUHnEbMC
         96Jc/Vu3fJGAyffTzGW5Rz1iEQKY9ARm6/GoEyv63HH7BrNHeAf47HV0WJ/R0gx1KVlg
         ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MNwt14ajK0Mfe3nbcyzjOF8rPdvapSkedNcN49vcCPU=;
        b=prlk/CgZNRxamCM35eSjV9DTZbR8tWPYMnUq74+WQM2d7u5DMYcjHuYLpev8bUPVLF
         26adgoybg12FIaeFam0U/3QYnuDsbHvci9Fqekyoi2O5qS1QVS9fNQiBRXH7hhIRw0WP
         ecMXya6jrowq8234Gzd/FDHWtWikpDaoB6OiajhGM6fhDjRssA+q0UaNPibvKjJouuxo
         H+9REMxpdBWoNmWWrasstyxA+RUnBTCvu4sewXeI+hQ4xgfdoiRXpNKbO8JU27vPNTI0
         jLJjqwArzRugfFS5cepwMhAcmdUnpYNj09l47l1sXYHo8bINiKEHbXHiAWdzw/bSXu3g
         F8tQ==
X-Gm-Message-State: ABuFfojsI0YG0rKJnL3SDf+c+4VLVvMT2ra1GimclDsmaEnhyI8/ukWE
        TkrzIwrDmpk4tI4PTLMrIasES/Ig
X-Google-Smtp-Source: ACcGV62Kll7DirrLXCMTSR6RiqS+gUGQgyYWqn8cy+KAl3ttEJKIffMhHMc+aoaw6JWxDRGrA3RpAg==
X-Received: by 2002:aa7:8715:: with SMTP id b21-v6mr16790037pfo.250.1539598333497;
        Mon, 15 Oct 2018 03:12:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id 84-v6sm12520929pfv.33.2018.10.15.03.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:12 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:12 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:52 GMT
Message-Id: <ae3c42519abff7ef32c767f9587ef7f0160033ed.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/13] tests: include detailed trace logs with
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
 t/test-lib.sh | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6f9c1f5300..8a60e39364 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,6 +85,13 @@ done,*)
 	test "$(cat "$BASE.exit")" = 0
 	exit
 	;;
+*' --write-junit-xml '*)
+	# record how to call this script *with* --verbose-log, in case
+	# we encounter a breakage
+	junit_rerun_options_sq="$(printf '%s\n' "$0" --verbose-log -x "$@" |
+		sed -e "s/'/'\\\\''/g" -e "s/^/'/" -e "s/\$/'/" |
+		tr '\012' ' ')"
+	;;
 esac
 
 # For repeatability, reset the environment to known value.
@@ -446,10 +453,31 @@ test_ok_ () {
 test_failure_ () {
 	if test -n "$write_junit_xml"
 	then
+		if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
+		then
+			# clean up
+			test_atexit_handler
+
+			# re-run with --verbose-log
+			echo "# Re-running: $junit_rerun_options_sq" >&2
+
+			cd "$TEST_DIRECTORY" &&
+			eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
+				>/dev/null 2>&1
+			status=$?
+
+			say_color "" "$(test 0 = $status ||
+				echo "not ")ok $test_count - (re-ran with trace)"
+			say "1..$test_count"
+			GIT_EXIT_OK=t
+			exit $status
+		fi
+
 		junit_insert="<failure message=\"not ok $test_count -"
 		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
-			"$(printf '%s\n' "$@" | sed 1d)")"
+			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
+		>"$GIT_TEST_TEE_OUTPUT_FILE"
 		junit_insert="$junit_insert</failure>"
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
@@ -734,6 +762,10 @@ test_start_ () {
 	if test -n "$write_junit_xml"
 	then
 		junit_start=$(test-tool date getnanos)
+
+		# truncate output
+		test -z "$GIT_TEST_TEE_OUTPUT_FILE" ||
+		>"$GIT_TEST_TEE_OUTPUT_FILE"
 	fi
 }
 
-- 
gitgitgadget

