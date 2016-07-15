Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D72A320195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcGOPKa (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:10:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:59020 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbcGOPK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 11:10:26 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MLfLH-1bOu6G3WRH-000qh6; Fri, 15 Jul 2016 17:10:15
 +0200
Date:	Fri, 15 Jul 2016 17:10:13 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar
 headers
In-Reply-To: <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607151707180.6426@virtualbox>
References: <20160630090614.GA16725@sigill.intra.peff.net> <20160630090857.GB17463@sigill.intra.peff.net> <alpine.DEB.2.20.1607141745420.6426@virtualbox> <20160714182108.GB16497@sigill.intra.peff.net> <xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
 <20160714201018.GA18372@sigill.intra.peff.net> <xmqqbn20otqu.fsf@gitster.mtv.corp.google.com> <20160714202727.GA19101@sigill.intra.peff.net> <xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:izkapTCE6bDxasEvo4hZ+uZDef8iTJwfS5qmu5vZVu8vJamuW9i
 N49DGvk/BkTLfBo7qdr4UJWIS4+aZvztJIk/fDB7khvWdg36Bn1BK2nG189zJCietnigfxc
 8GgWWAaVc0o1j0oGGb96lK+87O64z+w9kYt/GV/FhUsT2dkElrIXdnXCo5idzz2GYYMpnQg
 YLeCzS4s0EraDqU4LF6sA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TBNsKgoBKso=:X/gxH7DZr1jUlRTq1CPEp5
 JEqaIS9pj4QxfjCt6awbbuAs6HavTm6vOaw82Eir857Sy23dEJ1vYXhtoEKLLckhWghUWbipU
 rUMjp3lDeuKKSoPyfLZVx5iiSXVJdu8q83EXt/FC7dp+XfDq8Of7w0mVgp2HDsNePaeoC8nNK
 HWb+tDyDZLlKTvx4rqWuLBjPkwNE7rSrkWR47DsOjY8MpHNxiNIYxzzTdDdYLD7XpwQ2WtoUU
 hvyo9EXJ6uoxXoBwvRhk2gV0U5CIytLmJRBu8EKuq++iKC2Lr0YufBHFHGUqWLC5OnJZN8rPI
 CsxtFPquMM2v8/g4GSfAITs2sYrHoE6ROibn725udv71/V+FJAZ89UuiB5+1RQYIcPVePWlH1
 aIeglBwe4juTSxyCmDSmYzTuszRgYjwjQKvwjl/hBXb16Ql6HovkjrdZTXEUs7i4FuMrhuj51
 OUZhQh7f58Un09aofi6msiCUG7WEkL4D7vusBmWfdhE0jN2u/84cmhC2zhxm/F5U+lb667aiy
 64NQQpjPR/Ix1J4ilfaHJR27JrTifHd9K3M6SxV3bLT5KzOYDEoxeaMjKVCRirJZWo6EgqP/m
 xG/yhC4K+KrGqOqh9JKUu/Ne7OPAAxyxkUM+ZKRzLX/mU1z/Iz/eeLBjQx2M0vBzpeE5yXCTg
 2urPeG581U7GV7QkXDTjEMcLTg0/of5+xpNwy6aH9ZquT7Ndn0CoHMw7CEVn8bAhpx3S95V7X
 BdhH1tYIUBqgF35ibGaxnIBTEd90hpOUTEuDf8kAuwVo/prukXC6LaRiRnb2v8k8aYOy0ppv/
 nBruTIj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 14 Jul 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, that is what I was trying to get at, but you stated it much more
> > clearly. LONG_IS_64BIT is good. I wonder if the "git version
> > --build-options" should be "sizeof-long", too. It's shorter, and
> > indicates our assumption that we are talking about all longs, not just
> > unsigned ones.
> 
> OK, I'll do a final reroll and then wait for Europeans ;-)

Don't let me stand in the way of progress.

I would have preferred two separate prereqs, of course, for the same
reason we use time_t and off_t: I find it better to describe what the
prereq is about, and I do not mean implementation details here.

But that does not matter all that much. We will have to address the issues
anyway, and at that point that wart will be removed and we will all go on
with our lives.

So what are your plans with 2.9.2? I ask because I do not want to engineer
a 2.9.1 release just to see that 2.9.2 is out and having to spend the same
amount of time for another release ;-)

Ciao,
Dscho
