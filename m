Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75221F609
	for <e@80x24.org>; Tue,  4 Jun 2019 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfFDOCZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:02:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33405 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDOCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:02:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id y17so667954edr.0
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pdHFlZwkSGBFI+vlTBQ1FT7LGHuTJEq+PMJEyAVB9D4=;
        b=FfALs2DE8MsWcCCh0ikmN5ZPHG/K+Ahy7/lMIMNhK4c7/iFqzpCl01mkvZbNgzFFHm
         cIbWbYHn7fOy5/+rF5be9NStG94zEF9MvgIfhKOIf7jOZJsJYfklut3qlgL5tRNScRKF
         ium+LLMGclgw9Cl8/fw6sUN1UdmkwH6u/5FVZEYOeT4bbkFYvHUC3QRvs8HykGyWEhUk
         dLkQiJ+Ar4vfGen8Rniu1TodRtBH/I/BJDHHksXaUoBK663Dt6RzPpMh3liI2RPJmsZi
         UVv5w8ukTrjCiM0qMwpg7IUzjoy5VV32MhiNG44XVgRJyWk5mgeDHg+kiWC3BSTfmtYN
         wzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pdHFlZwkSGBFI+vlTBQ1FT7LGHuTJEq+PMJEyAVB9D4=;
        b=MR++M8R+egUO6BQphhaCko4o/VaJQIHi7cc7wK45nZfdnjbfieT/goe0XGw0t73p0V
         3NpChmI19WGrW9uxIAw8UwNMlJScVprqhPRXNJt7p6w4Z6fVyXxS9/xYCHhaYg1i153p
         naq6eTDVyw+W8BvLhJ2i57S+NLbiAW5H2ZbeSbHCgpjBVuZOqpXbRQHZUc6sgHHLKSVr
         X7VpTNfeMcgfylQ9PZFsZnmHuco23pWypK7PDIgiwv7lPQVQsECbllRWknAt3zy48ft8
         +be7/tlE5Y6trjPJogBQOxynOBTQrKZbG25dBHDvXAuw136xS1Jz6nz7GaiREKxsc5wP
         RTpA==
X-Gm-Message-State: APjAAAXENp7fpk07t143KtrJ5T4MtSd1gOjeUlOMb2cEO5RzpyhGEKA9
        /za0JxbVtDFvuEsWAxQ9bCEtXWw6
X-Google-Smtp-Source: APXvYqzanrIpScL01DjJo/Jz9vNb6hdu1L3UlVWHZsq3sWOzJUs0gIIWdwDgH6FmHppBheky55eLZA==
X-Received: by 2002:a17:906:2e4e:: with SMTP id r14mr29628299eji.34.1559656942322;
        Tue, 04 Jun 2019 07:02:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fj23sm999646ejb.47.2019.06.04.07.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:02:21 -0700 (PDT)
Date:   Tue, 04 Jun 2019 07:02:21 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Jun 2019 14:02:19 GMT
Message-Id: <7dfb9a4b1a720e8d55ff06ba378b907a7ee7f77a.1559656939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.196.v2.git.gitgitgadget@gmail.com>
References: <pull.196.git.gitgitgadget@gmail.com>
        <pull.196.v2.git.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] status: remove the empty line after hints
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
index 681bc314b4..4e676cdce8 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -95,18 +95,15 @@ test_expect_success 'status --column' '
 #
 # Changes to be committed:
 #   (use "git restore --staged <file>..." to unstage)
-#
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git restore <file>..." to discard changes in working directory)
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
 #   (use "git restore --staged <file>..." to unstage)
-#
 #	new file:   dir2/added
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files not listed (use -u option to show untracked files)
@@ -485,18 +470,15 @@ and have 1 and 2 different commits each, respectively.
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   ../dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	<GREEN>new file:   dir2/added<RESET>
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
-
 	new file:   dir2/added
 	new file:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
 ;   (use "git restore --staged <file>..." to unstage)
-;
 ;	modified:   sm
 ;
 ; Changes not staged for commit:
 ;   (use "git add <file>..." to update what will be committed)
 ;   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   sm
 
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
-
 	modified:   dir1/modified
 
 Untracked files not listed (use -u option to show untracked files)
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 1b9712c675..bf0b2c8bdb 100755
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
   (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -111,7 +108,6 @@ You are currently rebasing branch '\''rebase_conflicts'\'' on '\''$ONTO'\''.
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -150,7 +146,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
 Unmerged paths:
   (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -177,7 +172,6 @@ You are currently rebasing branch '\''rebase_i_conflicts_second'\'' on '\''$ONTO
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   main.txt
 
 Untracked files not listed (use -u option to show untracked files)
@@ -247,7 +241,6 @@ You are currently splitting a commit while rebasing branch '\''split_commit'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -355,7 +348,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -454,7 +446,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
-
 	modified:   main.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -558,7 +549,6 @@ You are currently splitting a commit while rebasing branch '\''several_edits'\''
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
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
@@ -818,7 +806,6 @@ You are currently reverting commit $TO_REVERT.
 Unmerged paths:
   (use "git restore --staged <file>..." to unstage)
   (use "git add <file>..." to mark resolution)
-
 	both modified:   to-revert.txt
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -838,7 +825,6 @@ You are currently reverting commit $TO_REVERT.
 
 Changes to be committed:
   (use "git restore --staged <file>..." to unstage)
-
 	modified:   to-revert.txt
 
 Untracked files not listed (use -u option to show untracked files)
diff --git a/wt-status.c b/wt-status.c
index 19fd1add75..ddab6b93be 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -199,7 +199,6 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 	} else {
 		status_printf_ln(s, c, _("  (use \"git add/rm <file>...\" as appropriate to mark resolution)"));
 	}
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_cached_header(struct wt_status *s)
@@ -221,7 +220,6 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 					 s->reference);
 	} else
 		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_dirty_header(struct wt_status *s,
@@ -240,7 +238,6 @@ static void wt_longstatus_print_dirty_header(struct wt_status *s,
 	status_printf_ln(s, c, _("  (use \"git restore <file>...\" to discard changes in working directory)"));
 	if (has_dirty_submodules)
 		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_other_header(struct wt_status *s,
@@ -252,7 +249,6 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
 	if (!s->hints)
 		return;
 	status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include in what will be committed)"), how);
-	status_printf_ln(s, c, "%s", "");
 }
 
 static void wt_longstatus_print_trailer(struct wt_status *s)
-- 
gitgitgadget
