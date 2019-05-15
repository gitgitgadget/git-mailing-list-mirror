Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF22F1F461
	for <e@80x24.org>; Wed, 15 May 2019 10:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEOKyI (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:54:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41731 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEOKyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:54:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so3478264edd.8
        for <git@vger.kernel.org>; Wed, 15 May 2019 03:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ad3bvQah8nyAcNuX9Wpf1rmdGDD0vJ+JAoECmOr5ebE=;
        b=fmX6Ia+hrgbYfAQkhC9hsBQa4O5WnSKwbSX+SevIfcZ4OzHcki6ugVsDrUk+HNZ8s+
         t9Za8ZTtCRvX/uss6+xm8/45fEGIXrDUwdDUJ5cf9dxvFiKANwpFtUMDmZb+1ep3p6Bs
         EBpsZuyRCgIef4PxNRb1sD/PyO7QwrgmhaeiZZzczQh8ODJYN5DpPjfkcPgpYJZTWRJC
         AtlxgiXLZoFHShVeD9AvZNzFo2I6C8i4hreH3mRmvcvySD639yqZ3VIJF5N2iBFJxNvK
         LYhfgyyK/hU7pizdPR0NgbRoiXAoulKzFiz+7ZJVlj1F6x2+ZG3gITLx3VaT1zJ7v5Pd
         8cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ad3bvQah8nyAcNuX9Wpf1rmdGDD0vJ+JAoECmOr5ebE=;
        b=PI0GzMoT18l10fI3PicbDmnSLxit/TUQPAcT7opQkFvwaAkQ5bQFLqHUX5n6OdWea5
         raqIMkIbGCDaW9rGULr35I8MV0g2a8Pc6qG6ATDvVZgoCiERetSX8XqUPiN1y1I0pMJO
         +JcDKbnK1s0wWzRBRM0CSWH/Rz0cye54YosGMnPkQ3B/zl5YehbQH92H9MpKKTPFUEGO
         HjVWQws1vH5QwEr5axUZ1w2/88/fF3r2GhwOih4PTGjvvVnXa4tzARC//3X+pWYiH24I
         dbs8IW79BAgLo/eioxMjoSyshrZ1WjrmmbMvyQ0AfYlLGZ5+0DP6rtmB8Zt4ijGXvViY
         hNLg==
X-Gm-Message-State: APjAAAXMOcywzHesEPtqQa02c5dYoBP1lw7yiOAlkXOv4tDbA8lZ9oDV
        CymACTMs+eOzhF2hLFeko9/mtUDl
X-Google-Smtp-Source: APXvYqxcFG3jpeqDaiyRtJa2CHgNuBsMuHCJjqCcCtbb+K+j6OsP+eaLKYAiR6QHpQiuNnOJm7twMw==
X-Received: by 2002:aa7:c483:: with SMTP id m3mr13186259edq.161.1557917644306;
        Wed, 15 May 2019 03:54:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm686497edb.48.2019.05.15.03.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 03:54:03 -0700 (PDT)
Date:   Wed, 15 May 2019 03:54:03 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2019 10:54:02 GMT
Message-Id: <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.196.git.gitgitgadget@gmail.com>
References: <pull.196.git.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] status: remove the empty line after hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Lin <johnlinp@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Lin <johnlinp@gmail.com>

Before this patch, there is inconsistency between the status
messages with hints and the ones without hints: there is an
empty line between the title and the file list if hints are
presented, but there isn't one if there are no hints.

This patch remove the inconsistency by removing the empty
lines even if hints are presented.

Signed-off-by: John Lin <johnlinp@gmail.com>
---
 t/t7060-wtstatus.sh    |  5 ----
 t/t7508-status.sh      | 62 ------------------------------------------
 t/t7512-status-help.sh | 14 ----------
 wt-status.c            |  4 ---
 4 files changed, 85 deletions(-)

diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 53cf42fac1..d5218743e9 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -38,7 +38,6 @@ You have unmerged paths.
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
-
 	deleted by us:   foo
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -143,7 +142,6 @@ You have unmerged paths.
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
-
 	both added:      conflict.txt
 	deleted by them: main.txt
 
@@ -177,7 +175,6 @@ You have unmerged paths.
 
 Unmerged paths:
   (use "git add/rm <file>..." as appropriate to mark resolution)
-
 	both deleted:    main.txt
 	added by them:   sub_master.txt
 	added by us:     sub_second.txt
@@ -201,12 +198,10 @@ You have unmerged paths.
   (use "git merge --abort" to abort the merge)
 
 Changes to be committed:
-
 	new file:   sub_master.txt
 
 Unmerged paths:
   (use "git rm <file>..." to mark resolution)
-
 	both deleted:    main.txt
 
 Untracked files not listed (use -u option to show untracked files)
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e1f11293e2..1cb1032c98 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -95,18 +95,15 @@ test_expect_success 'status --column' '
 #
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
-#
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
-#
 #	modified:   dir1/modified
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
-#
 #	dir1/untracked dir2/untracked
 #	dir2/modified  untracked
 #
@@ -129,18 +126,15 @@ cat >expect <<\EOF
 #
 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
-#
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
-#
 #	modified:   dir1/modified
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
-#
 #	dir1/untracked
 #	dir2/modified
 #	dir2/untracked
@@ -279,23 +273,19 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir2/modified
 
 Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
-
 	.gitignore
 	dir1/untracked
 	dir2/untracked
@@ -348,18 +338,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
-
 	.gitignore
 	dir1/untracked
 	dir2/modified
@@ -421,13 +408,11 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files not listed (use -u option to show untracked files)
@@ -485,18 +470,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -543,18 +525,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -606,18 +585,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   ../dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	untracked
 	../dir2/modified
 	../dir2/untracked
@@ -677,18 +653,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	<GREEN>new file:   dir2/added<RESET>
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	<RED>modified:   dir1/modified<RESET>
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	<BLUE>dir1/untracked<RESET>
 	<BLUE>dir2/modified<RESET>
 	<BLUE>dir2/untracked<RESET>
@@ -803,18 +776,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -853,12 +823,10 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/
 	untracked
@@ -897,19 +865,16 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -957,14 +922,12 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Submodule changes to be committed:
@@ -974,7 +937,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1020,12 +982,10 @@ and have 2 and 2 different commits each, respectively.
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1069,14 +1029,12 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD^1 <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Submodule changes to be committed:
@@ -1086,7 +1044,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
@@ -1124,13 +1081,11 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Submodule changes to be committed:
@@ -1140,7 +1095,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	.gitmodules
 	dir1/untracked
 	dir2/modified
@@ -1236,14 +1190,12 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
   (commit or discard the untracked or modified content in submodules)
-
 	modified:   dir1/modified
 	modified:   sm (modified content)
 
@@ -1254,7 +1206,6 @@ Submodule changes to be committed:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	.gitmodules
 	dir1/untracked
 	dir2/modified
@@ -1296,13 +1247,11 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 	modified:   sm (new commits)
 
@@ -1318,7 +1267,6 @@ Submodules changed but not updated:
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	.gitmodules
 	dir1/untracked
 	dir2/modified
@@ -1380,13 +1328,11 @@ cat > expect << EOF
 ;
 ; Changes to be committed:
 ;   (use "git reset HEAD <file>..." to unstage)
-;
 ;	modified:   sm
 ;
 ; Changes not staged for commit:
 ;   (use "git add <file>..." to update what will be committed)
 ;   (use "git checkout -- <file>..." to discard changes in working directory)
-;
 ;	modified:   dir1/modified
 ;	modified:   sm (new commits)
 ;
@@ -1402,7 +1348,6 @@ cat > expect << EOF
 ;
 ; Untracked files:
 ;   (use "git add <file>..." to include in what will be committed)
-;
 ;	.gitmodules
 ;	dir1/untracked
 ;	dir2/modified
@@ -1432,12 +1377,10 @@ and have 2 and 2 different commits each, respectively.
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	.gitmodules
 	dir1/untracked
 	dir2/modified
@@ -1459,18 +1402,15 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files:
   (use "git add <file>..." to include in what will be committed)
-
 	.gitmodules
 	dir1/untracked
 	dir2/modified
@@ -1582,13 +1522,11 @@ and have 2 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files not listed (use -u option to show untracked files)
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index c1eb72555d..e5ba2d2c8a 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -33,7 +33,6 @@ You have unmerged paths.
 
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -54,7 +53,6 @@ All conflicts fixed but you are still merging.
   (use "git commit" to conclude merge)
 
 Changes to be committed:
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -87,7 +85,6 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -111,7 +108,6 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -150,7 +146,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
 Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -177,7 +172,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -247,7 +241,6 @@ You are currently splitting a commit while rebasing branch '\''split_commit'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -355,7 +348,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -454,7 +446,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -558,7 +549,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -747,7 +737,6 @@ You are currently cherry-picking commit $TO_CHERRY_PICK.
 
 Unmerged paths:
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -771,7 +760,6 @@ You are currently cherry-picking commit $TO_CHERRY_PICK.
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)
 
 Changes to be committed:
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -836,7 +824,6 @@ You are currently reverting commit $TO_REVERT.
 Unmerged paths:
   (use "git reset HEAD <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   to-revert.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -856,7 +843,6 @@ You are currently reverting commit $TO_REVERT.
 
 Changes to be committed:
   (use "git reset HEAD <file>..." to unstage)
-
 	modified:   to-revert.txt
 
 Untracked files not listed (use -u option to show untracked files)
diff --git a/wt-status.c b/wt-status.c
index e065558c31..3d10d19af0 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -194,7 +194,6 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_cached_header(struct wt_status *s)
@@ -210,7 +209,6 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
 	else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_dirty_header(struct wt_status *s,
@@ -229,7 +227,6 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_other_header(struct wt_status *s,
@@ -241,7 +238,6 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	if (!s->hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_trailer(struct wt_status *s)
-- 
gitgitgadget
