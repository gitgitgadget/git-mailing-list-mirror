Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841D9C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5392074D
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 08:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhA0IWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:22:45 -0500
Received: from ciao.gmane.io ([116.202.254.214]:48150 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232218AbhA0IUr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 03:20:47 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1l4g3V-0004sz-W0
        for git@vger.kernel.org; Wed, 27 Jan 2021 09:20:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Daniel Lublin <daniel@lublin.se>
Subject: git stash push --patch offers skip-worktree hunks
Date:   Wed, 27 Jan 2021 08:15:19 -0000 (UTC)
Message-ID: <rur7en$16bk$1@ciao.gmane.io>
User-Agent: slrn/pre1.0.4-5 (Linux)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using this to hide some locally modified files from accidental commit:

  git update-index --skip-worktree ...

Doing `git stash push` does not result in the above modifications being
stashed. But, doing `git stash push --patch` asks me about hunks in the
files which were flagged to skip-worktree. Instinctively, this feels wrong.
The docs also say:

  Interactively select hunks from the diff between HEAD and the working tree
  to be stashed.

What do you think?

regards,

-- 
Daniel
lublin.se

