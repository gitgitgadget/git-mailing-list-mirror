From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 13:44:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705251343550.4648@racer.site>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <200705251427.46903.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 14:44:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrZ9y-0002RK-JF
	for gcvg-git@gmane.org; Fri, 25 May 2007 14:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827AbXEYMol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 08:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbXEYMok
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 08:44:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:57405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755827AbXEYMok (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 08:44:40 -0400
Received: (qmail invoked by alias); 25 May 2007 12:44:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 25 May 2007 14:44:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ks7tTDRgKt4CbezViDwsCVMulv9cZ3Tu7cNfSFC
	sT+czEpXJ1AkDq
X-X-Sender: gene099@racer.site
In-Reply-To: <200705251427.46903.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48368>

Hi,

On Fri, 25 May 2007, Josef Weidendorfer wrote:

> On Thursday 24 May 2007, Linus Torvalds wrote:
> > 
> > On Thu, 24 May 2007, Junio C Hamano wrote:
> > > 
> > > Why does this have to be out-of-tree and unversioned to begin
> > > with?
> > 
> > I _really_ think that the right approach is to
> > 
> >  - have the submodules information under version control (and I'd 
> >    personally call it the ".gitmodules" file, but whatever)
> > 
> >    This gives you the defaults, and the ability to change them.
> 
> Sorry to repeat the obvious.
> 
> I assume you talk about a versioned .gitmodules file tied to the
> superproject history, and any fetch/pull would look into this
> file from the current working directory to lookup the default URL.
> 
> Wouldn't this have the problem that when you check out an old
> revision of the superproject you get out-of-date URLs, so that
> a fetch does not work (without local overrides)?

If you check out an old revision, wouldn't you have that _already_, so it 
does not matter what URL is given in .gitmodules?

Ciao,
Dscho
