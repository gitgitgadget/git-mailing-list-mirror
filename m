Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48EC1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeA2WSm (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:18:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:57525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeA2WSl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:18:41 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MLNeQ-1efjnL15zm-000ff3; Mon, 29 Jan 2018 23:18:37 +0100
Date:   Mon, 29 Jan 2018 23:18:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
In-Reply-To: <xmqqvafsh0hu.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1801292316180.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de> <xmqqvafsh0hu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xYR+IMrA1wpr3faCnbjNw4G5jS3cED4zRbBQWtFMJOQQZrGQiXj
 sHJDZ6VQzFQ2IN/sq2WUBrjqvm50tgdAfG9TB4QVBdIuKirOvo4u3JA1J0qlVdmyoankOpY
 9bAA2Ft2ORYeUXVXezVtjTm6jMI2HAfWdX4aG/dXcSPLu5w8QXyh5FwQgyn6u577gGiby9X
 3devl21z78CqnQsBp9qBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cr64vU/Xin8=:OMtJMp4saFpeoYpsOx2roL
 vIDdrMoMnlDzXeamRAahDnpSfL89Of9TMOBpCuCnKSjsKHyXTZB5Fb/XJQFgTf+Be8mivSvl1
 swTXbnRirmwVkZQihXjQ8DP8ZNWF5RAjQG4shMN0ytTU+KUn02T9N/jQe4sLBcwwUlGh8Iy6t
 T6B8Y7UJocAC8llnFLFSHybq5nnk1C39qBqmIrqpIJBb6HLz1QD6PXU3xmx+6lWFLFWWu5EZz
 4fdTioGN154yFyE0/VFgush49LpuH5Ok13HnH4gMwn3KVu0gOTzuznQJuP8f+8RMPP++SG+21
 3P6K9AHRixdw8u8s/n9baEoWy4SjOplo7wYd4WmDm1rsEyhPIImHlyTOaLv3StHLdiihBi7X2
 n3anMNhcJM0Bla68eZPxJyYeCfWThMydEeFXbArK+L70lmgrjuzzsVdxY/IQKbkTLYz2EflXb
 dnqZqPHxhWi1UXwsPq84vxNvG06dQx6mvK45CgLpKAnxPas+PeV95VASnsthV8qW1L68RMQDi
 T8fHTLMc9crPez7mOdVt+42Hl2KH6SIUjg1R5unT0VDJUb8jS28JG13hjKOkrHzX7cgWTixAL
 zIVsNC/6gV4A8jqr8W3bhaRZp+Ako4cluo3asFPssFwpjyo2SNDKIWTsuXqJ3mHU6hHedCJWS
 8tbSFyqqEjQ42+qjCbGo5zkNhR6Z9V1lrxbFEpwXytpLW69ioFUMDvh/mLV8TLkTSs0OIBFoU
 JN1rhDinzq90sKeAZBD2auvcVaq7zh1hKewxz/lamZzZGSMOBEiUrIT7DU4KhBQ8MUXPR+MfD
 TKUVUSphifk3cSIBWz/Dzx8FR6mfei+CCoNsOfSbCAv8NZxygotPlHQJWda49Ve1lX2d7Ua
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jan 2018, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > +	/*
> > +	 * If HEAD is not identical to the parent of the original merge commit,
> > +	 * we cannot fast-forward.
> > +	 */
> > +	can_fast_forward = commit && commit->parents &&
> > +		!oidcmp(&commit->parents->item->object.oid,
> > +			&head_commit->object.oid);
> > +
> 
> I think this expression and assignment should better be done much
> later.  Are you going to update commit, commit->parents, etc. that
> are involved in the computation in the meantime???

No, it is in the exact right spot.

What you are missing is that there will be some more code here, to support
octopus merges.

That's why it is exactly the right spot.

> > @@ -2164,6 +2172,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
> >  		rollback_lock_file(&lock);
> >  		return -1;
> >  	}
> > +
> > +	if (can_fast_forward && commit->parents->next &&
> > +	    !commit->parents->next->next &&
> > +	    !oidcmp(&commit->parents->next->item->object.oid,
> > +		    &merge_commit->object.oid)) {
> 
> ... Namely, here.

... which the octopus merge code will never reach. That's why this is the
wrong spot for that initial can_fast_forward assignment.

> Because the earlier one is computing "are we
> replaying exactly the same commit on top of exactly the same
> state?", which is merely one half of "can we fast-forward", and
> storing it in a variable whose name is over-promising way before it
> becomes necessary.  The other half of "can we fast-forward?" logic
> is the remainder of the if() condition we see above.  IOW, when
> fully spelled, this code can fast-forward when we are replaying a
> commit on top of exactly the same first-parent and the commit being
> replayed is a single parent merge.
> 
> We may even want to get rid of can_fast_forward variable.

Absolutely not.

Ciao,
Dscho
