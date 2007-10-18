From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 22:58:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710182258000.25221@racer.site>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se> 
 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de> <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
 <Pine.LNX.4.64.0710181720010.25221@racer.site> <9EEDF284-22BE-44BF-A9B8-116407784BEB@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
	git <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IidOk-0000ry-Dl
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 23:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbXJRV7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756593AbXJRV7K
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 17:59:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:46666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756181AbXJRV7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 17:59:08 -0400
Received: (qmail invoked by alias); 18 Oct 2007 21:59:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 18 Oct 2007 23:59:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mE7g23GPm+9GFgs6OUHow1L+pivi0d/8Q15k/Wd
	+VBRH589Xm6qvc
X-X-Sender: gene099@racer.site
In-Reply-To: <9EEDF284-22BE-44BF-A9B8-116407784BEB@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61562>

Hi,

On Thu, 18 Oct 2007, Steffen Prohaska wrote:

> On Oct 18, 2007, at 6:21 PM, Johannes Schindelin wrote:
> 
> > On Thu, 18 Oct 2007, Joakim Tjernlund wrote:
> > 
> > > Seems like it is a bit too easy to make mistakes here. Why can I delete
> > > a branch with :linus but not create one with linus:linus?
> > 
> > I wonder why you bother with the colon at all.  Just
> > 
> > 	git push <remote> linus
> > 
> > and be done with it.  The colon is only there to play interesting games,
> > not something as simple as "push this branch" or "push this tag".
> 
> But you need a full refspec starting with 'refs/heads/' if you want to
> create a new branch on the remote side.

No.  Not if the name is the same on the local side.

Ciao,
Dscho
