Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A458E1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA0X07 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:59 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:45775 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfA0X05 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:57 -0500
Received: by mail-ed1-f49.google.com with SMTP id d39so11569391edb.12
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+n7i2tQJa0DlH1QtOlg+5zTg3n07wnZ+0QGC/00TeMc=;
        b=Jd+caI2zNb0G//pQJypwjBsdkjfJYciQQ/rufjXGt8qHLM2fwULPg3zRo6+1s+PCWi
         Y9YTz5f73Qr+h08JqSeUKi0GJXfknF+0nthVVRlX4vh8ml6Z9vXmzzXl3D3FIS+5HX9N
         h/QmQdfXmdNXxE/R5Ukdao6Ddp6O8ljNNTNXMkHN49az+14aVcK1bfy5P0+XZZ63lntJ
         wV06gRnBAhKn3ymHFK5Pw6KePqjjRLcrFGz3VV5hHz9XVyRs1Aj59dXRvIGkkvup2VO4
         Ec7TUPg7szdMHd3OpXCnoaiFRBx+DaN4P2LQnrhjESHj5Tn5Q5yEgiM8WZBY7KpWgJPe
         +QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+n7i2tQJa0DlH1QtOlg+5zTg3n07wnZ+0QGC/00TeMc=;
        b=Y3zsDyzZ43fQNJ1ZS2HwdSlfjGMqsrTQWsn4MPwS9OOizTxboVuZytbOXjqudeH6Ta
         pi0fOy/iGZlqlcdXNCrixcCtUb8V+i2f5yMgFKXx39gfXUxTYH6nUcghpm30fhddojLo
         K8dVyN8Zz3zcaMLXuyyDkZjAifDvYiBpQEyLqzT6ANGPPJ6Qvndr7JZ62VVn6y+IlJEj
         hykRYG7nTjKgAdFzCOly98Lj2aOTEiyv2AdQmsRPxvOxftsGnVIVrGSZ3UeuyJK9A/rw
         dCVe82v+SfTaO4t2i/m1Yz0yhW8NLqxc2qD3C2R/+sh375LMFs6BXYo/Z9jUpLfxTOV6
         rV/Q==
X-Gm-Message-State: AJcUukeDi+6rRKj9+V6ZoVVu/SoxmETBWjjxSR9+wOdtO0CiBIcRY/B0
        dBjLwvFfjtVqSwRRoTwtQK2hRwW4
X-Google-Smtp-Source: ALg8bN6JRmmNCc8Q9NEXO7Ukckzvjzi/5GYcIAUmT0O8LoXBRlkKQqVmZq2UZGuaKX2B0MsSckY7yg==
X-Received: by 2002:a17:906:4bd9:: with SMTP id x25mr6075895ejv.171.1548631615313;
        Sun, 27 Jan 2019 15:26:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p25sm373189ejn.6.2019.01.27.15.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:54 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:54 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:33 GMT
Message-Id: <31fbe114256688710216ad268c0c34206f71badd.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 07/21] tests: optionally write results as JUnit-style .xml
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
during an automated Azure DevOps run.

Note: we need to make extra sure that invalid UTF-8 encoding is turned
into valid UTF-8 (using the Replacement Character, \uFFFD) because
t9902's trace contains such invalid byte sequences, and the task in the
Azure Pipeline that uploads the test results would refuse to do anything
if it was asked to parse an .xml file with invalid UTF-8 in it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   |  1 +
 t/.gitignore               |  1 +
 t/helper/test-tool.c       |  1 +
 t/helper/test-tool.h       |  1 +
 t/helper/test-xml-encode.c | 80 +++++++++++++++++++++++++++++++++
 t/test-lib.sh              | 91 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 175 insertions(+)
 create mode 100644 t/helper/test-xml-encode.c

diff --git a/Makefile b/Makefile
index 1a44c811aa..044b4f77bd 100644
--- a/Makefile
+++ b/Makefile
@@ -754,6 +754,7 @@ TEST_BUILTINS_OBJS += test-submodule-config.o
 TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
+TEST_BUILTINS_OBJS += test-xml-encode.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
 TEST_BUILTINS_OBJS += test-windows-named-pipe.o
 TEST_BUILTINS_OBJS += test-write-cache.o
diff --git a/t/.gitignore b/t/.gitignore
index 348715f0e4..91cf5772fe 100644
--- a/t/.gitignore
+++ b/t/.gitignore
@@ -2,3 +2,4 @@
 /test-results
 /.prove
 /chainlinttmp
+/out/
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index bfb195b1a8..4b4b397d93 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -49,6 +49,7 @@ static struct test_cmd cmds[] = {
 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
 	{ "subprocess", cmd__subprocess },
 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
+	{ "xml-encode", cmd__xml_encode },
 	{ "wildmatch", cmd__wildmatch },
 #ifdef GIT_WINDOWS_NATIVE
 	{ "windows-named-pipe", cmd__windows_named_pipe },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 042f12464b..c0ab65e370 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -45,6 +45,7 @@ int cmd__submodule_config(int argc, const char **argv);
 int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__urlmatch_normalization(int argc, const char **argv);
+int cmd__xml_encode(int argc, const char **argv);
 int cmd__wildmatch(int argc, const char **argv);
 #ifdef GIT_WINDOWS_NATIVE
 int cmd__windows_named_pipe(int argc, const char **argv);
diff --git a/t/helper/test-xml-encode.c b/t/helper/test-xml-encode.c
new file mode 100644
index 0000000000..367c4875e6
--- /dev/null
+++ b/t/helper/test-xml-encode.c
@@ -0,0 +1,80 @@
+#include "test-tool.h"
+
+static const char *utf8_replace_character = "&#xfffd;";
+
+/*
+ * Encodes (possibly incorrect) UTF-8 on <stdin> to <stdout>, to be embedded
+ * in an XML file.
+ */
+int cmd__xml_encode(int argc, const char **argv)
+{
+	unsigned char buf[1024], tmp[4], *tmp2 = NULL;
+	ssize_t cur = 0, len = 1, remaining = 0;
+	unsigned char ch;
+
+	for (;;) {
+		if (++cur == len) {
+			len = xread(0, buf, sizeof(buf));
+			if (!len)
+				return 0;
+			if (len < 0)
+				die_errno("Could not read <stdin>");
+			cur = 0;
+		}
+		ch = buf[cur];
+
+		if (tmp2) {
+			if ((ch & 0xc0) != 0x80) {
+				fputs(utf8_replace_character, stdout);
+				tmp2 = 0;
+				cur--;
+				continue;
+			}
+			*tmp2 = ch;
+			tmp2++;
+			if (--remaining == 0) {
+				fwrite(tmp, tmp2 - tmp, 1, stdout);
+				tmp2 = 0;
+			}
+			continue;
+		}
+
+		if (!(ch & 0x80)) {
+			/* 0xxxxxxx */
+			if (ch == '&')
+				fputs("&amp;", stdout);
+			else if (ch == '\'')
+				fputs("&apos;", stdout);
+			else if (ch == '"')
+				fputs("&quot;", stdout);
+			else if (ch == '<')
+				fputs("&lt;", stdout);
+			else if (ch == '>')
+				fputs("&gt;", stdout);
+			else if (ch >= 0x20)
+				fputc(ch, stdout);
+			else if (ch == 0x09 || ch == 0x0a || ch == 0x0d)
+				fprintf(stdout, "&#x%02x;", ch);
+			else
+				fputs(utf8_replace_character, stdout);
+		} else if ((ch & 0xe0) == 0xc0) {
+			/* 110XXXXx 10xxxxxx */
+			tmp[0] = ch;
+			remaining = 1;
+			tmp2 = tmp + 1;
+		} else if ((ch & 0xf0) == 0xe0) {
+			/* 1110XXXX 10Xxxxxx 10xxxxxx */
+			tmp[0] = ch;
+			remaining = 2;
+			tmp2 = tmp + 1;
+		} else if ((ch & 0xf8) == 0xf0) {
+			/* 11110XXX 10XXxxxx 10xxxxxx 10xxxxxx */
+			tmp[0] = ch;
+			remaining = 3;
+			tmp2 = tmp + 1;
+		} else
+			fputs(utf8_replace_character, stdout);
+	}
+
+	return 0;
+}
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a1abb1177a..a3b2166cb5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -139,6 +139,9 @@ do
 		verbose_log=t
 		tee=t
 		;;
+	--write-junit-xml)
+		write_junit_xml=t
+		;;
 	--stress)
 		stress=t ;;
 	--stress=*)
@@ -622,11 +625,24 @@ trap 'exit $?' INT TERM HUP
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
@@ -635,11 +651,19 @@ test_failure_ () {
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
@@ -897,6 +921,10 @@ test_start_ () {
 	test_count=$(($test_count+1))
 	maybe_setup_verbose
 	maybe_setup_valgrind
+	if test -n "$write_junit_xml"
+	then
+		junit_start=$(test-tool date getnanos)
+	fi
 }
 
 test_finish_ () {
@@ -934,6 +962,13 @@ test_skip () {
 
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
@@ -949,9 +984,51 @@ test_at_end_hook_ () {
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
+	printf '%s\n' "$@" | test-tool xml-encode
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
 		mkdir -p "$TEST_RESULTS_DIR"
@@ -1178,6 +1255,7 @@ then
 else
 	mkdir -p "$TRASH_DIRECTORY"
 fi
+
 # Use -P to resolve symlinks in our working directory so that the cwd
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$TRASH_DIRECTORY" || exit 1
@@ -1191,6 +1269,19 @@ then
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

