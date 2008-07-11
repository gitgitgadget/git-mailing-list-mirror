From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 19:36:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111930160.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNUy-0000uB-9I
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688AbYGKSgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753790AbYGKSgm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:36:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:49134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753685AbYGKSgl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:36:41 -0400
Received: (qmail invoked by alias); 11 Jul 2008 18:36:39 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2008 20:36:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BvtMbwnoBZkGvIWvgaISov9VaAM+UixMZRTWsvb
	DmtYcMfkfgtKVm
X-X-Sender: gene099@racer
In-Reply-To: <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88151>

Hi,

On Fri, 11 Jul 2008, Steffen Prohaska wrote:

> On Jul 11, 2008, at 5:57 PM, Johannes Schindelin wrote:
> 
> >On Fri, 11 Jul 2008, Steffen Prohaska wrote:
> >
> > >On Jul 11, 2008, at 1:56 PM, Johannes Schindelin wrote:
> > >
> > > >On Fri, 11 Jul 2008, Steffen Prohaska wrote:
> > > >
> > > > >I decided to stop queuing changes in 4msysgit.  Instead I'd like 
> > > > >to bring the diff between Junio's and 4msysgit's master to zero.  
> > > > >This seems to be achievable after Junio merged Hannes' MinGW 
> > > > >changes.
> > > > >
> > > > >I think all Windows-related changes to the git code base could be 
> > > > >discussed directly on the main git list and the msysgit list 
> > > > >would be reserved for the MinGW/MSYS runtime environment and the 
> > > > >installer.
> > > >
> > > >I disagree.  Judging from the mails I read on the git list, Junio 
> > > >gets really swamped by patches these days (what with our very 
> > > >productive GSoC students).
> > >
> > >Sending the patches to the git list does not necessarily mean that 
> > >they are directly addressed to Junio.  We discuss JGIT, EGIT, gitk, 
> > >and git gui patches on the list too.  AFAIK, none of them are applied 
> > >by Junio directly but by the respective maintainers.  We could handle 
> > >Windows-related patches similarly.
> >
> >Then what is the msysGit list about?
> 
> I think the msysGit list could be useful for:
> 
> - Everything that is in the msysgit repo, i.e. the MinGW/MSYS
>   runtime environment and the installers.

Which very much includes brushing up the patches in 4msysgit, which are 
invariably of lower quality than git.git's, because we lack a brilliant 
maintainer like Junio.

Come to think of it, we do not have a maintainer at all.  Many people can 
commit and push into 4msysgit, and I am debating with myself for a long 
time already if that was a sensible thing to do.  Just think of that C# 
desaster.

> >No, I really disagree.  Windows support is too large a thing, and 
> >partly a too disgusting one to bother the git list.
> 
> My understanding is that the mainline of git starts supporting the MinGW 
> port with version 1.6.0.  The MinGW port is merged to Junio's master, so 
> the remaining differences between Junio's master and 4msysgit's master 
> should be removed and afterwards new changes should be discussed, 
> improved, and applied to Junio's master anyway.  This would also allow 
> to directly test Junio's next on Windows.

Junio expressed several times that he is uncomfortable that he cannot 
easily test Windows support himself.

I strongly doubt that discussing things on git@vger that are not even 
half-cooked would help that impression.

Also, there are a lot of people on git@vger who could not care _less_ 
about Windows.

And there are a few on the list who could not care less about those 
Windows users who seem to be content to let others work for them, but 
comment at every _possible_ occasion, on what should, and what should not 
be done.  Let's keep them on the msysGit list, for the benefit of the 
saner half of git@vger.

> > > >I really think that we should discuss the patches on the msysGit 
> > > >list first, whip them into shape, and then send them off.
> > > >
> > > >Just think of those patches that were sent off, only to realize 
> > > >that they were no longer needed.  That should not have happened.
> > >
> > >I intentionally sent the patches to show and discuss the differences 
> > >between the state of the MinGW port in Junio's master and in 
> > >4msysgit. Some of the patches could be reverted in 4msysgit.  But, at 
> > >least one patch was unrelated to MinGW and is now in master.  Some 
> > >other patches need more work and are currently improved.  I think 
> > >this was not a waste of time.
> >
> >IMO we could have discussed first what is the current state on the 
> >msysGit list, and I would have commented there already on the patches 
> >that I think would no longer be needed.
> >
> >Then the patch would have been sent off, and be in master, too.
> >
> >The difference: it would have been more efficient.  Those people who 
> >can test if something is still needed on Windows are on the msysGit 
> >list.
> >
> >We do not really need to clutter git@vger more than necessary.
> 
> But git 1.6 will contain the MinGW port.  Shouldn't related patches then 
> be discussed on git@vger?

See above.  There will be a rudimentary support for MinGW, yes, but that's 
for hardcore people like Hannes.

For those who just want to use Git on Windows, there is msysGit.  And 
for them, we have the msysGit list.

Let's not confuse things, let's not upset git@vger with too many less 
clueful users who should rather post to msysgit@googlegroups.com.

Ciao,
Dscho
