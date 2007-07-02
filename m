From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 01 Jul 2007 17:16:58 -0700
Message-ID: <7vd4zb3bid.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	<7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
	<7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 02:17:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I59bC-0006Pp-8W
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 02:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbXGBARA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 20:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbXGBARA
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 20:17:00 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61762 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbXGBAQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 20:16:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702001658.BQZT1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 20:16:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JQGy1X0051kojtg0000000; Sun, 01 Jul 2007 20:16:58 -0400
X-master-at: 71e55854fd6e5c9ce786bcd20efef43bd56f9df0
X-next-at: b0e5e47e8a7695549ff7732f4570538f981ae80d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51331>

Here are the topics that have been cooking in 'next'.

* ns/stash (Sun Jul 1 15:29:01 2007 -0700) 3 commits
 + git-stash: require "save" to be explicit and update documentation
 + Document git-stash
 + Add git-stash script

I am hoping this would appear in 1.5.3; it would help what many
people asked (and later we probably would want to invoke it in
git-merge to have an option to automated the process further).

* js/rebase (Mon Jun 25 18:59:43 2007 +0100) 6 commits
 + Teach rebase -i about --preserve-merges
 + rebase -i: provide reasonable reflog for the rebased branch
 + rebase -i: several cleanups
 + ignore git-rebase--interactive
 + Teach rebase an interactive mode
 + Move the pick_author code to git-sh-setup

Will merge.

* jc/diffcore (Thu Jun 28 23:14:13 2007 -0700) 4 commits
 + diffcore-delta.c: Ignore CR in CRLF for text files
 + diffcore-delta.c: update the comment on the algorithm.
 + diffcore_filespec: add is_binary
 + diffcore_count_changes: pass diffcore_filespec

Will merge; although the CRLF stuff itself would probably not
help anybody in real-life, the change in the interface to allow
further enhancement would be a good thing.

* ew/svn (Wed Jun 13 02:23:28 2007 -0700) 1 commit
 + git-svn: allow dcommit to retain local merge information

Any negative feedback on this?  Otherwise will merge.

* jo/init (Thu Jun 7 07:50:30 2007 -0500) 2 commits
 + Quiet the output from git-init when cloning, if requested.
 + Add an option to quiet git-init.

Opinions?
