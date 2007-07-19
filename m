From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 10:50:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191048030.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
 <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:50:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSeU-0000Id-2f
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbXGSJu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbXGSJuZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:50:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35884 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752824AbXGSJuY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:50:24 -0400
Received: (qmail invoked by alias); 19 Jul 2007 09:50:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 19 Jul 2007 11:50:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+T1kBYIB+TUvC32HuBTYm0ScjIpJrmp3/nz5mEU1
	tAQlw5io/6mp0/
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52955>

Hi,

On Wed, 18 Jul 2007, Linus Torvalds wrote:

> On Thu, 19 Jul 2007, Johannes Schindelin wrote:
> >
> > There is one severe shortcoming, though.  Since tree objects can 
> > contain file names of a variable length, it is not possible to do a 
> > binary search for the correct base name in the tree object's contents.
> 
> Well, I've been thinking about this, and that's not really entirely 
> correct.
> 
> It *is* possible to do a binary search, it's just a bit complicated, 
> because you have to take the "halfway" thing, and find the beginning of 
> an entry.

I will try to work from your proposal, and do some timings.  But for the 
notes, I really, really like the average constant running time of the hash 
map.  As you can see from my timings in

http://thread.gmane.org/gmane.comp.version-control.git/52598/focus=52603

it does make a difference, compared to binary search.

Ciao,
Dscho
