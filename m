Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A81741F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfKOBBH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:07 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33694 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:06 -0500
Received: by mail-pf1-f175.google.com with SMTP id c184so5484199pfb.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w5qreCzgo1Ie357SUBp7hNDQYI1WGp18wzwHQE3yqmI=;
        b=drFlDWdiXyBH7H0148xDY61cbZkTHJ4ULAIgDbeq9kUvi7p7MIMWyuWTR++AB17/6y
         /BvZLg6VdRy30uz/bKjfL3kW6Hu6Jx80VeuzQCt7qeiwfoWQG9QM9v9ItcOTHQpoU2Ff
         BD2vN+eEbU44EVuzE1vlwa9/tj+83ogufbNHYOaABnL2V/OAmt8mZ+/RQ65Z6uypA7En
         u1dorB5EGviGp/lFXHAfsVbdTOjp94yBpJzOvL36DMwtYngnlzUQ+1w96RF6ACKp+Aa7
         UlYz9bVAclqJgaEGfJ3YjnXdoeFDiiTmgm6a+OghFXiyghHNWyeATEmYELZP79eu05do
         LI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w5qreCzgo1Ie357SUBp7hNDQYI1WGp18wzwHQE3yqmI=;
        b=E1H0I72SGA3sKvH+hZ+NRtM0pBjfazJGNz0nzzctjjOa/k2SfJLo34OBnVBq4h+ycW
         FgxbhiHxmB+o0RZXMrzrPG5ogItFD4bsE468iVDnKYd7uQbgUErZXgwKnoR6x7ujhOj2
         /ZvVbJcUAVxKflb7odejv8qTVdKI7YVzUHPslilbcdRuSMbk41car2uCGks4rd6uq0TI
         jD8QqJ3EOZyUchzM44xsx/WQ5i0AwmR05Su5h/XMqxN0ghwMlfZ0VVCZEExWxNBz64V7
         IobnK0zl2w5ZdyGoUw4oOXB1crajfhY0pREUjc2gKAw3lhaWjbB0JK8DDNqSuhs4+xdb
         juLg==
X-Gm-Message-State: APjAAAU1GfSe94m3vrOxha71Ru5PZ7aQU13pTsz3trfOqt/5RK96F6id
        O0bm4Pu4MEcAOwRoqheaqScRtht3
X-Google-Smtp-Source: APXvYqx41UgEkx2L2MxyHKDsnWYFf5qhCvkGAMiN1ZDOYLqzzGVkJCag9mK623RvNCZV2zXELy7UXw==
X-Received: by 2002:a63:f743:: with SMTP id f3mr10288408pgk.410.1573779665727;
        Thu, 14 Nov 2019 17:01:05 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 125sm7955394pfu.136.2019.11.14.17.01.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:05 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 14/27] t7501: remove spaces after redirect operators
Message-ID: <3cb65b5954f5c0297e465f6d5261437debdfdfe6.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index f1349af56e..5765d33c53 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -150,7 +150,7 @@ test_expect_success 'setup: commit message from file' '
 test_expect_success 'amend commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-	sed -e "s/a file/an amend commit/g" < "$1" > "$1-"
+	sed -e "s/a file/an amend commit/g" <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 	chmod 755 editor &&
@@ -263,7 +263,7 @@ test_expect_success 'using message from other commit' '
 test_expect_success 'editing message from other commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-	sed -e "s/amend/older/g"  < "$1" > "$1-"
+	sed -e "s/amend/older/g"  <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 	chmod 755 editor &&
@@ -367,7 +367,7 @@ test_expect_success 'amend commit to fix author' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --author="$author" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
@@ -382,7 +382,7 @@ test_expect_success 'amend commit to fix date' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --date="$newtick" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
@@ -448,7 +448,7 @@ test_expect_success 'signoff gap' '
 	git commit -s -m "welcome
 
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -468,7 +468,7 @@ test_expect_success 'signoff gap 2' '
 
 We have now
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -489,7 +489,7 @@ test_expect_success 'signoff respects trailer config' '
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -506,7 +506,7 @@ Myfooter: x" &&
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -560,14 +560,14 @@ test_expect_success 'amend commit to fix author' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --author="$author" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
 
 test_expect_success 'git commit <file> with dirty index' '
-	echo tacocat > elif &&
-	echo tehlulz > chz &&
+	echo tacocat >elif &&
+	echo tehlulz >chz &&
 	git add chz &&
 	git commit elif -m "tacocat is a palindrome" &&
 	git show --stat | grep elif &&
-- 
2.24.0.399.gf8350c9437

