Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3274EC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 15:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiLEPij (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEPiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 10:38:22 -0500
X-Greylist: delayed 1067 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 07:38:02 PST
Received: from erc.thregr.org (erc.thregr.org [IPv6:2001:41c9:1:41f::63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCC25C9
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 07:38:01 -0800 (PST)
Received: from [37.163.152.118] (helo=localhost)
        by erc.thregr.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        id 1p2DGO-001ByG-2V (envelope-from <wavexx@thregr.org>)
        for git@vger.kernel.org;
        Mon, 05 Dec 2022 16:20:13 +0100
User-agent: mu4e 1.9.3; emacs 30.0.50
From:   Yuri D'Elia <wavexx@thregr.org>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-assembler 1.3 released
Date:   Mon, 05 Dec 2022 16:15:15 +0100
Message-ID: <87tu2927yt.fsf@wavexx.thregr.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-assembler 1.3 was just released. Aside from the usual bug-fixes,
this version now accepts wildcards when referring to branch names. This
reduces duplication in boilerplate rules as well enabling new forms of
branch compositions that work very well with CI.

git-assembler can perform automatic merge and rebase operations
following a simple declarative script. Like "make", but for branches.
You can use git-assembler to create a branch which is a combination of
patches using various strategies and keep it always updated.

Documentation and links are available at:

  https://www.thregr.org/~wavexx/software/git-assembler/

The source itself:

  https://gitlab.com/wavexx/git-assembler
