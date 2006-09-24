From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Kill Git.xs for now
Date: Sun, 24 Sep 2006 03:38:22 -0700
Message-ID: <7vwt7ta6sh.fsf@assigned-by-dhcp.cox.net>
References: <20060923181849.28753.56984.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fork0@t-online.de (Alex Riesen)
X-From: git-owner@vger.kernel.org Sun Sep 24 12:38:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRNT-000531-JE
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 12:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWIXKiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 06:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWIXKiY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 06:38:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40657 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751947AbWIXKiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 06:38:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924103823.XQQP13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 06:38:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SAeQ1V00S1kojtg0000000
	Sun, 24 Sep 2006 06:38:25 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27653>

Petr Baudis <pasky@suse.cz> writes:

> This patch removes Git.xs from the repository for the time being. This
> should hopefully enable Git.pm to finally make its way to master.

It's a bit sad, but I think this is a sane thing to do.

I suspect Alex still has problem with Makefile.PL due to issues
around ActiveState (slash vs bs and CRLF line ending if I recall
correctly)?
