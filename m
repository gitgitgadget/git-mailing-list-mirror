Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5030320437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753959AbdJaRVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:21:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:58780 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753907AbdJaRV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:21:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1C4-1e2yWJ3cq0-006daf; Tue, 31
 Oct 2017 18:21:15 +0100
Date:   Tue, 31 Oct 2017 18:21:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: convert SubmittingPatches to
 AsciiDoc
In-Reply-To: <CAHVLzcnS6n_BODDo3wrBzNkpEPTYBLD0V51H4O10q82J=xYnqw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710311819590.6482@virtualbox>
References: <20171029211308.272673-1-sandals@crustytoothpaste.net> <20171029211308.272673-3-sandals@crustytoothpaste.net> <xmqqa8096yzu.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710301333420.6482@virtualbox>
 <CAHVLzcnS6n_BODDo3wrBzNkpEPTYBLD0V51H4O10q82J=xYnqw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jRpWAs++sLPK7FnMjkj0+T2NBOft/OzJqXAedrQ0GnOesMa7AgA
 /17merwPu+E7fQrwlOmcuESc73klPqdMn7T5fWI2EiBIeMhWxO8ZZ3hi9baQyLDSG6/7/jk
 H6IbJumAMrbFvl2xqdxtnoHpXn6UUjCLrsStDiOxwsJ168aTf4aGXW7JjIsJX3PG9aMJR3V
 vszbpK5WK6aJAWANfvdKA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mbn6GqR40ko=:BHBkrr6PxvCzFy7YiCw4QM
 gFhxcrxA2a4J7pGgnI18DbIXIk/KXFun4XF+Bgy3vOU3D+kZT/DLjKGCihznU6Ujn1rIY2eW2
 x8anrccRj66M9ERIhTzOte4DnteBqNocVkikZ6xPH/fGz10EDmMRRGTK2T+uOZlUmmmhWUMmE
 zfDzIP+Hds+Q8HRJvlFxU847x9U53jSK9fgIA7JjPOllTBTmhCS8d3585rX3vbMf3PMPK+v1n
 egwPLj/nq5rSmIx5xenp0a7b4HCBcV2CLm1/c7UGjeVq16gQ3zZ3/5Y8O7jLCCJzNdsojoEi1
 0ObOqyNORd8Nz2FP7ziw03JaGmg1wwm6+4RXk1gtOt8wvv6iQYmWDRwmPEYKiqLort/65weOi
 JKjIx8CM46IkzmEOPK7mk2UGRhZCxButQhqm0HSvXTeZMemvLSjm+4hRjSnZxPBOfE4S6idcL
 8n7MFE/xXMkJDMINeTdCc/MpgZEP30+go0s/QlBd1bT1q360GeDz1BLmcsVge8w16XwISLaWH
 u2FWJWIVkvkIRXTJroDgWBxp+Vmfimi0qIyyWeNcc5MZn0+qieHwnXXZnKuWY+ga/2JciztGl
 JB2X8TMgZB5n/nXoIxeEoBGYm9NLZColSCpu+UQTi7srARoS6VoNh7I9quZEw+tbHTndDdIPW
 jxrN/6EMRCUQI2DXpHXFusdgo8GjuD6c1B/ViDm9Th3kmHHDKo/bctJbpVXeVDYwO4BAcj/Bm
 5jGfoXY717VEYwDmNOc2rJ9l7898YSVRYbu/uuO+99nESO6F7dUuZFltJk/j6TOxowaDoiJCn
 qLu8Q8xRoEMLWZ0dtCFk6NXCAue0AgnhxDZnJU9pmD1AxRBKa+2vMJ869JCcddmDauIM2GL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paolo,

On Mon, 30 Oct 2017, Paolo Ciarrocchi wrote:

> On Mon, Oct 30, 2017 at 1:35 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 30 Oct 2017, Junio C Hamano wrote:
> >
> >> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>
> >> Thanks.  I personally prefer the plain-text original, but I do
> >> understand the need to have a version with ids that you can tell
> >> others to visit in their browsers.  Assuming that this goes in the
> >> right direction, here are a few comments.
> >
> > If you want to go into the direction of the web, AsciiDoc is actually the
> > wrong choice IMO, and Markdown would be the right choice. Basically
> > everybody on the web is either supporting Markdown or being asked by users
> > to do so.
> >
> > Assuming that *that* is something we want to pursue, I would also suggest
> > to move the man pages away from AsciiDoc to Markdown (using e.g.
> > [ronn](https://rtomayko.github.io/ronn/ronn.1.html)).
> 
> Nitpick, the right URL is: https://rtomayko.github.io/ronn/ronn.1.html
> You put an extra ')' at the end and therefore I've got a scaring 404 error :-)

The first closing parenthesis closes the link associated with the label
`ronn`, the second closing parenthesis closes the remark I started in the
previous line (beginning with the word "using").

Ciao,
Johannes
