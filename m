Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828842036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbdKUWEN (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:04:13 -0500
Received: from ikke.info ([178.21.113.177]:41302 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbdKUWEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:04:11 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 6DD874400DB; Tue, 21 Nov 2017 23:04:09 +0100 (CET)
Date:   Tue, 21 Nov 2017 23:04:09 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171121220409.GC16418@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <alpine.LFD.2.21.1711211646050.26665@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211646050.26665@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 04:47:42PM -0500, Robert P. J. Day wrote:
> On Tue, 21 Nov 2017, Kevin Daudt wrote:
> 
> > On Tue, Nov 21, 2017 at 04:27:59PM -0500, Robert P. J. Day wrote:
> > > No major changes, just some rewording and showing some variations of
> > > general Git commands.
> > >
> > > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> > >
> > > ---
> > >
> > > diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > > index 9f13266a6..d690d1ff0 100644
> > > --- a/Documentation/gitcli.txt
> > > +++ b/Documentation/gitcli.txt
> > > @@ -13,7 +13,7 @@ gitcli
> > >  DESCRIPTION
> > >  -----------
> > >
> > > -This manual describes the convention used throughout Git CLI.
> > > +This manual describes the conventions used throughout Git CLI.
> > >
> > >  Many commands take revisions (most often "commits", but sometimes
> > >  "tree-ish", depending on the context and command) and paths as their
> > > @@ -32,32 +32,35 @@ arguments.  Here are the rules:
> > >     between the HEAD commit and the work tree as a whole".  You can say
> > >     `git diff HEAD --` to ask for the latter.
> > >
> > > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > > + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> > > +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
> >
> > 'Can' error out implies that it sometimes would not error out when
> > there is ambiguity. Are there situation where git does not error out
> > in that case?
> 
>   i would say (based on my limited knowledge) that if the heuristic
> kicks in and works fine, then things will work. i think it's fair to
> say that git "can" error out if the heuristic fails.
> 
> rday

In most cases that I'm aware of, you have to be explicit. If for example
you want to refer to a file that's not in the working tree, you have to
use '--'.  Even with heuristics, it would still have to error out when
it's ambiguous what the user meant.

So the way you worded it implies that there are situations where git
knows there are multiple things the user could have meant, but it would
not error out in that case.

Kevin

