From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Wed, 8 Aug 2007 09:26:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708080923580.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site>
 <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
 <7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 10:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIgtS-00020x-OD
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 10:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXHHI1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 04:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbXHHI1o
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 04:27:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:43176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751024AbXHHI1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 04:27:41 -0400
Received: (qmail invoked by alias); 08 Aug 2007 08:27:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 08 Aug 2007 10:27:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bc2961ugbI9P7wjW5GKhbtACUxreyTsaqszHYjG
	uvTWBzLlL0WcuQ
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55305>

Hi,

On Tue, 7 Aug 2007, Linus Torvalds wrote:

> Everybody who takes patches will accept crud afterwards, since the 
> normal thing is to email them around, so there's no real downside to 
> adding some status output at the end. It shouldn't screw anything up, 
> but people will hopefully notice (sure, if you exit the pager without 
> looking at it all you wouldn't notice, but that's _already_ true, so..)

But then, you could output the message _twice_: first possibly in-between 
patches ("WARNING: ...") and then at the end.

However, I have the slight suspicion that people will not even notice.  I 
mean, we had bug reports on merge-recursive, where the reporter failed to 
even acknowledge the fact that merge-recursive said that there were 
conflicts, and even listed them.

So I have the slight suspicion that all this will accomplish is "shut the 
darn thing up", and old-timers will have a harder time, since they no 
longer spot easily when they did a Dumb Thing and left the index out of 
sync.

Slightly negative.

Ciao,
Dscho
