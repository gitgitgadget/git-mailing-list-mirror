Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1D601F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 08:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbeGKJBp (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 05:01:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:52975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbeGKJBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 05:01:45 -0400
Received: from [192.168.0.129] ([37.201.195.87]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMShK-1fjFE92PiY-008GQW; Wed, 11
 Jul 2018 10:58:23 +0200
Date:   Wed, 11 Jul 2018 10:58:07 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/2] de-confuse git cherry-pick --author
In-Reply-To: <20180710043120.GA1330@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1807111057500.75@tvgsbejvaqbjf.bet>
References: <20180709194636.GB9852@sigill.intra.peff.net> <20180709194912.GB7980@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807092222300.75@tvgsbejvaqbjf.bet> <20180710021505.GA10248@sigill.intra.peff.net> <20180710043120.GA1330@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GR6q/OWbhAIxFcFeAA1K2OM6OgTiZpEsOZ+eSWXGRLffmo6V1xY
 3560Bifh80CsyVlT/z9tRAwxdytuXEfIbv4ybm8WcJcyn7PCu2bo5JqW0xYcZ3ITnxypkky
 IW9QM/4FnwdgoVvrLQb3a0l+ckJ+Oud+N4AIbX8LTXWGAVn8gh7J4xCC+v/4FRcowzitpL7
 QD6B+eix+EERO/BIyRS9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y93q/ZBSkhs=:1AAjoKBj6/EXQpUD2GJmsJ
 EYS7O4Rik9VRL120EVapZH197Jj+a4IO9jJVcDR/6y8o0MVV/klY5LdiHgeUqS8A2pVbIv4F0
 Gkh0UkPrS9ewp9/4kJ6VmE2R+dj1E4m7zqd3CIZ9j7NhztisjezqZDzo5gj21DWpePLbYIi0F
 OLzh8ZHOm8TQkBf3TAfgLGABwMuxDE2YxhJPMkLM8wBXlRZUaSAfGHdoueLxdRu5HKyurUfxu
 1mt9wAtKdL1ErUyWqpp3NIvtv/uC+eO6ZALwgZiJkO08HN/PIqaHs+V9YKPewc7b+/tYAgBnI
 0ZdbaZIuhyAUB2y2fMXg0Ni224znYLJYBLmnq8YY7CVAIIqABRpNZnACyVALGYLegAOpQ7pgB
 uPun/5GlatmqNtV9DtTV3peVPlaylaqyZ5jGpI/OTiwSY1jMuuW7F25WYdliOl7Bz+iCy+yPY
 Q7tHTLF+7duHUDV5N6DRHtOUes/W8OgcsMLT9NHDwQPAK786pzo18aU+r3jtId1la+MzA8xbG
 PrbcOkpqAD9z9jRKlTU9lgjZnAcQArgvWTh5vak29ws3r4XiZLaqfVRfyE/sVi+y0748E6HEn
 CfMdGTybO7WrCMAyWGtp8jyAIs9Qqn/ZuSc9g474sFH0ZxNEh/PD2d2o3sVeNZ3AOHJtuBS+N
 81zs9FfwCa+C453dwzC9jqt9yvMJG/Hgh+xc2t+ZQKAEFut1I6mvPOJ7LlsLEWrqUsUcbcsqR
 /2zIE5Oaj4LIseRWhkAKP8bbCeMAaaG7NISr8EaxylhDHUmgDaQyiaWsEQU6GgUsL5E6Xo78N
 i9tUsKG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 10 Jul 2018, Jeff King wrote:

> On Mon, Jul 09, 2018 at 10:15:05PM -0400, Jeff King wrote:
> 
> > > Should this not rather be
> > > 
> > > -		if (!cmit || get_revision(opts->revs))
> > > -			return error("BUG: expected exactly one commit from walk");
> > > +		if (!cmit)
> > > +			return error(_("empty commit set passed"));
> > > +		if (get_revision(opts->revs))
> > > +			return error(_("unexpected extra commit from walk"));
> > 
> > Yeah, you're right. I'm not sure how a single rev with no-walk would
> > ever turn up more than one commit, though. So I think we should probably
> > go with:
> > 
> >   if (!cmit)
> > 	return error(_("empty commit set passed"));
> >   if (get_revision(opts->revs))
> > 	BUG("unexpected extra commit from walk");
> > 
> > And then if we ever see that case, we can decide from there what the
> > right action is (though _probably_ it's just to emit an error like you
> > have above, it might be a sign that our single-pick logic is wrong).
> > 
> > I'll re-roll in that direction, and discuss further in the commit
> > message.
> 
> After poking at it a bit more, I've convinced myself that this is the
> right thing, as options like "--branches" which expand into multiple
> tips already push us into the other code path.
> 
> So here's a re-roll. The first one is identical except for the typo-fix
> in the commit message.
> 
>   [1/2]: sequencer: handle empty-set cases consistently
>   [2/2]: sequencer: don't say BUG on bogus input
> 
>  sequencer.c                     | 12 ++++++++----
>  t/t3510-cherry-pick-sequence.sh |  7 ++++++-
>  2 files changed, 14 insertions(+), 5 deletions(-)

ACK,
Dscho
