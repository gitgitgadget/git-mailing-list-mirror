Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FDE20281
	for <e@80x24.org>; Sun,  1 Oct 2017 10:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdJAKFt (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 06:05:49 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:38815 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbdJAKFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 06:05:48 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:46030 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dyb86-0007lf-MU; Sun, 01 Oct 2017 06:05:46 -0400
Date:   Sun, 1 Oct 2017 06:05:44 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-checkout", man page is inconsistent between SYNOPSIS
 and details
In-Reply-To: <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain> <20170930143258.GA20886@alpha.vpn.ikke.info> <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain> <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
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

On Sun, 1 Oct 2017, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   it's simply a matter of the forms not matching between the SYNOPSIS
> > and the DESCRIPTION sections. am i making sense?
>
> I think the whole thing is wrong and the root cause is because the
> (relatively newer) description of the "--patch" mode lazily tried to
> piggy-back the description of existing "check out from the index or
> tree-ish" mode, ending up in a confusing description...

  ... big snip ...

ok, i'm going to have to digest all that; pretty sure someone else
will need to change the man page to clarify the apparent inconsistency
i was referring to:

  SYNOPSIS
       git checkout [-p|--patch] [<tree-ish>] [--] [<paths>...]
  DESCRIPTION
       git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...

and on that note, i'll get back to proofreading.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
