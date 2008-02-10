From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 12:20:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101219280.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802100213330.11591@racer.site> <20080210101756.GB26568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBB4-0008HK-El
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbYBJMUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYBJMUX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:20:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:36830 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752661AbYBJMUW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:20:22 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:20:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp044) with SMTP; 10 Feb 2008 13:20:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3dLwHs/b3CKu5I0hcxrdMEVrs0yJvbCrLWkHTcr
	jVncXCrMRpt13n
X-X-Sender: gene099@racer.site
In-Reply-To: <20080210101756.GB26568@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73342>

Hi,

On Sun, 10 Feb 2008, Jeff King wrote:

> On Sun, Feb 10, 2008 at 02:15:50AM +0000, Johannes Schindelin wrote:
> 
> > I'm no longer that sure.  It seems that quite a lot of people do not read 
> > manuals, and have no clue what they are doing when they just try
> > 
> > 	$ git push
> > 
> > to see what the synopsis is.
> > 
> > If there are enough of those people out there, we might want to change 
> > our default action to "-h".
> > 
> > Yes, that hurts old-timers.  Yes, it's not a perfect world.  No, I 
> > don't want to bend over for just a few people.
> 
> I am still not convinced that an option to change the default behavior 
> is unreasonable. Yes, it means that "git push" will do different things 
> depending on your confi$g. But "git push" is a _shorthand_, and if you 
> want to say things definitely, then say them: "git push --matching 
> origin" or "git push HEAD" (assuming that a "--matching" option would 
> exist to specify what is now the default behavior).

Well, I am not completely opposed to changing the default behaviour, be 
that showing the synopsis or pushing HEAD to origin.

But _do_ give old-timers some time to adjust, _if_ you want to change the 
default behaviour.

Ciao,
Dscho
