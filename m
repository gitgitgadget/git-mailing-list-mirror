Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF74B1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfICR1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 13:27:36 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47047 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbfICR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 13:27:36 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EAB4CC0008;
        Tue,  3 Sep 2019 17:27:33 +0000 (UTC)
Date:   Tue, 3 Sep 2019 22:57:30 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     David <bouncingcats@gmail.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190903172730.esy3rr4gkwxhx2s6@yadavpratyush.com>
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <CAMPXz=r7hLn+aOp6B9arGMT2jxOTTpOvc0e5gm3=ttDqWNfmDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMPXz=r7hLn+aOp6B9arGMT2jxOTTpOvc0e5gm3=ttDqWNfmDA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 01:35AM, David wrote:
> On Tue, 3 Sep 2019 at 22:45, Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > Can you try doing a Shift+Tab? For me on Linux, if I hit Shift+Tab, it
> > immediately takes me to the "Amend last commit" option. Then I can press
> > space to select it and Tab again to get back to the commit message.
> 
> Hi Pratyush Yadav,
> 
> Yes, we know it can be done this way. The point being made is not
> "this cannot be changed with the keyboard". We know that you can
> fool around with the tab key and the shift key and the spacebar and
> eventually you can succeed in changing this option.

Yes, but what Birger was saying was hitting Ctrl+Tab 9-10 times to get 
to the option. This is much faster than that alternative.

My aim was to let people know what options already exist before 
proposing new ones.
 
> And if you want to toggle it back again, you have to do a slightly
> different keyboard dance, depending on where your cursor or
> highlight is currently positioned.
> 
> Rather what we (at least I) am hoping to communicate is that after you
> have done this many thousands of times, and you can do everything
> else in git-gui very fast without touching the mouse, you might also join
> us in wishing for action to be achievable with one hotkey-combination
> event that does not affect any other state, it just toggles new/amend
> commit, and is not a sequence of several multi-key actions which must
> be adapted according to the current status of other input mode actions.

Don't get me wrong. I am not against having a dedicated hotkey for 
toggling amends. I think it is a common enough operation to warrant a 
dedicated keyboard toggle. I was just letting everyone know what the 
current options are, so they can make better judgements whether they 
really need this option or not.

-- 
Regards,
Pratyush Yadav
