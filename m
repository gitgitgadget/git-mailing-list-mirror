Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA2D1F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 13:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdKKNqv (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 08:46:51 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:60710 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdKKNqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 08:46:51 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:49250 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDW7W-0007IM-8O; Sat, 11 Nov 2017 08:46:50 -0500
Date:   Sat, 11 Nov 2017 08:46:26 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Kevin Daudt <me@ikke.info>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] bisect: clarify that one can select multiple good
 commits
In-Reply-To: <20171111134430.GA30635@alpha.vpn.ikke.info>
Message-ID: <alpine.LFD.2.21.1711110846001.9944@localhost.localdomain>
References: <alpine.LFD.2.21.1711110820370.8941@localhost.localdomain> <20171111134430.GA30635@alpha.vpn.ikke.info>
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

On Sat, 11 Nov 2017, Kevin Daudt wrote:

> On Sat, Nov 11, 2017 at 08:26:00AM -0500, Robert P. J. Day wrote:
> >
> > Current man page for "bisect" is inconsistent explaining the fact that
> > "git bisect" takes precisely one bad commit, but one or more good
> > commits, so tweak the man page in a few places to make that clear.
> >
> > rday
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> >   i also exercised literary license to reword an example to look for a
> > commit where performance was *degraded* rather than improved, since i
> > think that's the sort of thing that people would be more interested
> > in.
> >
> >  In fact, `git bisect` can be used to find the commit that changed
> >  *any* property of your project; e.g., the commit that fixed a bug, or
> > -the commit that caused a benchmark's performance to improve. To
> > +the commit that caused a benchmark's performance to degrade. To
> >  support this more general usage, the terms "old" and "new" can be used
> >  in place of "good" and "bad", or you can choose your own terms. See
> >  section "Alternate terms" below for more information.
> > @@ -58,7 +58,7 @@ $ git bisect bad                 # Current version is bad
> >  $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
> >  ------------------------------------------------
> >
>
> I think this example was meant to suggest that it's not only possible to
> find bad things (bugs, performance degradations), but also the opposite
> (when was a bug fixed, what caused the performance to change).
>
> So I think it's good to keep the example like it is.

  ok, anyone else have any strong opinions on the subject?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
