From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Thu, 26 May 2016 12:23:48 -0400
Message-ID: <20160526162348.GA18210@sigill.intra.peff.net>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160518181500.GD5796@sigill.intra.peff.net>
 <b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
 <vpq8tz0hd2g.fsf@anie.imag.fr>
 <20160526043607.GB6756@sigill.intra.peff.net>
 <xmqqmvncyera.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, stefan@sevenbyte.org,
	jrnieder@gmail.com, rybak.a.v@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:24:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5y4i-0003XX-V4
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbcEZQXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:23:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:44646 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753900AbcEZQXw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:23:52 -0400
Received: (qmail 4608 invoked by uid 102); 26 May 2016 16:23:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:23:51 -0400
Received: (qmail 19901 invoked by uid 107); 26 May 2016 16:23:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:23:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 12:23:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvncyera.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295662>

On Thu, May 26, 2016 at 09:18:17AM -0700, Junio C Hamano wrote:

> >   1. Somebody produces a patch flipping the default. The patch is
> >      trivial, but the commit message should tell why, and try to dig up
> >      any possible problems we might see (e.g., why wasn't this the
> >      default? Particular versions of tools? Some platforms?)
> [...]
> There was no particular "caveat" raised there to recommend against
> using this on particular versions of tools or platforms.  It was
> inertia that has kept the new optional feature "optional".

Thanks for digging. That matches my recollection and the limited
research I did more recently.

> >   2. Assuming no problems, Junio merges the patch to "next". We get
> >      any reports of issues from people using "next" day-to-day.
> 
> So I can do these steps myself up to this point.  After waiting for
> a few days to see if somebody else with better memory tells me what
> I forgot, perhaps.

OK. I was trying to see if (1) could be low-hanging fruit for any of the
newcomers, but at this point it probably makes sense for you to just
write the patch.

-Peff
