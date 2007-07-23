From: Nicolas Pitre <nico@cam.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 15:06:09 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707231432560.6355@xanadu.home>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org>
 <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com>
 <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
 <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 21:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID3EX-0001tQ-BB
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 21:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762638AbXGWTGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 15:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762472AbXGWTGM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 15:06:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28068 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630AbXGWTGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 15:06:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLN00AH3BQ9F480@VL-MH-MR002.ip.videotron.ca>; Mon,
 23 Jul 2007 15:06:09 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53462>

On Mon, 23 Jul 2007, Linus Torvalds wrote:

> 
> 
> On Mon, 23 Jul 2007, Nicolas Pitre wrote:
> > 
> > I started this once.
> > 
> > I have (sort of) a GIT tree with all Linux revisions that I could find 
> > from v0.01 up to v1.0.9.  But the most interesting information and also 
> > what is the most time consuming is the retrieval of announcement 
> > messages for those releases in old mailing list or newsgroup archives to 
> > serve as commit log data.  It seems to be even arder to find for post 
> > v1.0 releases.
> 
> Yes, I agree. Google finds some of them, but (a) I was never very good 
> about announcements anyway and (b) there's nothing really good to search 
> for, so it's very hit-and-miss.
> 
> Some of the really early release notes are easy to find, just because I 
> made them available with the sources, but mostly I'd just have posten to 
> the newsgroup/mailing lists.

That's what I used when available, especially to properly time stamp 
those commits.  Using the latest date on files included in the archive 
isn't always reliable.

OK so actually what I have is from v0.01 up to v1.0 creating 93 commits.

What is missing is:

 - v0.02 sources

 - v0.10 announcement

 - v0.96 sources

 - v0.99.12 announcement

 - sources for v0.99.13{abcdefghij} (got k, don't know where the serie 
   ends) as well as announcements for all of them

 - all announcements for v0.99.14{a-z} except for pl14r

 - announcements for pl15c to pl15j, 1.0-pre1, and ALPHA-1.0.

Otherwise the archive appears fairly complete with almost 3 years of 
Linux development history captured in a 3MB pack file.


Nicolas
