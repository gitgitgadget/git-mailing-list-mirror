From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 16:51:44 -0400
Message-ID: <20150527205144.GA22815@peff.net>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
 <20150527072218.GB6898@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:51:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiIp-00006O-GY
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbbE0Uvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:51:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:36873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751765AbbE0Uvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:51:46 -0400
Received: (qmail 13442 invoked by uid 102); 27 May 2015 20:51:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:51:46 -0500
Received: (qmail 10493 invoked by uid 107); 27 May 2015 20:51:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:51:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:51:44 -0400
Content-Disposition: inline
In-Reply-To: <20150527072218.GB6898@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270093>

On Wed, May 27, 2015 at 03:22:18AM -0400, Jeff King wrote:

> In color.diff.*, these are called "new", "old", and "plain". I am of the
> opinion that "context" is a far better name than "plain", but perhaps we
> should support both for consistency.
> 
> Here's a patch for the color.diff side, if we want to go that route.

So I had originally thought we would support both names in both places.
But since the diff patch we ended up with is basically "the real name is
context; plain is just a historical anomaly", I do not see any need to
support "plain" in your new whitespace code.

I suspect you came to the same conclusion independently, but I wanted to
make sure what I had written before didn't leave anybody confused.

-Peff
