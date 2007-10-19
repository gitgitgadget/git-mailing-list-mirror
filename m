From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:38:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182328580.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <alpine.LFD.0.9999.0710182247130.19446@xanadu.home>
 <20071019031737.GD14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:39:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiii6-0001UX-UI
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934165AbXJSDjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759232AbXJSDjD
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:39:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63686 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbXJSDjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:39:01 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ5005CQ3GZFTM0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:39:00 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019031737.GD14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61635>

On Thu, 18 Oct 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 18 Oct 2007, Shawn O. Pearce wrote:
> > 
> > > I really don't have an opinion either way.  Actually I think the
> > > entire progress system of git-pack-objects should be reduced even
> > > further so that users aren't exposed to the internal phases we
> > > are going through.  Most of them just don't care.  They just
> > > want to know when its going to be done[*1*].
> > 
> > Well, with my latest patches in that area, the typical progress on 
> > screen has been cut in half.  And the different phases are intertaining.
> 
> Yup.  Your patches were a big improvement.  But I'm now sitting here
> wondering if we shouldn't just allow a progress meter to overwrite
> the prior one.  Then you only see the current task and progress,
> or the final output if we have nothing further to say about that.

And then you've lost some diagnostic clue (the absolute numbers) about 
the actual number of objects that were listed for "deltification" for 
example.

And imagine that you see the progress moving slowly because the remote 
server is a NSLU2, but it says 80%.  Then you go for a coffee and the 
progress says 20% when you return because it now has moved to a 
different phase.  Rather counter intuitive.


Nicolas
