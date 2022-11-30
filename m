Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F2C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 20:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiK3Ueq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 15:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiK3Ue3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 15:34:29 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88267633F
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 12:34:00 -0800 (PST)
Date:   Wed, 30 Nov 2022 20:33:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bytieful.com;
        s=protonmail3; t=1669840437; x=1670099637;
        bh=0cTC2njsmONG9W+ohkEkmoOxj62feQx467JqQ0Zg6hw=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=DIVE2A9vqTOnoSE17U8t3xje+cX5+BF7+hzBvSPsnPCZbG7ywypZiyQvXBuTToYBw
         1WN5tyXD4mosEy8a8YaXXeRkqCFPZbdj6RV3Rq19ODX9c5L5oWm98mdbfUX3+kA1IH
         eu2QrVJO4lPpPFKV9AgLZwSFV+mfRANkAWtqt7Zjv/SwXkw2fEAA0laRPcO1PDy5RN
         RkbtIorN63PY1H1DXuTsakIXiDVeOwL668iaQRCctl4aPNGtXUFN/RWXZowwyGTQQJ
         y0nXYZ3yM59y1FBKKXIYx8hmc3+2gjoYeDuDc50lIC/GPouHaGbmwqcUKpZ7gWmohD
         3nYxcWlAP6BOw==
To:     git@vger.kernel.org
From:   Erik Aigner <erik@bytieful.com>
Subject: git-worktree-list reporting wrong directory
Message-ID: <A0CB7B70-8EB2-464E-9BF9-320FC6EC3C44@bytieful.com>
Feedback-ID: 37933895:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

- Create a repository containing a submodule
- `cd` to the submodules directory
- run `git worktree list`

What did you expect to happen? (Expected behavior)

- The current directory is reported as the worktree

What happened instead? (Actual behavior)

- Instead the `/path/to/repo/.git/modules/reposubmodule` directory is liste=
d as a worktree

What's different between what you expected and what actually happened?

The `/path/to/repo/.git/modules/reposubmodule` is the repository path, not =
the worktree path.

Anything else you want to add:

-

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.1 (Apple Git-137.1)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 22.1.0 Darwin Kernel Version 22.1.0: Sun Oct  9 20:15:52 PDT =
2022; root:xnu-8792.41.9~2/RELEASE_ARM64_T8112 arm64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
pre-commit


