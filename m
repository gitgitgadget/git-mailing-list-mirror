From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Wed, 18 Apr 2007 11:10:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704181058190.4504@xanadu.home>
References: <200704171041.46176.andyparkins@gmail.com>
 <"200704171803.58940.a n dyparkins"@gmail.com>
 <200704172012.31280.andyparkins@gmail.com>
 <alpine.LFD.0.98.0704171530220.4504@xanadu.home>
 <Pine.LNX.4.63.0704171244450.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171624190.4504@xanadu.home>
 <Pine.LNX.4.63.0704171302200.1696@qynat.qvtvafvgr.pbz>
 <alpine.LFD.0.98.0704171708360.4504@xanadu.home>
 <7vy7kqlj5r.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704172154160.4504@xanadu.home>
 <Pine.LNX.4.64.0704181313060.12094@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	David Lang <david.lang@digitalinsight.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 18 17:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeBnz-0007Qc-Cp
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 17:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992734AbXDRPKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 11:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992742AbXDRPKo
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 11:10:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61962 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992734AbXDRPKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 11:10:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGP001MG8TTY740@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 Apr 2007 11:10:42 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704181313060.12094@racer.site>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44897>

On Wed, 18 Apr 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 17 Apr 2007, Nicolas Pitre wrote:
> 
> > So what?
> > 
> > We provide a rope with proper caveat emptor.  Up to others to hang 
> > themselves with it if they so desire.  It is not our problem anymore.
> 
> The people will complain. On this list. And I have to check the mails 
> before deleting, because the Subject: does not say "I just took the rope, 
> ignored your caveat emptor, and now I am dead. What should I do now?".

Well... in the case of keyword expansion (since this is really the 
contentious case here), with such a _generic_ facility to implement 
external filters, people will at least have the opportunity to try it.  
Sure they might complain that it doesn't work well, but 1) it is much 
easier to *understand* why it doesn't work well after experimenting with 
it, and 2) some people *will* be perfectly happy with something that 
doesn't work well but happens to just work in their own particular case.

And because it now becomes a case by case issue it is much easier for 
us to simply provide a generic mechanism and let people figure out by 
themselves what works and what doesn't work instead of having 
philosophical discussions on the merits of keyword expansions on the 
list.

And because people _will_ complain *anyway*, it might lead to more 
productive discussion if those who complain had the chance to realize 
what the issues really are by experience if theoretic demonstrations alone 
doesn't convey the problem fully.


Nicolas
