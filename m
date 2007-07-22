From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Sun, 22 Jul 2007 13:43:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707221331560.14781@racer.site>
References: <20070722124236.47baacb1@paolo-desktop> 
 <Pine.LNX.4.64.0707221255260.14781@racer.site>
 <4d8e3fd30707220511s3f9ee1dfu4b24b0a6d9949ebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 14:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICama-0001SX-D4
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 14:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760801AbXGVMn1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 08:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759632AbXGVMn1
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 08:43:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:49444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758086AbXGVMn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 08:43:26 -0400
Received: (qmail invoked by alias); 22 Jul 2007 12:43:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 22 Jul 2007 14:43:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jA/4ncGuji6tWXEN+n8JXPaNd9+XvDC/0VTGQDL
	//CtDLBXCy/QPL
X-X-Sender: gene099@racer.site
In-Reply-To: <4d8e3fd30707220511s3f9ee1dfu4b24b0a6d9949ebe@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53262>

Hi,

On Sun, 22 Jul 2007, Paolo Ciarrocchi wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Sun, 22 Jul 2007, Paolo Ciarrocchi wrote:
> > 
> > > Initial Italian translation
> > 
> > Thank you very much!  I took the liberty of squashing your 3 commits 
> > into one ;-)
> 
> Yeah, I was writing you an email suggesting to at least merge my latest 
> patch into the previous one.

;-)

> Out of curiosity, how did you merge my 3 commits into one? (I'm really a 
> newbie).

There are two nice way to do it:  Either make a new branch and squash 
merge the commits:

	$ git reset --hard HEAD~3
	$ git merge --squash HEAD@{1}

(Explanation: This does not really make a new branch, but resets the 
current HEAD 3 commits back.  Then it uses the _reflog_ to get at the old 
HEAD, and merges it with the "--squash" option.)

The second is what I actually did:  I used the interactive mode of rebase:

	$ git rebase -i HEAD~3
	[edit the 2nd and 3rd "pick" to become "squash"]

> > I see that 5 translations are missing:
> > 
> > Commit, Checkout..., Unstage From Commit, Sign Off, Apple
> > 
> > I guess that "Unstage From Commit" needs to be translated, but that 
> > you wanted to keep the others as-English, right?
> 
> Yes, I even translated a few words that I think should remain in 
> English. I FWed my patch to my local LUG, I'll collect some feedback and 
> post a followup patch.

Wonderful!

Ciao,
Dscho
