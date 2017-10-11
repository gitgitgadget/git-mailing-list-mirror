Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE021FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 19:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757851AbdJKTYx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 15:24:53 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:43235 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757432AbdJKTYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 15:24:51 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:58838 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2Mcc-0004iH-5J; Wed, 11 Oct 2017 15:24:50 -0400
Date:   Wed, 11 Oct 2017 15:24:48 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: slight addition to t.gummerer's proposed "git stash" patch
In-Reply-To: <20171011192109.GC15399@hank>
Message-ID: <alpine.LFD.2.21.1710111523510.4185@localhost.localdomain>
References: <alpine.LFD.2.21.1710110454240.11490@localhost.localdomain> <20171011192109.GC15399@hank>
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

On Wed, 11 Oct 2017, Thomas Gummerer wrote:

> On 10/11, Robert P. J. Day wrote:
> >
> >   was perusing thomas gummerer's proposed "git stash" patch here:
> >
> > https://www.spinics.net/lists/git/msg313993.html
> >
> > and i'd make one more change -- i'd separate the OPTIONS entries for
> > "git stash push" and "git stash save" so they don't end up being
> > rendered all crushed together when displaying the man page:
>
> I for one would like that.  I sent a patch recently [1] that would
> show git stash push first on the man page, which didn't seem to get
> much traction.  This goes a bit further than that, which I'd be happy
> with.
>
> [1]: https://public-inbox.org/git/20171005201029.4173-1-t.gummerer@gmail.com/

  ... snip ...

if you want, just crush my suggestion into your earlier patch and
resubmit it.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
