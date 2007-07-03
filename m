From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 13:04:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031303130.4071@racer.site>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	quilt-dev@nongnu.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:04:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5h7q-0007GI-Fd
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035AbXGCMEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757960AbXGCMEk
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:04:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:60424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756861AbXGCMEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:04:39 -0400
Received: (qmail invoked by alias); 03 Jul 2007 12:04:38 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 03 Jul 2007 14:04:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RszoXrUNRA+kjAFpHEhSB4NrMZZAjDfBMzwSGdC
	EyuAi4VuBVE4jC
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51480>

Hi,

On Mon, 2 Jul 2007, Linus Torvalds wrote:

> On Mon, 2 Jul 2007, Junio C Hamano wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > 
> > > So I would suggest that in quilt and other systems, you either:
> > >
> > >  - strip all headers manually
> > >
> > >  - forget about "patch", and use "git-apply" instead that does things 
> > >    right and doesn't screw up like this (and can do rename diffs etc too).
> > >
> > > I guess the second choice generally isn't an option, but dammit, 
> > > "git-apply" really is the better program here.
> > 
> > Why not?  git-apply works outside of a git repo ;-)
> 
> I was more thinking that people are not necessarily willing to install git 
> just to get the "git-apply" program..

But maybe they would be willing to install git to get that wonderful 
git-apply program, and that wonderful rename-and-mode-aware git-diff, and 
the git-merge-file program, all of which can operate outside of a git 
repository. (Take that, hg!)

Ciao,
Dscho
