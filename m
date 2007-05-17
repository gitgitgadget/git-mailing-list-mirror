From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 16 May 2007 17:21:07 -0700
Message-ID: <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 02:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoTkZ-0003P0-3y
	for gcvg-git@gmane.org; Thu, 17 May 2007 02:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbXEQAVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760142AbXEQAVK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 20:21:10 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55887 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbXEQAVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 20:21:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517002108.SCJI6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 20:21:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 00M61X00f1kojtg0000000; Wed, 16 May 2007 20:21:07 -0400
X-master-at: d26c4264e584a1a8cbadbc161fa52cf947f5230a
X-next-at: 77e153bc9c38130616467500beecf05922d34e5f
In-Reply-To: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 13 May 2007 15:29:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47472>

It probably would be more interesting to look at the earlier
"What's not in 1.5.2" messages, but here is the current status
of my tree on the 'next' and 'pu' front.

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* mst/connect (Wed May 16 20:09:41 2007 +0300) 1 commit
 + connect: display connection progress
* db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
 - Update local tracking refs when pushing
 - Add handlers for fetch-side configuration of remotes.
 - Move refspec parser from connect.c and cache.h to remote.{c,h}
 - Move remote parsing into a library file out of builtin-push.
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref
* dh/repack (Sun May 13 12:47:09 2007 -0700) 9 commits
 - git-repack --max-pack-size: add option parsing to enable feature
 - git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 - git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 - git-repack --max-pack-size: new file statics and code
   restructuring
 - Alter sha1close() 3rd argument to request flush only
 + Custom compression levels for objects and packs
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
* sp/cvsexport (Thu May 10 01:06:36 2007 +0200) 1 commit
 + Optimized cvsexportcommit: calling 'cvs status' once instead of
   once per touched file.
* dh/pack (Wed May 9 13:56:50 2007 -0700) 3 commits
 + Custom compression levels for objects and packs
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
* tt/gc (Wed May 9 15:48:39 2007 -0400) 1 commit
 + Add --aggressive option to 'git gc'
* np/pack (Wed May 9 14:42:42 2007 -0400) 3 commits
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused
* sv/checkout (Wed May 9 12:33:20 2007 +0200) 1 commit
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref
* jb/statcolor (Sat May 5 16:48:54 2007 -0400) 1 commit
 + Add colour support in rebase and merge tree diff stats output.
* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
