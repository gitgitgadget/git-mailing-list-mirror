Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6157520A2C
	for <e@80x24.org>; Sat, 30 Sep 2017 22:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdI3WEJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 18:04:09 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:39364 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdI3WEI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 18:04:08 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:41606 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyPrj-00081O-QQ; Sat, 30 Sep 2017 18:04:07 -0400
Date:   Sat, 30 Sep 2017 18:04:05 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Kevin Daudt <me@ikke.info>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-checkout", man page is inconsistent between SYNOPSIS
 and details
In-Reply-To: <20170930143258.GA20886@alpha.vpn.ikke.info>
Message-ID: <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain> <20170930143258.GA20886@alpha.vpn.ikke.info>
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

On Sat, 30 Sep 2017, Kevin Daudt wrote:

> On Sat, Sep 30, 2017 at 05:27:22AM -0400, Robert P. J. Day wrote:
> >
> >   just noticed that in "man git-checkout", the SYNOPSIS contains
> > the line:
> >
> >   git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
> >
> > implying that <paths> is optional, but further down in the
> > DESCRIPTION, one reads:
> >
> >   git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
> >
> > suggesting that <pathspec> is required.
> >
>
> Hello Robert, thank you for this report.
>
> Git checkout has 2 major modes of operating:
>
> 1. Checking out branches (and then update your working tree to match that
>   commit.
> 2. Checking out 1 or more files from a commit.
>
> The first four lines of the synopsis match mode nr. 1. The next two
> belong to mode nr. 2.
>
> The pathspec in the synopsis line you are quoting is required,
> because that's how you tell git you want mode nr 2. That's why it's
> not mentioned between [].  The last section under description
> explains that mode.
>
> Do you feel this distinction needs to be made more clear?

  upon re-examination, not so much more clear, as simply not
self-contradictory. just compare the lines in the SYNOPSIS and the
DESCRIPTION sections:

SYNOPSIS
       ...
       git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]

DESCRIPTION
       ...
       git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

  those lines clearly represent the same operating mode -- they are
identical in every respect -- but in the first case, paths is
optional, whereas in the second case, it's mandatory.

  it's simply a matter of the forms not matching between the SYNOPSIS
and the DESCRIPTION sections. am i making sense?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
