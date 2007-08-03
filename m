From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Fri, 3 Aug 2007 11:23:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031121000.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 12:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGuK4-0007b2-Bb
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 12:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067AbXHCKXz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 06:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758967AbXHCKXz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 06:23:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:35317 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758917AbXHCKXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 06:23:54 -0400
Received: (qmail invoked by alias); 03 Aug 2007 10:23:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 03 Aug 2007 12:23:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NNlhDd9mNLua1ocq5UlTOzzOIdA6pkp6+rDAjkN
	PK9kA37xxGg4UD
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3az1qgdg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54702>

Hi,

On Thu, 2 Aug 2007, Junio C Hamano wrote:

> Steven Grimm <koreth@midwinter.com> writes:
> 
> > 	Okay, enough arguing about whether the empty diff lines are
> > 	useful or not -- here's a patch to get rid of them.
> 
> I do not think this addresses anything but -p (i.e. textual
> diff) output.  If we _were_ to really do this, I think the patch
> I sent earlier today, with possible improvements I suggested,
> would be a better direction to go.

But I'd really think that what should be done (if anything has to be done 
at all) is to introduce a config variable which triggers the same logic in 
git-diff as was introduced in 2b5f9a8c0cff511f2bb0833b1ee02645b79323f4.

Ciao,
Dscho
