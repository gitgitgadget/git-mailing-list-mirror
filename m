From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Make "local" orthogonal to date format
Date: Wed, 2 Sep 2015 04:05:29 -0400
Message-ID: <20150902080529.GA19248@sigill.intra.peff.net>
References: <20150901083731.GE30659@serenity.lan>
 <cover.1441144343.git.john@keeping.me.uk>
 <20150901224431.GA9353@sigill.intra.peff.net>
 <20150902074826.GK30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX33G-0002Ae-36
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 10:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbbIBIFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 04:05:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:53599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752323AbbIBIFc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 04:05:32 -0400
Received: (qmail 4235 invoked by uid 102); 2 Sep 2015 08:05:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 03:05:32 -0500
Received: (qmail 10357 invoked by uid 107); 2 Sep 2015 08:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Sep 2015 04:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2015 04:05:29 -0400
Content-Disposition: inline
In-Reply-To: <20150902074826.GK30659@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277079>

On Wed, Sep 02, 2015 at 08:48:26AM +0100, John Keeping wrote:

> On Tue, Sep 01, 2015 at 06:44:31PM -0400, Jeff King wrote:
> > [1] I do think the error message for "relative-local is nonsense" could
> >     perhaps be more explanatory, but I couldn't come up with any better
> >     wording. But if you have ideas, feel free to switch it.
> 
> My only suggestion would be to reuse the "unknown date format: %s"
> message and avoid having a special message in this case.

Heh, that was what I was trying to avoid. I wanted to avoid "I do not
understand our request" and have it more like "I understand what you're
_trying_ to do, but it doesn't make sense".

I guess "relative dates do not depend on timezones, so -local is
meaningless" would be the closest thing.

I don't think it is that big a deal whichever way we go, though.

-Peff
