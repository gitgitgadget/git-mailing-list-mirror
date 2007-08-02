From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 11:48:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021147110.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:49:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGYEt-00009j-2G
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbXHBKs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753938AbXHBKs4
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:48:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753558AbXHBKsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:48:55 -0400
Received: (qmail invoked by alias); 02 Aug 2007 10:48:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 02 Aug 2007 12:48:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Af6s4OKuAy9p/xcfcCYtc9PdFQD4KodGX6Jbmr/
	m9B9HWy19sag/E
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqbqdq45ua.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54541>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 2 Aug 2007, Matthieu Moy wrote:
> >
> >> > If the feature still makes sense in the modern world is a
> >> > different story, but I do find it useful.
> >> 
> >> I understand that it can be usefull, but I really don't like having it
> >> by default (is there a way to deactivate it BTW?).
> >
> > Yes.  Just call "git status" and be done with it.
> 
> That's not what I mean (my original message mentionned that already
> BTW). By "deactivate", I mean "make git-diff never show empty diffs".
> I don't want to run two commands where I need only one.

Then don't touch the files you do not want to touch!  Or if you want to 
have it convenient, and have a script that touches everything, even if it 
does not change the contents, just add "git add -u" at the end of the 
script".  Not that difficult.

Ciao,
Dscho
