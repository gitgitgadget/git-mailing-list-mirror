From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sun, 7 Oct 2012 18:25:03 -0400
Message-ID: <20121007222502.GA3263@sigill.intra.peff.net>
References: <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
 <20121006131200.GB11712@sigill.intra.peff.net>
 <7vvcenqx39.fsf@alter.siamese.dyndns.org>
 <20121006183026.GA3644@sigill.intra.peff.net>
 <CAOTq_pu=xWF7q3QobxSerkkbV56n5o+CPQSyHg8onwv73v25+A@mail.gmail.com>
 <20121006190753.GA5648@sigill.intra.peff.net>
 <7vr4paovjq.fsf@alter.siamese.dyndns.org>
 <20121007214958.GC1743@sigill.intra.peff.net>
 <7vehl9q5uk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Conrad Irwin <conrad.irwin@gmail.com>,
	Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:25:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKzHg-0004JF-UH
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab2JGWZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 18:25:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44033 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab2JGWZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:25:05 -0400
Received: (qmail 18801 invoked by uid 107); 7 Oct 2012 22:25:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 18:25:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 18:25:03 -0400
Content-Disposition: inline
In-Reply-To: <7vehl9q5uk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207205>

On Sun, Oct 07, 2012 at 03:23:31PM -0700, Junio C Hamano wrote:

> >> Yeah, I agree with the reasoning.  This is an unessential feature
> >> that is with the problem for a long time, so let's go the route #1
> >> first before we do anything else.
> >
> > OK. I think Conrad's patch takes us most of the way there. I had a few
> > minor comments, but I think another round should do it. Conrad?
> 
> I'd rather want to see a patch that _only_ documents the current
> behaviour to unconfuse people first.  I definitely do not want any
> patch that changes the command line parsing or any other behaviour
> change with problems that have to take time from reviewers to point
> them out mixed in it.

Sorry, I should have been more clear. I want to see a re-roll of only
the documentation bits of Conrad's patch, for which I had only minor
comments. The code part had major problems. :)

-Peff
