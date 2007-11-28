From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 23:12:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282309030.27959@racer.site>
References: <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site> <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
 <Pine.LNX.4.64.0711282039430.27959@racer.site>
 <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
 <7vhcj63uhw.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711282156520.27959@racer.site>
 <20071128223339.GF7376@fieldses.org> <20071128224717.GG7376@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxW5m-0007qi-Oh
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbXK1XMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbXK1XMp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:12:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:41801 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755733AbXK1XMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:12:44 -0500
Received: (qmail invoked by alias); 28 Nov 2007 23:12:42 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 29 Nov 2007 00:12:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8YLshUd78ZNtd0x1oqdTj/eO7rJjA6ETP2SjJuo
	RJvqeVUIjaSJTl
X-X-Sender: gene099@racer.site
In-Reply-To: <20071128224717.GG7376@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66459>

Hi,

On Wed, 28 Nov 2007, J. Bruce Fields wrote:

> Would it be possible to add this to rebase instead of to pull?
> 
> 	git rebase --url git://x.org/x.git master
> 
> where --url means "interpret <upstream> as a branch from the given
> remote repository.

I was briefly considering it.

But the point is this: I know exactly if I want to rebase my branch onto 
upstream, or if I want to merge it.  There is not much point in mixing the 
two.

So my rationale was: if we already have an existing framework to integrate 
remote changes with our current branch, why not just go ahead and use it?  
That's the reason BTW why I originally wanted a "rebase" merge stragegy.  
Even if it is not technically a merge.

I really rather have no user-friendly support for fetch+rebase (and utter 
a friendly, but loud curse everytime I made a "git pull" by mistake) than 
yet another command.

Ciao,
Dscho
