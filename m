From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] bswap: add NO_UNALIGNED_LOADS define
Date: Tue, 29 Dec 2015 01:45:09 -0500
Message-ID: <20151229064509.GA31992@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
 <20151229063600.GB30340@sigill.intra.peff.net>
 <CAPig+cQ_u2Y6Z6SO3JQ0XtaoRCPf7r_gnEh-kTj0mn36ahEoHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 07:45:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDo21-0000KX-8N
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 07:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbbL2GpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 01:45:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:46556 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753153AbbL2GpM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 01:45:12 -0500
Received: (qmail 16143 invoked by uid 102); 29 Dec 2015 06:45:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 00:45:12 -0600
Received: (qmail 18973 invoked by uid 107); 29 Dec 2015 06:45:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:45:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 01:45:09 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQ_u2Y6Z6SO3JQ0XtaoRCPf7r_gnEh-kTj0mn36ahEoHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283079>

On Tue, Dec 29, 2015 at 01:42:45AM -0500, Eric Sunshine wrote:

> On Tue, Dec 29, 2015 at 1:36 AM, Jeff King <peff@peff.net> wrote:
> > The byte-swapping code automatically decides, based on the
> > platform, whether it is sensible to cast an do a potentially
> 
> s/an/and/ or something?

Yes, it should be "and". Thanks.

-Peff
