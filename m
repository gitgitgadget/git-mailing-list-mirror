From: Jeff King <peff@peff.net>
Subject: Re: contrib/credential/osxkeychain: Makefile should allow to set
 CFLAGS
Date: Thu, 24 May 2012 13:51:43 -0400
Message-ID: <20120524175143.GD3161@sigill.intra.peff.net>
References: <AB628C35-FEC2-4425-B3D8-EEC7F8D6A66B@samueljohn.de>
 <7vtxz82ap6.fsf@alter.siamese.dyndns.org>
 <20120523173653.GA29458@sigill.intra.peff.net>
 <7vaa0xxz14.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel John <mail@samueljohn.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 19:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXcCT-0002DS-TV
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758339Ab2EXRvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:51:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53760
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756965Ab2EXRvp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:51:45 -0400
Received: (qmail 29851 invoked by uid 107); 24 May 2012 17:52:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 13:52:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 13:51:43 -0400
Content-Disposition: inline
In-Reply-To: <7vaa0xxz14.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198400>

On Thu, May 24, 2012 at 10:35:35AM -0700, Junio C Hamano wrote:

> > I think so. Why don't we do this?
> 
> I am OK with that.
> 
> CFLAGS/LDFLAGS that come from ../../../config.mak _might_ not be suitable
> for this binary, but I do not think of a concrete example how that could
> be.  Besides, this is just an example in contrib/ so I'd not worry about
> it too much.

Yeah, I considered that, but I figured that what you have in config.mak
is _at least_ as sensible as the random defaults I stuck in the
Makefile.  And overriding with "make CFLAGS=..." is still available.

-Peff
