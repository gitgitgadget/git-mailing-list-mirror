From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:27:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182325300.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182238470.19446@xanadu.home>
 <20071019025913.GA9227@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182306300.19446@xanadu.home>
 <20071019031535.GB9274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:28:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiWs-0000EK-8a
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934609AbXJSD14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965577AbXJSD1z
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:27:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:54011 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934587AbXJSD1x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:27:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ5000U82YHDF50@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:27:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019031535.GB9274@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61631>

On Thu, 18 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 11:11:26PM -0400, Nicolas Pitre wrote:
> 
> > I think we might sidestep the issue entirely by remaining somewhat vague 
> > and simply saying "compressing objects" for that phase.  This is the 
> > part responsible for the reduction of a Git repository from 3GB down to 
> > 200MB anyway.
> 
> OK. I liked it a little more specific, but perhaps users really don't
> care what's going on. And it seems there is some support of simply
> "compressing", so that's probably reasonable.
> 
> I think that is going to make the statistics line doubly confusing,
> though, since we never even use the word "delta" (or any wacky
> verbifications based on it), and then they get a line about numbers of
> new and reused deltas.

Well, at least the statistics are real, and we're not inventing anything 
here.


Nicolas
