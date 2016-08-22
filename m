Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E96A1F859
	for <e@80x24.org>; Mon, 22 Aug 2016 22:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbcHVW4G (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 18:56:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33948 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932396AbcHVWzu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 18:55:50 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EDA821F859;
        Mon, 22 Aug 2016 22:55:49 +0000 (UTC)
Date:   Mon, 22 Aug 2016 22:55:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160822225549.GA25383@starla>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160818204902.GA1670@starla>
 <alpine.DEB.2.20.1608191720040.4924@virtualbox>
 <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608221509010.4924@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 19 Aug 2016, Eric Wong wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > On Thu, 18 Aug 2016, Eric Wong wrote:
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > > Old dogs claim the mail list-approach works for them. Nope.
> > > > > Doesn't.  Else you would not have written all those custom
> > > > > scripts.
> > > > 
> > > > git and cogito started as a bunch of custom scripts, too.
> > > 
> > > The difference is that neither git nor cogito were opinionated. Those
> > > custom scripts are. They are for one particular workflow, with one
> > > particular mail client, with a strong bias to a Unix-y environment.

<snip 3 lines I was not responding to>

> > I guess this is a fundamental difference between *nix and Windows
> > culture.
> 
> I do not understand how you get from "I wish to make it fun to contribute
> to Git" to "there is a fundamental difference between *nix and Windows
> culture".

Sorry, I over-quoted by 3 lines.

<snip more digression..>

> > > We do not even have a section on Outlook in our SubmittingPatches.
> > > 
> > > Okay, if not the most popular mail client, then web mail? Nope, nope,
> > > nope. No piping *at all* to external commands from there.
> > > 
> > > So you basically slam the door shut on the vast majority of email users.
> > 
> > Users have a choice to use a more scriptable mail client
> > (but I guess the OS nudges users towards monolithic tools)
> 
> You call that choice. Are you serious?
> 
> > > That is not leaving much choice to the users in my book.
> > 
> > Users of alpine, gnus, mutt, sylpheed, thunderbird, kmail,
> > roundcube, squirelmail, etc. can all download the source, hack,
> > fix and customize things.  It's easier with smaller software,
> > of course:  git-send-email does not even require learning
> > the build process or separate download.
> 
> Now I am getting upset. This is a BS argument. Sure, I can hack the source
> of these tools.
>
> But why on earth do I *have* to? Why can't we use or create an open
> contribution process *that works without having to work so hard to be able
> to contribute*?

The process we have is already open.  It may be *nix-centric,
and *nix may be picky about it's friends, but it is open:

	Anybody can still contribute today without any sort of
	registration, credentialism, or terms-of-service(*).

I am looking beyond git.

I hate signing up for websites.  For many years, I have used
Debian as a proxy for other projects with less open contribution
processes:

	apt-get source ...; <hack>; reportbug ...

Of course, going through Debian maintainers is not always
reliable or efficient.

I foolishly hoped git-svn would put an end to all the
registration-required bug tracker instances so I could just
send my changes directly to upstream maintainers without any
sort of registration.  Did not happen :<

> So unfortunately this thread has devolved. Which is sad. Because all I
> wanted is to have a change in Git's submission process that would not
> exclude *so many* developers. That is really all I care about. Not about
> tools. Not about open vs proprietary, or standards.
> 
> I just want developers who are already familiar with Git, and come up with
> an improvement to Git itself, to be able to contribute it without having
> to pull out their hair in despair.

We want the same thing.  I just want to go farther and get
people familiar with (federated|decentralized) tools instead of
proprietary and centralized ones.



(*) I wish git could get rid of the DCO, even.  But at least
    it's far better than the "papers, please" policy for some
    GNU projects.
