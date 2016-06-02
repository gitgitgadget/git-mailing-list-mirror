From: Jeff King <peff@peff.net>
Subject: Re: Mark remote `gc --auto` error messages
Date: Thu, 2 Jun 2016 18:04:55 -0400
Message-ID: <20160602220454.GA17202@sigill.intra.peff.net>
References: <146489432847.688.11121862368709034386@typhoon>
 <xmqqinxrtmgi.fsf@gitster.mtv.corp.google.com>
 <146489800609.1944.4398103814754920753@typhoon.lan>
 <CAPc5daXVx1=ptsKJEfEzXbjCNvwYxjAPyp_pob9CeR+Qr3tG_g@mail.gmail.com>
 <20160602214834.GB13356@sigill.intra.peff.net>
 <xmqqmvn3s148.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 00:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aje-0003jS-Go
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 00:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbcFBWE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 18:04:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:48071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932775AbcFBWE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 18:04:58 -0400
Received: (qmail 6532 invoked by uid 102); 2 Jun 2016 22:04:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 18:04:57 -0400
Received: (qmail 14855 invoked by uid 107); 2 Jun 2016 22:05:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 18:05:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 18:04:55 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmvn3s148.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296247>

On Thu, Jun 02, 2016 at 02:59:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So the greater question is not "should this output be marked" but
> > "should auto-gc data go over the sideband so that all clients see it
> > (and any server-side stderr does not)". And I think the answer is
> > probably yes. And that fixes the "remote: " thing as a side effect.
> 
> Thanks for stating this a lot more clearly than I could, and I agree
> that sending this to the other side regardless of the protocol is
> the right thing.  I somehow doubt that server operators would check
> Apache logs to decide when to do a proper GC, so I do not consider
> it a true loss ;-)

I definitely agree. I'd wonder more about "would they want their users
to see these details". I dunno. I am only intimately familiar with one
git hosting site, and we turn off auto-gc completely.

-Peff
