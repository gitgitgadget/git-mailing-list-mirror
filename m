From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Sun, 09 Apr 2006 02:16:57 -0700
Message-ID: <7v1ww7cdme.fsf@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Apr 09 11:17:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSW2h-0006Fh-PH
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 11:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDIJQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 05:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWDIJQ7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 05:16:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26811 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbWDIJQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 05:16:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409091658.FYJO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 05:16:58 -0400
To: git@vger.kernel.org
In-Reply-To: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 09 Apr 2006 02:04:02 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18544>

Junio C Hamano <junkio@cox.net> writes:

> And this makes "git log" to take common diff-tree options, so
> that it can be used as "git whatchanged".

BTW, this is *not* "whatchanged" in that it does not omit the
log when there is no diff output.  It may not matter much --
when we give paths limiter to the command, the commits that are
shown are already limited by those paths limiter.
