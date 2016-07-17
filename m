Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DB420195
	for <e@80x24.org>; Sun, 17 Jul 2016 08:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcGQIQ2 (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 04:16:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:50714 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbcGQIQY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 04:16:24 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MHnzh-1bNJGC0wsH-003bh7; Sun, 17 Jul 2016 10:15:57
 +0200
Date:	Sun, 17 Jul 2016 10:15:55 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
In-Reply-To: <20160716164747.GA24933@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607171003010.28832@virtualbox>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com> <alpine.DEB.2.20.1607141750190.6426@virtualbox> <CACsJy8AjVX1Say0srEq+ezGg=CzmbjBAt4PnuikXiqdnVC4G6g@mail.gmail.com> <alpine.DEB.2.20.1607161507250.28832@virtualbox>
 <20160716150835.GA24374@sigill.intra.peff.net> <alpine.DEB.2.20.1607161834420.28832@virtualbox> <20160716164747.GA24933@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HEn/VEr7sz1FfHOETpWvYD+iGcBJOosqceYYfAw+8HMjTIzTIlH
 YJXaDXTjqQyyeV0q9/PeGBQ3LR4ItgIkq6EIkzkI7sG+Gfko2IP6w8WKPrS4+VQm1s/OeQ4
 YlSZIpOlpBT7DTr9uSa+hsjvyLqwwI6dD5ceLfOvdHsV8VAhuwa6XGDnQXxcCRvjcRIBJjA
 V4i1hTwqucUxWvCYgn/0w==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:z1kKsrs0Cdg=:AcW4xhLPihEBbpq5TX6JgU
 8ztnWeAPbOdxuek10MpHE7pvj5dZQBpa1cumbEtRh5DrNG9vnFkSo02Jx71GS4foVXqxMQ+tZ
 gFoSZLsYDZXI4gDODjp085oDFvhCQA41Rkbjbt/jpCYuJh2jHbG581oDzafvlntfq6UdkHZ+r
 pwwBArtSh7StKqjaaGv2g7wxT4iS1kD0l9YleN2rgllxeL0qtFbhaGHB8WsD/wL7VizdLcetg
 PJA0canYr1zYSTcf4o96PNX3mBBoa6dOCZ7id+PeMlD3LnElJIYqebrckJ/s0awKEpxxTkWyb
 GreyQQ/zua26yy8dvIBQZyBjr24MdvZ9HOB2HF3UgpJyJx1RVcRu0KvuofOe9jlpNBCn6zpYg
 4+82uC7OdfD0KliJ+3EG0SMmVv93f9XTXAfuISiP+3p6kA6FiThdbLwCkZOgq6AJ6nGxgEICR
 el7QowI4kWX9ZvljDC4ZX4JWnRzPpxI6Lx7WaGcfyKcvAt+KBAvVxFhjJvLjyFWNxrrjT145r
 xq69vnxJQSCvBzF+7UwuoO9aPT0WAtmhdAaDJtioK8zkhQpse9oH5+5G7jrl9o5MNaixhuspb
 ib4Mo3JWdL9LFI1AUDwOywbfGVHCrx4hPsApLPicQRn/6OB2SGCBY0JJE5ErjcXQTjXbg3X6N
 opTFoOn5D795+p0zKBNL9O8X+TiYq5QE+o37bIlLUmO5w+qQl6MvHtgg5oPZNTrWgxOYHH5a2
 Ga+sye+8fCceiCczjjoXYba6YLjWrzcnbneHQgQwfZcyvlj7FdeEzBdriof/ZDY9eFPijFDVZ
 ibLEIuF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Sat, 16 Jul 2016, Jeff King wrote:

> On Sat, Jul 16, 2016 at 06:36:03PM +0200, Johannes Schindelin wrote:
> 
> > > On Sat, Jul 16, 2016 at 03:30:45PM +0200, Johannes Schindelin wrote:
> > > 
> > > > As an alternative solution to your problem, you could of course avoid all
> > > > conditional includes. Simply by adding the include.path settings
> > > > explicitly to the configs that require them. Now, that would make reasoning
> > > > and trouble-shooting simple, wouldn't it?
> > > > 
> > > > And the most beautiful aspect of it: no patch needed.
> > > 
> > > And you can just "cat" the included files directly into your
> > > .git/config. We don't even need include.path. Or ~/.gitconfig, for that
> > > matter. But sometimes dynamic things are convenient.
> > 
> > Well, apparently you are not convinced by my argument. I thought it was
> > pretty sound, but if you disagree, it cannot have been...
> 
> Heh. Don't get me wrong, I do think there's room for digging ourselves a
> deep hole with conditional includes, because anything dynamic opens up a
> question of _when_ it is evaluated, and in what context. So any
> condition should be something that we would consider static through the
> whole run of the program. Looking at the "gitdir" is right on the
> borderline of that, but I think it's OK, because we already have to
> invalidate any cached config when we setup the gitdir, because
> "$GIT_DIR/config" will have become a new source.
> 
> So I agree it's something we need to be thoughtful about, but I think
> this particular instance is useful and probably not going to bite us.

FWIW I am slightly less worried about the conditional includes (it is
already a horrible mess to figure out too-long include chains now, before
having conditional includes, for example). I am slightly more worried
about eventually needing to introduce support for something like

	[if-gitdir(...):section]
		thisSettingIsConditional = ...

or even

	[if (worktree==...):section]
		anotherConditional = ...

and then having two incompatible conditional constructs, one generic, the
other one specific to [include].

In other words, if we already introduce a conditional construct, I'd
rather have one that could easily be used for other conditions/sections
when (and if) needed.

I, for one, would rather have my repository-specific overrides in one single
file than having a bunch of files that are included conditionally and may
need to override one another: I can see the entries much easier in the
single file (and group them by section) than in the multiple files. My
working memory is just too filled up with other stuff to remember the
contents of the other file(s).

But I guess that boils down to preference.

Ciao,
Dscho
