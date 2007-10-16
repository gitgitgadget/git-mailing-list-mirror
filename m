From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 15:14:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161512450.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <2EA3BEC9-5B13-44D3-B190-CA77499F642C@zib.de>
 <Pine.LNX.4.64.0710161331440.25221@racer.site> <4D822762-D344-465E-B77D-90A64D61F5A9@zib.de>
 <Pine.LNX.4.64.0710161419140.25221@racer.site> <26554F2D-B44D-4691-A696-9B6924E08599@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Eli Zaretskii <eliz@gnu.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>, tsuna@lrde.epita.fr,
	Andreas Ericsson <ae@op5.se>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnBu-0000zM-HZ
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbXJPOO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbXJPOO2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:14:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:41196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932469AbXJPOO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 10:14:27 -0400
Received: (qmail invoked by alias); 16 Oct 2007 14:14:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 16 Oct 2007 16:14:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/FgUFd1MTF9YNHS02Ceb8DewUBrQvJbp0MQ2BCXo
	SoKTOKwcv5sKBB
X-X-Sender: gene099@racer.site
In-Reply-To: <26554F2D-B44D-4691-A696-9B6924E08599@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61173>

Hi,

On Tue, 16 Oct 2007, Steffen Prohaska wrote:

> On Oct 16, 2007, at 3:21 PM, Johannes Schindelin wrote:
> 
> > What you want would probably be all too easy with a pre-commit hook.  
> > No need to clutter the git-core with code that is usually not needed 
> > (you'd only ever activate it on Linux when other developers use 
> > Windows or MacOSX).
> 
> Personally, I'd be very happy if git enforced the minimal consent 
> between (supported) filesystems and provided a system to guarantee that 
> I can only create tree objects that can be checked out on all 
> (supported) filesystems.

This will not happen.  In the Linux kernel, there were exactly such cases, 
where the filenames differed only in case.

Also, some projects I checked out (notably Perl) assume that Makefile is 
different from makefile.

So I think this will always be something Windows users would wish to 
impose onto others, while Linux users would always refuse.

Ciao,
Dscho
