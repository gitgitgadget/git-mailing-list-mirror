From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] configure: add getdelim() check
Date: Tue, 2 Jun 2015 14:45:20 -0400
Message-ID: <20150602184519.GB11437@peff.net>
References: <1433269138-10890-1-git-send-email-sunshine@sunshineco.com>
 <1433269138-10890-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:45:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzrBs-0007a8-4x
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbbFBSpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:45:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:39814 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754264AbbFBSpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:45:22 -0400
Received: (qmail 16856 invoked by uid 102); 2 Jun 2015 18:45:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 13:45:22 -0500
Received: (qmail 10292 invoked by uid 107); 2 Jun 2015 18:45:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 14:45:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2015 14:45:20 -0400
Content-Disposition: inline
In-Reply-To: <1433269138-10890-3-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270581>

On Tue, Jun 02, 2015 at 02:18:58PM -0400, Eric Sunshine wrote:

> As an optimization, strbuf will take advantage of getdelim() if
> available, so add a configure check which defines HAVE_GETDELIM if
> found.

Thanks, looks good.

-Peff
