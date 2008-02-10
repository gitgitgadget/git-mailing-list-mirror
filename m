From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 02:15:50 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100213330.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site>
 <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:16:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1jz-0000Nh-2Z
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbYBJCPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbYBJCPs
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:15:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:53113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754361AbYBJCPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:15:47 -0500
Received: (qmail invoked by alias); 10 Feb 2008 02:15:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 10 Feb 2008 03:15:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bCHw22Q+bcFh/8VlZ/5O/IOAAkEpeERX2hmmKmJ
	ILyj3kcS8iYzuK
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73293>

Hi,

On Sat, 9 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The way would be like this, I think:
> >
> > - introduce a command line option for push, like "--push-common-refs", 
> > and issue a warning whenever "git push" is called without command line 
> > options (along the lines "This default behaviour is deprecated; please 
> > use --push-common-refs").
> >
> > - in a waaaay later version, just take away the default action of "git 
> > push", instead showing the usage.
> 
> I do not think that is a right approach.  To please both camps without 
> forcing people to
> 
>  (1) change what they are used to, and
>  (2) type overlong command line,
> 
> I think the traditional "matching refs by default", combined with "'git 
> push HEAD' defaults to pushing the current branch to the default 
> location" would be a well balanced compromise.

I'm no longer that sure.  It seems that quite a lot of people do not read 
manuals, and have no clue what they are doing when they just try

	$ git push

to see what the synopsis is.

If there are enough of those people out there, we might want to change our 
default action to "-h".

Yes, that hurts old-timers.  Yes, it's not a perfect world.  No, I don't 
want to bend over for just a few people.

Ciao,
Dscho
