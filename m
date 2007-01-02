From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Mon, 01 Jan 2007 16:07:19 -0800
Message-ID: <7vzm9247go.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 01:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1XBc-0006PD-V9
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbXABAHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 19:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbXABAHW
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 19:07:22 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:40467 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbXABAHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 19:07:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070102000720.LLVN3976.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Mon, 1 Jan 2007 19:07:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 607a1W00D1kojtg0000000; Mon, 01 Jan 2007 19:07:35 -0500
To: git@vger.kernel.org
X-maint-at: e6d40d65df07059fc655fabe62fa5b575ead7815
X-master-at: f4bf2184ae8b79f95b9f56c1ea5455d04e559299
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35751>

A happy new year.

I think this is more-or-less it to start the -rc1 cycle.  

I'll leave the window open for another week or so before people
come back from the christmas and new year break.  I have not
been working on any of the potential changes other people talked
about recently on the list, but things like detached HEAD and
more generic per-branch customization may magically materialize
from somewhere as a robust and usable set of patches.

I also haven't reviewed the introductory documentation set
recently, which I think is necessary before the release.

I'll be sending out an updated draft for v1.5.0 release notes in a
separate message.

* The 'master' branch has these since the last announcement.

   Eric Wong (3):
      git-svn: remove svnadmin dependency from the tests
      git-svn: t/t9100-git-svn-basic: remove old check for NO_SYMLINK
      git-svn: t/t91??-*: optimize the tests a bit

   J. Bruce Fields (6):
      Docs: update cvs-migration.txt to reflect clone's new default behavior
      Documentation: update git-clone.txt for clone's new default behavior
      Documentation: update glossary entry for "origin"
      Documentation: update tutorial's discussion of origin
      Documentation: update git-pull.txt for new clone behavior
      Documentation: remove master:origin example from pull-fetch-param.txt

   Junio C Hamano (12):
      send-pack: fix pipeline.
      Documentation: illustrate send-pack pipeline.
      Update documentation for update hook.
      send-pack.c: use is_null_sha1()
      send-pack: tell pack-objects to use its internal rev-list.
      Do not merge random set of refs out of wildcarded refs
      i18n: do not leak 'encoding' header even when we cheat the conversion.
      Update send-pack pipeline documentation.
      fail pull/merge early in the middle of conflicted merge
      git-fetch: remove .keep file at the end.
      Strongly discourage --update-head-ok in fetch-options documentation.
      Update clone/fetch documentation with --depth (shallow clone) option

   Shawn O. Pearce (4):
      Move better_branch_name above get_ref in merge-recursive.
      Allow merging bare trees in merge-recursive.
      Use merge-recursive in git-am -3.
      Add test case for update hooks in receive-pack.

   Theodore Tso (1):
      Fix formatting for urls section of fetch, pull, and push manpages
