From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git today
Date: Wed, 28 Dec 2005 15:32:14 -0800
Message-ID: <7vbqz0ajcx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 29 00:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErkmV-000643-4O
	for gcvg-git@gmane.org; Thu, 29 Dec 2005 00:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVL1XcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 18:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVL1XcS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 18:32:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58599 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932553AbVL1XcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 18:32:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051228233115.TVKL6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Dec 2005 18:31:15 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14105>

GIT 1.0.6 was silently pushed out.  Again, it has one notable
fix among minor test fixes.

 - Do not mark tags fetched via --tags flag as mergeable.

   This is to fix "git pull --tags"; it tried to merge all of
   the tags by mistake --- it should not merge any of them.

I have verified that the patch by Gerrit to fix merge-order test
is correct, but have not got around to apply it yet.

The master branch has the following enhancements in addition to
what is in 1.0.6.  I intend to have 1.1 release with them early
next year, when I come back from the new year break.

 - "git clone -o branchname" to specify name of the branch used
   to keep track of the upstream (Johannes).
 
 - "core.sharedrepository" and "git init-db --shared" to help
   group writable repositories (Johannes).

 - IPV6 literal address in git networking protocol (Hideaki).

 - "git pack-redundant" is more efficient (Lukas).

 - "git describe" and associated Makefile changes to give GIT
   releases a bit more descriptive names (Linus and me).

 - "git checkout <treeish> <path>..." and "git checkout -- <path>..."
   can be used to restore named paths even from a subdirectory.

 - git-receive-pack propagates hooks' refusal to update back to
   git-send-pack.

I'll be away from the network and will be back on the second
week of January.  I wish everybody a happy new year.
