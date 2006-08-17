From: Nicolas Pitre <nico@cam.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Thu, 17 Aug 2006 14:15:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608171413160.11359@localhost.localdomain>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com>
 <20060817040719.GC18500@spearce.org>
 <Pine.LNX.4.63.0608170943470.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0608171003020.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <9e4733910608170736y4863e0ebr55c6c822ae548cca@mail.gmail.com>
 <Pine.LNX.4.63.0608171738490.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0608171220260.11359@localhost.localdomain>
 <9e4733910608171022w25886d13ka40e5752fec4680b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 20:16:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDmPP-0002BT-Pn
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 20:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWHQSPy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 14:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWHQSPy
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 14:15:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53179 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932483AbWHQSPy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 14:15:54 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J4500IBYMQHBI80@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 17 Aug 2006 14:15:53 -0400 (EDT)
In-reply-to: <9e4733910608171022w25886d13ka40e5752fec4680b@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25601>

On Thu, 17 Aug 2006, Jon Smirl wrote:

> On 8/17/06, Nicolas Pitre <nico@cam.org> wrote:
> > Nah.  The only overhead for a server to feed an "old" pack format from a
> > "new" pack file is to inflate and deflate some data.  That is not _that_
> > costly.
> 
> It is costly because the Mozilla pack is going to inflate from 295MB
> to 845MB. It will take you much longer to download an extra 500MB than
> upgrading your client would take.

I didn't say it isn't costly.  I said that it isn't _that_ costly to the 
point of bringing down a server.


Nicolas
