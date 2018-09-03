Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC65B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeIDBcf (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:35 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:33790 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:35 -0400
Received: by mail-pf1-f178.google.com with SMTP id d4-v6so634109pfn.0
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1DDQ6bQHLeFLD4TmezyGWVpGQjEaG26ldFkIE4QNdB0=;
        b=RmInlSdmGw+tl45rSicc8KEEqFbb9BdZxjBtXlRdFqxUj1/SZeg7d0+Z9sNqjr08Bg
         UpHNWAER+wQMU6R9fVTJCCn7uQCtw82PZ/A7LNLdOo5QK6zx9RY+KFkHQlJtdFuZZKcV
         8tZVCGauREhcIveabtBfFrfwPTlMx7YSgDUGZNSYzxLstaQuYOknT4ZDBb1pBQTAlf/+
         9kR1N5CfcbzjdO2ACBtVM/GSE2FDCp4LdfZxEeHTmcoWgU4FvPYj9jJpOzYodmR+mUQd
         pA4YYwBsSkV1jK4w+zJhtxOPtXLqGKmLIZuWEkahXQeH58xC2CUky/Li0g7VxxadZB2r
         1pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1DDQ6bQHLeFLD4TmezyGWVpGQjEaG26ldFkIE4QNdB0=;
        b=bpJBpQXwA/XCty9taAj90+8ytgxrfWBL5Y+JSVfBcaYyqfIGaghCLsrxEkgG43WN82
         V8wxP6fs1FvemluzMDQnRzOI3mJg8pUGgBnaMxdZk+sWo3Xeq1/HuFwOT7m3IQ/eOUoi
         fBPCj4xvtScFqju+3FCAPoCdgWxWp+7Ng4oiCQV6hr8CV933b8cjW5Y6IS8WXLkrKxTL
         NkzebZp70PTPq2yA3sLlGbMBNyKOBBR87gnsWCRPoXCee/m8Z3WaGvrZy3OxcH5cOF/H
         1rivoadtE0rnpTxQx16ZdZrpEU0I384ncEnzl9O2e0qhN6V2igCOwPZlXR6tnSKp8NgU
         zgXg==
X-Gm-Message-State: APzg51DTdm6bgbmM1zub6bvZbsL1HpsRGFG9mMGuyMSl9P/bUci5qcka
        dpS9VPslGd3mHIc48mpf8Wzso98E
X-Google-Smtp-Source: ANB0VdagE3wtpHHbIkjvRK65Q9LDI88OY9mC1Ea/kxW2OWEmhAIOAqxs1RG79aq/EYKnrM/R9b8MKA==
X-Received: by 2002:a63:5ec1:: with SMTP id s184-v6mr28389704pgb.26.1536009035345;
        Mon, 03 Sep 2018 14:10:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id m21-v6sm25543969pgd.6.2018.09.03.14.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:34 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:34 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:21 GMT
Message-Id: <2b5d6785944ed1a66f0272896a45fece8521d10f.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/9] tests: optionally write results as JUnit-style .xml
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

This will come in handy when publishing the results of Git's test suite
during an automated VSTS CI run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/.gitignore  |  1 +
 t/test-lib.sh | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/t/.gitignore b/t/.gitignore
index 348715f0e4..91cf5772fe 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -2,3 +2,4 @@
 /test-results
 /.prove
 /chainlinttmp
+/out/
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8bb0f4348e..50a65a600e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -288,6 +288,9 @@ do
 	--verbose-log)
 		verbose_log=t
 		shift ;;
+	--write-junit-xml)
+		write_junit_xml=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -431,11 +434,24 @@ trap 'exit $?' INT
 # the test_expect_* functions instead.
 
 test_ok_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$*"
+	fi
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
 }
 
 test_failure_ () {
+	if test -n "$write_junit_xml"
+	then
+		junit_insert="<failure message=\"not ok $test_count -"
+		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode \
+			"$(printf '%s\n' "$@" | sed 1d)")"
+		junit_insert="$junit_insert</failure>"
+		write_junit_xml_testcase "$1" "      $junit_insert"
+	fi
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -444,11 +460,19 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$* (breakage fixed)"
+	fi
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
 }
 
 test_known_broken_failure_ () {
+	if test -n "$write_junit_xml"
+	then
+		write_junit_xml_testcase "$* (known breakage)"
+	fi
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
 }
@@ -706,6 +730,10 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
+	if test -n "$write_junit_xml"
+	then
+		junit_start=$(test-tool date getnanos)
+	fi
 }
 
 test_finish_ () {
@@ -743,6 +771,13 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
+		if test -n "$write_junit_xml"
+		then
+			message="$(xml_attr_encode "$skipped_reason")"
+			write_junit_xml_testcase "$1" \
+				"      <skipped message=\"$message\" />"
+		fi
+
 		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
@@ -758,9 +793,58 @@ test_at_end_hook_ () {
 	:
 }
 
+write_junit_xml () {
+	case "$1" in
+	--truncate)
+		>"$junit_xml_path"
+		junit_have_testcase=
+		shift
+		;;
+	esac
+	printf '%s\n' "$@" >>"$junit_xml_path"
+}
+
+xml_attr_encode () {
+	# We do not translate CR to &#x0d; because BSD sed does not handle
+	# \r in the regex. In practice, the output should not even have any
+	# carriage returns.
+	printf '%s\n' "$@" |
+	sed -e 's/&/\&amp;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g' \
+		-e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
+		-e 's/	/\&#x09;/g' -e 's/$/\&#x0a;/' -e '$s/&#x0a;$//' |
+	tr -d '\012\015'
+}
+
+write_junit_xml_testcase () {
+	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
+	shift
+	junit_attrs="$junit_attrs classname=\"$this_test\""
+	junit_attrs="$junit_attrs time=\"$(test-tool \
+		date getnanos $junit_start)\""
+	write_junit_xml "$(printf '%s\n' \
+		"    <testcase $junit_attrs>" "$@" "    </testcase>")"
+	junit_have_testcase=t
+}
+
 test_done () {
 	GIT_EXIT_OK=t
 
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
+	fi
+
 	if test -z "$HARNESS_ACTIVE"
 	then
 		test_results_dir="$TEST_OUTPUT_DIRECTORY/test-results"
@@ -996,6 +1080,7 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
+
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
@@ -1009,6 +1094,19 @@ then
 	test_done
 fi
 
+if test -n "$write_junit_xml"
+then
+	junit_xml_dir="$TEST_OUTPUT_DIRECTORY/out"
+	mkdir -p "$junit_xml_dir"
+	junit_xml_base=${0##*/}
+	junit_xml_path="$junit_xml_dir/TEST-${junit_xml_base%.sh}.xml"
+	junit_attrs="name=\"${junit_xml_base%.sh}\""
+	junit_attrs="$junit_attrs timestamp=\"$(TZ=UTC \
+		date +%Y-%m-%dT%H:%M:%S)\""
+	write_junit_xml --truncate "<testsuites>" "  <testsuite $junit_attrs>"
+	junit_suite_start=$(test-tool date getnanos)
+fi
+
 # Provide an implementation of the 'yes' utility
 yes () {
 	if test $# = 0
-- 
gitgitgadget

