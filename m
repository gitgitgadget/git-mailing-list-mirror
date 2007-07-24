From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Tue, 24 Jul 2007 13:37:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241336090.14781@racer.site>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
 <Pine.LNX.4.64.0707222205050.23426@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222223460.14781@racer.site>
 <Pine.LNX.4.64.0707222234020.5382@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707222255010.14781@racer.site>
 <Pine.LNX.4.64.0707222302170.19212@reaper.quantumfyre.co.uk>
 <Pine.LNX.4.64.0707230000020.14781@racer.site> <20070723035644.GC32566@spearce.org>
 <7v1wezohi4.fsf@assigned-by-dhcp.cox.net> <46A5B5F5.6000202@trolltech.com>
 <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net>
 <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 24 14:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDJeZ-0001vh-Pq
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 14:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656AbXGXMiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 08:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbXGXMiC
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 08:38:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:39519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755115AbXGXMiB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 08:38:01 -0400
Received: (qmail invoked by alias); 24 Jul 2007 12:37:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 24 Jul 2007 14:37:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WTBYM8lsWdBWynxD3FijX8LZCqbfQGBXZ6+Emk9
	ZM7FCkoQ3jz+1e
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707241252040.28577@reaper.quantumfyre.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53580>

Hi,

On Tue, 24 Jul 2007, Julian Phillips wrote:

> If you were going to avoid symlinks, then probably the cleanest way would be
> to have an explict way to point at the actual repo - rather than making the
> working look like a repo if you squint hard enough.  Which sounds rather like
> it would be an extension to GIT_DIR + GIT_WORK_TREE.

Almost.  .git/{config,HEAD} are not shared.  So it would be some extension 
that is triggered by something like

	[core]
		realGitDir = /bla/bla/.git/

Hmm?

Ciao,
Dscho
