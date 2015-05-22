From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: add `--seed` shorthand
Date: Fri, 22 May 2015 02:50:22 -0400
Message-ID: <20150522065022.GB27716@peff.net>
References: <20150521041435.GA18978@peff.net>
 <20150521041619.GC5196@peff.net>
 <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 22 08:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvgms-0004CV-KU
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbbEVGu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:50:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:34501 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbbEVGuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:50:25 -0400
Received: (qmail 17131 invoked by uid 102); 22 May 2015 06:50:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 01:50:25 -0500
Received: (qmail 12460 invoked by uid 107); 22 May 2015 06:50:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 02:50:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 02:50:22 -0400
Content-Disposition: inline
In-Reply-To: <8895881cd3f324d2b8a827e311296a48@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269696>

On Thu, May 21, 2015 at 06:05:31PM +0200, Johannes Schindelin wrote:

> > +--seed <repository>::
> > +	A convenient shorthand for `--dissociate --reference=<repository>`.
> > +
> 
> Since you want to advertise this as an easier way than `--dissociate --reference=<repository>`, it might make sense to avoid sending the reader that way, too.
> 
> Maybe something like
> 
> --seed <repository>::
>     Fetch objects from <repository> instead of the clone URL when
>     possible. This is useful when a (possibly partial) clone already
>     exists locally, to avoid transferring the same objects again.

Yeah, I agree that is much better (it's the "4/3" I suggested in the
cover letter).

-Peff
