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
	by dcvr.yhbt.net (Postfix) with ESMTP id 667C21F609
	for <e@80x24.org>; Tue,  4 Jun 2019 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfFDOCY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:02:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfFDOCY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 10:02:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id g13so635878edu.5
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kVEnm5VbTGW9DOPIRud5RJybAaySiqhYDRIRiIqqWe8=;
        b=GvvLaFGnRhjfTRJvwyzV0cE0QHRLT/44UlEuIQqkBjc5LA8voYI3bffLJmMLRHdAV+
         FaTRcqPrZPWDWh6tNZaRblpx/YODOx90CvqtHc3iWA+MpGUaghONb+rLKbTEUxstXxwS
         XQzlVhbWQU6n7LqWwRnF/zDmPp36+zLnaiVMvXum648wMq/SbjGpZYiR3bGiQmuaT349
         kVxPT1MW2Mw4mH4nAeL02/Bq9gKY1Y+M4z8flzw/DteJ7037gpYma75+n0BWvLHKmJS/
         S3HeJGJ3DITj/yo4UFS9ZPChZqdmYRNaELWsmx7BrX+134tBM5rhsltbHVU852jugKHK
         eKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kVEnm5VbTGW9DOPIRud5RJybAaySiqhYDRIRiIqqWe8=;
        b=lcGl236SWODtQOVMyWNHVzqeXkc8iSmUe8U+W6tkQUWUUZa7zWQR1OuYvRqSYopCoG
         m5ZpkM/kbQwCNeiCUwNOFPT000e6sKflIn7c7je4dwI4dGIPEFG27m/UyId/j9mdP+Wd
         8Nx8l6Z3ugXxXyBn2oEeTJfd/efK6iCzSHpbppvULZ0rvRRYjWqwOXd5xQToD+7117ce
         0WQO+5gO8g++nk3K9Uvo4UDPYxj/9Ijr2cfTOtAb/i3xsO+Uaws8XnArDFjUL+KRsR+M
         iolVxsnZhDF/TqKvE/g+jesUdU6HuAau5VtsVaqLGmoDaAlYk7V6lW/6CoX5z+g1MpUD
         sj5w==
X-Gm-Message-State: APjAAAWZYU7k+SkK0o9ImV5x+pGykpINltWjViCBHqyf6jsQmnP2QnwA
        +jUzkEVZqyVwhqWPZt08j9SVKR+J
X-Google-Smtp-Source: APXvYqz80X2Bs/dFlKFMKvpjCfz/bGk48xX8IwuZy1F3lG6WItuXfuQI8DUAxhNdD/6j/jZaYLKkmw==
X-Received: by 2002:a50:9729:: with SMTP id c38mr9888593edb.283.1559656941158;
        Tue, 04 Jun 2019 07:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id kt17sm1079212ejb.78.2019.06.04.07.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:02:20 -0700 (PDT)
Date:   Tue, 04 Jun 2019 07:02:20 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Jun 2019 14:02:18 GMT
Message-Id: <pull.196.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.196.git.gitgitgadget@gmail.com>
References: <pull.196.git.gitgitgadget@gmail.com>
From:   "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] status: remove the empty line after hints
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, there is inconsistency between the status messages with
hints and the ones without hints: there is an empty line between the title
and the file list if hints are presented, but there isn't one if there are
no hints.

This patch remove the inconsistency by removing the empty lines even if
hints are presented.

John Lin (1):
  status: remove the empty line after hints

 t/t7060-wtstatus.sh    |  5 ----
 t/t7508-status.sh      | 62 ------------------------------------------
 t/t7512-status-help.sh | 14 ----------
 wt-status.c            |  4 ---
 4 files changed, 85 deletions(-)


base-commit: 4e43b7ff1ea4b6f16b93a432b6718e9ab38749bd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-196%2Fjohnlinp%2Ffix-status-empty-line-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-196/johnlinp/fix-status-empty-line-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/196

Range-diff vs v1:

 1:  468be8f854 ! 1:  7dfb9a4b1a status: remove the empty line after hints
     @@ -59,13 +59,13 @@
      @@
       #
       # Changes to be committed:
     - #   (use "git reset HEAD <file>..." to unstage)
     + #   (use "git restore --staged <file>..." to unstage)
      -#
       #	new file:   dir2/added
       #
       # Changes not staged for commit:
       #   (use "git add <file>..." to update what will be committed)
     - #   (use "git checkout -- <file>..." to discard changes in working directory)
     + #   (use "git restore <file>..." to discard changes in working directory)
      -#
       #	modified:   dir1/modified
       #
     @@ -78,13 +78,13 @@
      @@
       #
       # Changes to be committed:
     - #   (use "git reset HEAD <file>..." to unstage)
     + #   (use "git restore --staged <file>..." to unstage)
      -#
       #	new file:   dir2/added
       #
       # Changes not staged for commit:
       #   (use "git add <file>..." to update what will be committed)
     - #   (use "git checkout -- <file>..." to discard changes in working directory)
     + #   (use "git restore <file>..." to discard changes in working directory)
      -#
       #	modified:   dir1/modified
       #
     @@ -97,13 +97,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -121,13 +121,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -140,13 +140,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -154,13 +154,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -173,13 +173,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -192,13 +192,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   ../dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   modified
       
     @@ -211,13 +211,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	<GREEN>new file:   dir2/added<RESET>
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	<RED>modified:   dir1/modified<RESET>
       
     @@ -230,13 +230,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -249,7 +249,7 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   dir1/modified
       
     @@ -262,14 +262,14 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       	new file:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -282,14 +282,14 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       	new file:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -305,7 +305,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -318,14 +318,14 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD^1 <file>..." to unstage)
     +   (use "git restore --source=HEAD^1 --staged <file>..." to unstage)
      -
       	new file:   dir2/added
       	new file:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -341,13 +341,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -363,13 +363,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
         (commit or discard the untracked or modified content in submodules)
      -
       	modified:   dir1/modified
     @@ -386,13 +386,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       	modified:   sm (new commits)
     @@ -408,13 +408,13 @@
      @@
       ;
       ; Changes to be committed:
     - ;   (use "git reset HEAD <file>..." to unstage)
     + ;   (use "git restore --staged <file>..." to unstage)
      -;
       ;	modified:   sm
       ;
       ; Changes not staged for commit:
       ;   (use "git add <file>..." to update what will be committed)
     - ;   (use "git checkout -- <file>..." to discard changes in working directory)
     + ;   (use "git restore <file>..." to discard changes in working directory)
      -;
       ;	modified:   dir1/modified
       ;	modified:   sm (new commits)
     @@ -430,7 +430,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -443,13 +443,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -462,13 +462,13 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   sm
       
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   dir1/modified
       
     @@ -495,7 +495,7 @@
       Untracked files not listed (use -u option to show untracked files)
      @@
       Unmerged paths:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
         (use "git add <file>..." to mark resolution)
      -
       	both modified:   main.txt
     @@ -504,14 +504,14 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   main.txt
       
       Untracked files not listed (use -u option to show untracked files)
      @@
       Unmerged paths:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
         (use "git add <file>..." to mark resolution)
      -
       	both modified:   main.txt
     @@ -520,7 +520,7 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   main.txt
       
     @@ -528,7 +528,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   main.txt
       
     @@ -536,7 +536,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   main.txt
       
     @@ -544,7 +544,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   main.txt
       
     @@ -552,7 +552,7 @@
      @@
       Changes not staged for commit:
         (use "git add <file>..." to update what will be committed)
     -   (use "git checkout -- <file>..." to discard changes in working directory)
     +   (use "git restore <file>..." to discard changes in working directory)
      -
       	modified:   main.txt
       
     @@ -575,7 +575,7 @@
       Untracked files not listed (use -u option to show untracked files)
      @@
       Unmerged paths:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
         (use "git add <file>..." to mark resolution)
      -
       	both modified:   to-revert.txt
     @@ -584,7 +584,7 @@
      @@
       
       Changes to be committed:
     -   (use "git reset HEAD <file>..." to unstage)
     +   (use "git restore --staged <file>..." to unstage)
      -
       	modified:   to-revert.txt
       
     @@ -602,15 +602,15 @@
       
       static void wt_longstatus_print_cached_header(struct wt_status *s)
      @@
     - 		status_printf_ln(s, c, _("  (use \"git reset %s <file>...\" to unstage)"), s->reference);
     - 	else
     + 					 s->reference);
     + 	} else
       		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
      -	status_printf_ln(s, c, "%s", "");
       }
       
       static void wt_longstatus_print_dirty_header(struct wt_status *s,
      @@
     - 	status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to discard changes in working directory)"));
     + 	status_printf_ln(s, c, _("  (use \"git restore <file>...\" to discard changes in working directory)"));
       	if (has_dirty_submodules)
       		status_printf_ln(s, c, _("  (commit or discard the untracked or modified content in submodules)"));
      -	status_printf_ln(s, c, "%s", "");

-- 
gitgitgadget
