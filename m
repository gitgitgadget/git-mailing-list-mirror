From: Junio C Hamano <junkio@cox.net>
Subject: Re: Documentation Directions
Date: Sun, 06 Nov 2005 12:11:13 -0800
Message-ID: <7vek5ty1su.fsf@assigned-by-dhcp.cox.net>
References: <E1EYoQE-0002QX-VM@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 21:12:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYqrc-0003KO-Ho
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 21:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVKFULQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 15:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKFULQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 15:11:16 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28544 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750796AbVKFULP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 15:11:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106201049.ZQER9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 15:10:49 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EYoQE-0002QX-VM@jdl.com> (Jon Loeliger's message of "Sun, 06
	Nov 2005 11:35:14 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11225>

Jon Loeliger <jdl@freescale.com> writes:

> Couple of questions regarding documentation direction:
>
> - Is the plan to update all docs to use $GIT_DIR instead of .git?

I personally feel we should use less (not more) $GIT_DIR in the
documentation and casual mention of things under .git/ directory
should say .git/ instead, with the understanding that the reader
have already learned that there is a way to override it if the
user chooses to do so.

> - Do we intend on adding explicit support for '--help' on most,
>   if not all, of the git commands?

I think that would be very helpful.

>     - Do you want to standardize on using a '$' prompt
>       for all the example command executions samples?

Ah, I see you recently added a couple of Csh style '%' prompt.
Also I suspect that some examples in earlier tutorial do not
even have any prompt.

You are right -- being consistent would be nice.
