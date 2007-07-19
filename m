From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add commit.editor configuration variable
Date: Thu, 19 Jul 2007 10:54:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191053230.14781@racer.site>
References: <11848235881723-git-send-email-aroben@apple.com>
 <7v7iox3oz8.fsf@assigned-by-dhcp.cox.net> <47EE39C7-0D57-48EC-B5A0-C10E49997E32@apple.com>
 <20070719062302.GG32566@spearce.org> <7v1wf451fc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 11:54:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSiE-0001Zf-P3
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXGSJyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXGSJyT
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:54:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:36789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750830AbXGSJyS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:54:18 -0400
Received: (qmail invoked by alias); 19 Jul 2007 09:54:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 19 Jul 2007 11:54:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//5e1oR1n/RZNfB0t+Nr4zKCgS9aXpiYLDoZHsMv
	3n0Wm7QdVLYm5Z
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wf451fc.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52957>

Hi,

On Wed, 18 Jul 2007, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > We only launch an editor for three reasons: commit messages, tag
> > messages and git-rebase -i.  If we were to ever add a new editor
> > using thingy, odds are the user would want the same editor by
> > default for that too.
> >
> > So please, core.editor, and also use it in git-rebase--interactive.
> 
> Ah, add "git-am -i" to the mix.  Potentially, git-notes would
> use it as well.

Now with so many commands in the lot, how about putting the code into 
git-sh-setup, into a function "get_editor()"?

Ciao,
Dscho
