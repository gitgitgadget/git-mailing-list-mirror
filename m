From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 16:11:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221609250.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
 <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221548310.6741@xanadu.home>
 <20090422200502.GA14304@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwipV-0008VQ-AU
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZDVULw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZDVULw
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:11:52 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23902 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbZDVULv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:11:51 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII004L4QRKK990@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 16:11:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090422200502.GA14304@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117250>

On Wed, 22 Apr 2009, Jeff King wrote:

> On Wed, Apr 22, 2009 at 04:00:06PM -0400, Nicolas Pitre wrote:
> 
> > And what would be the point of manually running 'git gc' then, given 
> > that 'git gc --auto' is already invoked automatically after most commit 
> > creating commands?
> > 
> > I mean, if you consider explicit 'git gc' too long, then simply wait 
> > until you can spare the time, if at all.  This is not like a non gc'd 
> > repository suddently becomes non functional.
> 
> The other tradeoff, mentioned by Matthieu, is not about speed, but about
> rollover of files on disk. I think he would be in favor of a less
> optimal pack setup if it meant rewriting the largest packfile less
> frequently.
> 
> However, it may be reasonable to suggest that he just not manually "gc"
> then. If he is not generating enough commits to warrant an auto-gc, then
> he is probably not losing much by having loose objects. And if he is,
> then auto-gc is already taking care of it.

My point exactly.

And those people savvy enough to automate 'git gc' nightly should be 
able to cope with .keep files as well.


Nicolas
