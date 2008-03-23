From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SoC RFC] git statistics - information about commits
Date: Sun, 23 Mar 2008 17:32:31 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231729150.4353@racer.site>
References: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>  <7vmyospgz7.fsf@gitster.siamese.dyndns.org>  <7v3aqik0nz.fsf@gitster.siamese.dyndns.org>  <bd6139dc0803230707w29e31d89kf65cf4ac7ad3c8@mail.gmail.com>  <alpine.LSU.1.00.0803231523110.4353@racer.site>
 <bd6139dc0803230841l93cdd0do39bf6c35a5d732fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: alturin marlinon <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 17:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdT8E-0005c8-LT
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 17:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYCWQcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 12:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbYCWQcd
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 12:32:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:56353 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752963AbYCWQcc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 12:32:32 -0400
Received: (qmail invoked by alias); 23 Mar 2008 16:32:31 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp025) with SMTP; 23 Mar 2008 17:32:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+i1O5Pyr+ixAfp043dE6Sdzz+FMwHYJqcKwP+lOg
	VhsnrC6DfCgfOG
X-X-Sender: gene099@racer.site
In-Reply-To: <bd6139dc0803230841l93cdd0do39bf6c35a5d732fa@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77923>

Hi,

On Sun, 23 Mar 2008, alturin marlinon wrote:

> On Sun, Mar 23, 2008 at 3:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  I think you will have to go to the line level to achieve what Junio 
> >  suggested.
> 
> I'm not sure what you mean with "go to the line level"? Do you mean that 
> using a Graph is not possible?

IIUC you suggested having a graph of the files.  But I think you have to 
have a graph of file _parts_, i.e.

	git.c:111-137

which you can split even further should the need arise.

> >  > >  * Identify "buggy commits" from history, without testing.  
> >  > >    Zeroth order
> >  >
> >  > A feature like this would fit well with the other "buggy 
> >  > commit/maintainer detection" but would require a lot of 
> >  > customization. However, considering git already comes with a good 
> >  > customization system it should still be feasible.
> >
> >  Yes.  And it would be really interesting for me.  Until it shows that 
> >  I am the biggest offender, of course.
> 
> Maybe we can put in an if-check for user "Johannes Schindelin"? ;)

I thought about something like this, actually ;-)

> >  I think the bigger problem is not visualising it, but finding what is 
> >  buggy, and what not.
> 
> Yes, ofcourse, I think I'll be busy mostly following lines across 
> commits and after that determining if a commit is buggy or not.

But as Junio said, there are improvements, and even in the same commit 
series, you can touch the same _line_ multiple times, to make the patch 
more obvious.

See for example Linus' nice commit series regarding core.ignorecase.  
Very nicely done, very easy to understand, no buggy code.

> >  I think it can be vague about the order in which things will be 
> >  implemented.  And the features which you think might be too 
> >  complicated should be marked as such: "possible extension (which 
> >  might not be finished within this project): <blabla>".
> 
> Cool, I think I can start on a RC for my application then! (Maybe I 
> should'of tracked it with git, then I could tag it...)

Hehe.  You'll come around putting even your photo collection into git, 
like I do.

Ciao,
Dscho
