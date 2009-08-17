From: Jeff King <peff@peff.net>
Subject: Re: How to stop sharing objects between repositories
Date: Mon, 17 Aug 2009 03:50:12 -0400
Message-ID: <20090817075012.GA3437@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
 <20090816122842.GA942@sigill.intra.peff.net>
 <alpine.DEB.1.00.0908161429590.8306@pacific.mpi-cbg.de>
 <20090816135703.GA31638@coredump.intra.peff.net>
 <7vmy5z603d.fsf@alter.siamese.dyndns.org>
 <1250475682.7155.16.camel@marge.simson.net>
 <20090817064801.GA31543@coredump.intra.peff.net>
 <7v63cm3ntl.fsf@alter.siamese.dyndns.org>
 <20090817072559.GA9730@coredump.intra.peff.net>
 <7v1vna3nae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <efault@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jon Jensen <jon@endpoint.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 09:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcwz1-0001XG-8c
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 09:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757065AbZHQHuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 03:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757063AbZHQHuN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 03:50:13 -0400
Received: from peff.net ([208.65.91.99]:60219 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbZHQHuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 03:50:12 -0400
Received: (qmail 29134 invoked by uid 107); 17 Aug 2009 07:50:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 17 Aug 2009 03:50:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Aug 2009 03:50:12 -0400
Content-Disposition: inline
In-Reply-To: <7v1vna3nae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126134>

On Mon, Aug 17, 2009 at 12:35:53AM -0700, Junio C Hamano wrote:

> > Did you miss the part where I asked "should we include instructions to
> > the user on how to fix this"?
> 
> Actually, I didn't.  It is very hard to lose data once you put it in git;
> "by following recovery insn the user can redo" is often trivially correct
> thanks to it.
> 
> But it is not a very good option to cause the damage and then give
> recovery insn.  The user might have ran out of quota, and even if he
> didn't, he wasted needless cycles for the unwanted sort of repacking.

OK, let's forget the warning, then. Hopefully between the note under
"clone -s" and the fact that most people should be using "git gc" these
days, it won't be a big issue.

-Peff
