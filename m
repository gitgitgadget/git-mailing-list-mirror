Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE49C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbiDCIul (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 04:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiDCIuk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 04:50:40 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Apr 2022 01:48:47 PDT
Received: from dcvr.yhbt.net (dcvr.yhbt.net [64.71.152.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428CAE71
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 01:48:45 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A50221F4CE;
        Sun,  3 Apr 2022 08:42:58 +0000 (UTC)
Date:   Sun, 3 Apr 2022 08:42:58 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Subject: any real-world SHA-256 repo users out there?
Message-ID: <20220403084258.GA27999@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all, just wondering if it's something I should prioritize
adding support for in some git-using project I hack on...

Of course, I'm not dropping SHA-1 support.  So I'm wondering if
I should wait for (or hack on :P) git to handle both SHA-256 and
SHA-1 in one process; or if it's something I'd be better off
managing via multiple (git cat-file --batch) processes.  No OIDs
are abbreviated, so it's just 20/40 vs 32/64.

I actually started an entirely new project in May 2021 using
SHA-256 and the only problem I've encountered (now fixed) was
with HTTP(S) clones.  I still haven't publicized that new
project, yet (I keep getting brain farts and side-tracked with
other stuff...)
