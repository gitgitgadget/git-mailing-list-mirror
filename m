From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] gitweb: Get rid of failed experiments ;-)
Date: Sun, 27 Aug 2006 15:22:19 -0700
Message-ID: <7vac5px1ic.fsf@assigned-by-dhcp.cox.net>
References: <200608272343.14653.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 00:21:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHT0u-0000vA-7b
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWH0WVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 18:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWH0WVu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:21:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53649 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751176AbWH0WVt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 18:21:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060827222148.CEHA21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Sun, 27 Aug 2006 18:21:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FAMm1V00E4Noztg0000000
	Sun, 27 Aug 2006 18:21:46 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608272343.14653.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 27 Aug 2006 23:43:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26123>

Jakub Narebski <jnareb@gmail.com> writes:

> Remove unused subroutines or subroutines which don't work correctly from 
> gitweb.

I'll apply both, thanks.  [2/2] had a fuzz at the very end of
the second hunk (your base version do not have -M to diff-tree
parameter anymore) but that was easy to deal with.

Also thanks for the reminder about "typo in git_patchset_body".
