Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EC5F202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 09:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdKVJ4j (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 04:56:39 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:34010 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdKVJ4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 04:56:36 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:33934 helo=DESKTOP-1GPMCEJ)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHRlj-0002Yk-V5; Wed, 22 Nov 2017 04:56:36 -0500
Date:   Wed, 22 Nov 2017 04:55:12 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@DESKTOP-1GPMCEJ
To:     Kevin Daudt <me@ikke.info>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
In-Reply-To: <20171121214552.GB16418@alpha.vpn.ikke.info>
Message-ID: <alpine.LFD.2.21.1711220453290.3814@DESKTOP-1GPMCEJ>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain> <20171121214552.GB16418@alpha.vpn.ikke.info>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017, Kevin Daudt wrote:

> On Tue, Nov 21, 2017 at 04:27:59PM -0500, Robert P. J. Day wrote:
> > No major changes, just some rewording and showing some variations of
> > general Git commands.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> > diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> > index 9f13266a6..d690d1ff0 100644
> > --- a/Documentation/gitcli.txt
> > +++ b/Documentation/gitcli.txt
> > @@ -13,7 +13,7 @@ gitcli
> >  DESCRIPTION
> >  -----------
> >
> > -This manual describes the convention used throughout Git CLI.
> > +This manual describes the conventions used throughout Git CLI.
> >
> >  Many commands take revisions (most often "commits", but sometimes
> >  "tree-ish", depending on the context and command) and paths as their
> > @@ -32,32 +32,35 @@ arguments.  Here are the rules:
> >     between the HEAD commit and the work tree as a whole".  You can say
> >     `git diff HEAD --` to ask for the latter.
> >
> > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> > +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
>
> 'Can' error out implies that it sometimes would not error out when
> there is ambiguity. Are there situation where git does not error out
> in that case?

  even if there is ambiguity, will git actually "error out"? i have a
git repo with a file called "Gemfile", so i created a branch called
"Gemfile", and when i ran:

  $ git checkout Gemfile

git switched to the branch. so even with the ambiguity, git obviously
has some sort of precedence order it checks. so what are the rules
here?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
