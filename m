From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] Added diff hunk coloring to git-add--interactive
Date: Fri, 23 Nov 2007 05:21:57 -0500
Message-ID: <20071123102156.GA6754@sigill.intra.peff.net>
References: <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045624.405e2b2b@paradox.zwell.net> <20071122122540.GH12913@sigill.intra.peff.net> <7v1wai3qrw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@zwell.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 11:22:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVfx-00054f-RH
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbXKWKWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 05:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXKWKWD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:22:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3396 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187AbXKWKWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:22:00 -0500
Received: (qmail 30214 invoked by uid 111); 23 Nov 2007 10:21:59 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 23 Nov 2007 05:21:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Nov 2007 05:21:57 -0500
Content-Disposition: inline
In-Reply-To: <7v1wai3qrw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65891>

On Thu, Nov 22, 2007 at 01:37:55PM -0800, Junio C Hamano wrote:

> > Unfortunately, there is a historical wart that probably still needs
> > supporting, which is that the original names were diff.color.*. Or have
> > we officially removed support for that yet?
> 
> Neither officially or unofficially yet, but we can start the
> process of making it official with an early announcement.  I do
> not think we would hurt people as long as a long enough advance
> notice is given.

Andy Parkins added color.* (and removed documentation for *.color)
almost a year ago (in a159ca0c). But I don't think there has been an
official deprecation notice.

> I however am wondering if we need to have so many "enable color
> support" switches.  color.status, color.diff, and now yet
> another color.interactive?  Who sets color.status and/or
> color.interactive to auto without setting color.diff to auto as
> well?

Yes, I have often thought this, as well, and a "color.all" would
probably be convenient.

-Peff
