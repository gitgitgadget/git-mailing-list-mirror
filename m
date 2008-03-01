From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects
 for sooner
Date: Sat, 1 Mar 2008 11:33:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803011127490.19665@iabervon.org>
References: <20080228084257.GC16870@spearce.org> <7v3arcduil.fsf@gitster.siamese.dyndns.org> <20080229223431.GT8410@spearce.org> <alpine.LNX.1.00.0802291736580.19665@iabervon.org> <20080301042510.GW8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 17:34:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVUeu-0001sB-Ib
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 17:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182AbYCAQdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755823AbYCAQdX
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 11:33:23 -0500
Received: from iabervon.org ([66.92.72.58]:60514 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbYCAQdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 11:33:23 -0500
Received: (qmail 5600 invoked by uid 1000); 1 Mar 2008 16:33:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Mar 2008 16:33:21 -0000
In-Reply-To: <20080301042510.GW8410@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75685>

On Fri, 29 Feb 2008, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Fri, 29 Feb 2008, Shawn O. Pearce wrote:
> > 
> > > Junio C Hamano <gitster@pobox.com> wrote:
> > > > This is cute.  Obviously some tests need to be adjusted for this
> > > > change, though.
> > > 
> > > I'll take a look at the current tests this weekend and see what
> > > needs to be adjusted, if anything.  I'd also like to get a few
> > > tests written for this, so we are certain the optimizations are
> > > kicking in when they are supposed to be.
> > 
> > I'd be really grateful if you came up with a good general strategy for 
> > testing that we're not doing too much work in fetching, because clone has 
> > optimizations that I need to test in a similar way, and I haven't been 
> > able to think of anything not horribly intrusive.
> 
> Is this "horribly intrusive" ?
> 
> We can test it with something like this:

That looks suitable to me (although maybe the environment variable should 
contain the fd to write to?). I also want to know the "have" info, so I 
can verify that the client is listing things appropriately, but that's an 
obvious addition.

	-Daniel
*This .sig left intentionally blank*
