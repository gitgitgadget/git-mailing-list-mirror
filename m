Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8607C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 08:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjFLIJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjFLIJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 04:09:11 -0400
Received: from erc.thregr.org (erc.thregr.org [46.43.2.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90553CE
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 01:08:47 -0700 (PDT)
Received: from [37.161.107.155] (helo=localhost)
        by erc.thregr.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1q8c7D-001YRW-1r (envelope-from <wavexx@thregr.org>)
        for git@vger.kernel.org;
        Mon, 12 Jun 2023 09:37:27 +0200
User-agent: mu4e 1.11.6; emacs 30.0.50
From:   Yuri D'Elia <wavexx@thregr.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-assembler 1.5 released
Date:   Sun, 11 Jun 2023 22:40:35 +0200
Message-ID: <87o7llt9ld.fsf@wavexx.thregr.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-assembler 1.5 was just released. Git flags can now directly be
passed onto the underlying merge and rebase operations, allowing the
developer to use different merge strategies or control fast-forward
settings on a branch-by-branch basis.

git-assembler can perform automatic merge and rebase operations
following a simple declarative script. Like "make", but for branches. It
can be used to create branches which are a combination of patches using
various strategies and keep it always updated. Useful for testing, CI or
custom branch organization workflows like a generalized stgit/topgit.

Documentation and links are available at:

  https://www.thregr.org/~wavexx/software/git-assembler/

The source itself:

  https://gitlab.com/wavexx/git-assembler
