Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C5C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D9D20878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgJLT7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:59:41 -0400
Received: from vimdzmsp-sfwd03.bluewin.ch ([195.186.120.132]:42357 "EHLO
        vimdzmsp-sfwd03.bluewin.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgJLT7j (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 15:59:39 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 15:59:38 EDT
Received: from localhost.localdomain ([178.82.236.236])
        by vimdzmsp-sfwd03.bluewin.ch Swisscom AG with ESMTPA
        id S3t2knEmD4up0S3t2kPITL; Mon, 12 Oct 2020 21:53:36 +0200
X-Bluewin-Spam-Analysis: v=2.3 cv=Zsp21+zG c=1 sm=1 tr=0
 a=HtqHOeZjyPUdB8xaH0hM2g==:117 a=HtqHOeZjyPUdB8xaH0hM2g==:17
 a=x7InfYVWiFSDIHPQhjQA:9
X-Bluewin-Spam-Score: 0.00
X-FXIT-IP: IPv4[178.82.236.236] Epoch[1602532416]
X-Bluewin-AuthAs: cedricschwyter@bluewin.ch
From:   Cedric Schwyter <cedricschwyter@bluewin.ch>
To:     git@vger.kernel.org
Cc:     Cedric Schwyter <cedricschwyter@bluewin.ch>
Subject: [PATCH 0/1] Alias 'list'-subcommands to 'ls' 
Date:   Mon, 12 Oct 2020 21:53:34 +0200
Message-Id: <20201012195335.189194-1-cedricschwyter@bluewin.ch>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNk5Syr7YNLyg4fF87os09TW3ApeiXl/lOjv3FbVPX989XsZof5OiG68rrnoHh+mbJS7tZ6xkmlVR5nHbAv64KwzUo1gYPTAvFaHW66oxhc0L4m/pnmv
 24sMqekdLEPPLI60z08NyF40I6xFxy8YN9tv/grf2v7zHDHN97JHlzPA92/ZnFj8FiGsbSHsz9dVhLHx2mmOiEoFV+IH3yqRsEZ5sKztbTRgzToQhCi3Xrwr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since many CLI-tools make use of this alias and many programmers are
used to it I thought I'd add it to git since I was missing such an alias.

I only added it to built-in subcommands for now, might add it to some
more commands in the future.

Cedric Schwyter (1):
  subcommands: alias 'list'-subcommands to 'ls' where applicable
  docs: update docs with new alias

 Documentation/git-bundle.txt          | 4 ++++
 Documentation/git-sparse-checkout.txt | 3 +++
 Documentation/git-stash.txt           | 5 +++++
 Documentation/git-worktree.txt        | 5 +++++
 builtin/bundle.c                      | 3 ++-
 builtin/sparse-checkout.c             | 3 ++-
 builtin/stash.c                       | 4 +++-
 builtin/worktree.c                    | 3 ++-
 8 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.28.0

