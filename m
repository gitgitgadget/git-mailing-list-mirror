Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B500C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0106124C
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 14:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346815AbhIXOgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 10:36:55 -0400
Received: from str75-3-78-193-33-39.fbxo.proxad.net ([78.193.33.39]:42536 "EHLO
        mail.qult.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1346795AbhIXOgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 10:36:54 -0400
X-Greylist: delayed 959 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 10:36:54 EDT
Received: from zenon.in.qult.net ([192.168.64.1])
        by mail.qult.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <ignacy.gawedzki@green-communications.fr>)
        id 1mTm2s-0000Bw-Om
        for git@vger.kernel.org; Fri, 24 Sep 2021 16:19:22 +0200
Received: from ig by zenon.in.qult.net with local (Exim 4.94)
        (envelope-from <ignacy.gawedzki@green-communications.fr>)
        id 1mTm2q-000PQx-67
        for git@vger.kernel.org; Fri, 24 Sep 2021 16:19:20 +0200
Date:   Fri, 24 Sep 2021 16:19:20 +0200
From:   Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
To:     git@vger.kernel.org
Subject: Wrong option -h in grep, ls-remote, and show-ref.
Message-ID: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

git ls-remote -h

What did you expect to happen? (Expected behavior)

The same as git ls-remote --heads.

What happened instead? (Actual behavior)

Displayed the git ls-remote usage.

What's different between what you expected and what actually happened?

The usage indicates -h is the same as --heads, while -h is handled
upstream and always displays the usage of the command.

Anything else you want to add:

The same problem exists with the following commands:

  grep -h is supposed to not show filenames according to its usage string.
  show-ref -h is defined as some hidden option equivalent to --head.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.11.0-31-lowlatency #33-Ubuntu SMP PREEMPT Wed Aug 11 14:21:21 UTC 2021 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
