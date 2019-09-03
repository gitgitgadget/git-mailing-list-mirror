Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C444B1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfICMpq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 08:45:46 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:41245 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICMpq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 08:45:46 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 9433AFF80B;
        Tue,  3 Sep 2019 12:45:43 +0000 (UTC)
Date:   Tue, 3 Sep 2019 18:15:41 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>, bouncingcats@gmail.com
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/19 07:37AM, Birger Skogeng Pedersen wrote:
> On Mon, Sep 2, 2019 at 10:15 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > does Control-Tab works for traversal?
> 
> 
> Bert,
> 
> Control+Tab works for traversal, but as a means to toggle new/amend
> it's very tedious. I have to press Ctrl+Tab 9 times to select "new"
> and 10 times to select "Amend"(!). Then 1 or 2 more times to go back
> to the input area.
> I sincerely doubt that this is your preferred method of switching
> between new/amend. At this point we're better of letting go of the
> keyboard and use the mouse, which is what I'm trying to avoid.
 
Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it 
immediately takes me to the "Amend last commit" option. Then I can press 
space to select it and Tab again to get back to the commit message.

Also, since we are on this topic, how about making the "Amend last 
commit" button a toggle instead? This would act as a "turn amend mode 
on/off" button. Since "Amend last commit" and "New Commit" are mutually 
exclusive, a single toggle to switch between those modes makes sense to 
me.

> > I think this is short enough, so that wasting a Letter is not 
> > justified here.
> I (also) often amend commits, so having a hotkey for this is quite a
> necessity imo.

Assuming the above works for you, do you still feel the need for a 
dedicated binding for amends?

-- 
Regards,
Pratyush Yadav
