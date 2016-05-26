From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Thu, 26 May 2016 12:39:10 -0400
Message-ID: <20160526163910.GA18597@sigill.intra.peff.net>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160518181500.GD5796@sigill.intra.peff.net>
 <b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
 <vpq8tz0hd2g.fsf@anie.imag.fr>
 <20160526043607.GB6756@sigill.intra.peff.net>
 <xmqqmvncyera.fsf@gitster.mtv.corp.google.com>
 <20160526162348.GA18210@sigill.intra.peff.net>
 <xmqqbn3sydvk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, stefan@sevenbyte.org,
	jrnieder@gmail.com, rybak.a.v@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:39:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yJa-0001L3-7m
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbcEZQjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:39:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:44680 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752915AbcEZQjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:39:14 -0400
Received: (qmail 5289 invoked by uid 102); 26 May 2016 16:39:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:39:12 -0400
Received: (qmail 20111 invoked by uid 107); 26 May 2016 16:39:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:39:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 12:39:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn3sydvk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295666>

On Thu, May 26, 2016 at 09:37:19AM -0700, Junio C Hamano wrote:

> >> There was no particular "caveat" raised there to recommend against
> >> using this on particular versions of tools or platforms.  It was
> >> inertia that has kept the new optional feature "optional".
> >
> > Thanks for digging. That matches my recollection and the limited
> > research I did more recently.
> 
> For completeness's sake I should point out that the discussion on
> the first thread did point out some version-dependent issues.  But
> with 79c461d5 (docs: default to more modern toolset, 2010-11-19), we
> declared the problematic versions obsolete; I suspect that it is
> safe to assume that those who would be hurt by flipping the default
> would already be extinct after 6 years since then.

Yeah, I'd agree, though that may be worth mentioning in the commit
message.

> > OK. I was trying to see if (1) could be low-hanging fruit for any of the
> > newcomers, but at this point it probably makes sense for you to just
> > write the patch.
> 
> Leaving it as low-hanging fruit is actually a good idea.
> 
> I was thinking about flipping it in Meta/dodoc.sh, which would
> update the git-manpages.git repository whose mirrors are found at

Ah, right. I was thinking that the patch would go to "master" first, but
there is no reason it could not be flipped independently for your build
process.

-Peff
