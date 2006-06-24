From: Junio C Hamano <junkio@cox.net>
Subject: Re: x86 asm SHA1 (draft)
Date: Sat, 24 Jun 2006 00:03:00 -0700
Message-ID: <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 09:03:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu2Ad-0002HT-KW
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 09:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbWFXHDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 03:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932940AbWFXHDE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 03:03:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24494 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932935AbWFXHDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 03:03:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624070301.LMFF5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 03:03:01 -0400
To: linux@horizon.com
In-Reply-To: <20060624012202.4822.qmail@science.horizon.com>
	(linux@horizon.com's message of "23 Jun 2006 21:22:02 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22489>

linux@horizon.com writes:

> Well, I'm not sure it's worth this much trouble.  Both of my PPC
> implementations are smaller and faster than the current one,
> so that's a pretty easy decision.  The difference between them
> is 2-3%, which is, I think, not enough to be worth the maintenance
> burden of a run-time decision infrastructure.  Just pick either one
> and call it a day.
>...
> Not that numbers are bad, but I think that until there's a real
> need for more than a single good-enough version per instruction set,
> this is excessive.

OK.  I somehow got an impression that your two versions had
quite different performance characteristics on G4 and G5 and
there was a real choice.  If they are between a few per-cent,
then I agree it is not worth doing at all.
