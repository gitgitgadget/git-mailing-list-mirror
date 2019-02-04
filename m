Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60666211B5
	for <e@80x24.org>; Mon,  4 Feb 2019 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfBDVNV (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 16:13:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40810 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfBDVNV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 16:13:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1434257wrt.7
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8O0kx4yMVqygaVwxge14KU7BCFYJ7nsrde6BBsPh9fM=;
        b=H2mSwNJUPlfZL1ebS39U197i/6sE5QZtU1Ztr67SJp8gJiJTP6mTjxcFku5G4+QpcY
         V6hjJGFdEiQ8GsCYP0vUcxhnBx+5bQ+BcSpFSanpCtw5Eg7T4NpZEkkqc6P6LKrDbv7c
         fbgxKak1BKSyse1z6aaLmL8jK5egNaOTB0IRzdm2r5mLHi+ufjgEDWZKCFwKc+Zr1Ln8
         B2TDSuxvYQW+BBeoq9qaVJORF6nKEPJh5Sewwn/MYNJ586I99HH+aBS08tZNJsY/AKGn
         /SVMetckpKzYlD0EbfaQIzjpod1Qw7tZSOXcEG0tc8RgCQ6n/hqmN7tMAuqO5p2dBhpg
         R3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8O0kx4yMVqygaVwxge14KU7BCFYJ7nsrde6BBsPh9fM=;
        b=WaGHBuNyBMAbS4/JrSNOPx14ve4OzNvAW2UfSAjbOCDP0RKGKaSio2/ktrnNQwp4p2
         B7fqjdMVZ+kOb4GTX56Pgi9/Xz7djrwsXmgCwgdzx5ubw4AEc93Qs6QIy2E0xXW6PxU2
         QRQWuML18BP+gaBLfPbTZ1TLhuAVVBODHw8UhvQNaw+ZVCADL3qKEVB4ZR9IN3uSZD2l
         XTj59IqjSaHi4ztpuqh2AT9RLFDBF84OLSCJZFoYRh6ANdxjCEheRqxQzKHXcX/Rgi40
         xC5ZjrT0QX/CEmyylBXpWyC+m1kX6yRABg1GF3FDEcwhjHGHOll8a4W5lDIl/Fuh+lET
         6nag==
X-Gm-Message-State: AHQUAuYuwLA0F3us6HcyLklnpYKXbdEsKzPDXq8ElhlbOSNhXQGJ9iVc
        gBz/gCb9Qkijg9o9rWv7cjE=
X-Google-Smtp-Source: AHgI3IYkbmnDjDoQ1ZfL3YrEvDdhKs9uf0bD2aiy0iay3/yOh4KsBQB+AYTMtEZJUr5D876Y77/Esw==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr962038wrm.328.1549314798428;
        Mon, 04 Feb 2019 13:13:18 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id x15sm36399447wrs.27.2019.02.04.13.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 13:13:17 -0800 (PST)
Date:   Mon, 4 Feb 2019 21:13:16 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
Message-ID: <20190204211316.GA6085@hank.intra.tgummerer.com>
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/29, Junio C Hamano wrote:
> * tg/checkout-no-overlay (2019-01-08) 8 commits
>   (merged to 'next' on 2019-01-18 at 1e2a79ba5c)
>  + checkout: introduce checkout.overlayMode config
>  + checkout: introduce --{,no-}overlay option
>  + checkout: factor out mark_cache_entry_for_checkout function
>  + checkout: clarify comment
>  + read-cache: add invalidate parameter to remove_marked_cache_entries
>  + entry: support CE_WT_REMOVE flag in checkout_entry
>  + entry: factor out unlink_entry function
>  + move worktree tests to t24*
> 
>  "git checkout --no-overlay" can be used to trigger a new mode of
>  checking out paths out of the tree-ish, that allows paths that
>  match the pathspec that are in the current index and working tree
>  and are not in the tree-ish.
> 
>  Will merge to 'master'.

I was traveling for Git Merge, so I largely ignored the mailing list
for the last week, so I'm a bit late on this, sorry.  Jonathan
mentioned in [*1*] that introducing a config option here is a bit
risky, so I think we should revert the last commit in this series.
Patch for doing that below.

There was also some discussion around the naming of the option, but I
don't have a strong opinion on that, so I'm happy with keeping the
--[no-]overlay option.  I just wanted to bring it up again here in
case someone had a very strong opinion, and would prefer it being
changed before this goes into 2.21.  (Not sure if I'm too late for the
series going to master).

*1*: https://public-inbox.org/git/20190123204721.GB34357@google.com/

--- >8 ---
Subject: [PATCH] revert "checkout: introduce checkout.overlayMode config"

This reverts 1495ff7da5 ("checkout: introduce checkout.overlayMode
config", 2019-01-08) and thus removes the checkout.overlayMode config
option.

The option was originally introduced to give users the option to make
the new no-overlay behaviour the default.  However users may be using
'git checkout' in scripts, even though it is porcelain.  Users setting
the option to false may actually end up accidentally breaking scripts.

With the introduction of a new subcommand that will make the behaviour
the default, the config option will not be needed anymore anyway.
Revert the commit and remove the config option, so we don't risk
breaking scripts.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/config/checkout.txt |  7 -------
 builtin/checkout.c                |  8 +-------
 t/t2025-checkout-no-overlay.sh    | 10 ----------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/Documentation/config/checkout.txt b/Documentation/config/checkout.txt
index 73380a8d86..c4118fa196 100644
--- a/Documentation/config/checkout.txt
+++ b/Documentation/config/checkout.txt
@@ -21,10 +21,3 @@ checkout.optimizeNewBranch::
 	will not update the skip-worktree bit in the index nor add/remove
 	files in the working directory to reflect the current sparse checkout
 	settings nor will it show the local changes.
-
-checkout.overlayMode::
-	In the default overlay mode, `git checkout` never
-	removes files from the index or the working tree.  When
-	setting `checkout.overlayMode` to false, files that appear in
-	the index and working tree, but not in <tree-ish> are removed,
-	to make them match <tree-ish> exactly.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5dfc45736..0c5fe948ef 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1019,19 +1019,13 @@ static int switch_branches(const struct checkout_opts *opts,
 
 static int git_checkout_config(const char *var, const char *value, void *cb)
 {
-	struct checkout_opts *opts = cb;
-
 	if (!strcmp(var, "checkout.optimizenewbranch")) {
 		checkout_optimize_new_branch = git_config_bool(var, value);
 		return 0;
 	}
 
-	if (!strcmp(var, "checkout.overlaymode")) {
-		opts->overlay_mode = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "diff.ignoresubmodules")) {
+		struct checkout_opts *opts = cb;
 		handle_ignore_submodules_arg(&opts->diff_options, value);
 		return 0;
 	}
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay.sh
index a4912e35cb..76330cb5ab 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -44,14 +44,4 @@ test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
 	test_path_is_missing file1
 '
 
-test_expect_success 'checkout with checkout.overlayMode=false deletes files not in <tree-ish>' '
-	>file &&
-	mkdir dir &&
-	>dir/file1 &&
-	git add file dir/file1 &&
-	git -c checkout.overlayMode=false checkout HEAD -- file &&
-	test_path_is_missing file &&
-	test_path_is_file dir/file1
-'
-
 test_done
-- 
2.20.1.495.gaa96b0ce6b

