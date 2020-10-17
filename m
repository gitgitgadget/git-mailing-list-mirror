Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B2EC433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E480D2074A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 16:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438684AbgJQQ4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 12:56:08 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38112 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438534AbgJQQ4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 12:56:07 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id AC8773A6E63
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 16:34:49 +0000 (UTC)
Received: from localhost (unknown [103.82.80.232])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 29753200011;
        Sat, 17 Oct 2020 16:34:26 +0000 (UTC)
Date:   Sat, 17 Oct 2020 22:04:11 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [GIT PULL] git-gui changes for v2.29
Message-ID: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Please pull in the changes in git-gui for v2.29. 

Dscho,

I still have some open points about intent-to-add files that I'm not 
clear about. Let's target support for them in the next release.

Regards,
Pratyush Yadav

---
The following changes since commit 
469725c1a3d44f7e1475f1d37cd13e0824d4ea41:

  Merge branch 'mt/open-worktree' (2020-06-22 20:23:28 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to 38c2ac2e2ab00a8bcef528f24cb5b883b4413e5c:

  Merge branch 'sh/blame-tooltip' (2020-10-17 15:05:27 +0530)

----------------------------------------------------------------
Pratyush Yadav (3):
      Merge branch 'st/spaces-tabs-cleanup' into master
      Merge branch 'st/dark-mode' into master
      Merge branch 'sh/blame-tooltip'

Serg Tereshchenko (2):
      git-gui: fix mixed tabs and spaces; prefer tabs
      git-gui: improve dark mode support

Stefan Haller (1):
      git-gui: blame: prevent tool tips from sticking around after Command-Tab

 git-gui.sh     | 103 ++++++++++++++++++++++++++++++---------------------------
 lib/blame.tcl  |   1 +
 lib/themed.tcl |  38 +++++++++++++++++++++
 3 files changed, 93 insertions(+), 49 deletions(-)
