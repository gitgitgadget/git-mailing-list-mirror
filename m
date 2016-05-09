From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 10:27:11 -0400
Message-ID: <20160509142711.GA9552@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <cover.1462774709.git.johannes.schindelin@gmx.de>
 <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
 <20160509080315.GA14383@sigill.intra.peff.net>
 <alpine.DEB.2.20.1605091557050.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 16:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azm9a-0004Dp-7q
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 16:27:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbcEIO1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 10:27:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:36272 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751080AbcEIO1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 10:27:15 -0400
Received: (qmail 13008 invoked by uid 102); 9 May 2016 14:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 10:27:14 -0400
Received: (qmail 19323 invoked by uid 107); 9 May 2016 14:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 10:27:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 10:27:11 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1605091557050.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293997>

On Mon, May 09, 2016 at 04:03:48PM +0200, Johannes Schindelin wrote:

> How about this:
> 
> 	As RewriteCond does not allow testing for *non*-matches, we simply
> 	match the desired case first and let it pass by marking the
> 	RewriteRule as '[L]' ("last rule, do not process any other
> 	matching RewriteRules after this"), and then have another
> 	RewriteRule that matches all other cases and lets them fail via
> 	'[F]' ("fail").
> 
> Good enough?

Yep, I think that explains it. Thanks.

-Peff
