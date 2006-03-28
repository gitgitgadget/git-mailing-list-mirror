From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Mon, 27 Mar 2006 16:28:44 -0800
Message-ID: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 28 02:29:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO24o-0007ig-0H
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWC1A2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWC1A2r
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:28:47 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34026 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751176AbWC1A2q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 19:28:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328002845.ZMZK20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 19:28:45 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18097>

GIT 1.3.0-rc1 is pushed out and will be mirrored out soon.

All of the things that were not in the "master" branch were
either cooked long enough in "next" without causing problems
(e.g. insanely fast rename detector or true built-in diff) or
isolated in a specific subsystem (e.g. tar-tree and svnimport).

So I am clearing the deck to prepare for a 1.3.0.  Remaining
wrinkles, if any, will be ironed out in the "master" branch.

------------
Changes since the last announcement:

 - updates around git-clone:
   . --use-separate-remote
   . --reference <repo>
   . fetch,parse-remote,fmt-merge-msg: refs/remotes/* support (Eric Wong)
   . sha1_name() understands refs/remotes/$foo/HEAD

 - sha1_name safety and core.warnambiguousrefs

 - git-merge knows some strategies want to skip trivial merges

 - insanely fast rename detection (Linus and me)

 - tar-tree updates (Rene Scharfe)

 - send-email updates (Eric Wong)

 - truly built-in diff (Linus with Davide)

 - ls-{files,tree} --abbrev (Eric Wong)

 - git-svnimport: if a limit is specified, respect it (Anand Kumria)

 - documentation (J. Bruce Fields)

 - build fix (Johannes Schindelin)

 - git-ls-files --others --directory --no-empty-directory (Petr Baudis)

 - gitk updates (Martin Mares, Paul Mackerras)

 - GIT 1.3.0 rc1 (me)

Currently "next" and "pu" are empty.
