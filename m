Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4061C2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 20:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbdJCUyg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:54:36 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:55531 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbdJCUyf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:54:35 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:46176 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dzUD4-0002XB-U4; Tue, 03 Oct 2017 16:54:34 -0400
Date:   Tue, 3 Oct 2017 16:54:32 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: "man git-config", "--list" option misleadingly refers to "config
 file" (singular)
In-Reply-To: <20171003134954.cptlpaipmiulfgug@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1710031653360.8461@localhost.localdomain>
References: <20171003063434.Horde.nbQwMWrv0wS_naxhawU5YlG@crashcourse.ca> <20171003134954.cptlpaipmiulfgug@sigill.intra.peff.net>
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

On Tue, 3 Oct 2017, Jeff King wrote:

> On Tue, Oct 03, 2017 at 06:34:34AM -0400, rpjday@crashcourse.ca wrote:
>
> >   (i suppose that if i'm going to continue whining about stuff, i might
> > as well clone the git source and start submitting patches.)
>
> Yes, please. :)
>
> >   in "man git-config":
> >
> >     -l
> >     --list
> >           List all variables set in config file, along with their values.
> >                                            ^^^^
> >
> > except that, AIUI, "git config --list" will list the combination
> > of all config values in (if it exists) /etc/gitconfig, then the
> > user's global settings, and finally the repo's config settings if
> > one happens to be in a working directory, so technically, it lists
> > the contents of *all* of the config files (plural), no?
>
> It does that by default, or it lists the contents of a specific file
> if given (either by --file, or with --system, --global, or --local).
>
> So I agree it's not quite accurate, but you probably want some
> phrasing that leaves this unsaid (the actual rules are described
> earlier in the description section). Maybe just refer to it as the
> "config source" or something?

  i think the simplest phrasing is, "List all variables set in the
current configuration, along with their values."

  sound fair?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
