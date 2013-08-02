From: Jeff King <peff@peff.net>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 10:28:04 -0700
Message-ID: <20130802172804.GB11329@sigill.intra.peff.net>
References: <20130801201842.GA16809@kitenet.net>
 <20130802064003.GB3013@elie.Belkin>
 <20130802105402.GA25697@sigill.intra.peff.net>
 <20130802115906.GA9183@sigill.intra.peff.net>
 <7vtxj8oxin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 19:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5J9G-0002rW-C1
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 19:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab3HBR2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 13:28:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:39516 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab3HBR2O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 13:28:14 -0400
Received: (qmail 18720 invoked by uid 102); 2 Aug 2013 17:28:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Aug 2013 12:28:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Aug 2013 10:28:04 -0700
Content-Disposition: inline
In-Reply-To: <7vtxj8oxin.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231533>

On Fri, Aug 02, 2013 at 09:41:52AM -0700, Junio C Hamano wrote:

> > Of the two, I think the latter is more sensible; the former is
> > unnecessarily placing the burden on the user to match "--split" with
> > their use of "%(rest)". The second is pointless without the first.
> >
> > A patch to implement (2) is below.
> 
> As I'd queue this on top of the revert, I had to wrangle it a bit to
> make it relative, i.e. "this resurrects what the other reverted
> patch did but in a weaker/safer form".

Yeah, sorry. After doing the patch I had the thought that maybe the
least invasive thing would be the fix rather than the straight revert
(we are counting on my assertion that just reverting out part of the
series will be OK; I'm pretty sure that is the case, but it is not
risk-free, either).

I didn't see the result of your wrangling in pu, but I will keep an eye
out to double-check it (unless you did not finish, in which case I am
happy to do the wrangling myself).

-Peff
