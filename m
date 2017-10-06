Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945801FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 17:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbdJFRjU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 13:39:20 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:51785 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdJFRjT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 13:39:19 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:40502 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0Wak-00077w-GP; Fri, 06 Oct 2017 13:39:18 -0400
Date:   Fri, 6 Oct 2017 13:39:16 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
In-Reply-To: <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca> <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
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

On Fri, 6 Oct 2017, Junio C Hamano wrote:

> rpjday@crashcourse.ca writes:
>
> >   at the other end, users are certainly welcome to add extra
> > patterns to be ignored, based purely on the way they work --
> > perhaps based on their choice of editor, they might want to
> > exclude *.swp files, or if working on a Mac, ignore .DS_Store, and
> > so on, using a core.excludesFile setting.
>
> This is primarily why .git/info/exclude exists.  A user who does not
> use the same set of tools to work on different projects may not be
> able to use ~/.gitconfig with core.excludesFile pointing at a single
> place that applies to _all_ repositories the user touches.
>
> Also, core.excludesFile came a lot later than in-project and
> in-repository exclude list, IIRC.
>
> Don't waste time by seeking a "compelling" reason.  A mere "this is
> the most expedite way to gain convenience" back when something was
> introduced could be an answer, and it is way too late to complain
> about such a choice anyway.

  perfectly respectable answer ... it tells me that, between
.gitignore files and core.excludesFile, there's not much left for
.git/info/exclude to do, except in weird circumstances.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
