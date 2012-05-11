From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Change error messages in ident.c...
Date: Fri, 11 May 2012 19:13:03 -0400
Message-ID: <20120511231303.GA24611@sigill.intra.peff.net>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
 <20120510192339.GA32357@sigill.intra.peff.net>
 <20120510195646.GA18276@sigill.intra.peff.net>
 <7vehqqjpmw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 12 01:13:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSz1M-0007ZD-VU
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 01:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488Ab2EKXNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 19:13:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754621Ab2EKXNG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 19:13:06 -0400
Received: (qmail 16199 invoked by uid 107); 11 May 2012 23:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 19:13:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 19:13:03 -0400
Content-Disposition: inline
In-Reply-To: <7vehqqjpmw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197705>

On Fri, May 11, 2012 at 03:53:43PM -0700, Junio C Hamano wrote:

> >> I am also tempted to suggest that we simply replace the static buffers
> >> with dynamic strbufs. I guess that may open up new vectors for an
> >> attacker to convince git to allocate arbitrary amounts of memory, but
> >> that is already pretty easy to do, so I doubt it's a big deal.
> >
> > For reference, that patch would look like something like this:
> 
> Looks quite straight-forward and readable, I would say.  Not only you gave
> us a legitimate excuse to get rid of the humourous messages, you lifted
> most of the artificial limitations ('domainname' limit is still there but
> that is not anything new) and use of strlcpy(), the last of which is a
> huge win from my point of view ;-)

Thanks. I'll re-roll with a commit message, and a follow-on patch to fix
the "you don't exist" message. But probably tomorrow, as I am just
finishing gitting for the day.

-Peff
