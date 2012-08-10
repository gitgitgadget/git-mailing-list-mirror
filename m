From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 14:08:36 -0400
Message-ID: <20120810180836.GA29597@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 20:08:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sztdh-0002SS-IU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 20:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816Ab2HJSIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 14:08:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33858 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748Ab2HJSIo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 14:08:44 -0400
Received: (qmail 426 invoked by uid 107); 10 Aug 2012 18:08:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 14:08:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 14:08:36 -0400
Content-Disposition: inline
In-Reply-To: <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203242>

On Fri, Aug 10, 2012 at 11:06:08AM -0700, Dave Borowitz wrote:

> > I asked the folks who run code.google.com and they are indeed seeing
> > something like these in their logs:
> >
> >  >> Client asked for capability agent=git/1.7.12.rc2.79.g86c1702 that was not advertised.
> 
> FWIW, this error comes from Dulwich:
> https://github.com/jelmer/dulwich/blob/25250c1694dac343d469742aeafa139f37fc4ec6/dulwich/server.py#L196

Thanks for the data point. I knew you guys ran some custom code, so I
wasn't sure how widespread this is. The fact that other dulwich-based
servers would see the same issue makes me doubly sure that my fix is the
right direction.

> So any servers running Dulwich would be affected by this...though I'm
> not aware of any large-scale Dulwich installations other than Google
> Code.

I'd rather not break small-scale installations, either. :)

-Peff
