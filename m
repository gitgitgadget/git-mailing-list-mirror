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
	by dcvr.yhbt.net (Postfix) with ESMTP id 07ACE1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 11:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfJ1LUV (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 07:20:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37101 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfJ1LUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 07:20:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id q130so8699218wme.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pM7YY3+nbTLyNtVGcPr129aqak/7Jp+NtAKY3DSLLPI=;
        b=d85PBOQQAPoKL44F0RF+Rtg7tcVuK1np93+lgSqtZN/fpFNW26qFmqHIESrma5kWIe
         nJobzr6tlIQAlmC+Y0c4B1Ouign9EflgTZYN1t1cBflXtYQBEdwR73obFL1cawaPXWPU
         PoyKMR4Gfhct/7M64bFMeWAnUupinJNhramAk3oqCUxjzEM+HisRDXK/I2bsNdsxTD7t
         L4PsqQguu8xKSs+8kQL2TDwnSiMSMCWAtQ9f94lxAnWH75E8DBMXg4lwaOI4uTTfoMqk
         Z/yXx9qeGZymG18ssqCsB6/M4fh0HAuHQLas27v9Rwx2YMq0UdidKCtFXNcnpUIPzU86
         CHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pM7YY3+nbTLyNtVGcPr129aqak/7Jp+NtAKY3DSLLPI=;
        b=GCirrUqdY2Lv4ldpnUHkr3QgXJh4ouDzA3KV+fmd+9IVAEs74sbbeE1kopVqgN0mxR
         Ndf0UJ7wNOv69AuTis25KUE0hm8dqGxNhsYNlb9jiS8o8Pu8E8a1SYABkb5UOX2L0uKh
         oTJY+Bbg+jxGyndEzc5crQUAquD3LO8iFc1U65Kx9C+UZWlR6YnfTZywEVh20jTCdSrn
         c06kUyDU1cXDZkVdhC1ZeCpCFNXZV+uBX/3d8P/E9YRoHxk/vJseaen1QvIHHncJp/9p
         Tliz4NEbRMgFrMOMpYPpYb1/OC2Wbhh/VA25KLQ2DueSMpW61Zo65oZaACYSVNnDtY3c
         d7Rg==
X-Gm-Message-State: APjAAAWxoEjRBW/1I3AqXZlujMNXRjdMze/GShjGRYZCTxVFhayMcq4b
        FVQsREI2OmKyj7ozblSJZCdqL9Ka
X-Google-Smtp-Source: APXvYqx6jBCRTEfI1Mg0WfhLBM2IRt5l9qY1FztJVQ/BdGBxottJxeqbkEah9kJDAcECQEkqjKUGLQ==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr14639000wma.16.1572261619152;
        Mon, 28 Oct 2019 04:20:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v128sm16549349wmb.14.2019.10.28.04.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 04:20:18 -0700 (PDT)
Message-Id: <9835e66399b5feeb3313bcee62f0519c025a4ca2.1572261615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
References: <pull.355.git.gitgitgadget@gmail.com>
        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 11:20:15 +0000
Subject: [PATCH v2 2/2] stash: handle staged changes in skip-worktree files
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
