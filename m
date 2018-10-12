Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0841F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJLXHc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 19:07:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:48147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728857AbeJLXHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 19:07:32 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPGI-1fjsBJ362Y-00hfIt; Fri, 12
 Oct 2018 17:34:27 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnPGI-1fjsBJ362Y-00hfIt; Fri, 12
 Oct 2018 17:34:27 +0200
Date:   Fri, 12 Oct 2018 17:34:26 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] zlib.c: use size_t for size
In-Reply-To: <xmqqzhvj9ssa.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121733560.561@tvgsbejvaqbjf.bet>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810121150050.45@tvgsbejvaqbjf.bet> <xmqqzhvj9ssa.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:shGv7PXBxeM0DP0I1iaee3bUPEAfR4lAWzm2SPNjOHR3pE1GCCc
 HM1w56Wrl+yHhBpHUynASzCn9MNw3lUOuDI5iZrao/JXuD9AM282tHZn1yvXOZY+hVzWeXI
 RMxp6xX9SK4z0q+niqQXMR2YhnjVVxoSrbMUIYEpH0gz9s0pgszDRBru3ohMT0wAFD0uiZa
 IGlS4yAMdHX4p+vlb1duA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j3xsl8jat7w=:Xl2sDIgZVkY0sQwTvFmSWc
 ojadDjImvTBHuR14JanWBBZn5Ykh1xJfKlbl6bQL2RNetauIydVzYhAfbch9HDvF2Xmhv2//Q
 grPP6d1v8g/VSpmggvn+Z29W7YAO/5hGr95HdL8c2Zag8zE0fsUN8ZfXtMTvDJFX0+PMz+mpd
 II00CeK85SCL9hInmn/GvNlkbqF1MrJLoCk+EGrNhldmxyOdu4yBP0huIq23W12WZ7DLAvBEN
 xh5++GmDo8l2rr0WPHx4OtQ6kIX4C25yg9gE32t8CGfh8SCkCJllM5eXqhBgj4lRJfRo7tpaX
 rWiIJiF4ZMrgLN6Yy6ycfcRIkjBrM/+8bVEJFhMFXPeGLPEkAvLg9t6AB45fmWzKvRMKsmQ00
 ZFz1rIpwa04JDbwLDNX+cWd1QfKIDRsqMKP/HsYYXge+aawJaVClaYQQM/wzMqWFqlkONoe4Q
 aN47UDc3tvWLVP0AloGl2p520Mhm9NA7TaBBHcxUSrPkK4B+OPT9rgL/8eNrpTbaB8wfLaCDP
 2s804UzH4zFYgEYzwDJHp0P7ibLR3Zt4LB1GcmW3c79QDI6YY37s2aGptX3zix5E1cNk0Rybz
 MN9gKxGttkKqmNKVrF3vEx05cHVrNC+00wbtJfa6PfdxDKJVbC2xDA8NaxVkCmMbnbgqhmKO5
 ibFVTRDuKZt5BVDLXlMlrXcdyuUHq74jGxAKN5s4nO/tW7vbQWAFhuNhc9Ka/Mp73vUJk9572
 OeZp4/CBbyhSqM/imIWdYc2jXbaSWhNgm6T10NxaBQF8+2JN8DyffF8Wzj8PtGgIYfKeL55cb
 Nx1FapI/i/4leTcwzJIMU4a0a6V2MkZYrB2Dr/GpzAe7eG3egs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Oct 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi Junio,
> >
> > On Fri, 12 Oct 2018, Junio C Hamano wrote:
> >
> >> From: Martin Koegler <martin.koegler@chello.at>
> >> Date: Thu, 10 Aug 2017 20:13:08 +0200
> >> 
> >> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >> 
> >>  * I made minimal adjustments to make the change apply to today's
> >>    codebase.  I still find some choices and mixing of off_t and
> >>    size_t done by the patch a bit iffy, and some arith may need to
> >>    become st_addX().  Extra set of eyes are very much appreciated.
> >> 
> >>  builtin/pack-objects.c | 10 +++++-----
> >>  cache.h                | 10 +++++-----
> >>  pack-check.c           |  6 +++---
> >>  pack.h                 |  2 +-
> >>  packfile.h             |  2 +-
> >>  wrapper.c              |  8 ++++----
> >>  zlib.c                 |  8 ++++----
> >>  7 files changed, 23 insertions(+), 23 deletions(-)
> >> 
> >> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> >> index e6316d294d..b9ca04eb8a 100644
> >> --- a/builtin/pack-objects.c
> >> +++ b/builtin/pack-objects.c
> >> @@ -266,15 +266,15 @@ static void copy_pack_data(struct hashfile *f,
> >>  		struct packed_git *p,
> >>  		struct pack_window **w_curs,
> >>  		off_t offset,
> >> -		off_t len)
> >> +		size_t len)
> >>  {
> >>  	unsigned char *in;
> >> -	unsigned long avail;
> >> +	size_t avail;
> >>  
> >>  	while (len) {
> >>  		in = use_pack(p, w_curs, offset, &avail);
> >>  		if (avail > len)
> >
> > Do we have to be careful to handle sizeof(off_t) != sizeof(size_t) here? I
> > guess we would receive a compiler warning about different sizes in that
> > case, but it makes me worry.
> 
> Yup, you just said exactly the same thing as I already said in the
> part you quoted.  I still find the mixed use of off_t and size_t in
> this patch iffy, and that was the secondary reason why the patch was
> kept in the stalled state for so long.  The primary reason was that
> nobody tried to dust it off and reignite the topic so far---which I
> am trying to correct, but as I said, this is just minimally adjusted
> to today's codebase, without any attempt to improve relative to the
> original patch.
> 
> I think we are in agreement in that this is not making things worse,
> as we are already in the mixed arith territory before this patch.

I will *try* to find the time to audit this some more, then. Maybe next
week, maybe the one afterwards... ;-)

Ciao,
Dscho

> 
> 
