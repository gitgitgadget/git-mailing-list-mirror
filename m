From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 17:05:06 -0400
Message-ID: <20111014210506.GA16226@sigill.intra.peff.net>
References: <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014192741.GA13029@sigill.intra.peff.net>
 <7v7h47z5i0.fsf@alter.siamese.dyndns.org>
 <20111014203438.GA15643@sigill.intra.peff.net>
 <7vpqhzxpsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 23:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REowQ-0003YP-2m
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523Ab1JNVFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:05:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60880
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab1JNVFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 17:05:10 -0400
Received: (qmail 15068 invoked by uid 107); 14 Oct 2011 21:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 17:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 17:05:06 -0400
Content-Disposition: inline
In-Reply-To: <7vpqhzxpsc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183611>

On Fri, Oct 14, 2011 at 01:48:51PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It would have been a better split to have the 1/2 patch to support both
> >> informative and uninformative errors, with the default to say "access
> >> denied", and 2/2 to flip the default to be more open.
> >
> > Isn't that what I did? It was what I meant to do, anyway...
> >
> > Or did you mean the options would have been better worded as:
> >
> >   --errors={terse,informative}
> >
> > or something similar?
> 
> Nothing that elaborate.
> 
> Supporting --no-* variant even when the default is already no will allow
> people to prepare their daemon invocation command line beforehand to ensure
> that they won't be affected to a more lenient default that may or may not
> come in the future.  That's all.

Oh. Then look again at 1/2. It supports both forms; I just didn't bother
advertising the --no form in the manpage, since it was the default.

-Peff
