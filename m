From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 16:36:49 -0400
Message-ID: <20150527203648.GE14309@peff.net>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
 <20150527072218.GB6898@peff.net>
 <xmqqa8wpn910.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 22:36:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxi4O-0007fU-FX
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbbE0Ugw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:36:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:36851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751575AbbE0Ugv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:36:51 -0400
Received: (qmail 12783 invoked by uid 102); 27 May 2015 20:36:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 15:36:51 -0500
Received: (qmail 10235 invoked by uid 107); 27 May 2015 20:36:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:36:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 16:36:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8wpn910.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270087>

On Wed, May 27, 2015 at 11:57:15AM -0700, Junio C Hamano wrote:

> > -- >8 --
> > Subject: diff: accept color.diff.context as a synonym for "plain"
> >
> > The term "plain" is a bit ambiguous; let's allow the more
> > specific "context", but keep "plain" around for
> > compatibility.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I didn't bother mentioning the historical "plain" in the documentation.
> > I don't know if it's better to (for people who find it in the wild and
> > wonder what it means) or if it simply clutters the description.
> 
> 'plain' does sound a misnomer, as these slot names are about "what"
> are painted, not "how" they are painted.  The latter is what their
> values represent.  Whoever named that slot was confused by the fact
> that 'context' (i.e. "what") lines are by default painted in 'plain'
> color without frills (i.e. "how").
> 
> We usually try to give a brief mention to historical names primarily
> to silence those who pick up stale information from the Web, get
> curious, and then complain loudly after finding that we no longer
> document them even though we keep accepting them silently, so I am
> somewhat tempted to do this on top.

Yeah, I waffled on doing it myself. If you take the patch, please do
squash that in.

Do you want me to also eradicate PLAIN from the code itself? It's a
rather simple change, but it does touch a lot of places.

-Peff
