Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA3182018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161262AbcHEPYn (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:24:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:62517 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759914AbcHEPYm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:24:42 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MQzoI-1bgA3D49E6-00ULk8; Fri, 05 Aug 2016 17:24:18
 +0200
Date:	Fri, 5 Aug 2016 17:24:14 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Richard Ipsum <richard.ipsum@codethink.co.uk>
cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	dborowitz@google.com, Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <20160805115911.GA4787@salo>
Message-ID: <alpine.DEB.2.20.1608051714110.5786@virtualbox>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <20160805115911.GA4787@salo>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:92mX2M+r4NkkLdRrfgmqZtO/Ao5WCGUyR10eHTVKqLiMHp+ChUl
 I1kq6ps2s57P9i5D4fhsnrBtyW9GRiMblcFTn+SDaIDMC5jyxgcB8spdAVLp8kwnHVFSpBE
 y8Zk4wAk7jnkY5XgjqVFuYDtY7M5+MIe8w3oqpvQnzuca3Pl9MK9vgEXgpRx9lk0ajTJxrx
 bZXjtDN/Zvvlz4NS5bhvA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ikhDTJpZUFA=:qhVURRY4aH1n7LoNrgOOww
 +3Y7dXrsO1s9mjarOEWWk3z3DnnJNB/aclP31ZZw9ZGjbycQ9BdsAOrhar5/DPkk6Xtf1BH3Q
 8oNmUYlVxNX51TmTdgVgWOl4sucuq3t5/oaOgT888CduiyVzOXWvGa9r8cCDtYzhO4JLnJwYg
 rWSW09/+yektUW7qDqOjbbCmj5LjMs2O5fgteaInTmI76VSD4AKXPs4qHPwDbH3/OIU7TfuGh
 jrW9tDakmlSKLucbfNr6WorB0soz9GivJXva5R31r71jqrTWzjPtc4IblKirLBzXYuGDbeyR0
 Dr+8sOeyVzPCYxrvEeRrYPXp4kZe2/lXsM16HGd5bM4ahRPwzDxA0YNNYDsz5EL9T0PKcSk6M
 Bip5aee8qJXzeSt5mow/TH9A1Lvo/ckQGUwaybPDGz6amm1XIL+lioy2cEeRUL+2J+f8llUB5
 7Ux5dzmk/QojxDlau4spi7kzgA+FerlOSyktgxXtbrNGVfXIR+Bc75xNvpm1UlmSiWpwOhJJM
 rckoG0Qw08eFOj748ZUoM1Gf7vHeJJcuWOlM9OwVd+yf9vO4K5pUCTmJ4tRuAvwkGwkjiPus/
 psumi/3r2VKQ9H0pMAwj5nZYrQHGrhT6AvkQD0dKmllpvEeqeudAHjBK391tbBsaKNaFd34Kc
 EFKHcluAzR9wn5P+sLfHb4eq8mFCH2OVFe0qNcXJenSs9BSPQvClwtvjNIyKHXMKlZf4qPkWH
 RBEmhPLUqbI3Qh9ZBwE9i6dG1oOKVzPJ/80OPxMzpx52nKkHYjMaXibxMFOreuKEmb0+6jkfq
 WPGcTjh
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Richard,

On Fri, 5 Aug 2016, Richard Ipsum wrote:

> On Thu, Aug 04, 2016 at 09:42:18AM -0700, Stefan Beller wrote:
> > On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > >> If we were to change our workflows drastically, I'd propose to go a
> > >> way[1] similar to notedb in Gerrit, or git-series,
> > >
> > > Gerrit is a huge, non-distributed system. Complex, too. If we change
> > > the patch submission process, we should make things *easier*, not
> > > *harder*. So I think Gerrit is pretty much out of the question.
> > 
> > I did not propose to use Gerrit or git-series or git appraise.
> > 
> > However whenever I see these projects talking to each other, the talk
> > focuses on a "unified review storage format" pretty often, which would
> > make them compatible with each other. So then I could choose
> > git-series, while you could go with git appraise (although that is
> > written in go, so maybe too fancy already ;) Or there could be another
> > new program written in C that follows the "review format".
> 
> This "unified review storage format" really does seem to be the missing
> piece.

FWIW I do not think so. The real trick will be to come up with an
improvement to the process that lets Junio and Peff continue to work as
before, because It Works For Them, while at the same time letting other
people (such as myself) use easy-to-configure tools that add substantial
convenience.

Which, to me, means that the missing piece is a clever idea how to
integrate with the mail-based process, without requiring everybody and her
dog to switch to a specific mail client.

> The tool I've been working on for the past year (git-candidate) was
> initially aimed at contrib[1], and was written in perl solely to satisfy
> contrib rules. It would have been python otherwise.

Oh...?

$ git ls-files contrib/\*.py | wc -l
4

And for that matter:

$ git ls-files contrib/\*.go | wc -l
4

In fact, there are even PHP scripts:

$ git ls-files contrib | sed -n 's/.*\.//p' | sort | grep -v '.....' |
	uniq | tr '\n' ' '
bash c el Git go perl php pl pm py rst sh tcsh txt zsh

But again, I do not think that it makes sense to focus too much on a
language, or on a file format, before we came up with a strategy how to
*not* require everybody to change their current ways.

Ciao,
Dscho
