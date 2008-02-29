From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/4] Make git-fetch follow tags we already have objects
 for sooner
Date: Fri, 29 Feb 2008 17:39:58 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802291736580.19665@iabervon.org>
References: <20080228084257.GC16870@spearce.org> <7v3arcduil.fsf@gitster.siamese.dyndns.org> <20080229223431.GT8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:40:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVDuB-0002VL-Sn
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934010AbYB2WkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934024AbYB2WkA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:40:00 -0500
Received: from iabervon.org ([66.92.72.58]:58606 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934010AbYB2Wj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:39:59 -0500
Received: (qmail 15111 invoked by uid 1000); 29 Feb 2008 22:39:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Feb 2008 22:39:58 -0000
In-Reply-To: <20080229223431.GT8410@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75581>

On Fri, 29 Feb 2008, Shawn O. Pearce wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
> > This is cute.  Obviously some tests need to be adjusted for this
> > change, though.
> 
> I'll take a look at the current tests this weekend and see what
> needs to be adjusted, if anything.  I'd also like to get a few
> tests written for this, so we are certain the optimizations are
> kicking in when they are supposed to be.

I'd be really grateful if you came up with a good general strategy for 
testing that we're not doing too much work in fetching, because clone has 
optimizations that I need to test in a similar way, and I haven't been 
able to think of anything not horribly intrusive.

	-Daniel
*This .sig left intentionally blank*
