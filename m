From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.1-rc2
Date: Wed, 28 Jun 2006 23:40:55 -0700
Message-ID: <7vwtb0tqfc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 08:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvqCz-0004dp-5d
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 08:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWF2Gk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWF2Gk5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 02:40:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24971 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932672AbWF2Gk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 02:40:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629064056.CPXN8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 02:40:56 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22843>

The tip of "master" branch has been tagged as GIT 1.4.1-rc2.
Many fixes since v1.4.1-rc1 was done, but most notable are:

 - git-cvsimport to manage multiple branches are (hopefully)
   fixed now (Martin and Johannes).

 - git-rebase learned how to use 3-way merge backends by
   "git-rebase --merge" (Eric Wong).

 - git-svn updates (Eric Wong).

 - "git-commit -m" breakage was fixed (me).

Hopefully we can merge the format-patch fixes from Johannes,
which is still cooking in "next", and do the real 1.4.1 release
this weekend.
