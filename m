Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE7E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751115AbeFHJIC (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 05:08:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:38728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750969AbeFHJIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 05:08:01 -0400
Received: (qmail 10604 invoked by uid 109); 8 Jun 2018 09:08:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Jun 2018 09:08:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25762 invoked by uid 111); 8 Jun 2018 09:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 08 Jun 2018 05:08:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jun 2018 05:07:58 -0400
Date:   Fri, 8 Jun 2018 05:07:58 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
Message-ID: <20180608090758.GA15112@sigill.intra.peff.net>
References: <20180607145313.25015-1-git@jeffhostetler.com>
 <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 11:10:52PM +0200, Johannes Sixt wrote:

> Am 07.06.2018 um 16:53 schrieb git@jeffhostetler.com:
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> > 
> > I've been working to add code to Git to optionally collect telemetry data.
> > The goal is to be able to collect performance data from Git commands and
> > allow it to be aggregated over a user community to find "slow commands".
> 
> Seriously? "add code to collect telemetry data" said by somebody whose email
> address ends with @microsoft.com is very irritating. I really don't want to
> have yet another switch that I must check after every update that it is
> still off.

If you look at the design document, it's off by default and would write
to a file on the filesystem. That doesn't seem all that different from
GIT_TRACE.

-Peff
