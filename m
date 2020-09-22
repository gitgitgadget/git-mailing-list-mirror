Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD691C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932DE2084C
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 10:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIVKCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:02:09 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35572 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVKCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 06:02:09 -0400
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id E570C3AE9DE
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 09:53:11 +0000 (UTC)
X-Originating-IP: 157.36.75.203
Received: from localhost (unknown [157.36.75.203])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 331D81BF20A;
        Tue, 22 Sep 2020 09:52:46 +0000 (UTC)
Date:   Tue, 22 Sep 2020 15:22:41 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Serg Tereshchenko <serg.partizan@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] style(git-gui): Fix mixed tabs & spaces; Prefer tabs.
Message-ID: <20200922095241.oswiczosfepj6ngx@yadavpratyush.com>
References: <20200909045108.j5ovnbk35cmghgcz@yadavpratyush.com>
 <20200909130136.39098-1-serg.partizan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909130136.39098-1-serg.partizan@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/20 04:01PM, Serg Tereshchenko wrote:
> Hi Pratyush,
> 
> Thanks for suggestion about scissors, i was wondering how to do this
> properly, i'll try it next time.
> 
> > I'm not on board with this entire hunk. In many C projects (like Linux, 
> > Git, etc) the "switch" and the "case" are on the same indent level. I 
> > can see instances of this in almost every switch-case block in 
> > git-gui.sh as well. We should stick to the local convention here and 
> > drop this hunk.
> > 
> > I can make these changes locally and merge them so no need to re-roll... 
> > unless you have any counter points that is.
> 
> I have no objections, please drop that hunk.

Merged with the above changes. Thanks.
 
> --
> Regards,
> Serg Tereshchenko

-- 
Regards,
Pratyush Yadav
