Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BBD1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 07:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdJMHFh (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 03:05:37 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:38648 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdJMHFg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 03:05:36 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:36844 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e2u2J-00033S-BA; Fri, 13 Oct 2017 03:05:35 -0400
Date:   Fri, 13 Oct 2017 03:05:33 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
In-Reply-To: <20171012235623.grpw67yyr64tynev@sigill.intra.peff.net>
Message-ID: <alpine.LFD.2.21.1710130305150.9014@localhost.localdomain>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca> <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain> <alpine.DEB.2.21.1.1710130116430.40514@virtualbox>
 <20171012235623.grpw67yyr64tynev@sigill.intra.peff.net>
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

On Thu, 12 Oct 2017, Jeff King wrote:

> On Fri, Oct 13, 2017 at 01:18:00AM +0200, Johannes Schindelin wrote:
>
> > [who I had to cull from the To:/Cc: headers, as my mailer consistently
> > told me that there is no valid DNS record to route mail to
> > rpjday@crashcourse.ca, which *is* weird.]
>
> You are not the only one to mention this, so I did 60 seconds of
> digging. Turns out that the MX of crashcourse.ca points to a CNAME
> (mail.crashcourse.ca), which is explicitly forbidden by RFC 2181
> (section 10.3). Some MTAs are picky about this and others are not
> (mine isn't, so I've added Robert back to the cc so he sees this).

  ok, i'll tell my admin about this, thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
