From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 15:43:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602011535220.28923@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601310926330.7301@g5.osdl.org> <1138734110.18852.26.camel@evo.keithp.com>
 <Pine.LNX.4.64.0601311110210.7301@g5.osdl.org> <20060131225514.GC2812@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Keith Packard <keithp@keithp.com>,
	Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 15:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4JDe-0001fW-1U
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 15:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWBAOoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 09:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWBAOoH
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 09:44:07 -0500
Received: from mail.gmx.de ([213.165.64.21]:50874 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932465AbWBAOoG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 09:44:06 -0500
Received: (qmail invoked by alias); 01 Feb 2006 14:44:04 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp039) with SMTP; 01 Feb 2006 15:44:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060131225514.GC2812@ca-server1.us.oracle.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15414>

Hi,

On Tue, 31 Jan 2006, Joel Becker wrote:

> On Tue, Jan 31, 2006 at 11:21:52AM -0800, Linus Torvalds wrote:
> > Now, I do agree. I don't actually like hiding the index too much. 
> > Understanding the index is _invaluable_ whenever you're doing a merge with 
> > conflicts, and understanding what tools are available to you to resolve 
> > those conflicts.
> 
> 	This is precisely the experience I've had explaining GIT to
> folks moving to it.  The simplest workflow (clone; hack one file, commit
> one file) is so similar to CVS/Subversion/Anything that it's immediately
> understood.  But when pull, push, merge, and any non-linear history are
> discussed, I have to describe the index and the commit/tree layout.
> Once I do, they get it.
> 
> > So I'm actually of the "revel in the index" camp (as could probably be 
> > guessed by the original tutorial).
> 
> 	I'm going to second this, from a real-world "explain it to
> others" standpoint.

How about talking about the index a bit at the end of tutorial.txt like 
this:

-- snip --
For a number of (mostly technical) reasons, "git diff" does not show the 
changes of the current working directory with respect to the latest 
commit, but rather to an intermediate stage: the "index".

Think of the index as a staging area just before committing: the commit 
object (and the tree and blob objects referenced from it) are assembled 
there.

Also, when you checkout, the index is used to disassemble the commit 
object just before writing the corresponding files and directories.
-- snap --

May this be worth the work?

Ciao,
Dscho
