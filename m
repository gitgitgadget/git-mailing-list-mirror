From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Fri, 19 Oct 2007 07:58:51 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710190753040.19446@xanadu.home>
References: <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <20071019023425.GB8298@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
 <20071019030749.GA9274@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182312160.19446@xanadu.home>
 <20071019033228.GA10697@coredump.intra.peff.net>
 <alpine.LFD.0.9999.0710182340550.19446@xanadu.home>
 <20071019035647.GA18717@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710182111030.26902@woody.linux-foundation.org>
 <20071019042930.GA16487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 14:03:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IiqZG-0000ie-KD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 14:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbXJSL6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 07:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757991AbXJSL6y
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 07:58:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45040 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758238AbXJSL6x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 07:58:53 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ500G06QM3YS70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Oct 2007 07:58:52 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019042930.GA16487@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61693>

On Fri, 19 Oct 2007, Jeff King wrote:

> On Thu, Oct 18, 2007 at 09:21:55PM -0700, Linus Torvalds wrote:
> 
> > I'd love it, but the way our current SHA1 parser works, I don't think it 
> > can really do it.
> > 
> > Basically, we currently assume that a SHA1 expression always expands to a 
> > *single* SHA1.
> 
> Ah, right. I hadn't thought of that. While it would be a nice
> convenience feature, it's probably not worth the deep internal hackery
> that would be required.

What about a preprocessor that could match <1>@{<2>..<3>} in the 
argument list and substitute that with <1>@{<2>}..<1>@{<3>} before it is 
actually parsed?


Nicolas
