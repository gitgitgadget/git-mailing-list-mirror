From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 13:35:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031334350.4071@racer.site>
References: <20070702125450.28228edd.akpm@linux-foundation.org> 
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org> 
 <20070702142557.eba61ccd.akpm@linux-foundation.org> 
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org> 
 <20070702145601.a0dcef0f.akpm@linux-foundation.org> 
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org> 
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> 
 <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0707031303130.4071@racer.site>
 <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:36:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5hbp-000512-P4
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXGCMfw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbXGCMfv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:35:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:41857 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752287AbXGCMfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:35:51 -0400
Received: (qmail invoked by alias); 03 Jul 2007 12:35:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp017) with SMTP; 03 Jul 2007 14:35:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HSqQciHJHGtxiR22pIRHycnMHTK4O96d6x/O0oE
	ey8en3lF7+YqOo
X-X-Sender: gene099@racer.site
In-Reply-To: <4d8e3fd30707030521k6cb3129dy9193344e9e1eccf7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51485>

Hi,

On Tue, 3 Jul 2007, Paolo Ciarrocchi wrote:

> On 7/3/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > On Mon, 2 Jul 2007, Linus Torvalds wrote:
> > > On Mon, 2 Jul 2007, Junio C Hamano wrote:
> > > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > >
> > > > > So I would suggest that in quilt and other systems, you either:
> > > > >
> > > > >  - strip all headers manually
> > > > >
> > > > >  - forget about "patch", and use "git-apply" instead that does things
> > > > >    right and doesn't screw up like this (and can do rename diffs etc
> > too).
> > > > >
> > > > > I guess the second choice generally isn't an option, but dammit,
> > > > > "git-apply" really is the better program here.
> > > >
> > > > Why not?  git-apply works outside of a git repo ;-)
> > >
> > > I was more thinking that people are not necessarily willing to install
> > git
> > > just to get the "git-apply" program..
> > 
> > But maybe they would be willing to install git to get that wonderful
> > git-apply program, and that wonderful rename-and-mode-aware git-diff, and
> > the git-merge-file program, all of which can operate outside of a git
> > repository. (Take that, hg!)
> 
> How about shipping just these commands as a separate package?
> Is that a cray idea?

Heh, all three programs are "builtins", which means that you get almost 
the whole package of git anyway ;-)

Ciao,
Dscho
