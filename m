From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 12:39:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251232370.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site>
 <47204ECA.7040309@op5.se> <Pine.LNX.4.64.0710251108330.25221@racer.site>
 <47206EC3.5000002@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il14G-0007uT-9G
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 13:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXJYLju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 07:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756649AbXJYLju
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 07:39:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:50668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754949AbXJYLjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 07:39:49 -0400
Received: (qmail invoked by alias); 25 Oct 2007 11:39:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 25 Oct 2007 13:39:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WlwkFfjhWD6AIkC4nxw5slIEbrWEoJHj1kHr3sr
	C6MuFubn5129QE
X-X-Sender: gene099@racer.site
In-Reply-To: <47206EC3.5000002@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62310>

Hi,

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Thu, 25 Oct 2007, Andreas Ericsson wrote:
> > 
> > > Johannes Schindelin wrote:
> > > 
> > > > On Wed, 24 Oct 2007, Andreas Ericsson wrote:
> > > > 
> > > > > Conceptually, I don't think it'll be any problem what so ever 
> > > > > telling anyone that the branches that aren't currently checked 
> > > > > out get merged automatically only if they result in a 
> > > > > fast-forward.
> > > >
> > > > It would be a matter of seconds until someone asks "why only 
> > > > fast-forwards? Would it not be _much_ better to merge _always_?  
> > > > Stupid git."
> > > > 
> > > > And all because the concept of "local" vs "remote" was blurred.
> > >
> > > It's already blurred, since we have git-pull instead of just 
> > > git-fetch.
> > 
> > Huh?  How is "I ask git pull to fetch the remote branch, and merge it 
> > into my local branch" a blurring of local vs remote branch?
> > 
> > The local branch is still the local branch where it is _my_ 
> > responsibility to update or change anything.
> 
> True. So git pull saves you exactly one command. The various 
> fetch-all-git- repos-and-update-all-fast-forward-branches in circulation 
> at the office save us ~500 commands each time they're run. Or rather, 
> they *could* do that, but you can't know until you've run it.

As I pointed out, there is no way to sensibly have 500 _local_ branches 
lying around.

It is ridiculous to assume that you have to have local branches for all 
the stable, maintenance, whatever branches.

When you have to change something, you branch, hack, develop, commit, 
push, and then _clean up_ after yourself.  No need to clutter your 
local branch space with unused branches.

> So what should I do to make what I want possible, without having 
> git-pull muddy the waters of local vs remote? There's clearly a user 
> desire for it, besides that of my eight co-workers and myself. Introduce 
> git-<cmd-156>?

If you _insist_ on your workflow, hey, git is a free program, and you can 
do what you want to do with an alias easily enough.  You can even make 
that alias part of the templates, so you can force your desires down the 
throat of every of your coworkers.

However, that does not mean that you can insist on support for your 
workflow in upstream git.

Ciao,
Dscho
