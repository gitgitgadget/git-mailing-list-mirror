Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCC01F859
	for <e@80x24.org>; Sat,  6 Aug 2016 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbcHFXHr (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 19:07:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:52390 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbcHFXHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 19:07:47 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LoEcP-1b2yPh1suv-00gFjN; Sat, 06 Aug 2016 10:58:56
 +0200
Date:	Sat, 6 Aug 2016 10:58:52 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Stefan Beller <sbeller@google.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608061045240.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <alpine.DEB.2.20.1608050925240.5786@virtualbox>
 <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p9y8rRRI0jZEKJYBhk2SqlHR7V1oz8b0FgyDrEXXrp0MiJCZBLV
 IoipozZQhj+YNirJKXOd4reB52OqsgRe+X/bgDzToeufaOFnrx+A3+weJgspabm3hg4XUMN
 OyRyrwvqvEZWuNHFkOsQSGa/OOEjkBaeNFr8tz/t8piafITIk2DB6NTu0ttwFafGAt2Mxdi
 erw8gwNTo3T95FqnkCdLw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:U5mmDUYAjKk=:1kGDljeFMfrnwAY1o1Hq92
 aR82m5Qh43Y4yh8PnDiCETu7l1aOrEt4PBW9lEzZb9VWKzAAdBk7egydrsBPaZjsgmDjutFPk
 piywhrBUPkMmGHNpYua+qLa4np9GPs76+yUceiVSKa2JYwFLoC/xABW1a7Je85TXlZaS6mOuJ
 1WrwfSPWVcagcTSbvGeenK1Itc5c8WdxF4lm6SumKzWyFzUQVQXN5X9Qs0jH9ZZyfd4M7nhUJ
 egFhlJkW8A0zqIqjgJhqWwLQcYkqBjtFTD1OLOEWDyp8JNpWpqnHj42D2qwLQNEu2RQod5P+k
 TQC2IF8piY98cCUb8RtfYygYIv6RWfeAWWOZKNxCxOaEzHj9CBsvWLWdQR6mkz72CZj0sKV0X
 akmBVOeFXiLAKns3DavQ82+fBhXfyVGGNDAEwnUO5mV2M169VIXttdtDmB17ynZ2+bZvE0+sc
 qcLljXEouf1481stMzdE1Hb1wyQeMroUk6QAoHTCwCTA0+p3PG0xV52LWcVaTd2j4iGgYr4st
 tCMlDfMfQKnnsnAczdTkNYhCWzKsRtvwl/Rjai+MrC0zWjYg2XIal2m6EkiSF+VgBZ69cFsol
 magjK0UQCthw2Fxg+hyQjxUxtzWjE/1fMC7F20dGvYVc8nu731pmyYm+Vws8v8Dkp/0CTkdcD
 2b119T4ysTONGrnK1BpjfjQZJ/chTaBNEIOUE9gjBQZcYeqHDI5KKhBQrW31VV8iqmGQ9NEuB
 VJm5vIXyvz1Rj1X/Z4JcdCNGRG6coA4zmF7c5ed4ug4EnBEnV9VbHQAE8P9VuLvF4PRxW3a2l
 OhyBJ01
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Stefan,

just quickly (i.e. addressing only one point, will try to address more at
a later date) because I want to be mostly offline this weekend:

On Fri, 5 Aug 2016, Stefan Beller wrote:

> On Fri, Aug 5, 2016 at 1:20 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > I also hate to break it to you that git-send-email is not going to be
> > part of any solution.
> 
> It's written in perl, so it's not one of the core parts of Git that you
> mentioned above. I do use it though for my submission process.

The problem is not Perl, but how fiddly it is to set up. And that you lose
all the niceties of an email client (e.g. when you want to add a comment
before the diff stat that is not intended to become a part of the commit
message).

But I had an apostrophe last night. I might have been a bit overzealous to
claim that git-send-email won't be a part of the solution. It cannot be
a *user-visible* part of any solution, that still holds true.

So here is the apostrophe: why not implement a bot that listens to the PRs
on GitHub, and accepts commands such as "@<whatever>bot please send this
upstream" via comments on the PR. It would then send the patches to the
list, from its own email address, on behalf of the contributor.

Lots of things to kink out, such as: does it need to be moderated? Record
what was submitted in its own git.git fork? Accept replies and attach them
to the correct PR? Maybe annotate those replies with the commits whose
patches were discussed? Maybe send out replies on the PR as emails? Maybe
try to auto-apply suggested patches? Cc: people who commented on earlier
iterations of the patch series? Maybe make interaction smarter using an AI
bot framework?

If only I had lots of time on my hand, I'd start by prototyping a node.js
server and hooking it up via webhooks, then show it off so others can
tinker with it.

This is not completely unlike submitGit, which was a good first attempt,
but I never used it because I needed it to do so much more than it already
did, *and* it complicated everything by requiring users to register with
an extra step to allow submitGit to send email on their behalf. It also
made contributing to it harder by choosing some non-standard web app
framework. Also, I really do not like having to go to a different website
just to send a GitHub PR to the list.

Anyway, that was my brain fart for the day.

Ciao,
Dscho
