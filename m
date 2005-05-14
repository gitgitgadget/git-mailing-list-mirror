From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] diff overhaul
Date: Fri, 13 May 2005 18:39:24 -0700
Message-ID: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 03:40:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWldY-0000eW-4f
	for gcvg-git@gmane.org; Sat, 14 May 2005 03:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVENBjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 21:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVENBjx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 21:39:53 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64903 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262668AbVENBj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 21:39:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050514013925.IPIT20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 21:39:25 -0400
To: pasky@ucw.cz, torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here are three patches to update diff we discussed earlier.

  [PATCH 1/3] Update mode-change strings in diff output.
  [PATCH 2/3] Rename git-diff-tree-helper to git-diff-helper.
  [PATCH 3/3] Rename git-diff-tree-helper to git-diff-helper (part 2).

The first one is to normalize the mode bits output to be more
machine friendly, which we discussed.

The second commit records only renames for two files and there
is no content change.  The third one is to change the Makefiles,
documentation, and also usage string in git-diff-helper itself.

I am deliverately doing the 2 and 3 in separate steps for two
reasons.  (1) to reduce the possibility of mistakes during the
rename for myself; (2) people doing the git repository browser
can use the commit trail for practicing their rename detection
logic.  So please keep these two steps separate when you commit.

