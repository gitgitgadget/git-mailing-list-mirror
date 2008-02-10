From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 16:29:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101626201.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site> <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com> <20080210150216.GB8797@dervierte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOF4B-00050v-Fj
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbYBJQ3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbYBJQ3b
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:29:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:43777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750917AbYBJQ3a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:29:30 -0500
Received: (qmail invoked by alias); 10 Feb 2008 16:29:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 10 Feb 2008 17:29:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WdnZ7Z6/WtiY6GaGnW5wWl3pBNtSiF6tTi+Clf2
	bCemQQYMBPgR3D
X-X-Sender: gene099@racer.site
In-Reply-To: <20080210150216.GB8797@dervierte>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73366>

Hi,

On Sun, 10 Feb 2008, Steven Walter wrote:

> I propose a new configuration option, remote.*.pushAllRefs, defaulting 
> to off.  When pushAllRefs is false, "git push" pushes only the current 
> branch.  When pushAllRefs is true, "git push" does what it does today. 
> For the old-timers, the impact of such a change seems minimal. 
> Worst-case, they run "git push," it doesn't do what they expect, they 
> run "git push origin" and then go change their config files.

I don't like it.

This would mean that I would have to look into the config everytime before 
I push, to be sure what semantics the push has in _this_ repository.

_If_ we change git-push's default behaviour, we have to introduce an 
option to do what the default action is now, _first_!

And _then_ we can start discussing what the default action should be, and 
I tend to think that it would make sense to default to the synopsis.

But that comes _second_, and we'd have to agree on _one_ course of action.

I mean, if you do not like the default behaviour of git-push now, you can 
always introduce an alias, if you want repository/host-specific actions.

Ciao,
Dscho
