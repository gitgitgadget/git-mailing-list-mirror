Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6686D1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 22:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfIDWbI (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:31:08 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45067 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDWbI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:31:08 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 7FE8A40006;
        Wed,  4 Sep 2019 22:31:05 +0000 (UTC)
Date:   Thu, 5 Sep 2019 04:01:03 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
Message-ID: <20190904223102.webntwh5awsl2m3i@yadavpratyush.com>
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com>
 <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
 <CAGr--=LY4JWdms3GtnKAtN6z-2c-jpXE2HJ5_dMM5gEFayrj_g@mail.gmail.com>
 <fcf52af1-dc57-fb58-f52c-7581910a28d6@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf52af1-dc57-fb58-f52c-7581910a28d6@kdbg.org>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09/19 11:39PM, Johannes Sixt wrote:
> Am 04.09.19 um 21:20 schrieb Birger Skogeng Pedersen:
> > On Wed, Sep 4, 2019 at 8:59 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >> Many keyboards do not have a right Alt-key. That means that Alt+1 to
> >> Alt+4 combinations must be typed single-handed with the left hand. This
> >> is mildly awkward for Alt+4. Can we please have the very important
> >> commit widget *not* at Alt+4? I could live with Alt+3.
> > 
> > (RightAlt wouldn't be used by Europeans, anyways)
> > Are you suggesting to keep Alt+1/2/3 for the files/staged/diff
> > widgets, but use something other than Alt+4 for the commit dialog? If
> > so, which one would you prefer?
> 
> I was suggesting Alt+3 for the commit message widget, but my preferences
> are actually Alt+1, Alt+2, Alt+3, in this order. My preference for the
> diff widget would be Alt+4 (the awkward one) because I do not foresee
> that I would use it a lot. Use what remains for the two file lists.

I wonder if that binding is very intuitive.  If we do 1/2 for the top 
and bottom panes on the left side, and 3/4 for the top and bottom panes 
on the right side, that makes some sense.  Doing it your way makes it a 
counter-clockwise motion.

I am not arguing for or against this proposal, just pointing something 
worth thinking about.  Either way, I suppose after a while it becomes 
muscle memory so I'm not sure how much difference this subtle thing will 
make.

> 
> > The initial propsal from me was to use CTRL/CMD+1/2/3/4. What do you
> > think of using the CTRL/CMD key instead of ALT?
> 
> I would not mind Ctrl instead of Alt. Take your pick.

FWIW, I vote for sticking with Alt.

-- 
Regards,
Pratyush Yadav
