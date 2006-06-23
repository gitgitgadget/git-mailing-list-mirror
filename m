From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 01:57:50 -0700
Message-ID: <7vejxgckq9.fsf@assigned-by-dhcp.cox.net>
References: <20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 10:58:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FthUE-00055J-D9
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 10:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWFWI5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 04:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFWI5w
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 04:57:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:29385 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751249AbWFWI5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 04:57:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623085751.SFZG11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 04:57:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623011205.GJ21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 03:12:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22402>

Petr Baudis <pasky@suse.cz> writes:

> Also, is there any real problem with just using -fPIC?

Personally, not really, but I consider it a workaround having to
compile with -fPIC (being able to compile with -fPIC is a
feature).

Doesn't it have performance implications to use -fPIC when you
do not have to?

By the way, you also need to adjust the testsuite so that it
finds the Perl modules from freshly built tree before
installing.  I think (but haven't checked yet) the stuff written
in Python does that already, so you might want to mimic it.
