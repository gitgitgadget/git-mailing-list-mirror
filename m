From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 9 Jun 2016 13:12:47 -0400
Message-ID: <20160609171246.GA9016@sigill.intra.peff.net>
References: <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
 <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
 <20160608194216.GA3731@sigill.intra.peff.net>
 <vpqwplypnpr.fsf@anie.imag.fr>
 <57597E93.9040808@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 19:12:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB3Vo-0001Yl-Ra
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 19:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbcFIRMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 13:12:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:51970 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932118AbcFIRMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 13:12:51 -0400
Received: (qmail 23423 invoked by uid 102); 9 Jun 2016 17:12:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:12:50 -0400
Received: (qmail 25145 invoked by uid 107); 9 Jun 2016 17:12:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jun 2016 13:12:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2016 13:12:47 -0400
Content-Disposition: inline
In-Reply-To: <57597E93.9040808@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296904>

On Thu, Jun 09, 2016 at 03:34:59PM +0100, Ramsay Jones wrote:

> Just FYI, this patch removes the last use of write_or_whine() - should it
> be removed?

That sounds reasonable. Want to do a patch on top?

-Peff
