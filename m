Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97CFF20986
	for <e@80x24.org>; Thu,  6 Oct 2016 10:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbcJFKpk (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 06:45:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:59548 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbcJFKpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 06:45:39 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MbJTE-1bZTO03KKq-00IpCw; Thu, 06 Oct 2016 12:44:40
 +0200
Date:   Thu, 6 Oct 2016 12:44:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     James B <jamesbond3142@gmail.com>
cc:     musl@lists.openwall.com, Rich Felker <dalias@libc.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
In-Reply-To: <20161005225934.770d73b7d491d4bf4816411d@gmail.com>
Message-ID: <alpine.DEB.2.20.1610061239480.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net> <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox> <20161005090625.683fdbbfac8164125dee6469@gmail.com>
 <alpine.DEB.2.20.1610051231390.35196@virtualbox> <20161005225934.770d73b7d491d4bf4816411d@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:svWy1U2b1BTtlRod1AGvFAl4OtqN+y999PeDpxJwmSOZTsFB69X
 RkR1Ft70jeOJdCdhh3uzk6rZ0nKI7Lrzg7qdGyfp8q83rSbYWW5bbjteHE6I7sL0Wg30TkX
 bzWfe0ZYVhtAmauUxGzIXe9c8AQ5HzK9bOA0YjNUWU5Z1M4bsNfIHa6el/NB9iFfMmfbxEz
 9A2TmejEbAUSncUltpkEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/3BuwSutYes=:ozjkoGpB1Guu1noQUKndqH
 aMJhKzH/+tlDvePlbTzwS0bDRUgHDzf8/I/5yrqrpI6kCpMzoQ+oL3sUmUiT5kY1VgE0gUjHD
 GczrteBuUV1/XsbwI4e8BVrZwZnaeMdl+oI3KrBf+ZrD+SMse6AkrcS6sHnTqqjgkEZNw9Gh9
 +E+xMQ3NXegiNp+8RG4qXrN4uzHmFNQajxKDdNtvwtKOkpaK+Q1GVPK5q4lTJN9HnFhLxPenN
 9wWXvy1/1LNBukSc30/xe5fHrJL2Jkjtey6L/k3Z5YKEZUsxIFDsAbtGkjzKwNgbbHaKR4Y/V
 1WQvcfJLuZprO/fAvyUyia/zDsDcOBQDmm6CQeLDjqGSso0uGBcXlakF0x4tRvLggs/JD2ftO
 lAHaZysozUfXI62VpEUvfLO9Z5rMh4kF9vI1UrhboZbU4NkawU+cuR9CPWi1+XYXw/0IrGpSE
 Hh0pE1nDaVC21jSodl8vPAmzWYmM9fmlBQJx5VZ/w/o+9c8NGyXzE5D+NMVtXNb7bo3dozOkM
 IlTJlPcCZlXZaHSZGHf9ehCsSn1tbH1qyoMjd+1ZZfHwd7NU4kv/cgBhHR6Cfm2mmqJMaUetW
 SNj/mTAKP0kM5GHCrlZcS+1hFY9dlVB7ENnbA4lRn+gwHtnDPlVX9+UHDi/cPIi40Lh6IbzhN
 lyVLMCojpJlHxdTTnOMgXSNYk/Fik50sCIIjdA2x2krFaic0dHSmNr/3HZ3Pgv6EnKnmrK5U7
 J9WZqpiAOvfIl+asPEwwgUsro9il7BSaoaZrn2Rb87gaFyO+u4e6JQyQOHBVD/rCLvqWFmE0F
 4RmkdE1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On Wed, 5 Oct 2016, James B wrote:

> On Wed, 5 Oct 2016 12:41:50 +0200 (CEST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> It's a very sad day for a tool that was developed originally to maintain
> Linux kernel, by the Linux kernel author, now is restricted to avoid
> use/optimise on Linux/POSIX features *because* it has to run on another
> Windows ...

Please note that this thread started because Git tried to shed the
restrictions of POSIX by using REG_STARTEND. In other words, we tried very
much *not* to be restricted.

And pragmatically, I must add that the REG_STARTEND feature is a very,
very useful one.

If you want to turn your sadness into something productive (you will allow
me that little prod after all you said in your mail), why don't you
dig back through the Git mailing list, fish out my original patch that
fell back to the "malloc();memcpy();/*add NUL*/" strategy, and contribute
that as a patch to the Git project, making a case that musl requires it?

Ciao,
Johannes
