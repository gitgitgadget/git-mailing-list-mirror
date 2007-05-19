From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Fri, 18 May 2007 22:48:49 -0700
Message-ID: <7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 07:48:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHoF-0000Uj-SG
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbXESFsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 01:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXESFsv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:48:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35425 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755525AbXESFsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 01:48:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519054849.PUHP22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 01:48:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0top1X00D1kojtg0000000; Sat, 19 May 2007 01:48:50 -0400
X-master-at: 404fdef22f1084141aeef5781d5a322554fed481
X-next-at: a489e62da283f5e7c31bc5868752ff97b4318e6d
In-Reply-To: <7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 16 May 2007 17:21:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47718>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

------------------------
To graduate immediately after 1.5.2, after 'maint' forks from
it.

* jb/statcolor (Sat May 5 16:48:54 2007 -0400) 1 commit
 + Add colour support in rebase and merge tree diff stats output.

* tt/gc (Wed May 9 15:48:39 2007 -0400) 1 commit
 + Add --aggressive option to 'git gc'

* np/pack (Wed May 9 14:42:42 2007 -0400) 3 commits
 + deprecate the new loose object header format
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused

* sv/checkout (Wed May 9 12:33:20 2007 +0200) 1 commit
 + git-update-ref: add --no-deref option for overwriting/detaching
   ref

* mst/connect (Wed May 16 20:09:41 2007 +0300) 1 commit
 + connect: display connection progress

* dh/pack (Wed May 9 13:56:50 2007 -0700) 3 commits
 + Custom compression levels for objects and packs
 + make "repack -f" imply "pack-objects --no-reuse-object"
 + allow for undeltified objects not to be reused

------------------------
To be re-reviewed and then merged to 'next' after 1.5.2.

* db/remote (Tue May 15 22:50:19 2007 -0400) 5 commits
 - Update local tracking refs when pushing
 - Add handlers for fetch-side configuration of remotes.
 - Move refspec parser from connect.c and cache.h to remote.{c,h}
 - Move remote parsing into a library file out of builtin-push.

* dh/repack (Sun May 13 12:47:09 2007 -0700) 9 commits
 - git-repack --max-pack-size: add option parsing to enable feature
 - git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 - git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 - git-repack --max-pack-size: new file statics and code
   restructuring
 - Alter sha1close() 3rd argument to request flush only

------------------------
I've queued this series only because I trust Pasky, not because I
looked at the code deeply.  I am not sure about this one's use
of JavaScript is acceptable (I haven't looked at the code and do
not even know if that is optional X-<  Yes, I know, My Bad).

* pb/web (Sat May 19 02:13:39 2007 +0200) 6 commits
 - gitweb: Clearly distinguish regexp / exact match searches
 - gitweb: Lift any characters restriction on searched strings
 - git-rev-list: Add regexp tuning options
 - gitweb: Remove git_blame (superseded by git_blame2)
 - gitweb: Extra columns in blame
 - gitweb: Incremental blame

------------------------
On hold.

* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
