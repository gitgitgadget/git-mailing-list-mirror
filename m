Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 977F62036D
	for <e@80x24.org>; Thu, 23 Nov 2017 07:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdKWHrM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 02:47:12 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:39317 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdKWHrL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 02:47:11 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:49582 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHmE2-0007Az-Fo; Thu, 23 Nov 2017 02:47:10 -0500
Date:   Thu, 23 Nov 2017 02:45:44 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
In-Reply-To: <20171123000346.GA8718@sigill>
Message-ID: <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain> <20171121214552.GB16418@alpha.vpn.ikke.info> <20171123000346.GA8718@sigill>
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

On Wed, 22 Nov 2017, Jeff King wrote:

> On Tue, Nov 21, 2017 at 10:45:52PM +0100, Kevin Daudt wrote:
>
> > > - * Without disambiguating `--`, Git makes a reasonable guess, but errors
> > > -   out and asking you to disambiguate when ambiguous.  E.g. if you have a
> > > + * Without a disambiguating `--`, Git makes a reasonable guess, but can
> > > +   error out, asking you to disambiguate when ambiguous.  E.g. if you have a
> >
> > 'Can' error out implies that it sometimes would not error out when there
> > is ambiguity. Are there situation where git does not error out in that
> > case?
>
> I read the rest of the thread, and I think the question here is not
> about Git's behavior, but about parsing this sentence.
>
> Without a "--" Git can sometimes do what you want. Or it may error out,
> if what you asked for is ambiguous. And that sentence is trying to cover
> those cases separately, and the "can" only applies to the ambiguous
> case.
>
> It's pretty clear to me as it is, but maybe we can write it differently.
> Like:
>
>   Without a disambiguating `--`, Git makes a reasonable guess. If it
>   cannot guess (because your request is ambiguous), then it will error
>   out.

  ok, i'll give this another try, given that there are two independent
points to be made here:

1) even without the "--", git can generally parse the command and do
the right thing (or do a *valid* thing, given its heuristics)

2) occasionally, without the "--", the command is really and truly
ambiguous, at which point git will fail and tell you to disambiguate

  not the wording i will use, but can we agree that those are the two
points to be made here?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
