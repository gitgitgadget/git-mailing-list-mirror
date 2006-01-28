From: Junio C Hamano <junkio@cox.net>
Subject: Re: LCA06 Cogito/GIT workshop - (Re: git-whatchanged: exit out early on errors)
Date: Fri, 27 Jan 2006 22:32:22 -0800
Message-ID: <7v3bj8yia1.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<Pine.LNX.4.64.0601280047240.2909@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, keithp@keithp.com
X-From: git-owner@vger.kernel.org Sat Jan 28 07:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2jdO-000168-No
	for gcvg-git@gmane.org; Sat, 28 Jan 2006 07:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422820AbWA1GcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 01:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbWA1GcZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 01:32:25 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7678 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422820AbWA1GcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 01:32:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060128062948.KNEF17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 Jan 2006 01:29:48 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601280047240.2909@evo.osdl.org> (Linus Torvalds's
	message of "Sat, 28 Jan 2006 00:53:31 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15194>

Linus Torvalds <torvalds@osdl.org> writes:

> The point being that we'd fill in a template that the committer will 
> hopefully edit to explain what he did to fix up the merge for each file 
> that had conflicts.

That is a sound idea from the point of view of good practice.

While on the topic of conflicting merge, I've been wondering if
it would make sense to do the "combined diff" between stage 2,
stage 3 and the working tree file, in addition to the --ours and
--theirs enhancements you added lately.

This would let you sanity check the merge you _could_ commit, in
the same format you would see later when you examine the merge
commit.
