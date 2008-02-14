From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-branch -m interprets first argument differently when two
 are   supplied
Date: Thu, 14 Feb 2008 16:49:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141648120.30505@racer.site>
References: <47B3497A.9050703@nrlssc.navy.mil> <47B3EFC4.1020808@viscovery.net> <47B46C8E.5030905@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:50:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhHk-0006Ik-UD
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266AbYBNQtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758259AbYBNQtQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:49:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:37886 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754130AbYBNQtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:49:15 -0500
Received: (qmail invoked by alias); 14 Feb 2008 16:49:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 14 Feb 2008 17:49:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//PboDPK//jasM4F7mVN9CVfWA8QZCYiCcUE2J4c
	1LhBawLvW54yVj
X-X-Sender: gene099@racer.site
In-Reply-To: <47B46C8E.5030905@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73888>

Hi,

On Thu, 14 Feb 2008, Brandon Casey wrote:

> Johannes Sixt wrote:
> > Brandon Casey schrieb:
> >> The first non-option argument is interpreted differently depending on
> >> whether one argument or two arguments have been supplied.
> >>
> >> 	git-branch -m [<oldbranch>] <newbranch>
> >>
> >> Has anyone considered whether this is inconsistent with how other
> >> commands operate?
> > 
> > Funny, I fell into this trap just yesterday and accidentally renamed
> > my master branch to something else. IMO git-branch -m should take two
> > arguments. Full stop.
> 
> Actually, I think the single argument case is unambiguous and I would
> rather not give it up.
> 
> It's the two argument case that both expects its arguments in a 
> different order than other commands _and_ is dangerous in the case of 
> -M.

The order was specifically requested, as "mv" also has that order.

And "-M" is always dangerous.  Don't use it, if you don't know what you're 
doing.

AFAIR -M is even _marked_ as a dangerous command.

Ciao,
Dscho
