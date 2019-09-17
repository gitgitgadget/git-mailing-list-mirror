Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB151F463
	for <e@80x24.org>; Tue, 17 Sep 2019 20:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfIQUNk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 16:13:40 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:50579 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfIQUNk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 16:13:40 -0400
X-Originating-IP: 157.49.251.89
Received: from localhost (unknown [157.49.251.89])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 8A6BEFF804;
        Tue, 17 Sep 2019 20:13:37 +0000 (UTC)
Date:   Wed, 18 Sep 2019 01:43:34 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [GIT PULL] git-gui pull request
Message-ID: <20190917201334.hfbvuisdwkwgvwg5@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

There were some topics and discussion related to git-gui in flight. Most 
of them have been stabilized, and merged in. So I think it's a good time 
to pull in those changes.

---
The following changes since commit 
5ab72271e16ac23c269f5019a74a7b1d65170e47:

  Merge remote-tracking branch 'philoakley/dup-gui' (2017-03-18 15:35:09 +0000)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to f7a8834ba4aa20ec750833cf8d30d9a9fed5eade:

  Merge branch 'bp/amend-toggle-bind' (2019-09-14 23:23:12 +0530)

----------------------------------------------------------------
Bert Wesarg (2):
      git-gui: convert new/amend commit radiobutton to checkbutton
      git-gui: add horizontal scrollbar to commit buffer

Birger Skogeng Pedersen (2):
      git-gui: add hotkeys to set widget focus
      git-gui: add hotkey to toggle "Amend Last Commit"

Pratyush Yadav (9):
      git-gui: allow reverting selected lines
      git-gui: allow reverting selected hunk
      git-gui: return early when patch fails to apply
      git-gui: allow undoing last revert
      Merge branch 'bp/widget-focus-hotkeys'
      Merge branch 'py/revert-hunks-lines'
      Merge branch 'bw/amend-checkbutton'
      Merge branch 'bw/commit-scrollbuffer'
      Merge branch 'bp/amend-toggle-bind'

 git-gui.sh          | 140 ++++++++++++++++++++++++++++++++++++++++------------
 lib/checkout_op.tcl |   6 +--
 lib/commit.tcl      |   4 +-
 lib/diff.tcl        |  96 +++++++++++++++++++++++++++++------
 lib/index.tcl       |   8 +--
 5 files changed, 199 insertions(+), 55 deletions(-)

-- 
Regards,
Pratyush Yadav
