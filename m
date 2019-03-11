Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464C320248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfCKT5l (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:57:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40420 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbfCKT5h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id r23so335354edm.7
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ql0Wns6C+338Gav1nGv7CEdqKKL5JRSw2Q3/qS/EMyM=;
        b=tBCl/GouZXSyN8DWf2JxvAYxGhGgL30voggHz4KNIJQzz5GonY62xJ2YBsiq0Cffq5
         BlCk46T+fjUjVVbvfzM4Sxp7maubAZHbvb8zi3AMSGR+Q7DJhLbIDvSkiFcFLRya4JvN
         DTfGeMq6XC2nB2nk1W/kGhEgaAKxdzs25zvuih0HHsRSDwk2McI21LLcDQnvzzexGm5t
         FXKUxEd7zrvSTO/jKvWZpzV8XHX8GhPamrJTNVspc8hqUlGS+Iga5VuQgxsbG6Chbdpj
         VS1pcszBCDpFZXrs7ofH+1Lvz8PehC5ely/lbLEMNkJrhyDGe4GFqcUqgIghHm3LN33n
         VVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ql0Wns6C+338Gav1nGv7CEdqKKL5JRSw2Q3/qS/EMyM=;
        b=jD0sUbeGxRTjNOiZFKsOfr8EgzNPqc2x54qD//ctBYjuQqYETy2gscg1/icjhIJQyP
         vvSk3LDeP/MrmloDoxVuvdVV2AFZBx5UpAdVQCuIQrAbBpLnzNbE8mxklIHPdQnra7so
         U8SiaE2VXt+2FIvTLrMG1iH8VmGeOKTSMjFimnlw1lQmIjEjmdKvxEMnHWYM0F6183dg
         lHdnXCEl+I3x3WkpVv8W7j4XpTT+e4t7cccpqIpqWMeKxoySYeJTt9NxoNWjoUL1eQlL
         ZtC5GFL2pOwVaE5StuYO8Sl28ZKfleIH056w+Dh80ca20nQYg6bng8SupajLeU1z64NR
         Q0RA==
X-Gm-Message-State: APjAAAXGL00PkR0dMVD60+0q7YJ1lz+a+KBbQaX66VCj1hYeyx9IXEWl
        rWlDy5I3KT2dybgZM5u5MguWDnn2
X-Google-Smtp-Source: APXvYqz7RZmBCQkXjnez62NQDse649jmpww+9E2Ucp82y6LrQpIdI6mqOpBZKplqkcr2tNyKxLNxCw==
X-Received: by 2002:a50:9484:: with SMTP id s4mr400425eda.82.1552334255764;
        Mon, 11 Mar 2019 12:57:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p44sm4888954edc.1.2019.03.11.12.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 12:57:35 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:57:35 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Mar 2019 19:57:33 GMT
Message-Id: <pull.158.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.158.git.gitgitgadget@gmail.com>
References: <pull.158.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Deprecate git rebase --preserve-merges
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

It had a good run, but its design was irreparably limited. So I came up with
a redesign:--rebase-merges. It seems to work all right, so now it is time to
start letting go of the previous design.

Changes since v1:

 * The term --rebase-merges is now marked as such in the deprecation notice
   in git rebase's manual.
 * The deprecation warning is now printed only in builtin/rebase.c, not
   repeated in git-rebase--preserve-merges.sh.

Johannes Schindelin (1):
  rebase: deprecate --preserve-merges

 Documentation/config/branch.txt |  6 +++---
 Documentation/config/pull.txt   |  6 +++---
 Documentation/git-rebase.txt    | 23 ++++++++++++-----------
 builtin/rebase.c                |  8 ++++++--
 4 files changed, 24 insertions(+), 19 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-158%2Fdscho%2Fdeprecate-rebase-p-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-158/dscho/deprecate-rebase-p-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/158

Range-diff vs v1:

 1:  6407430da7 ! 1:  f6990f28c0 rebase: deprecate --preserve-merges
     @@ -65,7 +65,7 @@
      -	Recreate merge commits instead of flattening the history by replaying
      -	commits a merge commit introduces. Merge conflict resolutions or manual
      -	amendments to merge commits are not preserved.
     -+	[DEPRECATED: use --rebase-merges instead] Recreate merge commits
     ++	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
      +	instead of flattening the history by replaying commits a merge commit
      +	introduces. Merge conflict resolutions or manual amendments to merge
      +	commits are not preserved.
     @@ -109,22 +109,9 @@
       				   builtin_rebase_options);
       
      +	if (options.type == REBASE_PRESERVE_MERGES)
     -+		warning(_("--preserve-merges is deprecated in favor of "
     -+			  "--rebase-merges"));
     ++		warning(_("git rebase --preserve-merges is deprecated. "
     ++			  "Use --rebase-merges instead."));
      +
       	if (action != NO_ACTION && !in_progress)
       		die(_("No rebase in progress?"));
       	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
     -
     - diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
     - --- a/git-rebase--preserve-merges.sh
     - +++ b/git-rebase--preserve-merges.sh
     -@@
     - 	printf '%s\n' "$*" >&2
     - }
     - 
     -+warn "git rebase --preserve-merges is deprecated. Use --rebase-merges instead."
     -+
     - # Output the commit message for the specified commit.
     - commit_message () {
     - 	git cat-file commit "$1" | sed "1,/^$/d"

-- 
gitgitgadget
