From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 15:14:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221509550.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
 <vpqws9cd06b.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <casey@nrlssc.navy.mil>, Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:16:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwhvR-0002Lg-W5
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843AbZDVTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbZDVTOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:14:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21544 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbZDVTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:14:25 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII0096SO3U0410@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 15:14:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <vpqws9cd06b.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117233>

On Wed, 22 Apr 2009, Matthieu Moy wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Why so?  Having fewer packs is always a good thing.  Having only one 
> > pack is of course the optimal situation. 
> 
> Good and optimal wrt Git, but not wrt an incremental backup system for
> example.

This goes without saying that git should optimize for its own usage by 
default, and not for a particular backup system.

> I have a "git gc" running daily in a cron job in each of my
> repositories, but to be nice with my sysadmin, I don't want to rewrite
> tens of megabytes of data each night just because I commited a 2 lines
> patch somewhere.

Just add a .keep file along side your .pack file after repacking.


Nicolas
