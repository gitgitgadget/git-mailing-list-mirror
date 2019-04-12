Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37CCF20248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfDLJhd (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:37:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37262 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfDLJh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:37:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id f53so6178884ede.4
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sHdx3mOtvpXxs6URTJ/MN7LjCPBzzxYk7MrRoOGx2fI=;
        b=TeensCcf/TUwjvpzhp0irj8VQrjhRWXsPqiITUdcwL1xQzUutk2tQ2+yeD62KOvmQf
         B8rLdr8ETtBXT+HWuvFGqeMtxGf2gjosRW13Rd8Q0WvYLRlqruXAn+VUlDcb8VqxZDOs
         ScUGTYMDv69NyM2vPilNO2JzBZPUvRiTRISqd8OdGgUsJWoP2TxpxMfVtiv7rniZjkeE
         st5EiH+TeUdG+cqh0MGrbkWN7JoZl27rioCbxYQPFGWzAqS0qXwZcGvySunHOOhURWTh
         dRIglGhQAdcT4VjvLkkEylK1yh5nT93od5gKSFypC21BWD+DoPn6lED47ESoACtWIh5f
         G6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sHdx3mOtvpXxs6URTJ/MN7LjCPBzzxYk7MrRoOGx2fI=;
        b=rqr5HHl6zGzGtSUL20ZDr5Q+HEuBPIjnrdRx7d9RjZwz9LIiS6W8Es3scZLPtwkEti
         t+6isfheXFhZJnog2HIgKJmobaEh2BclAAAFp+ullsnFzTSidjK2PYxvk0daPYOJT3Va
         4CfY9xiXdUgqbv6n99QVXsgN0swtX27tiA4Og/Q34NDaWt2AG6LIkYdH8Jb5gN6FJJkl
         NWee2DwsQl8kVCTP280qXHLnyOoGgdobguWwJXhGMRG7wS2r71RRJI5XZ+4FKkwQhZNB
         eXv9MvECXkEC5N0s4dmkxsPl03vuYWPh05AZTiIA99ezB8NpUr1YMq0015PFnICOClwc
         RJfw==
X-Gm-Message-State: APjAAAXIknt/FWye2l7pUtGbEs+mhL1IeB5eYvZAsYt1zDi6mxvPWvS1
        /VkAzrBeplY0NHsT0VbPTR7IIxyr
X-Google-Smtp-Source: APXvYqwnrVY1G9eBnaiyzNcf1MfjBT3+6pC8IqGRb4xEQuokZEyVV0Cumh4OJooZkuCgVxcJJeQwfw==
X-Received: by 2002:a17:906:d0c5:: with SMTP id bq5mr31052122ejb.43.1555061845233;
        Fri, 12 Apr 2019 02:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20sm12023888eda.40.2019.04.12.02.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 02:37:24 -0700 (PDT)
Date:   Fri, 12 Apr 2019 02:37:24 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 09:37:17 GMT
Message-Id: <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.167.v2.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 8/8] tests: disallow the use of abbreviated options (by
 default)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git's command-line parsers support uniquely abbreviated options, e.g.
`git init --ba` would automatically expand `--ba` to `--bare`.

This is a very convenient feature in every day life for Git users, in
particular when tab completion is not available.

However, it is not a good idea to rely on that in Git's test suite, as
something that is a unique abbreviation of a command line option today
might no longer be a unique abbreviation tomorrow.

For example, if a future contribution added a new mode
`git init --babyproofing` and a previously-introduced test case used the
fact that `git init --ba` expanded to `git init --bare`, that future
contribution would now have to touch seemingly unrelated tests just to
keep the test suite from failing.

So let's disallow abbreviated options in the test suite by default.

Note: for ease of implementation, this patch really only touches the
`parse-options` machinery: more and more hand-rolled option parsers are
converted to use that internal API, and more and more scripts are
converted to built-ins (naturally using the parse-options API, too), so
in practice this catches most issues, and is definitely the biggest bang
for the buck.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 parse-options.c          |  9 +++++++++
 t/README                 |  4 ++++
 t/t0040-parse-options.sh | 14 +++++++++++++-
 t/test-lib.sh            |  7 +++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index cec74522e5..acc3a93660 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "color.h"
 #include "utf8.h"
 
+static int disallow_abbreviated_options;
+
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
@@ -344,6 +346,10 @@ static enum parse_opt_result parse_long_opt(
 		return get_value(p, options, all_opts, flags ^ opt_flags);
 	}
 
+	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
+		die("disallowed abbreviated or ambiguous option '%.*s'",
+		    (int)(arg_end - arg), arg);
+
 	if (ambiguous_option) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
@@ -708,6 +714,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
 {
 	struct parse_opt_ctx_t ctx;
 
+	disallow_abbreviated_options =
+		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
+
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
diff --git a/t/README b/t/README
index 656288edce..9ed3051a1c 100644
--- a/t/README
+++ b/t/README
@@ -399,6 +399,10 @@ GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 fetch-pack to not request sideband-all (even if the server advertises
 sideband-all).
 
+GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
+the default when running tests), errors out when an abbreviated option
+is used.
+
 Naming Tests
 ------------
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index b8f366c442..6f6f74bfe2 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -203,20 +203,24 @@ file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --expect="integer: 2" --int=2
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test_expect_code 129 test-tool parse-options --strin 123
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool parse-options --strin 123
 '
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
@@ -325,6 +329,7 @@ file: (not set)
 EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --no-ambig >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
@@ -370,4 +375,11 @@ test_expect_success '--no-verbose resets multiple verbose to 0' '
 	test-tool parse-options --expect="verbose: 0" -v -v -v --no-verbose
 '
 
+test_expect_success 'GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS works' '
+	env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+		test-tool parse-options --ye &&
+	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+		test-tool parse-options --ye
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 562c57e685..f1a0fea4e1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,6 +57,13 @@ fi
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
+# Disallow the use of abbreviated options in the test suite by default
+if test -n "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS:+isset}"
+then
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
+	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
+fi
+
 ################################################################
 # It appears that people try to run tests without building...
 "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
-- 
gitgitgadget
