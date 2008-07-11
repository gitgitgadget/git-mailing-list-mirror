From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Should we discuss Windows-related changes on
 git@vger.kernel.org?
Date: Fri, 11 Jul 2008 22:38:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807112226190.8950@racer>
References: <DDFD7E3B-8401-4EA0-9BBA-C9D8E25998A3@zib.de> <alpine.DEB.1.00.0807111349470.3640@eeepc-johanness> <65365AC4-D7C9-462B-8239-F3B35F7ECBEF@zib.de> <alpine.DEB.1.00.0807111652170.8950@racer> <A065AF71-5685-423A-9F87-5349ADC6C9C9@zib.de>
 <alpine.DEB.1.00.0807111930160.8950@racer> <alpine.LFD.1.10.0807111159560.2936@woody.linux-foundation.org> <alpine.DEB.1.00.0807112037220.8950@racer> <0E93411E-745C-4858-999E-F0B7487B48B1@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:39:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQKq-0005VS-8R
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbYGKVi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYGKVi0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:38:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:37266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750938AbYGKViY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:38:24 -0400
Received: (qmail invoked by alias); 11 Jul 2008 21:38:23 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp027) with SMTP; 11 Jul 2008 23:38:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fQasFOjifUUITj32NONfBqjPuZ/fqur1hTKt4hl
	0lD3efz7gUnQiv
X-X-Sender: gene099@racer
In-Reply-To: <0E93411E-745C-4858-999E-F0B7487B48B1@zib.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88179>

Hi,

On Fri, 11 Jul 2008, Steffen Prohaska wrote:

> On Jul 11, 2008, at 9:40 PM, Johannes Schindelin wrote:
> 
> >On Fri, 11 Jul 2008, Linus Torvalds wrote:
> >
> > >- It may well be good to explain to the _real_ git people (eg me) 
> > >  what the problems in Windows land are, so that we get a first-hand 
> > >  view into hell, and can maybe take it into account when we make 
> > >  changes for other things.
> >
> >Wow.  I did not think that you were a masochist.
> >
> > >IOW, I think that since 1.6.0 is supposed to have native support for 
> > >windows, we should have patches discussed on the regular git list. 
> > >The ghetto that is windows can be useful for _user_ discussions, 
> > >where a lot of the core git people simply cannot help. But having 
> > >development discussions there is bad, I think.
> >
> >We do have development discussions there that do not belong to 
> >git@vger. For example, when Hannes reimplemented the utterly broken 
> >spawn() implementation of Microsoft's "Run" time library.
> >
> >That is not something you need to see, want to see, or can help with.
> 
> The separation is not always that clear.  For example, the discussion
> of issue 130 might benefit from "a first-hand view into hell",

Maybe I am overly cautious, but you remember what drove me away from 
msysGit?  Exactly, people, and issues, took out all the fun.

Let's not inflict upon git@vger what they did not deserve to suffer.

And if the separation is not always that clear, why not discuss those 
things on msysGit first, and then come to git@vger with our minds (and 
possibly our patches) made up?

> Another example is the discussion about GIT_EXEC_PATH, see
> 
> http://thread.gmane.org/gmane.comp.version-control.msysgit/2633

This is a particularly good example that does not matter for Linux, 
MacOSX, Solaris or the BSDs (Git's principal platforms!) at all.

And once this patch hits git@vger, it is still visible to other platforms.

> A last example is the crash of gitk that was observed on Windows and is 
> now buried in the msysGit issue tracker, although I am pretty sure that 
> is it not windows-specific, see
> 
> http://code.google.com/p/msysgit/issues/detail?id=125

So?  If it did not hit other platforms, it is the duty of that guy to find 
out what it is.  And if it _does_ turn out to be a Windows-specific bug, 
which might very well be the case, we do not need to add to the volume of 
git@vger.

> >Likewise, I think it has nothing to do with the git@vger list when we 
> >add work-arounds until some better solution is found, and then discuss 
> >whether the workaround is still needed.
> >
> >I cannot help to see the benefit, at least.
> >
> >Once things are sorted out, I agree, it has to be sent to the git list.
> >
> >Before that, however, allow us to work on another list.
> 
> Personally, I'd find it easier to work on a single list.

Sure the benefit is undisputed.

Now let's look at the downsides: we take away time, and possibly fun, from 
many more people than one or two persons.

It's like spam.  Asking somebody to "just hit the delete button" stops 
being funny very quickly.

> MinGW support is mature enough and workarounds should now be avoid.  If 
> we tested git during the official release cycle, we would have 
> sufficient time to find and solve problems on Windows and prepare 
> patches that have sufficient quality to be discuss on git@vger.

I am not so sure.

Your experience should match mine, that the patches coming in through 
msysGit are of a substantial lower quality than what we are used to on 
git@vger.

If you want to force those patches unfiltered onto the readers of 
git@vger, it would only be fair that you have to clean the readers' latest 
lunch out of their keyboards.

Ciao,
Dscho "who has a fata morgana of windmills"
