From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 09 May 2007 01:47:12 -0700
Message-ID: <7vbqguwfhr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 10:47:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlhpT-0004ud-Js
	for gcvg-git@gmane.org; Wed, 09 May 2007 10:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbXEIIrP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 04:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbXEIIrP
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 04:47:15 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59823 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbXEIIrO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 04:47:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509084713.UEEG13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 04:47:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wwnC1W00T1kojtg0000000; Wed, 09 May 2007 04:47:13 -0400
X-master-at: fba23c87fda0ac6698f191db6df57b8fdf23e2f8
X-next-at: 40686ce8a744bb9a6b5d4fff0a74ef71cb0b6d40
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46682>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

As before, there is nothing to see here, before v1.5.2 final.

* dh/repack (Tue May 8 13:05:04 2007 -0700) 5 commits
 - git-repack --max-pack-size: add option parsing to enable feature
 - git-repack --max-pack-size: split packs as asked by
   write_{object,one}()
 - git-repack --max-pack-size: write_{object,one}() respect pack
   limit
 - git-repack --max-pack-size: new file statics and code
   restructuring
 - Alter sha1close() 3rd argument to request flush only
* jc/blame (Fri Apr 20 16:25:50 2007 -0700) 4 commits
 - blame: show log as it goes
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
