From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] imap-send: avoid curl functions when not building curl
 support
Date: Mon, 10 Nov 2014 02:16:24 -0500
Message-ID: <20141110071623.GA9063@peff.net>
References: <20141110063947.GA7894@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Mon Nov 10 08:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnjDC-0007NG-9E
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 08:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbaKJHQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 02:16:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:38644 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750852AbaKJHQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 02:16:26 -0500
Received: (qmail 17334 invoked by uid 102); 10 Nov 2014 07:16:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:16:26 -0600
Received: (qmail 660 invoked by uid 107); 10 Nov 2014 07:16:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 02:16:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 02:16:24 -0500
Content-Disposition: inline
In-Reply-To: <20141110063947.GA7894@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 10, 2014 at 01:39:47AM -0500, Jeff King wrote:

> On top of br/imap-send-via-libcurl. I needed this to compile 'pu' with
> NO_CURL (which I don't usually do, but was testing on a minimal box). I
> expect it can just be squashed in to the next re-roll.

Oops, just started reading through my list backlog and realized you
already noticed and dealt with this. Sorry for the noise.

-Peff
