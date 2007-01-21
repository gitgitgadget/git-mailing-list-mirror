From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sat, 20 Jan 2007 19:17:49 -0800
Message-ID: <7vr6tp5aqq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<200701210137.41219.robin.rosenberg.lists@dewire.com>
	<Pine.LNX.4.63.0701210234350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17842.53449.35322.514320@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 04:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8TDW-0002eW-Mr
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 04:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbXAUDRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 22:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAUDRv
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 22:17:51 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56335 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154AbXAUDRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 22:17:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121031750.NPKW9717.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Sat, 20 Jan 2007 22:17:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DfGu1W00R1kojtg0000000; Sat, 20 Jan 2007 22:16:55 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17842.53449.35322.514320@lisa.zopyra.com> (Bill Lear's message
	of "Sat, 20 Jan 2007 20:32:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37306>

Bill Lear <rael@zopyra.com> writes:

> How about a '--order' switch?
>
>    --order=chrono[logical]
>    --order=rev[erse][-chrono[logical]] (default)
>
> The switches "--reverse" and "--noreverse" are certainly confusing in
> the context of a default that is "reverse chronological order".

I think --reverse is just fine.  It is "reverse" from usual, and
people already know (or they should learn) what the usual order
is.

> BTW, my mailer is defaulting to sending mail to the original poster,
> CCing others, including the mailing list.  I'm used to simply replying
> to the list.  Is this the proper convention here, to reply directly to
> humans and CC the list?

I only speak for myself, but I always prefer to address my
message's To: header to the person I am primarily talking to,
while leaving other people on Cc: line (which usually includes
the list address).
