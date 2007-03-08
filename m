From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 18:37:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081834310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703080827170.10832@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703081755500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703080928580.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 18:37:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPMYJ-0004DQ-3b
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 18:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbXCHRhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXCHRhK
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 12:37:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752597AbXCHRhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 12:37:08 -0500
Received: (qmail invoked by alias); 08 Mar 2007 17:37:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 08 Mar 2007 18:37:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KvLxZvoJKFOwPfMrnoyVBnCqvz3vPz1DHeua9Ew
	oWiZPMeWYhPOaO
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703080928580.10832@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41766>

Hi,

On Thu, 8 Mar 2007, Linus Torvalds wrote:

> On Thu, 8 Mar 2007, Johannes Schindelin wrote:
> > 
> > How about something totally different: "git log --shortlog". I.e.
> 
> Sure, but this is even worse, because the way you wrote the patch

I should have marked it as "this is the idea, but even if it looks like a 
patch, it is not".

Unfortunately, I don't have time to do a proper patch, which is why I just 
wrote that simple and completely untested example of how this could be 
done.

I'd split off a proper builtin_shortlog(revs) from cmd_shortlog(), to 
avoid double parsing, and also because it looks nicer to the eye, but time 
is scarce.

Ciao,
Dscho
