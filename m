From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Sun, 3 Feb 2008 22:43:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802032237320.7372@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:44:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLna2-00080B-OC
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbYBCWoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbYBCWoW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:44:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:57867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbYBCWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:44:21 -0500
Received: (qmail invoked by alias); 03 Feb 2008 22:44:19 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp006) with SMTP; 03 Feb 2008 23:44:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M3yxkvkSM/182UlVC3kK+DrVjyISo4CrraHhd3b
	Tg5ssi37A9cFRg
X-X-Sender: gene099@racer.site
In-Reply-To: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72414>

Hi,

On Sun, 3 Feb 2008, Mark Levedahl wrote:

> This patch series was inspired by several issues dealing with multiple 
> remotes and submodules. The tests added as the last patch demonstrate 
> the specific use pattern to be supported, and that does not work 
> currently.

It seems that everytime you send a new patch series, it gets longer/more 
complicated/affects more and more of git.

As far as I understood, your problem was _purely_ a submodule issue.  I 
find it utterly unnerving that you keep trying to sneak in _anything_ 
unrelated to submodules.

Such as the origin issue.

I am getting pretty angry that you keep trying to complicating things in 
that area!  origin is origin is origin.  It is the default remote.  It is 
what you can change to fetch from somewhere else _by default_.  So I 
absolutely detest your changes in that regard, who help _noboy_ except 
people who like confusion.

So just change remote.origin.url, but do not mess up our nice source code.

If your issue is with git-submodule, then fix _that_, and do not "fix" 
_anything_ else.

Thankyouverymuch,
Dscho
