From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 14 Jan 2006 12:35:23 -0800
Message-ID: <7vslrqfsz8.fsf@assigned-by-dhcp.cox.net>
References: <dp3qpb$7uk$1@sea.gmane.org>
	<7voe2prniw.fsf@assigned-by-dhcp.cox.net>
	<43C91B25.9030707@research.att.com>
	<7v1wzaliv0.fsf@assigned-by-dhcp.cox.net>
	<43C95E25.3070006@research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:35:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exs7W-0006r5-K9
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWANUf0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWANUf0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:35:26 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62104 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751086AbWANUf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:35:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060114203431.ZCGN15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 14 Jan 2006 15:34:31 -0500
To: John Ellson <ellson@research.att.com>
In-Reply-To: <43C95E25.3070006@research.att.com> (John Ellson's message of
	"Sat, 14 Jan 2006 15:25:09 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14681>

John Ellson <ellson@research.att.com> writes:

> Anyway, this is above and beyond doing something with sed to
> fix the '-' issue.

What I am saying is that until that issue of ordering is
resolved (and I highly suspect it is unsolvable) I think it is
dangerous and more confusing to let binary packages be built,
and it is better to simply forbid it like in the current
scheme.

BTW, if we _were_ to do a sed, please do s/-/./g instead; the
underscore breaks Debian if I am not mistaken.
