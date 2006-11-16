X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 22:43:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611152228540.2591@xanadu.home>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <200611151858.51833.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
 <87velgs9hx.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org>
 <87psbos4pb.wl%cworth@cworth.org> <20061115230252.GH24861@spearce.org>
 <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611151905460.2591@xanadu.home>
 <Pine.LNX.4.64.0611151859370.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 16 Nov 2006 03:44:31 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Carl Worth <cworth@cworth.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611151859370.3349@woody.osdl.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31553>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYAe-00063O-1Z for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031089AbWKPDoA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031090AbWKPDoA
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:44:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:48982 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1031089AbWKPDn7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:43:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8T00H1611AEBE0@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 22:43:58 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Linus Torvalds wrote:

> 
> 
> On Wed, 15 Nov 2006, Nicolas Pitre wrote:
> > 
> > That is an implementation detail that should be easily overcome once the 
> > notion of tracking branch with URL attribute is implemented.
> 
> Nope.
> 
> I simply don't _have_ those branches.
> 
> Why? Because the kernel is _distributed_. There is no central place 
> (certainly not my repository) that tracks all the possible branches that 
> might get merged.
> 
> In other words, I repeat: in a TRULY DISTRIBUTED ENVIRONMENT it makes more 
> sense to have a "pull" that fetches and merges, over something that 
> fetches separately and then merges.
[...]

OK fine.  git-pull is there to stay and let's make sure it remains the 
same.

Let's see if, for example, git-merge can be made more useful in the mean 
time for those evidently inferior people that would prefer an interface 
that maps more closely to the actual operation that is being performed.  
And although I do understand what "pull" does, I think I should qualify 
myself as one of those inferior people nevertheless since /pull . blah" 
really irritates me.  OK I must be really dumb to let myself being 
disturbed by such an insignificant detail... but apparently I'm not 
alone.

But I promise to never change the "pull" behavior if I ever attempt to 
fix the "merge" command for the inferior mortals as myself.  All power 
to those with superior minds shall never be removed.

;-)


