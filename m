From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 10:51:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021050500.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 11:51:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXLS-0007cS-0s
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 11:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbXHBJvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 05:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbXHBJvr
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 05:51:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:47609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752705AbXHBJvq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 05:51:46 -0400
Received: (qmail invoked by alias); 02 Aug 2007 09:51:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 02 Aug 2007 11:51:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ND4YBhMPNN21jD7VCqtkbtcYH7bgmUR3HoWb0jp
	mEfXrUninkgxhp
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqhcni47ek.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54531>

Hi,

On Thu, 2 Aug 2007, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> >
> >> $ touch bar
> >> $ git diff
> >> diff --git a/bar b/bar         <--- here ---<
> >> $ git status
> >> # On branch master
> >> nothing to commit (working directory clean)
> >> $ git diff                     <--- status updated
> >>                                     the stat in the index.
> >>
> >> Is this intended,
> >
> > Yes.  Very much so, intentionally, from very early days of git.
> > This serves as a reminder to the user that he started editing
> > but changed his mind to end up with the same contents as the
> > original, until the next "update-index --refresh" (which is
> > internally invoked from "status").
> >
> > If the feature still makes sense in the modern world is a
> > different story, but I do find it useful.
> 
> I understand that it can be usefull, but I really don't like having it
> by default (is there a way to deactivate it BTW?).

Yes.  Just call "git status" and be done with it.

Ciao,
Dscho
