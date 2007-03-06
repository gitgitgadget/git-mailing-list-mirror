From: Junio C Hamano <junkio@cox.net>
Subject: Short term release plans
Date: Tue, 06 Mar 2007 02:53:48 -0800
Message-ID: <7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 11:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOXJ0-0005BP-KW
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 11:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965654AbXCFKxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 05:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965833AbXCFKxu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 05:53:50 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59035 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965819AbXCFKxt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 05:53:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306105350.IYBB2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 05:53:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XNto1W00C1kojtg0000000; Tue, 06 Mar 2007 05:53:49 -0500
In-Reply-To: <20070306071630.GB24004@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Mar 2007 02:16:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41571>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Be nice to get them into your next release, whatever that winds
> up being.  ;-)

Surely git-gui 0.6.3 will be in 1.5.0.4, but I'd like to start
planning for 1.5.1 now.

In addition to what are described in the current 1.5.1 draft
release notes, I'd like to have a few topics graduated to
'master' and declare 1.5.1 by the end of the month.

That would mean we would have these biggies among other things
in 1.5.1:

Already in 'master':

 - git-apply subdirectory behaviour fix
 - git-remote update
 - git-bundle
 - working on filesystems without symbolic links
 - automatic CRLF munging
 - git-rev-list --boundary --max-count (broken)
 - /etc/gitconfig

Cooking in 'next':

 - git-diff --no-index
 - built-in git-revert/git-cherry-pick
 - git-rev-list --boundary --max-count fix (this is sorely
   needed to make "gitk -50 master" to work)
 - handling corrupt loose objects in git-fsck and unpack_sha1_file
 - commit --interactive
 - format-patch --inline/--attach

Not in 'next' yet, but would like to have in 1.5.1:

 - git-branch --track and git-checkout -B

In 'next' or 'pu' but needs more work, will not be in 1.5.1:

 - git-fetch half-C-rewrite.
 - .gitattributes (the code needs redesign --- handling multiple
   actions on a single path is nasty).
 - git-merge-subtree (subtree matching needs more work).
