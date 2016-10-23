Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74A8E20229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbcJWJzV (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:55:21 -0400
Received: from mout.gmx.net ([212.227.15.18]:64608 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933504AbcJWJzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:55:20 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MexaL-1cIOuM2IPJ-00OW6H; Sun, 23 Oct 2016 11:54:55
 +0200
Date:   Sun, 23 Oct 2016 11:54:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase
 -i patches
In-Reply-To: <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610231151140.3264@virtualbox>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de> <xmqqinsk8g1b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UWL/askP+2+8BQjjdIXNmWTU5Wy15pu3rKDOJ6bvXPqBmVB1/gE
 ZCOFh3ctfPxBglsU+usUSRJZH1C3TRYwAlsnBPVPCt2PKgct5hG2x6/gyh79wQe0uVg43C7
 uDMwSMwQqQ5xHdQneWsNo9uoQYjpe7+SBUewFZ5FghsmIENHV2d8EnvpYidkT7k7uJ4408I
 JARcZI1JAorD7e+kXxaQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WAQ8ecba/AY=:783a65lblKQU5t6RSqgo3T
 +cIPuZ1dAC1I45oPsSKiSqAx/rpgn9yllE5aedYeOOGDMa6gbmqY2Ke0jEtD9oxeO3X+YAPzr
 rJEtF/uvYjXM4dNaRmESI5AkjFhMdih0YbqWWAElDqANr1E+br9q1+r9F/cD9nPcccb84U3rp
 FMLefCmYAWjhwyKXofY1LmS3LNvq+8ClPDBlZPgFAQy/Hlx31aYnjex0rEIKpj6y4MEaMkhic
 w2T8+uynJ+qp2BhjfDaSckz7VVYUdwrh0UztrObs8Cpx+TXsKndCGVua4SLRfDTYPCVu4z6fa
 xRq62030sXcky8l+0SIry3wjH8j16OT8X3O4yyx5OrysC+/M4gZupmTuK/a/mGciFKY0LHTx1
 QEF/Cm7ebUEHZ7gyw19sBD7znpWM51pT9IpBH2Y9RCafKHf1FHXRX0oHb/hRV2oMG7NKR5InM
 mQlRL7G8OqyLl+wn+E6eR3fM2hV20qEKxHofWCx/ItHm2QuXyVboXUwcsg/iis2EYKdr8z5ub
 cc19q9/H2FyzwvfEfbh+HvKjZ1iCHzZtvNjqM+MWlMMPmWAYZVp8WhOlLvweKm2zbTIzq2u5b
 RaL/oD8TgvfIIDA2r68vNcgJMGpo7nCTFaYSRfqwEamFJ6e6QulHTf1yq4y9DWC7OqeEncokF
 9BKMNVMgg7HGLvQ9Fih3WNMR1sKMgbVI8CbMlsmhZ8U7j3ETRqTIkVZMhbj1DJLRJnUDfJxNo
 kAyAym/YKUfJ7ua1bFAjyuenfJ0FG6sBuvrC1qIqVWU1zELwxQZ7KrAybEZzhe3I8mSJ+hXuw
 BGglNKI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 22 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This patch series marks the '4' in the countdown to speed up rebase -i
> > by implementing large parts in C (read: there will be three more patch
> > series after that before the full benefit hits git.git: sequencer-i,
> > rebase--helper and rebase-i-extra).
> > ...
> > It would be *really* nice if we could get this patch series at least
> > into `next` soon, as it gets late and later for the rest of the
> > patches to make it into `master` in time for v2.11 (and it is not for
> > lack of trying on my end...).
> 
> This "countdown 4" step can affect cherry-pick and revert, even
> though we were careful to review changes to the sequencer.c code.

As I pointed out in another mail in this thread: we should not fall into
the trap of overrating review.

In the case of the rebase--helper patches, so far the review mainly
resulted in more work for me (having to change spellings elsewhere, for
example), not in improving the changes I intended to introduce into
git.git's code.

Sure, there has been the occasional improvement, but it certainly feels as
if I spent about 80% of the work after each -v1 iteration on things that
have positively nothing at all to do with accelerating rebase -i.

> I prefer to cook it in 'next' sufficiently long to ensure that we hear
> feedbacks from non-Windows users if there is any unexpected breakage.

FWIW I am using the same patches not only on Windows but also in my Linux
VM.

> There isn't enough time to include this topic in the upcoming
> release within the current https://tinyurl.com/gitCal calendar,
> however, which places the final on Nov 11th.

More is the pity.

Thank you, though, for being upfront with me. I will shift my focus to
tasks that require my attention more urgently, then.

Ciao,
Dscho
