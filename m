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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E9131F4C0
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbfKERHk (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:40 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:34478 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbfKERHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:40 -0500
Received: by mail-wr1-f42.google.com with SMTP id e6so20466466wrw.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jxoXBzB1x08/8OJLbYp766dFyF2d9HXNSiWvQ4o4gBY=;
        b=q3J5hjRzLMNt2tZLgXytKipjTZL/9PUma0bcLMdvJZgfTzey3ze1Y0j8q2dlbC29pk
         1gUFrlNY/Wlf0MnLb9yDWx9EICCYmvMe5y1HQMnbJmtEc1UZzGiQjuZmBIXcghalpmI4
         anKU7/eGaUtsXLGYhbVcQfMxLBaURZaEN4zlFGzj8EmujmwAaRkTkQUeZiOjbTGHUpXz
         AVmTLCj6/OGWXw1i57ECD0UkFs7SKex71ytIeIpKb3cPr4H58k8gJouRAxhVP/Hfc4fg
         13UaWUvqTupa7HT/iBK8HFbqYLbwUqPUvp6915OyOOzuJtpRpVwMDB+3IDsANzaf91wt
         bFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jxoXBzB1x08/8OJLbYp766dFyF2d9HXNSiWvQ4o4gBY=;
        b=GlnVWt1a41uYYNWvnj656Pzt7GREcxVqg4CXWlenai4V9u1i1tghqCS5CYhckepqes
         6WW2sSUgvntv1GYsX2noioqMg6Vi2skemACy/5qdEDGXmn3jf6ad35RfpY5GWwexjdeX
         MKMCsIkJZGfhGRITra0SSaKbLf70afzkVEYdh9qonTYVj/ii3BX2SjdgCXSNWDFiBeCe
         0Zf3GipWxhiscdivJp1IEMEZ1S4esw3WQ0kr7Bon9TKjpdyd04RkMG4wuCX3xJkwShTm
         wM2MAQX58MdFpsUCLTNnwiLuPxPwMroQMvl/8PS3/VjdgxPj9pOT/Exx3HETmPEKZjPz
         hZlQ==
X-Gm-Message-State: APjAAAVBEs8DaAqRy/DutDxUD7Ww5f2jXHnl+mroVlrC8sHLBYbfkxci
        epNfpEzWXS/QazIk7Te3eKDjWptS
X-Google-Smtp-Source: APXvYqymxnBpZxcIWarHMRUScxZNWRIBv2sHEUJjz2rP6Wc3xU02b4YCY2VTaq8nSDD4V5tLq3WZ4A==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr30560123wrw.13.1572973657295;
        Tue, 05 Nov 2019 09:07:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5sm9701718wro.76.2019.11.05.09.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:36 -0800 (PST)
Message-Id: <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:22 +0000
Subject: [PATCH v2 03/11] Prefer 'up-to-date' spelling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When we are providing an English error message for users, we should
avoid 'uptodate'.  According to
https://writingexplained.org/up-to-date-hyphenated, when used as an
adjective (i.e. when used as a synonym for 'current') -- which matches
our usage -- the correct spelling is up-to-date.  (Alternatively, when
used as an adverb, the same page points out it is spelled 'up to date'.)
In either case, when providing an English error message for users, we
shouldn't use 'uptodate'.  Correct the spelling.

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fetch.c                | 2 +-
 gitk-git/gitk                  | 2 +-
 t/t7110-reset-merge.sh         | 4 ++--
 t/t7609-merge-co-error-msgs.sh | 2 +-
 unpack-trees.c                 | 6 +++---
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 863c858fde..d597fa5be0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -604,7 +604,7 @@ static void adjust_refcol_width(const struct ref *ref)
 {
 	int max, rlen, llen, len;
 
-	/* uptodate lines are only shown on high verbosity level */
+	/* up-to-date lines are only shown on high verbosity level */
 	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
 		return;
 
diff --git a/gitk-git/gitk b/gitk-git/gitk
index abe4805ade..50a5b60c13 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9696,7 +9696,7 @@ proc cherrypick {} {
     if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
 	notbusy cherrypick
 	if {[regexp -line \
-		 {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
+		 {Entry '(.*)' (would be overwritten by merge|not up-to-date)} \
 		 $err msg fname]} {
 	    error_popup [mc "Cherry-pick failed because of local changes\
 			to file '%s'.\nPlease commit, reset or stash\
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index a82a07a04a..d81a27f3b0 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --merge HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up-to-date"
 '
 
 # The next test will test the following:
@@ -189,7 +189,7 @@ test_expect_success 'reset --keep fails with changes in file it touches' '
     sed -e "s/line 1/changed line 1/" <file1 >file3 &&
     mv file3 file1 &&
     test_must_fail git reset --keep HEAD^ 2>err.log &&
-    grep file1 err.log | grep "not uptodate"
+    grep file1 err.log | grep "not up-to-date"
 '
 
 test_expect_success 'setup 3 different branches' '
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index e90413204e..111253ae5d 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -98,7 +98,7 @@ Please commit your changes or stash them before you switch branches.
 Aborting
 EOF
 
-test_expect_success 'not uptodate file porcelain checkout error' '
+test_expect_success 'not up-to-date file porcelain checkout error' '
 	git add rep/one rep/two &&
 	test_must_fail git checkout branch 2>out &&
 	test_i18ncmp out expect
diff --git a/unpack-trees.c b/unpack-trees.c
index 33ea7810d8..8ba2dc3267 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -29,7 +29,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
 	/* ERROR_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot merge.",
+	"Entry '%s' not up-to-date. Cannot merge.",
 
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
@@ -44,7 +44,7 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_ERROR_TYPES] = {
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
 	/* ERROR_SPARSE_NOT_UPTODATE_FILE */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Entry '%s' not up-to-date. Cannot update sparse checkout.",
 
 	/* ERROR_WOULD_LOSE_ORPHANED_OVERWRITTEN */
 	"Working tree file '%s' would be overwritten by sparse checkout update.",
@@ -2027,7 +2027,7 @@ static int merged_entry(const struct cache_entry *ce,
 	} else if (!(old->ce_flags & CE_CONFLICTED)) {
 		/*
 		 * See if we can re-use the old CE directly?
-		 * That way we get the uptodate stat info.
+		 * That way we get the up-to-date stat info.
 		 *
 		 * This also removes the UPDATE flag on a match; otherwise
 		 * we will end up overwriting local changes in the work tree.
-- 
gitgitgadget

