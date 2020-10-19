Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445D5C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA40E2225F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 08:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgJSITw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 04:19:52 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35717 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgJSITw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 04:19:52 -0400
X-Originating-IP: 103.82.80.246
Received: from localhost (unknown [103.82.80.246])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 2D598E0017;
        Mon, 19 Oct 2020 08:19:48 +0000 (UTC)
Date:   Mon, 19 Oct 2020 13:49:44 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GIT PULL] git-gui changes for v2.29
Message-ID: <20201019081944.l45a4mskjg5qvwqc@yadavpratyush.com>
References: <20201017163411.hk7tqwzyqzvynf6c@yadavpratyush.com>
 <xmqqmu0k8vej.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmu0k8vej.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/10/20 01:11PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > Junio,
> >
> > Please pull in the changes in git-gui for v2.29. 
> 
> OK, thanks.  Pulled but not pushed out (yet).
> 
> By the way, next time we might want to arrange subsystem pulls a bit
> sooner than immediately before the final---what do you think?

Ok. I'll send the PR by -rc0 or -rc1 next time.
 
> > The following changes since commit 
> > 469725c1a3d44f7e1475f1d37cd13e0824d4ea41:
> >
> >   Merge branch 'mt/open-worktree' (2020-06-22 20:23:28 +0530)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/prati0100/git-gui.git 
> >
> > for you to fetch changes up to 38c2ac2e2ab00a8bcef528f24cb5b883b4413e5c:
> >
> >   Merge branch 'sh/blame-tooltip' (2020-10-17 15:05:27 +0530)
> >
> > ----------------------------------------------------------------
> > Pratyush Yadav (3):
> >       Merge branch 'st/spaces-tabs-cleanup' into master
> >       Merge branch 'st/dark-mode' into master
> >       Merge branch 'sh/blame-tooltip'
> >
> > Serg Tereshchenko (2):
> >       git-gui: fix mixed tabs and spaces; prefer tabs
> >       git-gui: improve dark mode support
> >
> > Stefan Haller (1):
> >       git-gui: blame: prevent tool tips from sticking around after Command-Tab
> >
> >  git-gui.sh     | 103 ++++++++++++++++++++++++++++++---------------------------
> >  lib/blame.tcl  |   1 +
> >  lib/themed.tcl |  38 +++++++++++++++++++++
> >  3 files changed, 93 insertions(+), 49 deletions(-)

-- 
Regards,
Pratyush Yadav
