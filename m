From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add a message explaining that automatic GC is about to start
Date: Thu, 18 Oct 2007 20:16:48 -0400
Message-ID: <20071019001648.GO14735@spearce.org>
References: <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org> <20071018003256.GA5062@coredump.intra.peff.net> <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org> <20071018024553.GA5186@coredump.intra.peff.net> <alpine.LFD.0.999.0710171955580.26902@woody.linux-foundation.org> <20071018032307.GA7313@coredump.intra.peff.net> <20071018044143.GA24043@midwinter.com> <3391BADA-B5B4-4A8E-A6C0-42169AFC0331@silverinsanity.com> <47176AB9.7010409@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 02:17:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IifY7-00066U-5h
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 02:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbXJSARA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 20:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbXJSARA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 20:17:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38956 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbXJSAQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 20:16:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IifXX-0007Ry-Ks; Thu, 18 Oct 2007 20:16:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3AB0920FBAE; Thu, 18 Oct 2007 20:16:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47176AB9.7010409@midwinter.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61579>

Steven Grimm <koreth@midwinter.com> wrote:
> Brian Gernhardt wrote:
> >I'm not sure telling the users how to disable it every time it shows 
> >up is a good idea.  gc --auto exists for the naive user, and 
> >suggesting they turn it off each time it happens will just result 
> >in...  people turning it off, leading back to the performance issues 
> >that caused the feature to be installed in the first place.  Perhaps a 
> >message more along the lines of "To avoid this, run "git gc" manually 
> >on a regular basis.  See 'git help gc' for more information."
> 
> That's a good point. Jeff / Shawn, do you agree with that? I'll come up 
> with an alternate patch if so.

Arrgh.  I already have the original patch in this thread in my master
so I can't rewind it.  But yes, the argument Brian is making above
makes a lot of sense and I like his proposed message even better
than what I've already applied.

A patch against spearce/master to revert the prior message and insert
something that is perhaps more reasonable would be most appreciated.

-- 
Shawn.
