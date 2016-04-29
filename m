From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 09:10:30 -0400
Message-ID: <20160429131029.GA30931@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
 <xmqqshy54j2h.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1604291429560.9313@virtualbox>
 <alpine.DEB.2.20.1604291443561.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:10:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw8Br-0000Du-5E
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 15:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbcD2NKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 09:10:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:59057 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753442AbcD2NKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 09:10:33 -0400
Received: (qmail 5066 invoked by uid 102); 29 Apr 2016 13:10:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:10:32 -0400
Received: (qmail 21435 invoked by uid 107); 29 Apr 2016 13:10:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:10:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 09:10:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1604291443561.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292995>

On Fri, Apr 29, 2016 at 02:48:44PM +0200, Johannes Schindelin wrote:

> > If you know off-hand how to teach my vim to use your preferred indenting,
> > I'll gladly just brow-beat it into submission.
> 
> For the record, I think the default in vim is to indent two tabs after an
> unclosed parenthesis in an `if` line (the "(2s" just below
> http://vimdoc.sourceforge.net/htmldoc/indent.html#javascript-indenting in
> the default cinoptions). The "(0" setting fixes this, I think, so I forced
> my vim to use
> 
> 	cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(0,us,U0,w0,W0,m0,j0,J0,)20,*70,#0
> 
> from now on.

Yeah, "(0" is the only non-default cinoption I use for git.  Other than
that, everything fits our guidelines (I guess I explicitly make sure
shiftwidth and tabstops are all at 8, but I think those are the
defaults, too).

-Peff
