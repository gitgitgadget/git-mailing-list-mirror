Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89DE20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 20:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbdK0Uuw (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 15:50:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:49887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752626AbdK0Uuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 15:50:52 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0cs6-1f7X6f3rw6-00uuBr; Mon, 27
 Nov 2017 21:50:32 +0100
Date:   Mon, 27 Nov 2017 21:50:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: git status always modifies index?
In-Reply-To: <xmqqmv38cl6a.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1711272146540.6482@virtualbox>
References: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org> <20171122161014.djkdygmclk227xmq@LykOS.localdomain> <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org> <20171122202720.GD11671@aiede.mtv.corp.google.com> <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com> <20171122220627.GE2854@sigill> <alpine.DEB.2.21.1.1711252240300.6482@virtualbox> <20171126192508.GB1501@sigill> <alpine.DEB.2.21.1.1711262231250.6482@virtualbox> <20171127052443.GB5946@sigill>
 <xmqqmv38cl6a.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SWCyvA2xQrs8sEzY2sa3AJ5kZYbxPMHmNDBazBEuf7OMkdbBOPb
 dvG2rHQ3XWn70lhJPRJjmBCL4La8YKgjLgmUTN0El4KNKaPkPPIKDHwL185FzCFh/6C7AGi
 ASwGLwt0UeGj7ZWU2FRNYmocUXSTVBozlTjWy8WWB6KXkIrMajzBZqz6Hh5w70qLq5h4qw2
 sgXn4PnUEjweZI3ELczfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4GqGK62hudk=:v5gyyG0P3u85COM9+NZuqN
 Jd6rj40uZPkyqpW0rzDlP+jAlA3T5+hktRx+QmVwGmlSqQxYpUD0euITRG6n0KZ+aoqAC+VIz
 pGvRahBzGEZXjMV1usAd0pDQpCr6DaPtLQ6F0Cu35dpgtjkTn0fvhZFCIOtRsE/VlPD69TGhg
 RaR3IzS4uzWiuiD0GAn++63TnXSVWj1Da8k20veQn1TD9E5BCdC7iaz1nf8smFg3Pv9inAzKU
 pt4RcVebTqtap3nfE7DcI0yot8YOSKioZbI+EmpU+iCbGg4ljJbUjLJBEBzd6m+foXOeQMbSf
 BHiwL+zCXGIsnKF6sPeKNi6sa7hiILwQnOPw7u6fO4idtbNdXtN6Qt1jUvFvtb5aa9PEE3jtx
 gcZeR8qqRifkUIQslZ4jyWlCzSORCOKkS1W0VtMEHFYlDY1Ge7zf7LITBDT4GUnVv+S5Zg23T
 Xxqdyi9ht/Yzg3zDy/CJ0Ybk9rwk+7vzRP9XqI+U5Izg9+mwlqIaka48Kcc4jRBq1p2mME6z8
 oDjPj+/sdn1uyX1P0FYw77zh7CzMPkVfVcu/k7GxXut2ji4aXIs2QvtqVvajqWwgWPs/McDJR
 CeAWuCX3BsG2t8M2hufKrGRr10EQfBeehcQNSHhcjXAgZw9nZAUuj1q4Gv9QbYi57mszKYD+U
 qY0b2szy9GXjqf/lj2FY0qWdENtbEdIG+FSYPVdwC66A2Y/EI8vImDL84D+gE00vgS3zgnhX/
 ExSlPh+ThnOWXrgLUKqeFZDEjaKCMIkcE5RVsLewztPD7PwYY4pfck5LKmCVKTtRWxGCL2Hqx
 WEsTyU3JD3XGj5HfqPnea0jvCUbFKiuPaY6m18TV1jOZB5jOBs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 27 Nov 2017, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Again, maybe the bit above explains my viewpoint a bit more. I'm
> > certainly sympathetic to the pain of upstreaming.
> >
> > I do disagree with the "no good reason" for this particular patch.
> >
> > Certainly you should feel free to present your hunches. I'd expect you
> > to as part of the review (I'm pretty sure I even solicited your opinion
> > when I sent the original patch). But I also think it's important for
> > patches sent upstream to get thorough review (both for code and design).
> > The patches having been in another fork (and thus presumably being
> > stable) is one point in their favor, but I don't think it should trumps
> > all other discussion.
> 
> I haven't been following this subthread closely, but I agree.  I
> think your turning a narrow option that was only about status into
> something that can be extended as a more general option resulted in
> a better design overall.

The --no-optional-locks feature is

- hard to find,

- in the current scenarios less desirable than a very concrete "do not
  write index.lock files in `git status`",

- too simple to introduce to merit introducing it *before* a need for it
  arises that is larger than `git status --no-lock-index`, and you would
  still have to keep the latter because it is a very concrete and real use
  case that is unlikely to want to avoid other .lock files too.

So while you two are happily on agreeing with one another, the reality is
that this supposedly better design is nothing else than premature
optimization.

Ciao,
Dscho
