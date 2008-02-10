From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 01:12:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100110450.11591@racer.site>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 02:13:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0l1-0006jC-Sh
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 02:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbYBJBMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 20:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbYBJBMl
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 20:12:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:57873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755449AbYBJBMl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 20:12:41 -0500
Received: (qmail invoked by alias); 10 Feb 2008 01:12:39 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp034) with SMTP; 10 Feb 2008 02:12:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UfN4tUoaUrEltTPMW4HZ/C0LbV7WgJNC3nf55o/
	FYxwKPni/TYSNx
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73282>

Hi,

On Sat, 9 Feb 2008, Linus Torvalds wrote:

> I'm starting to free up some resources to look at the interesting 
> problem with screwed-up commit dates confusing our commit walker into 
> thinking that some uninteresting commit isn't actually uninteresting due 
> to not traversing the uninteresting chain deep enough.

I was thinking the other night why I did not like the generation header.  
And I found out why: it is redundant information.

So why not have some local "cache" which maintains the generation numbers 
for the commits?  (Much like the "notes" cache I showed last year?)

Hmm?

Ciao,
Dscho
