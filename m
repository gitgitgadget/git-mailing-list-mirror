From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 14:54:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241453350.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707241336090.14781@racer.site> <200707241547.16681.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKrF-0005HJ-4P
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXGXNzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbXGXNzV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:55:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:47713 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754377AbXGXNzR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:55:17 -0400
Received: (qmail invoked by alias); 24 Jul 2007 13:55:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 24 Jul 2007 15:55:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18b3Vg/vrkbWWCgiE2O+DhQaJKP0+/dS/u9BsRGAz
	D6l9tdUoZoIR1g
X-X-Sender: gene099@racer.site
In-Reply-To: <200707241547.16681.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53597>

Hi,

On Tue, 24 Jul 2007, Josef Weidendorfer wrote:

> On Tuesday 24 July 2007, Johannes Schindelin wrote:
> 
> > On Tue, 24 Jul 2007, Julian Phillips wrote:
> > 
> > > If you were going to avoid symlinks, then probably the cleanest way would be
> > > to have an explict way to point at the actual repo - rather than making the
> > > working look like a repo if you squint hard enough.  Which sounds rather like
> > > it would be an extension to GIT_DIR + GIT_WORK_TREE.
> > 
> > Almost.  .git/{config,HEAD} are not shared.
> 
> .git/index, too. And for .git/config, it would probably be better to merge the
> two config's (the one from "realGitDir" with 2nd priority).

I blame it on me being tired.  .git/config _is_ shared, and I meant to 
write "index" instead of "config" there.  Not really a typo, is it?

> > So it would be some extension  
> > that is triggered by something like
> > 
> > 	[core]
> > 		realGitDir = /bla/bla/.git/
> 
> That is more or less almost exacty the last agreement about how to
> implement the lightweight checkouts, a few months ago.

Oh?  I saw no code...  To me it is not an agreement, if no code comes out 
of it.

Ciao,
Dscho
