From: Martin Renold <martinxyz@gmx.ch>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Tue, 30 Jun 2009 17:14:42 +0200
Message-ID: <20090630151442.GA20688@old.homeip.net>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628185218.GB8634@sigio.peff.net> <20090628210117.GA7821@old.homeip.net> <20090630053304.GB29643@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 17:15:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLf3M-0002KA-3f
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 17:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754AbZF3POk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbZF3POk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 11:14:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:36276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752800AbZF3POj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 11:14:39 -0400
Received: (qmail invoked by alias); 30 Jun 2009 15:14:41 -0000
Received: from 84-74-83-103.dclient.hispeed.ch (EHLO bazaar) [84.74.83.103]
  by mail.gmx.net (mp013) with SMTP; 30 Jun 2009 17:14:41 +0200
X-Authenticated: #1936982
X-Provags-ID: V01U2FsdGVkX1+LPpQ/9GmLkpmdlgNFkRio3CApfA8fwmjqCM1JM+
	RaDuAGfISu2XOF
Received: from martin by bazaar with local (Exim 4.69)
	(envelope-from <martinxyz@gmx.ch>)
	id 1MLf2g-0006BG-9x; Tue, 30 Jun 2009 17:14:42 +0200
Content-Disposition: inline
In-Reply-To: <20090630053304.GB29643@sigio.peff.net>
X-Virus: Hi! I'm a header virus! Copy me into yours and join the fun!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122519>

On Tue, Jun 30, 2009 at 01:33:05AM -0400, Jeff King wrote:
> If it is convenience you want, perhaps you would be even happier with:
>   git config status.showUntrackedFiles no

No, that doesn't help in my usecase. I want to be reminded about the
untracked files by default because I intend to clean them up later.

> [...] but we have to deal with the fact that "git status" is really a
> dry-run version of "git commit", which already has a "-q" option

Good point. However I think those commands are similar only from an
implementation point of view.  As an user I think of them as being quite
different.  I would not be surprised about different meaning of options -
certainly less than about "git commit -a" vs "git add -u".

> So I am a little hesitant to endorse its use in "git status" for something
> unrelated (and I am hesitant to have redundant command line options, as
> well).

Yes I understand that. I'm using a wrapper script for now, but if it was any
other one-letter shortcut, I would prefer to learn that instead.

bye,
Martin
