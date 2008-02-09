From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 13:06:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091304440.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>  <20080209030046.GA10470@coredump.intra.peff.net>  <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:07:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNpQG-0000ev-G3
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbYBINGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYBINGj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:06:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:37246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754405AbYBINGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:06:38 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:06:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 09 Feb 2008 14:06:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+joPkDoF6jGDMsQUa/2BGazm8vOzEkK4aNLuaRgo
	hrqiS48b/ykypS
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73217>

Hi,

On Sun, 10 Feb 2008, Martin Langhoff wrote:

> And I don't completely follow how bad the impact of
> auto-fast-forwarding local tracking branches on a merge. If it's a
> fast-forward, my "local state" wasn't that exciting to begin with ;-)

Not necessarily.  Maybe you wanted to work on it, kept your local branch 
as a reminder.  Maybe even reset --hard to a known-bad commit.

The thing is: local is local is local.  If you muddy the clear 
distinctions, you will make semantics much harder to grasp.

Having said that, you _could_ introduce a command line option 
"--ff-local-branches", which would keep the semantics clean.

Ciao,
Dscho
