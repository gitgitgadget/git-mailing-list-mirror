Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCBC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416020678
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgAHTAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:00:24 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48893 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgAHTAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:00:23 -0500
X-Originating-IP: 157.45.10.97
Received: from localhost (unknown [157.45.10.97])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D8C4D1BF204;
        Wed,  8 Jan 2020 19:00:21 +0000 (UTC)
Date:   Thu, 9 Jan 2020 00:30:19 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20200108190019.cvrddsmppg4xjka6@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the new changes in git-gui for the upcoming Git v2.25 release.

---
The following changes since commit b524f6b399c77b40c8bf2b6217585fde4731472a:

  Merge branch 'ka/japanese-translation' (2019-10-14 23:22:50 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git

for you to fetch changes up to 0d2116c6441079a5a1091e4cf152fd9d5fa9811b:

  Merge branch 'zs/open-current-file' (2020-01-05 02:38:03 +0530)

----------------------------------------------------------------
Jonathan Gilbert (3):
      git-gui: consolidate naming conventions
      git-gui: update status bar to track operations
      git-gui: revert untracked files by deleting them

Kazuhiro Kato (1):
      git gui: fix branch name encoding error

Pratyush Yadav (5):
      Merge branch 'jg/revert-untracked'
      Merge branch 'kk/branch-name-encoding'
      git-gui: allow closing console window with Escape
      Merge branch 'py/console-close-esc'
      Merge branch 'zs/open-current-file'

Zoli Szabó (1):
      git-gui: allow opening currently selected file in default app

 git-gui.sh                |  61 ++++--
 lib/blame.tcl             |  24 ++-
 lib/branch.tcl            |   2 +
 lib/checkout_op.tcl       |  15 +-
 lib/choose_repository.tcl | 120 +++++++----
 lib/chord.tcl             | 160 ++++++++++++++
 lib/console.tcl           |   2 +
 lib/index.tcl             | 523 ++++++++++++++++++++++++++++++++++------------
 lib/merge.tcl             |  14 +-
 lib/status_bar.tcl        | 231 +++++++++++++++++---
 10 files changed, 920 insertions(+), 232 deletions(-)
 create mode 100644 lib/chord.tcl

-- 
Regards,
Pratyush Yadav
