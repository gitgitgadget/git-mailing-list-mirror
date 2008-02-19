From: Jeff King <peff@peff.net>
Subject: Re: [PATCH(TIC)] push: annoy all users by deprecating the default
	semantics
Date: Tue, 19 Feb 2008 12:05:07 -0500
Message-ID: <20080219170507.GA1144@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <20080219150826.GA24499@sigill.intra.peff.net> <76718490802190718t5e70abb2x8f96fc7154576594@mail.gmail.com> <20080219152549.GC24499@sigill.intra.peff.net> <alpine.LSU.1.00.0802191610480.30505@racer.site> <20080219163743.GA31668@sigill.intra.peff.net> <alpine.LSU.1.00.0802191651550.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Jason Garber <jgarber@ionzoft.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVub-0007Tp-Qn
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 18:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbYBSRFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 12:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbYBSRFK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 12:05:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1650 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700AbYBSRFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 12:05:09 -0500
Received: (qmail 23756 invoked by uid 111); 19 Feb 2008 17:05:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 12:05:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 12:05:07 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802191651550.30505@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74439>

On Tue, Feb 19, 2008 at 04:54:14PM +0000, Johannes Schindelin wrote:

> > Just say "git push origin HEAD"?
> 
> The point is: if that becomes the default (with a certain config option), 
> people will get used to typing "git push".  They will not even _know_ 
> about the explicit form.

I guess I hoped that people giving answers on the IRC channel would be a
little less clueless. Perhaps that is just optimism.

> See followup.

I'm actually starting to like your patch now...;)

> BTW if that is really the way to go, we will have to have a _long_ period 
> (I am talking about 6-12 _months_ if not more) where there _must not_ be a 
> default action for git-push.  Otherwise people _will_ get more confused 
> than necessary.

I agree that it would need a long deprecation period to change behavior.
It would almost be easier to have a "git <foo>" command where <foo> is
some sort of restricted, safe-for-certain-workflows version of push.

-Peff
