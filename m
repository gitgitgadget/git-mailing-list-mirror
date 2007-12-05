From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/6] DWIM "git add remote ..."
Date: Wed, 5 Dec 2007 19:47:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051946350.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
 <Pine.LNX.4.64.0712051902510.27959@racer.site>
 <alpine.LFD.0.9999.0712051129280.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:54:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J00KY-0007ON-Hh
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbXLETsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756523AbXLETsQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:48:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:47273 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755854AbXLETsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:48:15 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:48:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 05 Dec 2007 20:48:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/swPd9QEzsuD8ZsLQDg/GdPy8iB9j//PGLX6wfok
	jb8tlCVDj6mjn0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712051129280.13796@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67190>

Hi,

On Wed, 5 Dec 2007, Linus Torvalds wrote:

> On Wed, 5 Dec 2007, Johannes Schindelin wrote:
> > 
> > It is wrong to divert to "git remote add" when you typed the (more 
> > English) "git add remote".  But is it also pretty convenient.
> 
> Please don't do cute things like this. Suddenly "git add remote" has two 
> different meanings depending on whether you have a file called "remote" 
> or not. That is *not* ok.
> 
> Not to mention the fact that your patch is also a horrible piece of 
> bug-infested shit, to put it less-than-politely. Namely, you now broke 
> "git add remote" when "remote" is a symbolic link pointing to 
> hyperspace.
> 
> But even if you fix that bug, it only goes to show just how misguided 
> things like these are. It's a *lot* more important to make sense and not 
> have surprising special cases, than to try to make git command lines act 
> as if they were free-form English.

Hehe.  You're right, of course.  But I could not resist showing off that 
patch which I wrote after I mixed up the command line of "remote add" for 
the 926th time.

Ciao,
Dscho
