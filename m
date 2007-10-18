From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Thu, 18 Oct 2007 15:33:22 +0200
Message-ID: <20071018133322.GC3917@planck.djpig.de>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <20071017190646.GC9041@planck.djpig.de> <98FA3712-B4E5-499A-B3E5-818FC33833DA@silverinsanity.com> <20071018050456.GD14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 15:34:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiVVi-0003yS-Rj
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 15:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbXJRNdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 09:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933232AbXJRNdk
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 09:33:40 -0400
Received: from planck.djpig.de ([85.10.192.180]:4218 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933226AbXJRNdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 09:33:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id B41D688231;
	Thu, 18 Oct 2007 15:33:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ySOmT4PYbEJg; Thu, 18 Oct 2007 15:33:28 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 61CC688235; Thu, 18 Oct 2007 15:33:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071018050456.GD14735@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61528>

On Thu, Oct 18, 2007 at 01:04:56AM -0400, Shawn O. Pearce wrote:
> Brian Gernhardt <benji@silverinsanity.com> wrote:
> > On Oct 17, 2007, at 3:06 PM, Frank Lichtenheld wrote:
> > 
> > >I have this in my repo and will submit this with the other git- 
> > >cvsserver
> > >changes. I was just waiting for either Junio to return or someone else
> > >stepping up.
> > 
> > Ah.  I had missed that.  I just dug up the patch when switching to  
> > Shawn's repo gave me those old testing errors.  Had thought it had  
> > gotten lost in the shuffle.
> 
> It did.  I have your resubmit that started this thread in my INQ and
> will try to get to it today.  But if Frank has a queue of stuff I've
> missed I'd like a pointer to it so I can also try to start working
> through it.  I know I also have some other topics that Lars Hjemli
> accumlated in his tree that I still need to cherry-pick over into
> mine, but I don't see the one we are talking about in there.

Yeah, I postponed sending it to tomorrow for some days now :/

Anyway, my current queue is visible at
git://source.djpig.de/git/git-cvsserver.git cvsserver
So you can fetch and merge/cherry-pick it yourself if you prefer.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
