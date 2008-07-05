From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git sequencer prototype
Date: Sat, 5 Jul 2008 12:13:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807051210530.3334@eeepc-johanness>
References: <1214879914-17866-1-git-send-email-s-beyer@gmx.net> <20080704210052.GA6984@steel.home> <7vwsk1ti6y.fsf@gitster.siamese.dyndns.org> <20080705081321.GA4935@blimp.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Alex Riesen <fork0@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jul 05 12:14:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF4mj-0002H0-08
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 12:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYGEKNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 06:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbYGEKNc
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 06:13:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:47571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751134AbYGEKNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 06:13:31 -0400
Received: (qmail invoked by alias); 05 Jul 2008 10:13:30 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp014) with SMTP; 05 Jul 2008 12:13:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nrCEPMVGnYPZI3VsLX1zwJjSYeYwiBNiHeV5Ndw
	2YAbchn/9yhfRK
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080705081321.GA4935@blimp.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87441>

Hi,

On Sat, 5 Jul 2008, Alex Riesen wrote:

> Junio C Hamano, Sat, Jul 05, 2008 00:09:41 +0200:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> > 
> > > Stephan Beyer, Tue, Jul 01, 2008 04:38:30 +0200:
> > >> 
> > >> here is the patchset for the git-sequencer prototype, 
> > >> documentation, test suite and a first git-am and git-rebase-i 
> > >> migration. Indeed, monster patches. ;)
> > >
> > > BTW, how about renaming it in something short: git seq. There is 
> > > already a seq(1) in GNU coreutils, which does roughly the same 
> > > (prints a sequence of numbers), why not reuse the name?
> > 
> > Is it advantageous to use shorter but less descriptive name for this 
> > command?  It will be a backend to am/rebase and not something the 
> > users will type from the command line, won't it?
> 
> There is not a huge lot of possible meanings of "seq" in the given 
> context. Somehow I find it hard to believe someone will be confused by a 
> backend command with a short name "seq" (seq-uence-something?)

It might be a bit confusing, since "seq" _produces_ sequences, and 
"sequencer" is kind of an assembly line, getting commits in a sequence and 
then applying the corresponding changes in order.

> It'll make the lines shorter, less need to wrap them.

By that reasoning, we should have git-a, git-b, ... but that would not 
improve readability.

> BTW, what does "am" (git am) mean?

It means "applymbox", but that name was already taken.  And "am" turned 
out _not_ to replace "applymbox" right away as was expected, so it is a 
bit of unfortunate history.

Ciao,
Dscho
