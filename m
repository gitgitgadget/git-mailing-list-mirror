Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E15E202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbdKVIAe (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 03:00:34 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:59893 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751425AbdKVIAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 03:00:33 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:42394 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eHPxR-00081D-1S; Wed, 22 Nov 2017 03:00:33 -0500
Date:   Wed, 22 Nov 2017 02:59:10 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: Add missing "-n" (dry-run) option to reflog man
 page
In-Reply-To: <xmqqh8tnvvom.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1711220249020.31052@localhost.localdomain>
References: <alpine.LFD.2.21.1711211038410.8568@DESKTOP-1GPMCEJ> <xmqqh8tnvvom.fsf@gitster.mtv.corp.google.com>
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

On Wed, 22 Nov 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> > While the "git reflog" man page supports both "--dry-run" and "-n" for
> > a dry run, the man page mentions only the former, not the latter.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
>
> I have a suspicion that this was deliberately omitted in order to
> keep the lines in the description short and concise.  Just adding
> 5-columns may appear not to hurt too much, but these things tend to
> accumulate, so...
>
> Queued, so that I won't lose sight of it, but won't merge unless
> somebody else strongly feels about it.

  i appreciate the need for brevity, but this just takes us back to,
is there a standard for man pages, given how they bounce around all
over the place?

  i tossed in that missing "-n" option for "man git-reflog" since it
was the *only* option missing from the SYNOPSIS, and it didn't mess up
the aesthetics. but there are other examples that clearly aren't worth
the trouble:

  $ man git-clean
  SYNOPSIS
    git clean [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...

where *only* the short forms are used in the SYNOPSIS.

  and, finally, there are examples that mix and match, like:

  $ man git-commit
  SYNOPSIS
    git commit [-a | --interactive | --patch] ...

which uses "-a" instead of "--all", but "--patch" instead of "-p". i'm
fine if someone says, "there is no standard," but if there is, then
the docs should follow them.

  thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
