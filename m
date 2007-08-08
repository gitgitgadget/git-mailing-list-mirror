From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Wed, 08 Aug 2007 01:43:40 -0700
Message-ID: <7v3ayu5scj.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021050500.14781@racer.site>
	<vpqbqdq45ua.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0708021147110.14781@racer.site>
	<AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
	<Pine.LNX.4.64.0708021541520.14781@racer.site>
	<46B1F3F4.5030504@midwinter.com>
	<Pine.LNX.4.64.0708021614420.14781@racer.site>
	<20070803053717.GA16379@midwinter.com>
	<alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
	<7v4pjc9czm.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
	<Pine.LNX.4.64.0708080923580.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Steven Grimm <koreth@midwinter.com>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 10:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIh8u-0005mb-5D
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 10:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353AbXHHInm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758098AbXHHInm
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 04:43:42 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44468 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbXHHInl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 04:43:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808084341.TTXR1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 8 Aug 2007 04:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ZLjg1X0081kojtg0000000; Wed, 08 Aug 2007 04:43:40 -0400
In-Reply-To: <Pine.LNX.4.64.0708080923580.14781@racer.site> (Johannes
	Schindelin's message of "Wed, 8 Aug 2007 09:26:58 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55307>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So I have the slight suspicion that all this will accomplish is "shut the 
> darn thing up", and old-timers will have a harder time, since they no 
> longer spot easily when they did a Dumb Thing and left the index out of 
> sync.

The hardest hit would be old-timers who try to be friendly by
trying to help new people, who has much less chance to notice
and report these much less prominent warnings, over e-mail or
irc.
