From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 16:52:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201647420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200610180246.18758.jnareb@gmail.com> <45382120.9060702@utoronto.ca>
 <20061020141222.GA17497@coredump.intra.peff.net> <200610201640.36640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Carl Worth <cworth@cworth.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 16:53:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GavjM-0003xY-I6
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 16:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992621AbWJTOwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992627AbWJTOwN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 10:52:13 -0400
Received: from mail.gmx.de ([213.165.64.20]:16801 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S2992621AbWJTOwM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 10:52:12 -0400
Received: (qmail invoked by alias); 20 Oct 2006 14:52:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 20 Oct 2006 16:52:10 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610201640.36640.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29482>

Hi,

On Fri, 20 Oct 2006, Jakub Narebski wrote:

> Jeff King wrote:
> > 
> > I was accustomed to doing such things in CVS, but I find the git way
> > much more pleasant, since I don't have to do any arithmetic:
> >   diff d8a60^..d8a60
> 
> By the way "diff d8a60" also works (unless d8a60 is merge commit, in
> which case you would need "diff -c d8a60" or "diff -m d8a60").

I could be wrong, but I have the impression (even after actually testing 
it) that "git diff d8a60" is equivalent to "git diff d8a60..HEAD", _not_ 
"git diff d8a60^..d8a60".

IIRC we had a "-p" flag to denote "parent" once upon a time, but that no 
longer works...

"git-show" is definitely what you want.

Ciao,
Dscho
