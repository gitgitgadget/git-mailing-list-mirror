Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CC6820372
	for <e@80x24.org>; Thu, 12 Oct 2017 23:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbdJLX40 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 19:56:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:51622 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751168AbdJLX4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 19:56:25 -0400
Received: (qmail 10621 invoked by uid 109); 12 Oct 2017 23:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 23:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21806 invoked by uid 111); 12 Oct 2017 23:56:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Oct 2017 19:56:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Oct 2017 19:56:23 -0400
Date:   Thu, 12 Oct 2017 19:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     rpjday@crashcourse.ca, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: is there a truly compelling rationale for .git/info/exclude?
Message-ID: <20171012235623.grpw67yyr64tynev@sigill.intra.peff.net>
References: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
 <xmqqmv54v5h6.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710061337300.14079@localhost.localdomain>
 <alpine.DEB.2.21.1.1710130116430.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1710130116430.40514@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 01:18:00AM +0200, Johannes Schindelin wrote:

> [who I had to cull from the To:/Cc: headers, as my mailer consistently
> told me that there is no valid DNS record to route mail to
> rpjday@crashcourse.ca, which *is* weird.]

You are not the only one to mention this, so I did 60 seconds of
digging. Turns out that the MX of crashcourse.ca points to a CNAME
(mail.crashcourse.ca), which is explicitly forbidden by RFC 2181
(section 10.3). Some MTAs are picky about this and others are not (mine
isn't, so I've added Robert back to the cc so he sees this).

-Peff
