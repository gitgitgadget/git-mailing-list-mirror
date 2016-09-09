Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112141F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 12:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754725AbcIIM7C (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 08:59:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:60743 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbcIIM7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 08:59:01 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LfC4q-1bFZAA1RUG-00orEA; Fri, 09 Sep 2016 14:58:42
 +0200
Date:   Fri, 9 Sep 2016 14:58:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] diff_flush_patch_id: stop returning error result
In-Reply-To: <20160909104007.pwki2ir6et3vvk55@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609091455180.129229@virtualbox>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net> <20160907220409.oowxymhvkof2xsk5@sigill.intra.peff.net> <alpine.DEB.2.20.1609091219350.129229@virtualbox> <20160909104007.pwki2ir6et3vvk55@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mRUW/hLJmuO7ORQLz/h1rgmeqlN2ajCT43+Cz8PveMSLPBcL90S
 tPjqcsumSXb6+TxnIKF7eSNuUQIYP0K2q/+3oKehbd2m3QulOvb+fs+2dzs1kWywGbCJNgR
 UapzbkHXxsDbrDvCZRMqsvQRLhYLOLbk7aw2iqjyZEnfgVHKGK25BjpcvOOyG+i9Uj9xmeE
 4YsMCyFRoSyA1hPdNB4hA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:R4dALtMTgQ8=:zxcFcxzswizzLxXBG0lnRQ
 7ZLVK2Ucv/yazkTCw1DiaE6TTgQmPSmZGf0LHf3eLhHP1hwUhByxNIxkExM+xauj1uRt8Aqjk
 0bZLPGIYA6MlGExoe8X7o8v7DBnyw8lLwcJU3EfeAYftbJo2yzcnpobX7rebnIhQTxbVsMJUO
 2auUjlU3GRoFeu14qa0WHmpRBgVqWfLuv9yqlj3jOSdYGH9LzOpFDhcDFGJluLAnNmEWg1wvK
 H8y3a2JFjo7SKfzPhqYRQda9jo+NJlMJ2J5WoorlcvRb6mbOYIfCOEbAGBTIER+u08pfakNyQ
 RoO6x/dsUS7/oUgZ0YIi76lYESGdQHrkBV7qedUX1d8BmKvaa1vi/f7bVRnHQbiPB2GtdeM9l
 oWPIUPzWYPwBT6UngyBMfELZ/owoUpGF7UGqj26EVPp1jTTl1lrYzy05scnonhF+qf9P3Bn6x
 8ndvCyX569vbRspwjXVN2xAwJAyD11+79ZDqMTGwZbUzXMF0JxjypxO3nJbZRVvk/CszWbXTN
 fyIZKO8QKsWrLe6XhKf1SiyOljVyK4rzFLAbo6+vn0N6o+GoAmbErQiDkl6KUFnTk8sZOPIvI
 twXI17h9bBRNGxz8smpYCr19GumtznvmP/NRzLuW4driQ6Bf12umoK5eOIfvwvKjqzeLN/k3Q
 kRpkcM+1pMKD2ipWPC24T5Enpsxo3tBA1onftlpQb03SdqfGg5KrQPRTM9AWYr0W+A0/5dWsW
 8WCwx3sGDmv3aBmtC8Ae8UyxDlIwAE9/Oyh9Ds/Lel3+HW7SlmDYRtxrie/ZvEmPx6GGIaUa0
 zBsenRK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 9 Sep 2016, Jeff King wrote:

> On Fri, Sep 09, 2016 at 12:28:38PM +0200, Johannes Schindelin wrote:
> 
> > I like the simplification, but I *hate* the fact that the calling code has
> > *no way* to inform the user about the proper next steps.
> > 
> > You are touching code that is really quite at the bottom of a lot of call
> > chains. For example in the one of `git pull --rebase`. I just spent an
> > insane amount of time trying to make sure that this command will not
> > simply die() somewhere deep in the code, leaving the user puzzled.
> > 
> > Please see 3be18b4 (t5520: verify that `pull --rebase` shows the helpful
> > advice when failing, 2016-07-26) for more details.
> 
> Yes, I agree that this is the opposite direction of libification. And I
> agree that the current message is not very helpful.
> 
> But I am not sure that returning the error up the stack will actually
> help somebody move forward. The reason these are all die() calls in the
> rest of the diff code is that they are generally indicative of
> unrecoverable repository corruption. So any advice does not really
> depend on what operation you are performing; it is always "stop what you
> are doing immediately, run fsck, and try to get the broken objects from
> somebody else".
> 
> So IMHO, on balance this is not hurting anything.

Well, you make such a situation even worse than it already is.

It would be one thing to change the code to actually say "stop what you
are doing immediately, run `git fsck` and try to get the broken objects
from somewhere else", *before* saying how to proceed after that.

But that is not what your patch does.

What your patch does is to remove *even the possibility* of saying how to
proceed after getting the repository corruption fixed. And instead of
saying how the corruption could be fixed, it outputs a terse "cannot read
files to diff".

I do not think that is a wise direction.

Ciao,
Dscho
