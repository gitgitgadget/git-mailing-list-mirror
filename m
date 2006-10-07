From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: [commit view] Do not suppress commitdiff link in root commit
Date: Sat, 07 Oct 2006 00:25:52 -0700
Message-ID: <7vmz88ziwv.fsf@assigned-by-dhcp.cox.net>
References: <20061006165933.4127.72491.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 09:26:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW6ZL-0002Dt-0S
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 09:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWJGHZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 03:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbWJGHZx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 03:25:53 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36584 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932695AbWJGHZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 03:25:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007072552.QHDO26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 03:25:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XKRv1V0051kojtg0000000
	Sat, 07 Oct 2006 03:25:55 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006165933.4127.72491.stgit@rover> (Petr Baudis's message of
	"Fri, 06 Oct 2006 18:59:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28456>

Petr Baudis <pasky@suse.cz> writes:

> There's no reason for that, the commitdiff view is meaningful for the
> root commit as well and we link to it everywhere else.

It probably is not any more useful than the blob view but I
agree there is no strong reason to supress it, as long as the
commitdiff page is prepared to show the root commit (which I
haven't checked -- if you have --root you should be Ok).
