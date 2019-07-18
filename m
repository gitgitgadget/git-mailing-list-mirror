Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1CE01F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbfGRNTY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39238 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390523AbfGRNTT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so28651035wrt.6
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+6H0fHX/mTATCap1vwfdLXRxarE76b8uk9+FtkHdS0I=;
        b=Ca4uBMVSQeY+/KXBOka2+R8an5lbpCcPGYNP7hR1fih+su5tuB719O7nO0gABXocFs
         Xcv904hSGqKoTlKx7Fk1Idy+tZEdGE0c2ajReJ80N0uyk6XjsjxXMQsZICfkYAdyJHGp
         0RiVyR20rspcBPoEhAkrvkBRv03AjyHpSYGHdiFOHI9yT+Cfbx9Hx9EohbbOyufQEEFm
         X+K0jl0hdbM6jWSctA7EHW65le1rZoLEFnMSDgWrEifCJLK0XVN3qDmj69u2UYtDOkUI
         n1Nisj6SOEEK8jQxCKzipZ40U2O5pBezsfdRJlePPXkzGqFaswypkjBerfxZkJvnqRkW
         YpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+6H0fHX/mTATCap1vwfdLXRxarE76b8uk9+FtkHdS0I=;
        b=EjG5AqreK/eFQEJkrjtBuORxSdXZxaGNnPJ8Bdr/XKx7JJVeqXy58VVHCiVr1ZBK1R
         X6CpVizkTVB4fnc3rZS+8mb0ApMXQKlsKyN+5f+Z9U7kRPtudR9QwFkrxpe7qp4id1jL
         6szzQBpxCGl7eHkKEyX3yn9j35gHQ/64is5+cVo/AnVN5pi/Xop6yTfYoFImmN1h6R9t
         6To5oOWa+kGNnX7llcFrj4lzkj8tcC6dsTC5Pi4ujhuQxfFz1HFfRmS4hn/rnpd44iNS
         HdW0lVqKSU+mvbnyKuXGgWV5jmMtc3Bq1q8YYi9jQv1a6qSYKI7Lfs/OnFzI8e7WalYZ
         3KRw==
X-Gm-Message-State: APjAAAUJUb8H0K/MkqBSi9Y40npyIy8N8LpqCWscND1jcvUKkfVmUMDm
        IuFCTWHHneWl+E7Ix5GFYxKIUmux
X-Google-Smtp-Source: APXvYqyEeyZMjG9ClTpe/uqHHAnroMoeWN/QyvZTmHoKBtg8LjrQllehagHJ07zZBRZddI95uI/Dzw==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr20437279wrp.38.1563455956551;
        Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm13218439wrw.21.2019.07.18.06.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:16 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:58 GMT
Message-Id: <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
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

It is a real old anachronism from the Cogito days to have a
.git/branches/ directory. And to have tests that ensure that Cogito
users can migrate away from using that directory.

But so be it, let's continue testing it.

Let's make sure, however, that git init does not need to create that
directory.

This bug was noticed when testing with templates that had been
pre-committed, skipping the empty branches/ directory of course because
Git does not track empty directories.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh     | 2 ++
 t/t5516-fetch-push.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 883b32efa0..1132964044 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -824,6 +824,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	(
 		cd six &&
 		git remote rm origin &&
+		mkdir -p .git/branches &&
 		echo "$origin_url" >.git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
@@ -838,6 +839,7 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)'
 	(
 		cd seven &&
 		git remote rm origin &&
+		mkdir -p .git/branches &&
 		echo "quux#foom" > .git/branches/origin &&
 		git remote rename origin origin &&
 		test_path_is_missing .git/branches/origin &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c81ca360ac..47c2959a90 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -866,6 +866,7 @@ test_expect_success 'fetch with branches' '
 	mk_empty testrepo &&
 	git branch second $the_first_commit &&
 	git checkout second &&
+	mkdir -p testrepo/.git/branches &&
 	echo ".." > testrepo/.git/branches/branch1 &&
 	(
 		cd testrepo &&
@@ -879,6 +880,7 @@ test_expect_success 'fetch with branches' '
 
 test_expect_success 'fetch with branches containing #' '
 	mk_empty testrepo &&
+	mkdir -p testrepo/.git/branches &&
 	echo "..#second" > testrepo/.git/branches/branch2 &&
 	(
 		cd testrepo &&
@@ -893,6 +895,7 @@ test_expect_success 'fetch with branches containing #' '
 test_expect_success 'push with branches' '
 	mk_empty testrepo &&
 	git checkout second &&
+	mkdir -p .git/branches &&
 	echo "testrepo" > .git/branches/branch1 &&
 	git push branch1 &&
 	(
@@ -905,6 +908,7 @@ test_expect_success 'push with branches' '
 
 test_expect_success 'push with branches containing #' '
 	mk_empty testrepo &&
+	mkdir -p .git/branches &&
 	echo "testrepo#branch3" > .git/branches/branch2 &&
 	git push branch2 &&
 	(
-- 
gitgitgadget

