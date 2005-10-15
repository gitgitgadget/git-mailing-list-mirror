From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git repository
Date: Fri, 14 Oct 2005 22:48:35 -0700
Message-ID: <7vwtkfpbyk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Oct 15 07:49:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQeui-0008NM-Ms
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 07:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJOFsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 01:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVJOFsh
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 01:48:37 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61693 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751070AbVJOFsh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 01:48:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015054827.VLCF16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 01:48:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10127>

The "master" branch has been updated with some "obviously
correct" updates, as usual.

In proposed updates, there are currently two topics.

One is the new tag dereference notation and showing the deref'ed
tag from the remote side via ls-remote I posted last night. 

I'd have this graduate to the "master" branch after some more
testing, only if people are interested in it; otherwise I'm
thinking about dropping this (I am not particularly interested
in this enhancement myself).

Another is the improved handling of funny characters in
pathnames.  The final notation follows what Paul Eggert outlined
in his message a couple of days ago -- C-style quoted string
enclosed in a pair of double-quotes.  I have not written formal
set of tests, but updated git-diff-*, git-ls-files, git-ls-tree,
and git-apply seem to do the right thing with my limited
hand-tests.
