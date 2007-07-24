From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 10:02:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241002410.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:03:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGIa-0003ca-CD
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761155AbXGXJDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760288AbXGXJDR
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:03:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:52455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761155AbXGXJDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:03:16 -0400
Received: (qmail invoked by alias); 24 Jul 2007 09:03:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 24 Jul 2007 11:03:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197t41p2Vl7O+VU2rTVSr0trb8/Lx813A+IjHzgUq
	RYjO5ADem51JBb
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5B5F5.6000202@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53538>

Hi,

On Tue, 24 Jul 2007, Marius Storm-Olsen wrote:

> > > I live by new-workdir.  I do everything with it.  And today I
> > > just spent over an hour sorting out cases where my many, many
> > > workdirs have different refs than their base repositories,
> > > because their packed-refs files are different.
> > > Grrrrrrrrrrrrrrrrrr.
> > > 
> > > So we really need to make anyone that edits packed-refs (and maybe also
> > > config) resolve the symlink and do the edit in the target directory.  Then
> > > we can consider adding this workdir thing
> > >  to core git.
> > 
> > This is actually not limited to packed-refs file, but applies to other
> > things as well.
> > 
> > I have been wondering if something like this patch would be sufficient.  The
> > idea essentially is to take the lock on the link
> > target when we try to take a lock on something that is a symlink
> > pointing elsewhere.
> (..snip..)
> 
> While you guys are discussing this, please please keep in mind that there are
> Windows users (/me raises his hand) out there that really really want this
> too. So, please try to keep it light on the symlinks.

Easy: use cygwin.

Okay, a bit more seriously again: in the recent weeks, it seems that more 
and more Windows users are asking for features.  Since I guess you are a 
developer (why else would you want to use git), IMHO it is your itch to 
scratch.

Ciao,
Dscho

P.S.: Sorry if this came over as rude, but I am growing slightly annoyed 
by the expectation of so many that since it is Open Source, I should work 
for free.
