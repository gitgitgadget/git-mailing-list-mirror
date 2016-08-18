Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A37E2018E
	for <e@80x24.org>; Fri, 19 Aug 2016 01:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755105AbcHSBeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:34:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53246 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755020AbcHSBeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:34:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id F40312018E;
        Thu, 18 Aug 2016 20:49:02 +0000 (UTC)
Date:   Thu, 18 Aug 2016 20:49:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160818204902.GA1670@starla>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608181430280.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> BTW I take this thread as yet another proof that people are unhappy with
> mail list-based review: if you have to build *that much* tooling around it
> (and Peff & Junio certainly have a megaton of advanced and sophisticated
> tooling around it, holy cow!) it is really incorrect to state that the
> mail list-driven approach works for you. It is much closer to the truth to
> say that the mail-list-plus-loads-of-custom-tools-driven approach works
> for you.
> 
> I am really not a fan of this.
> 
> The theory "it's inclusive because everyone has access to mail" falls on
> its face, badly, when even old timers have to build entire infrastructures
> around it just to begin to be able to use it efficiently.
> 
> It reminds me of an old software developer I met long ago, who claimed CVS
> works for him. He had written tens of thousands of lines of shell scripts,
> is what allowed "CVS" to work for him.
> 
> Same here. Old dogs claim the mail list-approach works for them. Nope.
> Doesn't. Else you would not have written all those custom scripts.

git and cogito started as a bunch of custom scripts, too.
IMHO, it's what makes Free Software (and *nix) great:
users have control to customize and improve things.
With scripts, they don't even need to learn a build process
to do so.

I see a choice of mail client as no different than a choice of
text editor.  Neither my mail client or text editor is heavily
customized.  The key feature I rely on from both tools is piping
data to external commands.


OTOH, today, I see people using git aliases all the time which
look more like ASM instructions than user commands.

Is the widespread use of these aliases a deficiency to git?
Maybe, I don't know.

Normally, I do not care about aliases: it's a private thing;
but it also makes it incredibly difficult for me to help
users when they're exposed in public.


Users ought to be able to pick, choose, and replace tools as
they wish as long as an interchange format remains stable
and widely-supported.

Fwiw, I still use patch(1) pretty often, even on patches
generated with git.  I see nothing wrong with that; patch is
lenient in ways git-apply was explicitly designed not to be.
And I don't always use git send-email or my normal MUA for
sending; or use git for generating diffs.  I do:

	diff -u a b | mail -s WIP-blah-blah $SOMEONE


While you and I are long-time git hackers, I don't think it's
reasonable for everyone to use git or git-specific tools;
even to git.git for one-offs like portability or doc fixes.

Even today, at least one Linux kernel hacker still uses quilt to
generate patches: http://ozlabs.org/~akpm/mmotm/
