Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA4C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 19:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B623B6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 19:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgLRTwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:52:13 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53919 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgLRTwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 14:52:13 -0500
X-Originating-IP: 103.82.80.9
Received: from localhost (unknown [103.82.80.9])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3D83740002;
        Fri, 18 Dec 2020 19:51:30 +0000 (UTC)
Date:   Sat, 19 Dec 2020 01:21:28 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20201218195128.z7zuvraj4mm2e6tz@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull in changes in git-gui for Git v2.30. I hope the PR is not 
too late this time. Thanks.

---
The following changes since commit 38c2ac2e2ab00a8bcef528f24cb5b883b4413e5c:

  Merge branch 'sh/blame-tooltip' (2020-10-17 15:05:27 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git

for you to fetch changes up to 7b0cfe156e1f1fbb77ab35d55d48eef41625944d:

  Merge branch 'sh/inactive-background' (2020-12-19 01:02:34 +0530)

----------------------------------------------------------------
David Aguilar (1):
      git-gui: ssh-askpass: add a checkbox to show the input text

Dimitriy Ryazantcev (1):
      git-gui: update Russian translation

Martin Schön (1):
      git-gui: use commit message template

Pratyush Yadav (8):
      git-gui: Only touch GITGUI_MSG when needed
      Merge branch 'ms/commit-template'
      Merge branch 'dr/russian-translation'
      Merge branch 'da/askpass-mask-checkbox'
      Merge branch 'sh/macos-labels'
      Merge branch 'rj/clean-speedup'
      Merge branch 'st/selected-text-colors'
      Merge branch 'sh/inactive-background'

Ramsay Jones (1):
      Makefile: conditionally include GIT-VERSION-FILE

Serg Tereshchenko (1):
      git-gui: Fix selected text colors

Stefan Haller (2):
      git-gui: fix colored label backgrounds when using themed widgets
      git-gui: use gray background for inactive text widgets

 Makefile         |    2 +
 git-gui--askpass |   15 +-
 git-gui.sh       |   30 +-
 lib/commit.tcl   |    1 +
 lib/themed.tcl   |   41 +-
 po/ru.po         | 3053 +++++++++++++++++++++++++++++-------------------------
 6 files changed, 1728 insertions(+), 1414 deletions(-)

-- 
Regards,
Pratyush Yadav
