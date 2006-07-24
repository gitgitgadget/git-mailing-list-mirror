From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] support cover letter before commit log, using "+++"
Date: Sun, 23 Jul 2006 23:54:22 -0700
Message-ID: <7v1wsbfq75.fsf@assigned-by-dhcp.cox.net>
References: <20060723214524.GC20068@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 08:54:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4uKn-0000NQ-19
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 08:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWGXGy3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbWGXGy3
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 02:54:29 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:42668 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751423AbWGXGy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 02:54:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060724065428.TCRI18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Jul 2006 02:54:28 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060723214524.GC20068@admingilde.org> (Martin Waitz's message
	of "Sun, 23 Jul 2006 23:45:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24127>

Martin Waitz <tali@admingilde.org> writes:

> We already have a "---" separator to end the commit log.
> But writing the cover letter after this separator looks strange.
> Now it is possible to put the cover letter and comments both before
> or after the commit log, as the author sees fit.
>
> Just put the commit log between lines starting with "+++" and "---".
>
> Signed-off-by: Martin Waitz <tali@admingilde.org>

I do not have problem with the implementation itself, but

* I always had an impression that cover letters are tolerated
  not encouraged.  In other words, as a good practice it would
  be nice if necessary information is described in the commit
  log messages themselves.  Do we want to start encouraging the
  cover letter with this patch?

* Has anybody ever used that "+++" as an auxiliary separator?
  In other words, is it an established convention?  If not,
  would it be a good convention that we would want to establish
  here?
