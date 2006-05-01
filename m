From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Transitively read alternatives
Date: Mon, 01 May 2006 13:56:36 -0700
Message-ID: <7v1wvdsbuj.fsf@assigned-by-dhcp.cox.net>
References: <20060501203631.GH20847@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 22:56:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FafRi-0006eH-7o
	for gcvg-git@gmane.org; Mon, 01 May 2006 22:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWEAU4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 16:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWEAU4j
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 16:56:39 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25217 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932256AbWEAU4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 16:56:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501205638.QTHZ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 16:56:38 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060501203631.GH20847@admingilde.org> (Martin Waitz's message
	of "Mon, 1 May 2006 22:36:33 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19389>

Martin Waitz <tali@admingilde.org> writes:

> When adding an alternate object store then add entries from its
> info/alternates files, too.
>
> Signed-off-by: Martin Waitz <tali@admingilde.org>

Happy.  Sometimes it pays off to leave things that can be
improved as they are, mention just "we might want to do this
instead", and forget about it myself.  Somebody else comes in
and fixes it for me ;-).

If you have a local copy of Linus, Jeff and David trees, you
could arrange Jeff tree to borrow from Linus and David, and
David tree to borrow from Linus and Jeff.  I wonder what the new
code does when you add a new repository that borrows from Jeff
and David.  Does it borrow from Linus twice?  Four times?  Does
it stop without falling into endless recursion?  I did not do
this myself because I was lazy and did not want to address these
issues.
