Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 067FF1FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdEaPqr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:46:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:58684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbdEaPqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:46:46 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbZb-1doscJ1XfP-00aDaU; Wed, 31
 May 2017 17:46:36 +0200
Date:   Wed, 31 May 2017 17:46:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Zero King <l2dy@macports.org>
Subject: Re: [PATCH 6.5?/8] version: move --build-options to a test helper
In-Reply-To: <20170531153123.atl45b3kbfmqhnta@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1705311744170.3610@virtualbox>
References: <20170530051742.3j3yn3ipfmyrrteu@sigill.intra.peff.net> <20170530204553.25968-1-avarab@gmail.com> <20170530210530.o5gbz2k24wxrfner@sigill.intra.peff.net> <alpine.DEB.2.21.1.1705311726110.3610@virtualbox>
 <20170531153123.atl45b3kbfmqhnta@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JM0jZ0NbJDT/XATKIaQQCGsDoyG0d7mOPIsvC2uIO6ikVEFIdl9
 I+iwtkDjQEXgdE1Kt5F0mP1E6321AduuX76wZSuEq3T+etkBumCxz+V15FBP0Q67pBRZJyW
 cHNGkevMDdbRzuhgJyrS06u329ocu7bxR9hvJWmkrYFTNOV/GpZJTPCP9JNiTKehlp+Pr7f
 0R5lkBlX+HHwC6wrwawOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7wsD48elmI4=:Rx3ATU1nE5uYf+feMdjPEb
 Tc/5r2J82l4ftJ9KfiYjSDYl2O/VDWV2KcwAvctIhXwSh0dSY1rugNmJohrsMD9awEMTFFKdM
 lprbufoYJe3aDZPqDhGCOhE4EyDFMIlnIR2pKTeyz4LYl9CMkbYY8u1nHF7nREBEEFlkdfzrs
 l38qdgLl7EgML+4fqD9z0JTtVJhecXIT/bJkDCwn9rOnWO29f8ZJoYWGedpvGYcRApCG3jZHU
 FU3W86JlzpUJOZL/yyj1nGMasqud1z07whJ8TK6yr9WVAVG0cVqO1oijE5G0SUNkSaQDDk5d/
 bBoUADRmLFs269tf8MZimCKVClKRueeiPppOQ/FyBwsRSLrfKDQhrKLxfXrhTabJrDXngmIUV
 IurHCKMtooHydZB34/OjYSBK84sk/dlKLGm5XayEB16s6iXmVIhWaYymEGo+p4S4KKUxOCi1g
 tg32oaBqqgt7cPtO9fHwoKsfD3bk7js5tYyto2bx9yVU0LIYMH6mevGPXH/oOOgcNjA85oZQL
 euM714Qu0eMfK603/gXvHc9Y+x7ubvmZb7n/OkO1MeBLwDcvpBxHDMh+jjH8Q7Dj3zyPFkpg5
 WoO/d8EQmuoNf0HQcddwJB40ngzNx6Mtf9H8SxySBK4xepRedT4wd6/AiZLUOnO0uNLBnaxv0
 XQAOug29oKjbyzArj/kldrpi8GUIHj0g1XinohtfLeVK1KIfdFy8qgAep9lbIdpfj4VFrLWwh
 Rx3AnAI1uqg0EeipKznUxIAJP8U9hvGhrXcRKrnDIyw+G7L9gYeSmZ0ylP+0hEHVPZp7iur1u
 fJf8tgn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 31 May 2017, Jeff King wrote:

> On Wed, May 31, 2017 at 05:27:21PM +0200, Johannes Schindelin wrote:
> 
> > > My intent in putting it into the actual git binary was that it could
> > > also be useful for collecting build-time knobs from users (who may be
> > > using a binary package). Like:
> > > 
> > >   http://public-inbox.org/git/20160712035719.GA30281@sigill.intra.peff.net/
> > > 
> > > We haven't filled in that NEEDSWORK yet, but I'd rather see us go in
> > > that direction than remove the option entirely.
> > 
> > FWIW it also helped Git for Windows.
> > 
> > The two additional bits we added to the build options (the commit from
> > which Git was built and the architecture) did not hurt one bit, either.
> > 
> > In other words, it would make my life a lot harder if --build-options were
> > moved to a test helper that does not ship with the end product.
> 
> Cool, I'm glad it has helped already. If you have further bits added to
> the output, is it worth sending that patch upstream?

Yes, of course.

The day only has 24h though and I am still stuck with other things I try
to contribute that seem to be requiring a lot more effort (mostly trying
to make my case that there are certain coding paradigms I find too sloppy
to put my name on) from my side to get accepted than I'd like.

So yeah, as soon as the queue drains a bit more, I have tons more patches
ready to go upstream.

Ciao,
Dscho
