From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 04:52:30 -0500
Message-ID: <20071127095230.GA4337@sigill.intra.peff.net>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net> <20071127094639.GC3571@sigill.intra.peff.net> <figp6f$onj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 10:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwx7b-0003Co-O9
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 10:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXK0Jwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 04:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbXK0Jwd
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 04:52:33 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4810 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbXK0Jwc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 04:52:32 -0500
Received: (qmail 31037 invoked by uid 111); 27 Nov 2007 09:52:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 27 Nov 2007 04:52:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Nov 2007 04:52:30 -0500
Content-Disposition: inline
In-Reply-To: <figp6f$onj$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66177>

On Tue, Nov 27, 2007 at 10:49:03AM +0100, Jakub Narebski wrote:

> > However, I'm sure you will be shocked to learn that /bin/sh on Solaris
> > doesn't understand it:
> > 
> > $ export foo=bar
> > foo=bar: is not an identifier
> 
> If I remember correctly /bin/sh on Solaris cannot be used because
> of other issues (like $(...) and such).

Yes, my response was not "we can't use this" (because clearly we have
been for some time) but rather "look how crappy the Solaris shell is.
Maybe you were thinking of it?"

IOW, the construct is fine to the best of my knowledge.

-Peff
