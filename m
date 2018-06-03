Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E6C81F403
	for <e@80x24.org>; Sun,  3 Jun 2018 13:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFCNiu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 09:38:50 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:51452 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeFCNit (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 09:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5ywgK4MxPfHTXkrOSJYQNOroojEJrBXLGK8b5NSMTfA=; b=O7iQ1CzNcUY608uit35OChDkP
        1NZRl4vNTDW78q4Q/hnVpZNb4pqpo9d5KOOXoy7UkWb0fR/7c4JTCl/wZMefWNGMW5vv/cWlU45EV
        eBEv4zeOujpbsKnygebp6Jlpz2sj4rHt17uk7KiV7a+Jw45v2k+N5M6kf16g40VdcWwn0JX4d6jJH
        GrL+/0Z/Z2Y7FyMjIOFWIMQEcWSivA+yOdZoQojxhySzI31w0dIKgfaYt+81RKdPSjZesTOl2sb5W
        5OoR/02uzCQ0b3qkJxlKsULgqTfMBNa2tfNPkn4r3yyAI+v7vgnqNr6RH4fwGl6bWxccjD0yyqXF0
        lIMFmoA4A==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:60386 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPTDa-004un3-Pb; Sun, 03 Jun 2018 09:38:47 -0400
Date:   Sun, 3 Jun 2018 09:36:40 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
 "--get-regex"
In-Reply-To: <20180603133039.GF26159@hank.intra.tgummerer.com>
Message-ID: <alpine.LFD.2.21.1806030935010.21364@localhost.localdomain>
References: <alpine.LFD.2.21.1806030613080.7681@localhost.localdomain> <20180603133039.GF26159@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 3 Jun 2018, Thomas Gummerer wrote:

> > Subject: [PATCH v2] t/perf/run: Use proper "--get-regexp", not
>
> micronit: we prefer starting with a lowercase letter after the "area:"
> prefix in commit messages.   Junio can probably fix that while
> queuing, so no need to resend.

  argh, i actually know that, i just screwed up.

> On 06/03, Robert P. J. Day wrote:
> >
> > Even though "--get-regex" appears to work with "git config", the
> > clear standard is to spell out the action in full.
>
> --get-regex works as the parse-option API allows abbreviations of the
> full option to be specified as long as the abbreviation is
> unambiguos.  I don't know if this is documented anywhere other than
> 'Documentation/technical/api-parse-options.txt' though.
>
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
>
> It took me a bit to figure out why there is a v2, and what changed
> between the versions.  This space after the '---' would be a good
> place to describe that to help reviewers.
>
> For others that are curious, it seems like the word "clear" was added
> in the commit message.
>
> The change itself looks good to me.

  the actual rationale for v2 was in the subject, i originally put
just "get-regex" rather then "--get-regex"; i resubmitted for
consistency.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
