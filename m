From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: respect advice.statusHints for ahead/behind
 advice
Date: Mon, 3 Dec 2012 13:32:43 -0500
Message-ID: <20121203183243.GA25526@sigill.intra.peff.net>
References: <20121203061656.GA20164@sigill.intra.peff.net>
 <7vr4n7rrgb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfapR-0005Gu-QU
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 19:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab2LCScz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 13:32:55 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51059 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab2LCScy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 13:32:54 -0500
Received: (qmail 30298 invoked by uid 107); 3 Dec 2012 18:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Dec 2012 13:33:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Dec 2012 13:32:43 -0500
Content-Disposition: inline
In-Reply-To: <7vr4n7rrgb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211049>

On Mon, Dec 03, 2012 at 09:11:32AM -0800, Junio C Hamano wrote:

> > On top of mm/status-push-pull-advise.
> >
> > I left "git checkout" alone, though I'd also like to turn it off there,
> > too. Should it get a separate advice option there? Should it simply
> > respect statusHints (it seems odd because I know that "status" there
> > means "git status", not "hints about the status of your repo")?
> 
> I agree that we should have a toggle to turn it off and I think it
> is OK to reuse the same "hints about the status" option for this
> purpose.  It is not like there is a released version that already
> gives the advice (possibly with some other option to turn it off)
> and you are changing the behaviour of "checkout" by suddenly making
> it honor statusHints advice.
> 
> So let's do a lot simpler patch instead.
> 
> -- >8 --

Perfect, thanks.

-Peff
