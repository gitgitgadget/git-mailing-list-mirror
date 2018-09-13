Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8821F404
	for <e@80x24.org>; Thu, 13 Sep 2018 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeIMUGi (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:06:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45679 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeIMUGh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:06:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id x26-v6so2854110pge.12
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ygNhw3g/6YG8B7ADNsdBfQ6Kw/7VV5VKrDmFcDWWReE=;
        b=TTvpIZBJccVXJoIAE9mB8z6Xj71mW4BAM5zbKIlf3GVkNhxV70mRZAaIhRuDkqT4es
         pTiaUEdsdS7CwleOS/DGnhHQ8UO9mmWwqQUSuRiB1lK5PqQMFiUrqwVVzCsGQl1x50MY
         NIKV+ilMZFxeSVDQehCKukU+FLL5EqLDvQ8Z74ijyGJ40/pHHhHNNy5RTiusFlV+mDdj
         MKXo15wM0dNqblt3Nvrx+qGJpNmW4N0N/yf2+VjZ+vu3m6bym6DwB82/JhohhohxVU+V
         SI0BTkPq6QKvMua2zG+zevGe+Ds0w5e9DjczU4UknkE1zKWSniTYw7sTTgJQmaTrtf5E
         XGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ygNhw3g/6YG8B7ADNsdBfQ6Kw/7VV5VKrDmFcDWWReE=;
        b=j5f7j6QQe+SLga1FYK/DNQDNBeaHYe/IIwxzXiVLKouVuGh4sScqztacd/Z/POUyQs
         +g2qg72foTf0K1l/vtg21EqaSJvFfbaPtNV3l0v+AblbJ1hrUJAUtYiQCvvy4pjm4OsS
         a7A4GOHJCWxmVEPHvCtAN59mRRgqz8PGsjW3GH6drZdjMT2qstvNQfnwYHx0tenQtAdM
         gNm1rqnNuNQUPjqwhnnGZaRrKO6Wj+Apig1ZCrazB7R8sHwpvQdzlX8GY4gBnieDMax5
         YuaJjPAug/So5kjOYj/gymvHY0oqZaawd+zm/jJ+m7/wUFE4r/2iZdlL0ljEekz56kKA
         0mnw==
X-Gm-Message-State: APzg51Ded1RUOHX9yuD5MaC6okRCKhf3yG6Di4m2t6O1maPCgXBp4ghT
        prp2FxPFwryFnmMOdCGLMklgdkPz
X-Google-Smtp-Source: ANB0VdbuFfoiOBU4eWV6NHYUteEoy7OXdooqOT9b4Wrs1BHR10WIJaBS/MKtDRjkq44evzZBPHG38A==
X-Received: by 2002:a62:1192:: with SMTP id 18-v6mr7940391pfr.54.1536850605014;
        Thu, 13 Sep 2018 07:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v6-v6sm7847751pfa.28.2018.09.13.07.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 07:56:44 -0700 (PDT)
Date:   Thu, 13 Sep 2018 07:56:44 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 14:56:40 GMT
Message-Id: <7714b0659e3210e34d0904b3347473427546d15c.1536850601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.v2.git.gitgitgadget@gmail.com>
References: <pull.40.git.gitgitgadget@gmail.com>
        <pull.40.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] contrib: add coverage-diff script
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
this means that any logic should be covered, but the 'die()' blocks in error
cases do not need to be covered.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

    contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by the
test suite. The output uses 'git blame -c' format so you can find the commits
responsible and view the line numbers for quick access to the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 contrib/coverage-diff.sh | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100755 contrib/coverage-diff.sh

diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
new file mode 100755
index 0000000000..0f226f038c
--- /dev/null
+++ b/contrib/coverage-diff.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+# Usage: 'contrib/coverage-diff.sh <version1> <version2>
+# Outputs a list of new lines in version2 compared to version1 that are
+# not covered by the test suite. Assumes you ran
+# 'make coverage-test coverage-report' from root first, so .gcov files exist.
+
+V1=$1
+V2=$2
+
+diff_lines () {
+	while read line
+	do
+		if echo $line | grep -q -e "^@@ -([0-9]+)(,[0-9]+)? \\+([0-9]+)(,[0-9]+)? @@.*"
+		then
+			line_num=$(echo $line \
+				| awk 'match($0, "@@ -([0-9]+)(,[0-9]+)? \\+([0-9]+)(,[0-9]+)? @@.*", m) { print m[3] }')
+		else
+			echo "$line_num:$line"
+			if ! echo $line | grep -q -e "^-"
+			then
+				line_num=$(($line_num + 1))
+			fi
+		fi
+	done
+}
+
+files=$(git diff --raw $V1 $V2 \
+	| grep \.c$ \
+	| awk 'NF>1{print $NF}')
+
+for file in $files
+do
+	git diff $V1 $V2 -- $file \
+		| diff_lines \
+		| grep ":+" \
+		| sed 's/:/ /g' \
+		| awk '{print $1}' \
+		| sort \
+		>new_lines.txt
+
+	hash_file=$(echo $file | sed "s/\//\#/")
+	cat "$hash_file.gcov" \
+		| grep \#\#\#\#\# \
+		| sed 's/    #####: //g' \
+		| sed 's/\:/ /g' \
+		| awk '{print $1}' \
+		| sort \
+		>uncovered_lines.txt
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
