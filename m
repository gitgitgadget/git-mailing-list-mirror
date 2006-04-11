From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 10 Apr 2006 21:40:57 -0700
Message-ID: <7v3bgk7mhy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 11 06:41:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTAgm-0003QQ-Bz
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 06:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDKElA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 00:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDKElA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 00:41:00 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37630 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750868AbWDKElA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 00:41:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060411044059.IXKS15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Apr 2006 00:40:59 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18608>

No real 1.3.0 yet...

* The 'master' branch has these since the last announcement.
  All of them are fixes and clean-ups (except --parents stuff
  from Linus which seems safe enough).

Junio C Hamano:
      git-log: match rev-list --abbrev and --abbrev-commit
      diff: fix output of total-rewrite diff.
      diffcore-rename: fix merging back a broken pair.
      Retire diffcore-pathspec.
      Retire git-log.sh
      Retire git-log.sh (take#2)

Linus Torvalds:
      Make "--parents" logs also be incremental

Marco Roeland:
      xdiff/xdiffi.c: fix warnings about possibly uninitialized variables

Petr Baudis:
      Improve the git-diff-tree -c/-cc documentation


* The 'next' branch, in addition, has these.

  - diff-* --patch-with-raw
  - Implement limited context matching in git-apply (Eric W. Biederman)

  - log-tree: separate major part of diff-tree.
  - git log [diff-tree options]...

I should not be moving anything new from "next" to "master"
before 1.3.0, but I am inclined to include the --patch-with-raw
change, which Cogito wants.  Also apply -Cn by Eric seems safe
enough; as long as you do not ask for it, it keeps the existing
behaviour.  The initial part of "git log with diff-tree options"
seems safe enough so it is also in 'next'.

I have the rest of "git log with diff-tree options", along with
its fallouts, which turned out to be more than what I wanted to
see, in "pu".
