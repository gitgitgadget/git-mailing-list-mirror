Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C5651F461
	for <e@80x24.org>; Mon,  2 Sep 2019 12:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfIBMZ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 08:25:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50829 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729893AbfIBMZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 08:25:58 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 85FB0E0010;
        Mon,  2 Sep 2019 12:25:55 +0000 (UTC)
Date:   Mon, 2 Sep 2019 17:55:27 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
Message-ID: <20190902122527.6cbcizo5dsewrl57@yadavpratyush.com>
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
 <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
 <e2b35f49-5578-c58f-326d-3111333737a0@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2b35f49-5578-c58f-326d-3111333737a0@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09/19 11:27PM, Philip Oakley wrote:
> Hi Pratyus,
> On 01/09/2019 12:32, Pratyush Yadav wrote:
> > Hi Birger,
> > 
> > In case you haven't been following the list, Pat has been inactive
> > recently, so I am acting as the interim maintainer of git-gui for now,
> > because no one else stepped up and Junio would rather not maintain it.
> > 
> > You can find my fork over athttps://github.com/prati0100/git-gui. I
> > munged your patches to apply on my tree (which is separate from the
> > git.git tree), but it would be great if you base them on my tree next
> > time around.
> 
> Are there any plans or thoughts about creating a more inclusive man page for
> the git-gui?
 
Having better documentation has been one of the things I have in my 
future plans, but I can't really say when I can get to it depending on 
my schedule and time available. I have a couple other topics active 
which I'd like to get resolved first.

Of course, if someone else is willing to take the initiative, I'm happy 
to help :)

> Such things as the Options dialog linkages [1], and how to drive the command
> line options are areas I've wondered about over the years.
> 
> Not exactly sure how our plain text man pages and formatted HTML would fare
> for describing the gui layout and where to click. One thing I am noting is
> that these hotkey nicely have numbers so can easily be used for reference..
 
For the options dialog, I think a "tooltip" (something like what you get 
when you hover over a image in a browser) that describes the option is a 
better idea than having a separate man page. I don't expect the option 
descriptions to be too long or complicated. This approach has the added 
benefit of not having to maintain a separate man page. Whenever someone 
adds a new options, they have to add its description as well.

I also think the "tools" feature needs some documentation, especially 
about what environment variables we export.

Other than these two, I don't see many places that need too much 
documentation. Rest of the UI is pretty self-intuitive, at least to me.

> Philip
> 
> [1] https://stackoverflow.com/questions/6007823/is-there-a-help-page-for-the-git-gui-options-dialog

-- 
Regards,
Pratyush Yadav
