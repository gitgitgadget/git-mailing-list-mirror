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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7175E1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 11:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJHLd3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 07:33:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51500 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHLd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 07:33:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so2768101wme.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NmfyIKJRm/VRZGG5bmBEBD+kyHeXAQrLk4sVTiCB7jE=;
        b=obB8EQTo4SDh607k3vLNrK+SCKAN5ocw6Ox1ZTHmOEWkTKuSLd5Eppy16FfSFhKtWg
         VzyqdqMgp+8N8h9oOWZ4KjoXPkuQrhzT5Vuk5OH9GoHzjNdEHSYMDwt5FLqE8hhLQnzy
         oygYzj3jmzcouRkWXICkUaag5B/TWiDvRq8rr/k/sWMLAkwC20nouYIxDwDRGY5Ijp2i
         QqLW0j/BzvtHVYsJfm2yllBvZj8jb8tB/Fo19LOZFmPmTMbHNe9LpZsmJ3p+nwbn4RlQ
         xLntFhpbjs/2XzF9iDbvar6z3AqOwx1QWBukGhloo56BqAI/eocsZhruL9k0hHYeQFOQ
         SyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NmfyIKJRm/VRZGG5bmBEBD+kyHeXAQrLk4sVTiCB7jE=;
        b=V6temFwjcDgzSRJPqQftOpK8/8MdbfNMRkLVnsY0Kzvw2ImoCAmBeF8ld6aN23Id8T
         zxdLwSOqaN72Ru0m0CXIf2bm34q0WecTMHH6hcDyZn6AevKUUfv8iyl5GakA7OHybydI
         HJRyJu6c3ZcF3wDZF9/6QOSec9iVMrhJIvhDQdtYI2sorQB4zmNfxIKU4lVJVvawkkIG
         l8lft7gSIe36cXabKWBWriu0+7wIVjszJD6NetpUc2lXJ2GqK031p/Hg6ug6escpptTs
         KRi1udLVBSvz84SPsUlImgN5aipEpK2T0ixD7NRdhd4PUf9QLyyBp4SfItL8zP8KUVbA
         ubeA==
X-Gm-Message-State: APjAAAXKCrSQM3/LKhZZS1r05SP2YpiWV/R+no6Cq2edolExsopia5oP
        ou9W0tyoPtehRq8pLpm3XMPo+Pdb
X-Google-Smtp-Source: APXvYqw7BUsddz/Jy3LagY4GBWSMj3YOf9luovv1AdXGPUeIqQNkGWVd4NkTtD1HepPvlnsZ+yRfRw==
X-Received: by 2002:a1c:1bd8:: with SMTP id b207mr3338691wmb.62.1570534406277;
        Tue, 08 Oct 2019 04:33:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9sm17369484wre.74.2019.10.08.04.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:33:25 -0700 (PDT)
Date:   Tue, 08 Oct 2019 04:33:25 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 11:33:24 GMT
Message-Id: <pull.361.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.v3.git.gitgitgadget@gmail.com>
References: <pull.361.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] git-gui: respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch from Git for Windows.

Changes since v3:

 * Adjusted the commit message to reflect that this is no longer only about
   the hooks directory.
 * Added a code comment to indicate how the list of keys was determined that
   are used for the gitdir priming.
 * The gitdir cache is now re-primed upon F5.

Changes since v2:

 * The paths returned by git rev-parse --git-path are now cached, and the
   cache is primed with the most common paths.

Changes since v1:

 * Rather than a fine-grained override of gitdir just for the hooks path, we
   now spawn git rev-parse --git-path [...] every time gitdir is called with
   arguments. This makes the code safer, although at the cost of potentially
   many spawned processes.

Johannes Schindelin (1):
  Make gitdir work with worktrees, respect core.hooksPath, etc

 git-gui.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 4 deletions(-)


base-commit: 60c60b627e81bf84e1cb01729d2ae882178f079d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-361%2Fdscho%2Fgit-gui-hooks-path-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-361/dscho/git-gui-hooks-path-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/361

Range-diff vs v3:

 1:  65c2fa33e1 ! 1:  2f55d6fb2a Fix gitdir e.g. to respect core.hooksPath
     @@ -1,17 +1,21 @@
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
     -    Fix gitdir e.g. to respect core.hooksPath
     +    Make gitdir work with worktrees, respect core.hooksPath, etc
      
     -    Since v2.9.0, Git knows about the config variable core.hookspath
     -    that allows overriding the path to the directory containing the
     -    Git hooks.
     +    Since v2.9.0, Git knows about the config variable core.hookspath that
     +    allows overriding the path to the directory containing the Git hooks.
      
     -    Since v2.10.0, the `--git-path` option respects that config
     -    variable, too, so we may just as well use that command.
     +    Since v2.10.0, the `--git-path` option respects that config variable,
     +    too, so we may just as well use that command.
     +
     +    Other paths inside `.git` are equally subject to differ from
     +    `<gitdir>/<path>`, i.e. inside worktrees, where _some_ paths live in the
     +    "gitdir" and some live in the "commondir" (i.e. the "gitdir" of the main
     +    worktree).
      
          For Git versions older than v2.5.0 (which was the first version to
     -    support the `--git-path` option for the `rev-parse` command), we
     -    simply fall back to the previous code.
     +    support the `--git-path` option for the `rev-parse` command), we simply
     +    fall back to the previous code.
      
          An original patch handled only the hooksPath setting, however, during
          the code submission it was deemed better to fix all call to the `gitdir`
     @@ -19,7 +23,9 @@
      
          To avoid spawning a gazillion `git rev-parse --git-path` instances, we
          cache the returned paths, priming the cache upon startup in a single
     -    `git rev-parse invocation` with the known entries.
     +    `git rev-parse invocation` with some paths (that have been
     +    determined via a typical startup and via grepping the source code for
     +    calls to the `gitdir` function).
      
          This fixes https://github.com/git-for-windows/git/issues/1755
      
     @@ -48,6 +54,8 @@
      +
      +	# `--git-path` is only supported since Git v2.5.0
      +	if {[package vcompare $::_git_version 2.5.0] >= 0} {
     ++		# This list was generated from a typical startup as well as from
     ++		# grepping through Git GUI's source code.
      +		set gitdir_keys [list \
      +			CHERRY_PICK_HEAD FETCH_HEAD GITGUI_BCK GITGUI_EDITMSG \
      +			GITGUI_MSG HEAD hooks hooks/prepare-commit-msg \
     @@ -106,3 +114,21 @@
       		set _prefix [git rev-parse --show-prefix]
       	} err]} {
       	load_config 1
     +@@
     + 	global HEAD PARENT MERGE_HEAD commit_type
     + 	global ui_index ui_workdir ui_comm
     + 	global rescan_active file_states
     +-	global repo_config
     ++	global repo_config _gitdir_cache
     + 
     + 	if {$rescan_active > 0 || ![lock_index read]} return
     + 
     ++	# Only re-prime gitdir cache on a full rescan
     ++	if {$after ne "ui_ready"} {
     ++		array unset _gitdir_cache
     ++		prime_gitdir_cache
     ++	}
     ++
     + 	repository_state newType newHEAD newMERGE_HEAD
     + 	if {[string match amend* $commit_type]
     + 		&& $newType eq {normal}

-- 
gitgitgadget
