From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/4] Merging merge-trees changes to pasky-0.4
Date: Thu, 14 Apr 2005 23:00:28 -0700
Message-ID: <7vr7hco9z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 07:57:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJpU-0004QM-5e
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 07:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVDOGAf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 02:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDOGAf
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 02:00:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53746 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261735AbVDOGAa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 02:00:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415060028.FGGH7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 02:00:28 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I finally sync'ed up with Pasky 0.4.  Reviewing the diffs
between Linus tree and Pasky tree for the core part you seem to
have picked up some good changes (especially the byteorder one),
so I decided to rebase my changes.  So here it comes...

What follows are the 3 patches to the core part to support the
three-tree merge script, and another to introduce the script
itself.  I used to call it git-merge.perl, but now it is called
merge-trees (per request from Pasky to drop git- prefix, and
Linus has merge-tree that does not recurse while this one does
subdirectories).  The core functinality has not changed much.
The changes from the previous version at this point is still
code and interface cleanup only.

My next step will be to make it possible to tell it not to do
anything but just output recipe.

[PATCH 1/4] Add --cacheinfo option to update-cache
[PATCH 2/4] Add -z option to show-files
[PATCH 3/4] Add -r and -z options to ls-tree
[PATCH 4/4] Makefile change and merge-trees script itself.

The patches are against 516f2a088903a7b5f5a542de96b6a70c17856314

