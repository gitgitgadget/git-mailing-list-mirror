From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Sat, 12 Jul 2008 00:47:37 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807120043150.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
 <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <7v4p6wjcgm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807120033490.8950@racer>
 <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 01:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHSLs-0003Gn-FV
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 01:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbYGKXrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 19:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYGKXrj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 19:47:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:40651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753890AbYGKXri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 19:47:38 -0400
Received: (qmail invoked by alias); 11 Jul 2008 23:47:36 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 12 Jul 2008 01:47:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XGXVx1z2XsVWNIWju0K9juU/0GpiJ8NfoMk61ou
	qVyqZq9rwdC0WE
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0807111638130.3459@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88207>

Hi,

On Fri, 11 Jul 2008, Linus Torvalds wrote:

> On Sat, 12 Jul 2008, Johannes Schindelin wrote:
> > 
> > I think that is a perfect example, since Hannes worked on it in 
> > mingw.git.  AFAIR a few comments came through msysGit, and were 
> > incorporated.  When everything was good for a first go at git@vger, it 
> > was sent, and the interface finalized.
> 
> Umm. Dscho - that was before the thing was merged.
> 
> Now that the basic mingw support is part of standard git, the situation 
> has changed.
> 
> That's the main issue here - if mingw support is in standard git (and it 
> is), then mingw issues that touch any non-mingw code should be discussed 
> where all the git developers are.
> 
> Can't you see the difference between the pre-merge and the post-merge 
> situation?

Sure I can.

But we are talking about 4msysgit.git, no?

At least the patches that Steffen sent were all from 4msysgit.git, and for 
some reason or other not necessary for Hannes' mingw.git.

We are talking about stuff like that putty thing, where people feel it 
would be a better idea to avoid scripts, at the cost of a higher 
maintenance burden.

We are talking about patches that were necessary a long time ago, but are 
no longer, and we should have that sorted out on the msysGit list before 
sending them to a list where many people could not care less for Windows, 
and are probably annoyed to even read as much as _this_ thread about it, 
let alone be bothered by patches that turn out to be stale in the first 
place.

_That_ is what I am arguing should be sorted out, at least the early 
stages, on msysGit.  As we did in the past.

And that worked out rather well so far, do you disagree?

Ciao,
Dscho
