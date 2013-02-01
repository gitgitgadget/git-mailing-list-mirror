From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Fri, 1 Feb 2013 00:03:43 -0500
Message-ID: <20130201050343.GA29973@sigill.intra.peff.net>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
 <20130131230455.GN27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:04:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U18nN-0004EE-DX
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 06:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab3BAFDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 00:03:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55150 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab3BAFDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 00:03:47 -0500
Received: (qmail 17706 invoked by uid 107); 1 Feb 2013 05:05:10 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 00:05:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 00:03:43 -0500
Content-Disposition: inline
In-Reply-To: <20130131230455.GN27340@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215203>

On Thu, Jan 31, 2013 at 03:04:55PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Maybe it is just me, but the fact that accessing the manpage is now:
> >
> >   man gitremote-helpers
> >
> > feels weird to me. I know it technically follows our syntactic rules,
> > but having the lack of dash be significant between "git" and "remote",
> > but then having a dash later makes it hard on the eyes.
> 
> Yes.  I have thought for years that it should be git-remote-helpers,
> that "git help" should be tweaked to look for that, and that the
> existing gitrepository-layout and friends should be replaced with
> redirects.

What was the original rationale for the "gitfoo" form? Was it just to
visually distinguish command manpages from non-command manpages? I can't
remember the origins now. It does seem like it is causing more
hassle than it is worth, but maybe there is something I am forgetting.

-Peff
