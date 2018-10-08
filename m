Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87861F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJHWES (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:04:18 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35571 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJHWER (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:04:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id f8-v6so10196855plb.2
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NQxqxnkWI6Yi+lYaM7GYNeVlF52F3agCl+JNVwIABnE=;
        b=dNV5I/3dh8BmXp+b0krov7TYJnBZpoGD5wo7pZPtbSB+Z/sQTrq4n/GM9x05oSLbqS
         Nz0eDLbkfYwPif4u6R/XLN0YWtIgHW9nlapiTtX44QuTD07hH2XukdN3q6MiJBC8Fv/A
         4Tbip1oZhpVuzpUQ613ED61WZ9NHZLWR9p1dip2PrNY8RMGxKQLrZ7xr4bHUmPEqu9fK
         hqYOBge8khh664NMeBbFT2Ply4wZ4Rx7R8yT5Xd7YWRti5Q/mV2b7zF2NZO4/S+zCUO0
         PYPZKzHSNFYTlp5lagZ/0Owf5KdDjYMxM4ixMr4KrTRn1X1/yeX2DyVteinLQJDX7x8/
         GfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NQxqxnkWI6Yi+lYaM7GYNeVlF52F3agCl+JNVwIABnE=;
        b=RfchvMxu3iWV+hURM2eUpdjDd93Zx6yQEjAke6a8ANFNUZyM4EzOmvM42t1HnkAmrR
         C4ZOBldAcOXejD7NOyUgaE3pq0r464/tPGQRAoqlRm3L6b10jbRahEl6EY65XUngmJOL
         tZIcfsFz5nSkaN4agJyau99kFYXorFRJs1Adm8TGWA5FddKD56Ph4S1N9jOC/OHdi67V
         Qc6gRq8ZKZxNLRgfteO8ZpzpC4kq/AATCEulGg92LaaMvyl9EMwRkv+Xwytuyz+F1gHJ
         Y7jOO8VErn4osnenASWi4CQBbhI6B352TOdXqM/pdl62pCgYjNnqZL8Rkz5Mw6gi5igD
         OeHw==
X-Gm-Message-State: ABuFfogifebbsmP/JUD2yFB+hPMI9G2dHIdfa264rNnRa9G3yFp3Iqmq
        Jax8QvSeZbl+Kz4by4mZ84qmKC1R
X-Google-Smtp-Source: ACcGV61OLKdmsd9OIoFMTW0TZOXG3GkmlcuhPgJ1tm5rzmhzJU6FrExm5eXZbZqCDnfXKwNgCyI0AQ==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3-v6mr24728194plb.80.1539010330487;
        Mon, 08 Oct 2018 07:52:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h8-v6sm4601061pgg.23.2018.10.08.07.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 07:52:09 -0700 (PDT)
Date:   Mon, 08 Oct 2018 07:52:09 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 14:52:06 GMT
Message-Id: <6daf310a43b2b35467393a8c5e34e76f4b9391d7.1539010326.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.v4.git.gitgitgadget@gmail.com>
References: <pull.40.v3.git.gitgitgadget@gmail.com>
        <pull.40.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 1/1] contrib: add coverage-diff script
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
test suite. The output uses 'git blame -s' format so you can find the commits
responsible and view the line numbers for quick access to the context, but
trims leading tabs in the file contents to reduce output width.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/coverage-diff.sh | 108 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100755 contrib/coverage-diff.sh

diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
new file mode 100755
index 0000000000..4ec419f900
--- /dev/null
+++ b/contrib/coverage-diff.sh
@@ -0,0 +1,108 @@
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
+files=$(git diff --name-only "$V1" "$V2" -- \*.c)
+
+# create empty file
+>coverage-data.txt
+
+for file in $files
+do
+	git diff "$V1" "$V2" -- "$file" |
+	diff_lines |
+	sort >new_lines.txt
+
+	if ! test -s new_lines.txt
+	then
+		continue
+	fi
+
+	hash_file=$(echo $file | sed "s/\//\#/")
+
+	if ! test -s "$hash_file.gcov"
+	then
+		continue
+	fi
+
+	sed -ne '/#####:/{
+			s/    #####://
+			s/:.*//
+			s/ //g
+			p
+		}' "$hash_file.gcov" |
+	sort >uncovered_lines.txt
+
+	comm -12 uncovered_lines.txt new_lines.txt |
+	sed -e 's/$/\)/' |
+	sed -e 's/^/ /' >uncovered_new_lines.txt
+
+	grep -q '[^[:space:]]' <uncovered_new_lines.txt &&
+	echo $file >>coverage-data.txt &&
+	git blame -s "$V2" -- "$file" |
+	sed 's/\t//g' |
+	grep -f uncovered_new_lines.txt >>coverage-data.txt &&
+	echo >>coverage-data.txt
+
+	rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt
+done
+
+cat coverage-data.txt
+
+echo "Commits introducing uncovered code:"
+
+commit_list=$(cat coverage-data.txt |
+	grep -E '^[0-9a-f]{7,} ' |
+	awk '{print $1;}' |
+	sort |
+	uniq)
+
+(
+	for commit in $commit_list
+	do
+		git log --no-decorate --pretty=format:'%an      %h: %s' -1 $commit
+		echo
+	done
+) | sort
+
+rm coverage-data.txt
-- 
gitgitgadget
