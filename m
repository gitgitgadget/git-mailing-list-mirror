From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Wed, 15 Dec 2010 23:23:04 -0500
Message-ID: <20101216042304.GA886@sigill.intra.peff.net>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
 <alpine.DEB.1.10.1012151931030.25560@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 05:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PT5Ng-0000dj-UX
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 05:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab0LPEXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 23:23:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38117 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0LPEXI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 23:23:08 -0500
Received: (qmail 29494 invoked by uid 111); 16 Dec 2010 04:23:06 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 16 Dec 2010 04:23:06 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Dec 2010 23:23:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012151931030.25560@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163800>

On Wed, Dec 15, 2010 at 08:44:45PM +0100, Martin von Zweigbergk wrote:

> > One note:
> > 
> > >  		color.diff
> > >  		color.diff.commit
> > >  		color.diff.frag
> > > +		color.diff.func
> > >  		color.diff.meta
> > >  		color.diff.new
> > >  		color.diff.old
> > >  		color.diff.plain
> > >  		color.diff.whitespace
> > 
> > We have color.diff.branch coming soon (I think it is in 'next' now).
> 
> Strictly speaking, that note is for Junio to think of when he merges,
> right? But adding it early is pretty harmless and if that relieves him
> of some work, I would be happy to add it in the next submission of
> this patch. Is that better?
> 
> Thinking a bit more, maybe what you are suggesting is that I base the
> next revision of this patch on the branch that adds that variable?

The "correct" thing to do from a topic branch standpoint is to submit
this patch without it as its own topic, submit a patch with just
color.diff.branch on top of the other topic, and then the merge
resolution will include both sets.

In this case, it might be OK to just start shipping color.diff.branch in
the completion list. It doesn't hurt anything to have the extra
completion before the feature is in, and the feature seems very likely
to make it in soon.

But I'll let Junio decide how meticulous about history he wants to be.
:)

-Peff
