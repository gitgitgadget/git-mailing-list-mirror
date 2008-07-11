From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 16:57:04 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111652170.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHL0a-0006sJ-54
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYGKP5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbYGKP5I
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:57:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:43215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750992AbYGKP5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:57:07 -0400
Received: (qmail invoked by alias); 11 Jul 2008 15:57:05 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp034) with SMTP; 11 Jul 2008 17:57:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iU082pCGiB2oe746ISTTYnz1zxlbE0V5C/fbJ0T
	/pEuw0XX978r9u
X-X-Sender: gene099@racer
In-Reply-To: <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88134>

Hi,

On Fri, 11 Jul 2008, Steffen Prohaska wrote:

> On Jul 11, 2008, at 1:56 PM, Johannes Schindelin wrote:
> 
> >On Fri, 11 Jul 2008, Steffen Prohaska wrote:
> >
> > >I decided to stop queuing changes in 4msysgit.  Instead I'd like to
> > >bring the diff between Junio's and 4msysgit's master to zero.  This
> > >seems to be achievable after Junio merged Hannes' MinGW changes.
> > >
> > >I think all Windows-related changes to the git code base could be
> > >discussed directly on the main git list and the msysgit list would be
> > >reserved for the MinGW/MSYS runtime environment and the installer.
> >
> >I disagree.  Judging from the mails I read on the git list, Junio gets
> >really swamped by patches these days (what with our very productive GSoC
> >students).
> 
> Sending the patches to the git list does not necessarily mean that
> they are directly addressed to Junio.  We discuss JGIT, EGIT, gitk,
> and git gui patches on the list too.  AFAIK, none of them are applied
> by Junio directly but by the respective maintainers.  We could handle
> Windows-related patches similarly.

Then what is the msysGit list about?

No, I really disagree.  Windows support is too large a thing, and partly a 
too disgusting one to bother the git list.

> >I really think that we should discuss the patches on the msysGit list 
> >first, whip them into shape, and then send them off.
> >
> >Just think of those patches that were sent off, only to realize that 
> >they were no longer needed.  That should not have happened.
> 
> I intentionally sent the patches to show and discuss the differences 
> between the state of the MinGW port in Junio's master and in 4msysgit. 
> Some of the patches could be reverted in 4msysgit.  But, at least one 
> patch was unrelated to MinGW and is now in master.  Some other patches 
> need more work and are currently improved.  I think this was not a waste 
> of time.

IMO we could have discussed first what is the current state on the msysGit 
list, and I would have commented there already on the patches that I think 
would no longer be needed.

Then the patch would have been sent off, and be in master, too.

The difference: it would have been more efficient.  Those people who can 
test if something is still needed on Windows are on the msysGit list.

We do not really need to clutter git@vger more than necessary.

Ciao,
Dscho
