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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB491F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 10:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfJ3Ktq (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 06:49:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54403 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfJ3Ktn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 06:49:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id g7so1566734wmk.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pM7YY3+nbTLyNtVGcPr129aqak/7Jp+NtAKY3DSLLPI=;
        b=ekLHM+u0LbDFfemh4r9P8wG6h3YXn/Q3hna9Uud+gtk/9nQlFEcwy1bbErYWezYzu2
         EaGYvzFrtj48NKoGkQP+GElyR9BngXaRu3qYt3I9W5pjHAU4scLGf+pdbwkd5QUPD1LJ
         CpCILWZeBnU8gYvaybnpixp2bJNXlN1eIVo27wKfjKsHvcIM+7UW3wQGJruZLZmm1I/Q
         c4DSBxgNArX2oFWLhIbbtprODTxzrTOrK7fDbIOY6+69lVosSzlCpVHZSF0CEzacKC6z
         XHpxj2ebxJk+rqXs5YBeTYN3SFIiWrxT+tTl3dhpKlsOZZyGntx5X2BdXpeXbs3taRVj
         nteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pM7YY3+nbTLyNtVGcPr129aqak/7Jp+NtAKY3DSLLPI=;
        b=eTpy5CqHddY1H26uLpcty6WFp+OSzK+S7tHEt2cHudNe9hwNX5NU7zr9DOCysDoJgc
         rFcaO10UXUlcNrPYUPjT6G64tk4NUIQSGAk7WXfvPDPOH3E7hlWXKRWmPKOIIQpVXuOK
         y1L4SWaYZvIM2aSudEuurQq1g61c1+P1J7T0BIrf+iR7CzyuIfydjRmFbK1PlW1viRsk
         /VaVO7RQdvVTLyo7U92sdbobDaZ0RrfGFUCq3OBQM+n8/bp/rtHywiz0D5F4Ikf+vC/8
         wlzMLSnEME/d0m6AQBfo/VyOJozTV0gFa4YbIutUKX/6TckmFEVIHtgj1Avpfl3cr7H5
         VhLw==
X-Gm-Message-State: APjAAAVMxjTWgboRORAZvTFfrfd3UcCE2x9sGIKy9XACWoe8gmHTuQ8J
        gYg+OnRGIUClOEFYBm2Ajj4xS7Yo
X-Google-Smtp-Source: APXvYqyH8Xc3PT0MKYyUyEgNJpe+qjhVUDLl72weHIYrSk2psh6n0ERQl32UCT3JhQ860rn0AiKaSg==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr8869579wma.81.1572432581490;
        Wed, 30 Oct 2019 03:49:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26sm1819224wmi.17.2019.10.30.03.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 03:49:40 -0700 (PDT)
Message-Id: <8f49a393e0ef7fff955a02963ff5229fb9885e89.1572432578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.v3.git.1572432578.gitgitgadget@gmail.com>
References: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
        <pull.355.v3.git.1572432578.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:49:38 +0000
Subject: [PATCH v3 2/2] stash: handle staged changes in skip-worktree files
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When calling `git stash` while changes were staged for files that are
marked with the `skip-worktree` bit (e.g. files that are excluded in a
sparse checkout), the files are recorded as _deleted_ instead.

The reason is that `git stash` tries to construct the tree reflecting
the worktree essentially by copying the index to a temporary one and
then updating the files from the worktree. Crucially, it calls `git
diff-index` to update also those files that are in the HEAD but have
been unstaged in the index.

However, when the temporary index is updated via `git update-index --add
--remove`, skip-worktree entries mark the files as deleted by mistake.

Let's use the newly-introduced `--ignore-skip-worktree-entries` option
of `git update-index` to prevent exactly this from happening.

Note that the regression test case deliberately avoids replicating the
scenario described above and instead tries to recreate just the symptom.

Reported by Dan Thompson.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stash.c     |  5 +++--
 git-legacy-stash.sh |  3 ++-
 t/t3903-stash.sh    | 11 +++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index ab30d1e920..e3962bf73e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1082,8 +1082,9 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	}
 
 	cp_upd_index.git_cmd = 1;
-	argv_array_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
-			 "--remove", "--stdin", NULL);
+	argv_array_pushl(&cp_upd_index.args, "update-index",
+			 "--ignore-skip-worktree-entries",
+			 "-z", "--add", "--remove", "--stdin", NULL);
 	argv_array_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index f60e9b3e87..5398a5161d 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -193,7 +193,8 @@ create_stash () {
 			GIT_INDEX_FILE="$TMPindex" &&
 			export GIT_INDEX_FILE &&
 			git diff-index --name-only -z HEAD -- "$@" >"$TMP-stagenames" &&
-			git update-index -z --add --remove --stdin <"$TMP-stagenames" &&
+			git update-index --ignore-skip-worktree-entries \
+				-z --add --remove --stdin <"$TMP-stagenames" &&
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 392954d6dd..57258d5668 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1257,4 +1257,15 @@ test_expect_success 'stash apply should succeed with unmodified file' '
 	git stash apply
 '
 
+test_expect_success 'stash handles skip-worktree entries nicely' '
+	test_commit A &&
+	echo changed >A.t &&
+	git add A.t &&
+	git update-index --skip-worktree A.t &&
+	rm A.t &&
+	git stash &&
+
+	git rev-parse --verify refs/stash:A.t
+'
+
 test_done
-- 
gitgitgadget
