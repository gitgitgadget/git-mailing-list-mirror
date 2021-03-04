Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C590C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F79464EF8
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhCDSqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:46:12 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39841 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhCDSpl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 13:45:41 -0500
X-Originating-IP: 180.94.32.211
Received: from localhost (unknown [180.94.32.211])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 953F260004;
        Thu,  4 Mar 2021 18:44:59 +0000 (UTC)
Date:   Fri, 5 Mar 2021 00:14:55 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [GIT PULL v2] git-gui pull request
Message-ID: <20210304184455.sah45hzavctfnhwa@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

In light of the recent breakages on macOS, this PR contains a revert of 
the offending commit. I will add it back in the next version with 
problems on macOS fixed.

This highlights the need for me to figure out a way to test on macOS. It 
is not a good strategy to put breaking bugs in a release and hope to fix 
it in the next one. And macOS has been a regular offender. Dunno if it 
is possible without owning the Mac hardware though...

---
The following changes since commit 
b1056f60b63f1bc8226d01881bc829e171fc78bf:

  Merge branch 'py/commit-comments' (2021-02-22 20:19:53 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to df4f9e28f64ea97032ec70d9c8894dc87a1b7f9e:

  Merge branch 'py/revert-commit-comments' (2021-03-04 13:59:45 +0530)

----------------------------------------------------------------
Pratyush Yadav (2):
      Revert "git-gui: remove lines starting with the comment character"
      Merge branch 'py/revert-commit-comments'

 git-gui.sh     |  5 -----
 lib/commit.tcl | 18 ++----------------
 2 files changed, 2 insertions(+), 21 deletions(-)

-- 
Regards,
Pratyush Yadav
