From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Thu, 25 Oct 2007 11:12:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251108330.25221@racer.site>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de> <Pine.LNX.4.64.0710231155321.25221@racer.site>
 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de> <20071024192058.GF29830@fieldses.org>
 <471F9FD1.6080002@op5.se> <20071024194849.GH29830@fieldses.org>
 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org>
 <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx>
 <471FBF29.8030802@op5.se> <Pine.LNX.4.64.0710242315310.25221@racer.site>
 <47204ECA.7040309@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzi3-00033A-SI
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403AbXJYKMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXJYKMv
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:12:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:53666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754017AbXJYKMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:12:50 -0400
Received: (qmail invoked by alias); 25 Oct 2007 10:12:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 25 Oct 2007 12:12:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191WGBENNd1DDuBlV2lUh/HERRbGnZsy3Kxi2l1dV
	pMmjeHOWbZm1ow
X-X-Sender: gene099@racer.site
In-Reply-To: <47204ECA.7040309@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62292>

Hi,

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> 
> > On Wed, 24 Oct 2007, Andreas Ericsson wrote:
> > 
> > > Conceptually, I don't think it'll be any problem what so ever 
> > > telling anyone that the branches that aren't currently checked out 
> > > get merged automatically only if they result in a fast-forward.
> > 
> > It would be a matter of seconds until someone asks "why only 
> > fast-forwards? Would it not be _much_ better to merge _always_?  
> > Stupid git."
> > 
> > And all because the concept of "local" vs "remote" was blurred.
> 
> It's already blurred, since we have git-pull instead of just git-fetch.

Huh?  How is "I ask git pull to fetch the remote branch, and merge it into 
my local branch" a blurring of local vs remote branch?

The local branch is still the local branch where it is _my_ responsibility 
to update or change anything.  The remote branch is not.  If at all, I can 
push -- iff it fast-forwards.

The fact that you can set up local mirroring branches (with "git remote 
add") which are only updated via "git fetch" is _no_ blurring of the 
concepts: we make it quite explicit that you cannot check them out.  They 
are not local branches.

Hth,
Dscho
