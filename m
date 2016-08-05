Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DFA02018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161615AbcHEPwE (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:52:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:52469 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161616AbcHEPwC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:52:02 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lurin-1b5TUp0Ntp-0108YB; Fri, 05 Aug 2016 17:51:46
 +0200
Date:	Fri, 5 Aug 2016 17:51:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <xmqq37mk1bnt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051743410.5786@virtualbox>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <20160803163449.iwjv4youmsf6okme@sigill.intra.peff.net> <xmqqbn19aj5t.fsf@gitster.mtv.corp.google.com> <20160803165652.zek5df7tv5reg6w4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1608041706040.5786@virtualbox> <20160804180749.foowbsmce72s46ww@sigill.intra.peff.net> <xmqq37mk1bnt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lzFzhpxIKZveQrrRnqXP+PeHyyPBV26b/5YB6Kr2WQfoYDulWxM
 VzYNVgC6bTEn9AE4S6bDYzqNeTPAbTDLaefHYbF9elwgRjLm8b3YnlQWlrNsT76fKgUYkaD
 EcW9Dp8nfpbK6lr+w9ImEDMdPISepMEI3G/K82spCXMN1jC5eEdp4SmI/VFFAwCnaHoayrX
 QF5hJwGqU5C4I5RUTsE1A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:v8Z3W/pB/jY=:HLBjTASqGyYYgwHh0Wdtks
 GGZa2+7deWEwCWmR2CbDNb0aC6iK+qFBIhLo1yXyBKFdBMV5UUWqUdrgjK1efsOJH11fbwq5Q
 qYPgA7hXT4eMkQBpJSzAepVg7GYaqd2DISDFbPvXbzeFQgMO7XBSOCkl32K+lSMLyswaxxShF
 gy5rwDompnyPgiYqODF0f50Rq2RKTEl7/U3+4sj/0voUHCs4E7cEiGdY9OYNoDktaWEq/7D8x
 e9TKKk1xkVhuF9eDs5Fvif40Gp85wPGerupwZnGv8LzvTdm0eRH+3Gk9L246LBC+NFipwJBKU
 ZmN9++wpsagvLveIU21wPmwvPI+fL8XBdChxZjKBNxZcr9Lk2/F6OPv4HJkPywhSenqcTrBz5
 /Jj+yBsVa3r3rIDO7l9k8w+MzXijugp+PkMWkvESV0/NxLYkOZNd9ido059UnpZzBhobtdBxx
 oJBZnuVd4YUO9vByrXkapGBZFIdMvs3HUIu6UbCnIZV69iDNLvKhkLoJD+NNPC8S55FzZ4R7D
 C8xV0F6M727rCKbfnwohuoXy27cmaPUG04qlY+zqSNYTkN6QTaiO6WjCZFrDfOxLnfHdOlBpU
 dd8vDeWhNns9sxspJsvAlvwTIc/zny/hMqJT3Y3KAhODc1ykMVq1Pr3lG3QND+P1BUadAZs/v
 uPLy7W5l8RuLTHraFx9J8wZ5ukdin3ytLEfOx7EdcMU+6tgtHjFTDCXaWDBLKgPLGfg8fOOTB
 O5YV3s7dnei3avw3PzR6ZziWi4bIHhcbWcK6X+oMUymJiwDp+dQjJL05k9+RSVs3F3F4kkIpf
 93pIoYO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Like you, I have occasionally been bitten by Junio doing a fixup, and
> > then I end up re-rolling, and lose that fixup.
> 
> ... which usually is caught when I receive the reroll, as I try to apply
> to the same base and compare the result with the previous round.

I find it incredibly nice of you to do those fix-ups, sorry to state that
as clearly only now. It's just that I hate to see your time wasted, in
particular when *I* waste it because I missed the fix-ups in `pu`.

> > But I think such fixups are a calculated risk. Sometimes they save a
> > lot of time, both for the maintainer and the contributor, when they
> > manage to prevent another round-trip of the patch series to the list.
> 
> Yes.

FWIW I am more than just willing to spend a little more time on applying
fix-ups and re-rolling patch series (and dual-publishing them via my
public repository), if it helps lighten your burden.

> > IOW, if the flow is something like:
> >
> >   1. Contributor sends patches. People review.
> >
> >   2. Minor fixups noticed by maintainer, fixed while applying.
> 
> This includes different kinds of things:
> 
>     a) Trivially correct fixes given in other people's review.
> 
>     b) Minor fixups by the maintainer, to code.
> 
>     c) Minor fixups by the maintainer, to proposed log message.
> 
>     d) "apply --whitespace=fix" whose result I do not even actively
>        keep track of.
> 
> >   3. Only one small fixup needed from review. Contributor sends
> >      squashable patch. Maintainer squashes.
> >
> > then I think that is a net win over sending the whole series again, for
> > the contributor (who does not bother sending), reviewers (who really
> > only need to look at the interdiff, which is what that squash is in the
> > first place), and the maintainer (who can squash just as easily as
> > re-applying the whole series).
> 
> > And that is the flip side. If the flow above does not happen, then step
> > 2 just becomes a pain.
> 
> I think I can
> 
>  * stop taking 2-a).  This is less work for me, but some
>    contributors are leaky and can lose obviously good suggestions,
>    so I am not sure if that is an overall win for the quality of the
>    end product;

If you had a `git commit --reword` command to touch up commit messages,
would that help you, together with the `git commit --fixup` command for
code changes? The branches in `pu` would have your fix-ups as strictly
separate commits on top of the contributed patches, and the branches would
need to be sent through rebase -i before merging to `next`, of course.

The idea would be to not forget your fixups in subsequent iterations, but
simply rebase them on top of the new iteration.

It would still not solve my problem that there is no convenient way to
jump from your commits in `pu` to the corresponding ones in my local
branch. But that is my problem, not yours.

Ciao,
Dscho
