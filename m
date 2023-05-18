Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2526C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 11:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjERLnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 07:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjERLnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 07:43:06 -0400
X-Greylist: delayed 1854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 May 2023 04:42:41 PDT
Received: from erc.thregr.org (erc.thregr.org [46.43.2.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4F10FC
        for <git@vger.kernel.org>; Thu, 18 May 2023 04:42:41 -0700 (PDT)
Received: from [37.160.198.141] (helo=localhost)
        by erc.thregr.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1pzbXa-000fIC-2n (envelope-from <wavexx@thregr.org>)
        for git@vger.kernel.org;
        Thu, 18 May 2023 13:11:27 +0200
User-agent: mu4e 1.11.6; emacs 30.0.50
From:   Yuri D'Elia <wavexx@thregr.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-assembler 1.4 released
Date:   Thu, 18 May 2023 13:05:52 +0200
Message-ID: <877ct5uc6b.fsf@wavexx.thregr.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-assembler 1.4 was just released. This version brings full worktree
support. Checked-out branches are correctly updated/rebuilt from any
tree when referenced in the current assembly. This allows the developer
to use worktrees as automated "patch testing ground" across multiple
mainlines, either for local use or CI.

git-assembler can perform automatic merge and rebase operations
following a simple declarative script. Like "make", but for branches.
You can use git-assembler to create a branch which is a combination of
patches using various strategies and keep it always updated.

Documentation and links are available at:

  https://www.thregr.org/~wavexx/software/git-assembler/

The source itself:

  https://gitlab.com/wavexx/git-assembler
