From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 0.99.7b
Date: Thu, 22 Sep 2005 23:18:44 -0700
Message-ID: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 23 08:18:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIgtW-0004bx-N3
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 08:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIWGSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 02:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbVIWGSr
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 02:18:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:241 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750702AbVIWGSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 02:18:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923061846.ZUHF13739.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 02:18:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9159>

GIT 0.99.7b

Contains the following post-0.99.7a fixes:

 - Commit walker performance fix, mostly during walking commits
   in a downloaded packfile, thanks to Sergey Vlasov.

 - Squelch unnecessarily alarming error message from fetch and
   clone over rsync transport, when remote repository does not
   borrow anything from other repositories.

   I've seen enough people got annoyed/worried/alarmed after
   seeing this one on both git and linux-kernel list.

 - Documentation was not rebuilt before installation, noticed by
   Randal L Schwartz.

 - Fetching of objects over http transport got a bit safer.


Tarballs, RPMs and Debs are available at

	http://kernel.org/pub/software/scm/git/

Or, if you use git already:

	{http,rsync}://kernel.org/pub/scm/git/git.git/
