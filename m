Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE231F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbcHFUYr (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:24:47 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34981 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbcHFUYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:24:45 -0400
Received: by mail-pf0-f178.google.com with SMTP id x72so107038043pfd.2
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:24:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N7n9iTjQF1/LwI9HqMucKN3yODUWkobgSxSle6eMFxk=;
        b=B0ul0PRvmN+dk7kRAP1IiJUQhUlqDT/iE7bzmhEz1rinRENClBMxIpKg6hLlzTVFaW
         tq3SQ76Xh3m2GbFTqZ0qpQew4hjelJjH8EqMKDmrT155GixO/v6rE4oh4ZMXGf/0byyc
         KD8r4/OjLIgBwpWhaIP7Kne6mwDtlw1Io9f5/yiGNOIvwAaSnwlBVWTwbON9PCzuhwVO
         rhP57VpiRGbl8FsBeWm+HImCrwjYG+CeGKSqvuY2HzYzAuNSf1mFBq02xMCs8U/4zHxm
         SmtO+0JuqbKQFMZmYeFlURo33zUkGZkwkbWxdgcyLxuorfGKSfjQ5KGG9O2SH+4CJMGo
         m47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N7n9iTjQF1/LwI9HqMucKN3yODUWkobgSxSle6eMFxk=;
        b=UHoSPpM1nCzfg9wjAqOmJ6US/I5T8bhLcqlmKEmUl85UE3G2fd7fS5f5nrsGU0tJ7W
         YIqbrJKNvaNRxvAAN/7/27RWx4HN84nBNtjIW5PA+v5OTb1izlDa8b/xsEagqDojjimb
         oQSMW356cmK/a+ADhrGhzvK6fJ2m/dmaDkeZoS5MAcV7GOziY/1/KQMqt9Londfa91ys
         XMiJJ/rQeSHk5Zi2D5NkYrmUOVyhmhdyZ6+PGRQ8OwJxoIHzIuQW4YZZ+GTBLWbTbM1i
         /HyrX/kc+dGYlxmCIUvXK+Dscs1l1LKzsmA4x6X9o/PqGu6iT+mpg4uPD64S8idmrvy4
         PBmA==
X-Gm-Message-State: AEkooutt/hjFFvf3ADAa8wrg6wO7pWSQ1Gzn4zBYpYsffJmzIcuEAmmAASxBWa5MOHtlAnMw
X-Received: by 10.98.69.201 with SMTP id n70mr142788751pfi.64.1470446613781;
        Fri, 05 Aug 2016 18:23:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id tr1sm30729997pab.19.2016.08.05.18.23.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:33 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/6] t7408: modernize style
Date:	Fri,  5 Aug 2016 18:23:13 -0700
Message-Id: <20160806012318.17968-2-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

No functional change intended. This commit only changes formatting
to the style we recently use, e.g. starting the body of a test with a
single quote on the same line as the header, and then having the test
indented in the following lines.

Whenever we change directories, we do that in subshells.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7408-submodule-reference.sh | 140 +++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index eaea19b..beee0bb 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -8,74 +8,76 @@ test_description='test clone --reference'
 
 base_dir=$(pwd)
 
-U=$base_dir/UPLOAD_LOG
-
-test_expect_success 'preparing first repository' \
-'test_create_repo A && cd A &&
-echo first > file1 &&
-git add file1 &&
-git commit -m A-initial'
-
-cd "$base_dir"
-
-test_expect_success 'preparing second repository' \
-'git clone A B && cd B &&
-echo second > file2 &&
-git add file2 &&
-git commit -m B-addition &&
-git repack -a -d &&
-git prune'
-
-cd "$base_dir"
-
-test_expect_success 'preparing superproject' \
-'test_create_repo super && cd super &&
-echo file > file &&
-git add file &&
-git commit -m B-super-initial'
-
-cd "$base_dir"
-
-test_expect_success 'submodule add --reference' \
-'cd super && git submodule add --reference ../B "file://$base_dir/A" sub &&
-git commit -m B-super-added'
-
-cd "$base_dir"
-
-test_expect_success 'after add: existence of info/alternates' \
-'test_line_count = 1 super/.git/modules/sub/objects/info/alternates'
-
-cd "$base_dir"
-
-test_expect_success 'that reference gets used with add' \
-'cd super/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-diff expected current'
-
-cd "$base_dir"
-
-test_expect_success 'cloning superproject' \
-'git clone super super-clone'
-
-cd "$base_dir"
-
-test_expect_success 'update with reference' \
-'cd super-clone && git submodule update --init --reference ../B'
-
-cd "$base_dir"
-
-test_expect_success 'after update: existence of info/alternates' \
-'test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates'
-
-cd "$base_dir"
-
-test_expect_success 'that reference gets used with update' \
-'cd super-clone/sub &&
-echo "0 objects, 0 kilobytes" > expected &&
-git count-objects > current &&
-diff expected current'
-
-cd "$base_dir"
+test_expect_success 'preparing first repository' '
+	test_create_repo A &&
+	(
+		cd A &&
+		echo first >file1 &&
+		git add file1 &&
+		git commit -m A-initial
+	)
+'
+
+test_expect_success 'preparing second repository' '
+	git clone A B &&
+	(
+		cd B &&
+		echo second >file2 &&
+		git add file2 &&
+		git commit -m B-addition &&
+		git repack -a -d &&
+		git prune
+	)
+'
+
+test_expect_success 'preparing superproject' '
+	test_create_repo super &&
+	(
+		cd super &&
+		echo file >file &&
+		git add file &&
+		git commit -m B-super-initial
+	)
+'
+
+test_expect_success 'submodule add --reference' '
+	(
+		cd super &&
+		git submodule add --reference ../B "file://$base_dir/A" sub &&
+		git commit -m B-super-added
+	)
+'
+
+test_expect_success 'after add: existence of info/alternates' '
+	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
+'
+
+test_expect_success 'that reference gets used with add' '
+	(
+		cd super/sub &&
+		echo "0 objects, 0 kilobytes" > expected &&
+		git count-objects > current &&
+		diff expected current
+	)
+'
+
+test_expect_success 'cloning superproject' '
+	git clone super super-clone
+'
+
+test_expect_success 'update with reference' '
+	cd super-clone && git submodule update --init --reference ../B
+'
+
+test_expect_success 'after update: existence of info/alternates' '
+	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
+'
+
+test_expect_success 'that reference gets used with update' '
+	cd super-clone/sub &&
+	echo "0 objects, 0 kilobytes" > expected &&
+	git count-objects > current &&
+	diff expected current
+'
 
 test_done
-- 
2.9.2.572.g9d9644e.dirty

