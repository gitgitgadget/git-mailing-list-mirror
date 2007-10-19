From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:24:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiTo-0008AX-6u
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760580AbXJSDYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759939AbXJSDYm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:24:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49725 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759620AbXJSDYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:24:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ50029B2T55MV0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:24:41 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019030749.GA9274@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61629>

On Thu, 18 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 11:01:02PM -0400, Nicolas Pitre wrote:
> 
> > Maybe the "Removing unused objects" should use the common progress 
> > infrastructure?  It could even use the delayed interface, just like when 
> > checking out files, so no progress at all is displayed when that 
> > operation completes within a certain delay.  And the removal of unused 
> > objects is usually quick.
> 
> Are you volunteering (I think you know the progress code best)?
> Otherwise, I will get to it, but probably not tonight.

If I do it that won't be today either.

> > But I like the statistics.  They might be pretty handy to diagnoze 
> > performance issues on remote servers for example.
> 
> They are by far the most useful of the three lines I mentioned, but I
> just wonder if they are a bit meaningless and cluttery for light users.
> We can always cut the others and see how it looks.

Frankly, I think effort should be spent on the refs update display at 
this point.  Something that looks like:

* refs/heads/origin: fast forward to branch 'master' of git://gi
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
  old..new: 66ffb04..4fa4d23

[ note that I arbitrarily cut the long line before the 80th column to 
  show the effect within an email ]

You usually get long lines that gets wrapped, so that means 3 lines of 
screen space for one updated branches.  Is the "66ffb04..4fa4d23" 
information really useful?  Might someone ever care?


Nicolas
