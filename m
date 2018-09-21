Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44D31F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbeIUVFR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:05:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43644 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390391AbeIUVFR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:05:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so5334833pgn.10
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CQtC/rucWB7+WfEGsQ+6Eyk6mZ39ADd1XdOLHj1e9ZA=;
        b=QuP4gCaCB49whnEkQqFARYgNqlUEgOXyPHC2BK2hndr3q9J/R6JVsMnCPy3VPuFdhP
         sMwObTxMQmAX9ccxIbK6ULDqHPfaWGGKas07aB4tcNR0NJc3QDzudd8N8dnIFp6Feqc5
         GrzoJ95rkm0wZOmwzTk0jcQAGVJylr9mt4LhzDRpduNnfRmBMe6DaRjZpnneiPmapNBQ
         lFg5JGsULTwhMDhrJu5P94K3Sf5kOhexgmyu1ywZzGtrc6e6riloSV5SY/HzDQhtG8Uf
         SA8gUXPF3kYytxleYIVRD1qW1bvj8RfWrJ7JDE8dA116c6D0pF5pLuuHRjGPMeNmkl2G
         QH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CQtC/rucWB7+WfEGsQ+6Eyk6mZ39ADd1XdOLHj1e9ZA=;
        b=CQn70JfxKbx0qaqNy1PErEXNHZFQTB+Oz+Io+Y8RFgDMgSQErzHf1+P+OPXpc8DVaM
         UvsVLsKdyYvLWXwI69S1IVqPr9TP1nzzaUMoc8dediDCb9xxb9TAHND0rNAjIfORJNtl
         4heqepxtdUy8tsnVgoJ/yxwwtY6MxePXhnxK5ctlaRMU+AAwZkEEJaSar2n7AYFq/SB+
         kWfhmmQCN/NimRisu8UevpqF07syLJoX9YzCSJ9pzXFOh8x6h8oK/UVB1cHJTiGvh8Uq
         nIhGh6wF+sTNzEVNuTbqYQ3ToVKDAXiDasoCR1LkzE70sRpxO5wGOvryF4bsAbTzFWQv
         Enyw==
X-Gm-Message-State: APzg51AkPQt0HUwxtodC4tNmzdtUL4ypiolJh2cQw36gPp/opIdK0HfA
        QnGLSzhEFsCXDjXJZBTiV5BA9gQy
X-Google-Smtp-Source: ANB0VdY+05xPxzuO6Q1oQOybWv6YdoSM7xiStLNePtLM2Zw1uoIvVVgJvZty5i3P+I8slFOBrTWLdw==
X-Received: by 2002:a63:26c4:: with SMTP id m187-v6mr6946017pgm.268.1537542956269;
        Fri, 21 Sep 2018 08:15:56 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y128-v6sm38545159pfb.56.2018.09.21.08.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:15:55 -0700 (PDT)
Date:   Fri, 21 Sep 2018 08:15:55 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 15:15:51 GMT
Message-Id: <21214cc321f80cf2e9eb0cdb1ec3ebb869ea496d.1537542952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.v3.git.gitgitgadget@gmail.com>
References: <pull.40.v2.git.gitgitgadget@gmail.com>
        <pull.40.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/1] contrib: add coverage-diff script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

We have coverage targets in our Makefile for using gcov to display line
coverage based on our test suite. The way I like to do it is to run:

    make coverage-test
    make coverage-report

This leaves the repo in a state where every X.c file that was covered has
an X.c.gcov file containing the coverage counts for every line, and "#####"
at every uncovered line.

There have been a few bugs in recent patches what would have been caught
if the test suite covered those blocks (including a few of mine). I want
to work towards a "sensible" amount of coverage on new topics. In my opinion,
this means that any logic should be covered, but the 'die()' blocks covering
very unlikely (or near-impossible) situations may not warrant coverage.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

    contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by the
test suite. The output uses 'git blame -c' format so you can find the commits
responsible and view the line numbers for quick access to the context.

Helped-by: Junio C Hamano <gister@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/coverage-diff.sh | 79 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 contrib/coverage-diff.sh

diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
new file mode 100755
index 0000000000..48b9a3ae96
--- /dev/null
+++ b/contrib/coverage-diff.sh
@@ -0,0 +1,79 @@
+#!/bin/sh
+
+# Usage: Run 'contrib/coverage-diff.sh <version1> <version2>' from source-root
+# after running
+#
+#     make coverage-test
+#     make coverage-report
+#
+# while checked out at <version2>. This script combines the *.gcov files
+# generated by the 'make' commands above with 'git diff <version1> <version2>'
+# to report new lines that are not covered by the test suite.
+
+V1=$1
+V2=$2
+
+diff_lines () {
+	perl -e '
+		my $line_num;
+		while (<>) {
+			# Hunk header?  Grab the beginning in postimage.
+			if (/^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/) {
+				$line_num = $1;
+				next;
+			}
+
+			# Have we seen a hunk?  Ignore "diff --git" etc.
+			next unless defined $line_num;
+
+			# Deleted line? Ignore.
+			if (/^-/) {
+				next;
+			}
+
+			# Show only the line number of added lines.
+			if (/^\+/) {
+				print "$line_num\n";
+			}
+			# Either common context or added line appear in
+			# the postimage.  Count it.
+			$line_num++;
+		}
+	'
+}
+
+files=$(git diff --name-only $V1 $V2 -- *.c)
+
+for file in $files
+do
+	git diff $V1 $V2 -- $file \
+		| diff_lines \
+		| sort >new_lines.txt
+
+	if ! test -s new_lines.txt
+	then
+		continue
+	fi
+
+	hash_file=$(echo $file | sed "s/\//\#/")
+	sed -ne '/#####:/{
+			s/    #####://
+			s/:.*//
+			s/ //g
+			p
+		}' "$hash_file.gcov" \
+		| sort >uncovered_lines.txt
+
+	comm -12 uncovered_lines.txt new_lines.txt \
+		| sed -e 's/$/\)/' \
+		| sed -e 's/^/\t/' \
+		>uncovered_new_lines.txt
+
+	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \
+		echo $file && \
+		git blame -c $file \
+			| grep -f uncovered_new_lines.txt
+
+	rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt
+done
+
-- 
gitgitgadget
