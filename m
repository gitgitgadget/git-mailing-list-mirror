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
	by dcvr.yhbt.net (Postfix) with ESMTP id 264FF1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfIZIa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:28 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:34395 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfIZIa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:26 -0400
Received: by mail-lj1-f176.google.com with SMTP id j19so1250533lja.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+ALQB6JMvVM0c9hGwY/fZEppEZoPfVaLQt24/cPaKnQ=;
        b=Dx3HGL1kqhj10iEV6cdMv39TZIFW5bH0ckf1xL+yhFGjWCA2FZU5SuBVibr8Cmi7gz
         Xr2+/csqTQPhOprxMEOgYbqomnMQTxai5jllloti5ocmXvUGB3gojTWbaliCxTcPuWR2
         p/SWqbeXX+6oGSsa7oeUN0acxpzwfJjxgGCp57kLf0xWvpkC+spyyaRJD/a3CMxogjsj
         TLUaEKzfaBZSM9oV+LyYUQisLsTCBx7Ni/a4GKHGzadr2x0B4EETJcnu6W6uEjWsbJkG
         8ekeBnseTbkOz6UNEOmQ06fJyaugjiI/DnvbN3k+12O6TiLZCRZOGCgXrBE2XcCcxaWr
         UoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+ALQB6JMvVM0c9hGwY/fZEppEZoPfVaLQt24/cPaKnQ=;
        b=RvfzcSClEfbKT/Px4yWUMC4FQu/tag+jx5XQ0vB5yjIholSzEG9T/GH133IIxKppMj
         SuAe5IrP9/NCo/+h4e6Cz8gaR0wLVGaq62jMdJcHphVQo31CPKvMgDB3AFFaYuDZJoKi
         R7PMkfePJWdh/obbAQOGLmUy/A3nUrwquL+SX45l4wG7KdXFxK+LLGbsc5nGbCMg4Il2
         OjvOBeQy/x7cRRITUO9TeCbpJaXK9c2lYOIyP31XELPRkyrRLKMSgbXoxbP8VoKfunmQ
         RlIYtF+U/pPCX3knemEDHAajrYMKrZHu3UltEcn+TSPs3kmNZBlsKfFA3qEXsjboxbQh
         rzeQ==
X-Gm-Message-State: APjAAAVg36tEX3vFBUhTJPo1ojwzpqhVy3pAROcW9Jf/haUMYYPL4O1N
        YtsMJdpV27b6QPu3CgLe7HfEck4h
X-Google-Smtp-Source: APXvYqyL61s0D6slVxYKf6/wGtCjPM2gLHi2gQYk2g2sYkR0wK3nmkoFR6UUkAcXMTmHyr5q5VqTbg==
X-Received: by 2002:a2e:1614:: with SMTP id w20mr1669141ljd.159.1569486622904;
        Thu, 26 Sep 2019 01:30:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23sm413380ljc.13.2019.09.26.01.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:22 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:22 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:04 GMT
Message-Id: <99724f6a1e45b497e15037bbac1cb5f70a3bb236.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/13] tests: let --immediate and --write-junit-xml play well
 together
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

When the `--immediate` option is in effect, any test failure will
immediately exit the test script. Together with `--write-junit-xml`, we
will want the JUnit-style `.xml` file to be finalized (and not leave the
XML incomplete). Let's make it so.

This comes in particularly handy when trying to debug via Azure
Pipelines, where the JUnit-style XML is consumed to present the test
results in an informative and helpful way.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d1ba33745a..f21c781e68 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -695,7 +695,7 @@ test_failure_ () {
 	say_color error "not ok $test_count - $1"
 	shift
 	printf '%s\n' "$*" | sed -e 's/^/#	/'
-	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
+	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
 }
 
 test_known_broken_ok_ () {
@@ -1063,6 +1063,25 @@ write_junit_xml_testcase () {
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
@@ -1085,21 +1104,7 @@ test_done () {
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

