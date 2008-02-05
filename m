From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/9] Send unpack-trees debugging output to stderr
Date: Tue, 5 Feb 2008 15:38:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802042118420.13593@iabervon.org>
References: <alpine.LNX.1.00.0802041335430.13593@iabervon.org> <alpine.LSU.1.00.0802050117410.8543@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMUZT-0003vl-Qq
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 21:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757763AbYBEUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 15:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757728AbYBEUij
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 15:38:39 -0500
Received: from iabervon.org ([66.92.72.58]:48613 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYBEUii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 15:38:38 -0500
Received: (qmail 9439 invoked by uid 1000); 5 Feb 2008 20:38:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 20:38:35 -0000
In-Reply-To: <alpine.LSU.1.00.0802050117410.8543@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72692>

On Tue, 5 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 4 Feb 2008, Daniel Barkalow wrote:
> 
> >  #if DBRT_DEBUG > 1
> >  		if (first)
> > -			printf("index %s\n", first);
> > +			fprintf(stderr, "index %s\n", first);
> >  #endif
> 
> This code path is only affected when DBRT_DEBUG is defined ("Daniel 
> Barkalow's Roasted Tomatoes"?).  So technically, I do not really see why 
> this is part of this patch series...

"Daniel Barkalow's read_tree" (which is what that code was called when it 
was added). I needed to enable this debugging in order to debug this 
series, and found that enabling debugging caused tests to fail, so I fixed 
that in the series. To the extent that this matters at all, having it in 
the series that could need debugging makes sense.

	-Daniel
*This .sig left intentionally blank*
