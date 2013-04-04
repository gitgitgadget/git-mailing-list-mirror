From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 4 Apr 2013 16:54:23 -0400
Message-ID: <20130404205423.GA25986@sigill.intra.peff.net>
References: <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
 <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
 <20130307185046.GA11622@sigill.intra.peff.net>
 <20130404203344.GA25330@sigill.intra.peff.net>
 <20130404204944.GB4913@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>, kernel@pengutronix.de
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrBT-00008w-8q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761464Ab3DDUya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 16:54:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760820Ab3DDUy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:54:29 -0400
Received: (qmail 7037 invoked by uid 107); 4 Apr 2013 20:56:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 16:56:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 16:54:23 -0400
Content-Disposition: inline
In-Reply-To: <20130404204944.GB4913@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220101>

On Thu, Apr 04, 2013 at 10:49:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:

> On Thu, Apr 04, 2013 at 04:33:44PM -0400, Jeff King wrote:
> > [...]
> > So I do think zdiff3 is useful, and I plan to continue using it.
> Thanks for your description. I'm using and liking zdiff3, too. So I'd
> really like seeing it in vanilla git.

I don't know if Junio is interested in taking a patch with the concept
or not, but as I recall, your patch needed at least a documentation
update before it could be picked up. Unless Junio wants to say "no, I a=
m
not interested at all", I think the next step would be to repost an
updated version.

-Peff
