From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 12:07:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241207390.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:08:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIFY-0007TV-Ty
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440AbXGXLIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760332AbXGXLIS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:08:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:49246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759283AbXGXLIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:08:17 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:08:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 24 Jul 2007 13:08:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tT/dhSp2tH9HcqfKC+V81QzJmjMMPhUkpwz+lIa
	aV4MGXoaBlWiIT
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53565>

Hi,

On Tue, 24 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> While you guys are discussing this, please please keep in mind that there are
> >> Windows users (/me raises his hand) out there that really really want this
> >> too. So, please try to keep it light on the symlinks.
> >
> > Easy: use cygwin.
> >
> > Okay, a bit more seriously again: in the recent weeks, it seems that more 
> > and more Windows users are asking for features.  Since I guess you are a 
> > developer (why else would you want to use git), IMHO it is your itch to 
> > scratch.
> 
> I do not know this is an appropriate itch to scratch for a
> Windows developer to begin with.  The new-workdir setting *is*
> about symlinked .git/ metainfo space.  If somebody wants to work
> on a filesystem without symlink, he should not be using
> new-workdir but something else.  E.g. GIT_DIR + GIT_WORK_TREE,
> or perhaps GIT_DIR + core.worktree comes to mind.

... which reminds me that I wanted to overhaul that patch series.

Ciao,
Dscho
