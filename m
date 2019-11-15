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
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB051F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKOBBO (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:14 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so4893797pgh.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gyf0mQdI+ahL2QZYsGrQPm9DBYKLwCIHsQU+kEth2aw=;
        b=HZqLTh3pjl/psxCkHR5/9reCFOPA9vFYQ4Al8AZoW5tajz5n7YnGIjlviGmImDGMCf
         lqN9qxhIEOt/8EvNaA4hBmHqwxWL7YdzH3e/fKJW+/SZENzlMlHIX5W4yfd8mmUolm17
         h/ARvCqPONWjaAmFVjFZQoJv51DEGpORHCz8QPkJliderOmkIJa0kcm+4pBLWaRWBwP3
         /8vX5ZsUooWs0nNrnlN9gKbV8ek24gdPMBM4ngjSjAPG3xnaH4sWgQuybgJ3jfwR81WM
         +IfL7uYMZ9pqOW858ZFhPCZPyTRtlqODU48L9+BvfkPBttn4PY1FLhKFAbgKoo5sDpP+
         jklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gyf0mQdI+ahL2QZYsGrQPm9DBYKLwCIHsQU+kEth2aw=;
        b=HMn4mZ+xAfZ2EuQzmcdq1TlbO8OXIgPRu0l7bSU2Fo6IN76rzBvRKi1P6lbSrVAkuc
         uaHG/g3+BEnb7m46pOQ/ZVqd55NdA9RbSILj9JaK0dl5B7b2y24ZNuLdbqH7PmxVCswO
         13iwzVcbEvNRhz88j5au7lR2ve4gASJwQbP4C8xD7BF5Pj9hSfILqOMvf1BPfHcN84fY
         sXy8vNCxmAJzlRy4NBuZZHI+qX1LL3WUuYjZLmjctz4jXHlMLjDuvYGDvOzlQozaEL0u
         foM+E+4/+yHJQydPpkgE/KVrYv1CHgUuex68mbahfpG43m/dtwBlfG0ziUp+5J6GsUrD
         kpzQ==
X-Gm-Message-State: APjAAAVdQe5Yd6rDRDj59XRaJ3OBIzRbpSGSbWutGQFPx7bC3oraR7vz
        0rXvTJAKpfeUlU3DUzygERDcI60f
X-Google-Smtp-Source: APXvYqyEYtAzDVdujYKGP3VJfHF8jTI31jsthEa9LhAeCxjEgfT3E68ZRAGIbZkxXXG6QY3L/Qa8nA==
X-Received: by 2002:a62:f243:: with SMTP id y3mr14438136pfl.196.1573779672855;
        Thu, 14 Nov 2019 17:01:12 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id x13sm8142620pfc.46.2019.11.14.17.01.12
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:12 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 17/27] t7700: remove spaces after redirect operators
Message-ID: <206ac68a91f4fabe184403e41496bc341f3f18d1.1573779465.git.liu.denton@gmail.com>
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
 t/t7700-repack.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index e1a689d6a9..8936928387 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -11,8 +11,8 @@ commit_and_pack() {
 }
 
 test_expect_success 'objects in packs marked .keep are not repacked' '
-	echo content1 > file1 &&
-	echo content2 > file2 &&
+	echo content1 >file1 &&
+	echo content2 >file2 &&
 	git add . &&
 	test_tick &&
 	git commit -m initial_commit &&
@@ -75,8 +75,8 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 
 test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
-	echo content3 > file3 &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
+	echo content3 >file3 &&
 	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
 	git add file3 &&
 	test_tick &&
@@ -111,7 +111,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
 	rm -f .git/objects/pack/* &&
-	echo new_content >> file1 &&
+	echo new_content >>file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit -m more_content &&
@@ -169,12 +169,12 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
 test_expect_success 'local packed unreachable obs that exist in alternate ODB are not loosened' '
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
@@ -186,7 +186,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
@@ -196,7 +196,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	H0=$(git rev-parse HEAD) &&
 	H1=$(git rev-parse HEAD^) &&
 	H2=$(git rev-parse HEAD^^) &&
-	echo "$H0 $H2" > .git/info/grafts &&
+	echo "$H0 $H2" >.git/info/grafts &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-- 
2.24.0.399.gf8350c9437

