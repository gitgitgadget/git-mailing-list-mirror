From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 16:07:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221601200.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
 <vpqws9cd06b.fsf@bauges.imag.fr>
 <20090422190856.GB13424@coredump.intra.peff.net>
 <I5p8gPPuE_qW2RDhwiqxCWDuMtnuvvgtSkeTkxby6rlj_FKtpERaBA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:09:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwikt-0006gE-Ck
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527AbZDVUHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756457AbZDVUHj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:07:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14795 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbZDVUHi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:07:38 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII00415QKDK990@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 16:07:26 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <I5p8gPPuE_qW2RDhwiqxCWDuMtnuvvgtSkeTkxby6rlj_FKtpERaBA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117249>

On Wed, 22 Apr 2009, Brandon Casey wrote:

> But isn't git-gc supposed to be the "high-level" command that just does
> the right thing?  It doesn't seem to me to be outside the scope of this
> command to make a decision about trading off speed/io for optimal repo
> layout.  In fact, it does do this already.  The default window, depth and
> compression settings are chosen to be "good enough", not to produce the
> absolute optimum repo.

Exact.

> I'm just pointing out that everything is a trade off.  So I think saying
> something like "gc must optimize for git's performance" is not entirely
> accurate.  We make tradeoffs now.  Other tradeoffs may be helpful.

Git makes tradeoffs for itself.  Trying to optimize by _default_ for 
some random backup system, or any other environmental component not 
involved in git usage, is completely silly.

> Also, don't interpret my comments as me being convinced that a change to
> gc should be made.  It's a trivial patch, but I'm not yet certain one
> way or the other.

Be free to interpret my replies as me being certain of not doing such a 
change.


Nicolas
