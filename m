From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (part #1-2)
Date: Thu, 01 Jun 2006 02:27:00 -0700
Message-ID: <7vr729gra3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 01 11:27:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FljSM-00051O-Mq
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 11:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWFAJ1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 05:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFAJ1D
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 05:27:03 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12720 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750782AbWFAJ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 05:27:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060601092701.WOZP27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Jun 2006 05:27:01 -0400
To: git@vger.kernel.org
X-maint-at: be0c7e069738fbb697b0719f2252107261c9340e
X-master-at: 87840620fd77e39a0df91dc8b8db6cfdb5e4845a
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21110>

(this one is about "next" only -- I am bisecting)

* The 'next' branch, in addition, has these.

 - git-svnimport

   Florian Forster:
      git-svnimport: Improved detection of merges.

 - read-tree/write-tree --prefix

   Junio C Hamano:
      read-tree: --prefix=<path>/ option.
      write-tree: --prefix=<path>
      read-tree: reorganize bind_merge code.

 - format-patch

   Junio C Hamano:
      format-patch --signoff

 - tree parser updates

   Linus Torvalds:
      Add raw tree buffer info to "struct tree"
      Make "tree_entry" have a SHA1 instead of a union of object pointers
      Switch "read_tree_recursive()" over to tree-walk functionality
      Remove "tree->entries" tree-entry list from tree parser
      Make "struct tree" contain the pointer to the tree buffer
      Make "tree_entry" have a SHA1 instead of a union of object pointers
      Switch "read_tree_recursive()" over to tree-walk functionality
      builtin-read-tree.c: avoid tree_entry_list in prime_cache_tree_rec()
      Remove "tree->entries" tree-entry list from tree parser
      fsck-objects: avoid unnecessary tree_entry_list usage
      Remove unused "zeropad" entry from tree_list_entry
      Convert "mark_tree_uninteresting()" to raw tree walker
      Convert fetch.c: process_tree() to raw tree walker
      Remove last vestiges of generic tree_entry_list
      tree_entry(): new tree-walking helper function

 - fetch-pack into a repository with more root than the server

   Junio C Hamano:
      fetch-pack: give up after getting too many "ack continue"

 - http-fetch fixes

   Nick Hengeveld:
      http: prevent segfault during curl handle reuse
   Sean Estabrooks:
      Remove possible segfault in http-fetch.

 - reflog

   Junio C Hamano:
      fetch.c: do not pass uninitialized lock to unlock_ref().
   Shawn Pearce:
      Improve abstraction of ref lock/write.
      Convert update-ref to use ref_lock API.
      Log ref updates to logs/refs/<ref>
      Support 'master@2 hours ago' syntax
      Fix ref log parsing so it works properly.
      General ref log reading improvements.
      Added logs/ directory to repository layout.
      Force writing ref if it doesn't exist.
      Log ref updates made by fetch.
      Change 'master@noon' syntax to 'master@{noon}'.
      Correct force_write bug in refs.c
      Change order of -m option to update-ref.
      Include ref log detail in commit, reset, etc.
      Create/delete branch ref logs.
      Enable ref log creation in git checkout -b.
      Verify git-commit provides a reflog message.
      Test that git-branch -l works.
