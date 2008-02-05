From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 5 Feb 2008 22:41:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802052236220.8543@racer.site>
References: <ve53xwob.fsf@blue.sea.net> <alpine.LSU.1.00.0802051524580.8543@racer.site> <prvbxfhl.fsf@blue.sea.net> <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMWV9-0000NZ-M4
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762463AbYBEWmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762348AbYBEWmR
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:42:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:44176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762460AbYBEWmO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:42:14 -0500
Received: (qmail invoked by alias); 05 Feb 2008 22:42:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp027) with SMTP; 05 Feb 2008 23:42:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8vaZa8+W8yfdEqp1/2l98pCZVKCOLhbc9w7TXo7
	wmNOM/fXF6A1OX
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802051334070.3110@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72713>

Hi,

[Jari, keep me Cc'ed.  I missed your mail, because you didn't.]

On Tue, 5 Feb 2008, Linus Torvalds wrote:

> It all makes perfect sense. Or rather, it made sense way back when. I 
> agree that it's just totally insane these days, and ".dotest/" should be 
> renamed to something like ".git/split/" or something.

But please, please, please not without a proper plan to keep people 
informed!  I.e. a switch-over plan with deprecation and all.  (IOW what I 
_already_ wrote to Jari.)

On at least one machine (not the current one, because I was too lazy), I 
have a git alias to call when the patch does not apply, to call another 
program in turn which made it easier for me to integrate a non-applying 
patch into the current working directory.

And guess what: this script accesses .dotest/.  Yes, I know, it was 
_prone_ to move.

But I am lucky, I read the git list regularly, I know what truck is going 
to hit me if I do not change that alias.

However, there are others.  And while we like to give everybody way too 
much rope, we should not willfully run a truck in the direction of 
unsuspecting users.

Ciao,
Dscho
