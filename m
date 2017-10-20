Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 885AE1FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 08:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbdJTIEQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 04:04:16 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:52812 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdJTIEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 04:04:14 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:34158 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e5SHt-0007hX-D0; Fri, 20 Oct 2017 04:04:13 -0400
Date:   Fri, 20 Oct 2017 04:04:10 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
In-Reply-To: <20171019180801.GI15399@hank>
Message-ID: <alpine.LFD.2.21.1710200403260.30185@localhost.localdomain>
References: <20171005200049.GF30301@hank> <20171005201029.4173-1-t.gummerer@gmail.com> <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net> <20171017214515.GG15399@hank> <20171017214708.ixc2hnut2virarzh@sigill.intra.peff.net>
 <20171019180801.GI15399@hank>
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

On Thu, 19 Oct 2017, Thomas Gummerer wrote:

> On 10/17, Jeff King wrote:
> > On Tue, Oct 17, 2017 at 10:45:15PM +0100, Thomas Gummerer wrote:
> >
> > > > Seems reasonable, though if we are deprecating "save" should we demote
> > > > it from being in the synopsis entirely?
> > >
> > > I saw that as a next step, with the "official" deprecation of "save".
> > > I thought we might want to advertise "push" a bit more before actually
> > > officially deprecating "save" and sending the deprecation notice out
> > > in the release notes.
> >
> > Right, my thinking was that it would still be documented in the manpage,
> > just lower down. And that would probably say something like "save is a
> > historical synonym for push, except that it differs in these ways...".
> >
> > > OTOH, dropping it from the synopsis in the man page probably wouldn't
> > > cause much issue, as "push" directly replaces it, and is easily
> > > visible.  Not sure how slow we want to take the deprecation?
> >
> > I don't think there's any reason to go slow in marking something as
> > deprecated. It's the part where we follow up and remove or change the
> > feature that must take a while.
>
> Makes sense, let me drop it from the synopsis then.

  what, exactly, is the oft-referred-to issue with how "git stash
save" works that is being addressed with the new syntax of "git stash
push"?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
