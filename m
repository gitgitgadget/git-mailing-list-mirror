From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Tue, 2 Oct 2007 18:40:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021834470.28395@racer.site>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org> <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
 <87bqbisae6.wl%cworth@cworth.org> <Pine.LNX.4.64.0710021045430.28395@racer.site>
 <m34ph9tye1.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Barry Fishman <barry_fishman@acm.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:41:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iclke-00069d-Ty
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXJBRlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbXJBRlh
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:41:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:41090 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752726AbXJBRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:41:36 -0400
Received: (qmail invoked by alias); 02 Oct 2007 17:41:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp019) with SMTP; 02 Oct 2007 19:41:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vvgMUhetvkiQGZ4T9tkOfGpw3GdcIrgMWP0Vnra
	t14CMKwwAYwAbx
X-X-Sender: gene099@racer.site
In-Reply-To: <m34ph9tye1.fsf@barry_fishman.acm.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59701>

Hi,

[please do not cull me from the Cc: list, especially when you are quoting 
me]

On Tue, 2 Oct 2007, Barry Fishman wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Well, if the OP had used "git push <bla> master" instead of "... 
> > master:master", it would have worked.  I am unaware of any tutorial 
> > that suggests the latter, only of tutorials that suggest the former.
> 
> I did recheck the tutorials, and did not find the code I was
> using.  So there was nothing incorrect in the documentation.

Good.  Just for my curiousity: where in the documentation did you look for 
help?  (We might want to advertise "git push <nick> <branch>" more loudly 
there.)

> What distracted me was that after the "git --bare init", there seemed to 
> be a incompletely defined setup.  This sent me down the wrong path.
> 
> Although there was a master branch to which HEAD pointed, there was no
> ref/heads/master file or even a "packed-refs".

That means that there was no master branch.  Before the first commit, a 
branch does not exist.  We are stricter in that regard than other SCMs.

> If there isn't an initial master branch, then shouldn't "git branch" be
> able to create one.

Why?  I really do not see the point in creating a branch which is named 
different than "master", when you have nothing to begin with.

Just use "master".  As easy as that.

If you really have to paint the bike shed, you can always rename your 
branch later, when you got something, by "git branch -m <new-branch-name>".

>   This command creates an empty git repository - basically a .git directory
>   with subdirectories for objects, refs/heads, refs/tags, and template
>   files. An initial HEAD file references the refs/heads/master branch
>   which is created with the first commit.

How about "Your first commit will create the master branch" instead of the 
last sentence?

Ciao,
Dscho
