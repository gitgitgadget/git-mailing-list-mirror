From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Implement git-cp.
Date: Sun, 10 Feb 2008 12:33:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101230160.11591@racer.site>
References: <38b2ab8a0802031023y2ed7a5aax6d3c404b08757a4d@mail.gmail.com> <vpq63x5swsj.fsf@bauges.imag.fr> <m3tzkp6eqz.fsf@localhost.localdomain> <20080210011203.GL25954@genesis.frugalware.org> <alpine.LSU.1.00.0802100125510.11591@racer.site>
 <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBNq-0002uL-MT
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbYBJMdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbYBJMdc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:33:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:40650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755544AbYBJMdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:33:31 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:33:30 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp046) with SMTP; 10 Feb 2008 13:33:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8lBMnQU38jOp1SW8A/WSdyarOhW/siEetBdd/rm
	FUwn6C7PhzTf/y
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlu9uu7c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73346>

Hi,

On Sat, 9 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you touch builtin-mv.c already, why not just move cmd_cp() in 
> > there?  It's not like it would be the first cmd_*() function living in 
> > the same file as other cmd_*() functions.
> 
> Why do we even want "git-cp", especially when git-mv and git-rm are 
> already pretty much redundant commands?
> 
> Especially, why do we even encourage copy-and-paste?

Heh.  I quote:

	If you want to shoot yourself in the foot Git will point you to 
	the gun rack and show you how to load the bullets. (Masukomi)

But yeah, I did not really think about it.  I had the impression 
originally that it would make sense to copy a few tracked files around, in 
order to modify them.

Think "kernel module".  You'd not start from scratch, but find a similar 
one, and then change the heck out of it.

But your comment made me think again: It's better to "cp" those 
files/directories, and then "git add" the relevant ones.  It even avoids 
stupid mistakes where you commit something you "cp"ed, but did not need.

Ciao,
Dscho
