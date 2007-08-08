From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Wed, 8 Aug 2007 10:23:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708081022440.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
 <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
 <Pine.LNX.4.64.0708080923580.14781@racer.site> <7v3ayu5scj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 11:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhlm-00061W-8P
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbXHHJXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 05:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757874AbXHHJXx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:23:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:59416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757864AbXHHJXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:23:52 -0400
Received: (qmail invoked by alias); 08 Aug 2007 09:23:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 08 Aug 2007 11:23:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Nm3Z78ohNm3nzJO3CyNtCog9YmPIuUdZXc9SMQc
	EbwTPgfPh3P/gR
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3ayu5scj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55313>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > So I have the slight suspicion that all this will accomplish is "shut the 
> > darn thing up", and old-timers will have a harder time, since they no 
> > longer spot easily when they did a Dumb Thing and left the index out of 
> > sync.
> 
> The hardest hit would be old-timers who try to be friendly by
> trying to help new people, who has much less chance to notice
> and report these much less prominent warnings, over e-mail or
> irc.

True.  It is even bigger than that annoyance to people who know how git 
works.

Ciao,
Dscho
