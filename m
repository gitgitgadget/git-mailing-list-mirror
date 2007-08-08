From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when contents are unchanged
Date: Tue, 07 Aug 2007 20:44:14 -0700
Message-ID: <7vabt2667l.fsf@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 05:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIcT7-0005nQ-Ck
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 05:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934827AbXHHDoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 23:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934547AbXHHDoR
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 23:44:17 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64365 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934202AbXHHDoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 23:44:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808034416.VOTK23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 23:44:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZFkF1X0091kojtg0000000; Tue, 07 Aug 2007 23:44:16 -0400
In-Reply-To: <alpine.LFD.0.999.0708072004150.23971@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 7 Aug 2007 20:07:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55296>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Everybody who takes patches will accept crud afterwards, since the normal 
> thing is to email them around, so there's no real downside to adding some 
> status output at the end. It shouldn't screw anything up, but people will 
> hopefully notice (sure, if you exit the pager without looking at it all 
> you wouldn't notice, but that's _already_ true, so..)

Well, at least "hundreds of empty diff" has a value of getting
attention for even such a use case, so you _could_ argue this
patch is a regression ;-)

In any case, this will go in as part of the first batch after
1.5.3, I would guess.
