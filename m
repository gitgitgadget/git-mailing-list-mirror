From: Junio C Hamano <junkio@cox.net>
Subject: Re: merging initial part of a branch?
Date: Fri, 13 Jan 2006 11:50:44 -0800
Message-ID: <7v4q477vqj.fsf@assigned-by-dhcp.cox.net>
References: <20060111230451.GH8618@fieldses.org>
	<7vek3epbs9.fsf@assigned-by-dhcp.cox.net>
	<20060112005531.GB14599@fieldses.org>
	<7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
	<20060113030837.GD27214@fieldses.org>
	<7v8xtkhj5l.fsf@assigned-by-dhcp.cox.net>
	<20060113151005.GA29804@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 20:51:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExUx4-0002nC-Dk
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 20:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422903AbWAMTu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 14:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422906AbWAMTuv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 14:50:51 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:33481 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1422903AbWAMTur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 14:50:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113194816.IUQO17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 14:48:16 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14641>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> ....  Plain git
> actually seems to have pretty usable interfaces at this point, but it's
> not always obvious where to find them....

I share that feeling too, especially in the documentation area.

Last time we had something very nice going on in this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/12917

whose the key article is:

    http://article.gmane.org/gmane.comp.version-control.git/13360

but the general sentiment was that having another document is
making things more confusing and we should try to clarify the
main documentation instead. Pasky said aptly:

    http://article.gmane.org/gmane.comp.version-control.git/13410

I am not much of a documentation person myself, and I do not
have much interaction with people new to git, without which it
is hard to know which point is harder to grasp and what
documentation pages assume certain things are known to an
uninitiated when they should not.

So I would really appreciate documentaiotn patches to clarify
the current mess ;-).

> I also have Yet Another Git Tutorial, at
> http://www.fieldses.org/~bfields/kernel/git.html.  (Corrections and
> suggestions welcomed.)

The $prefix defaults to $HOME/bin/.  Having $bindir on $PATH
ought to be enough and exporting GIT_EXEC_PATH is not needd.

Other than that I did not see anything obviously wrong, although
I suspect you did not intend to say clone with stgit.
