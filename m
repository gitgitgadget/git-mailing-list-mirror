From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn: nearing 1.0.0
Date: Mon, 20 Feb 2006 10:57:25 -0800
Message-ID: <11404618453236-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Feb 20 19:58:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBGE1-0001PS-Tz
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 19:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWBTS5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 13:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWBTS5a
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 13:57:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:55227 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932623AbWBTS50 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2006 13:57:26 -0500
Received: from untitled (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 915A72DC03A;
	Mon, 20 Feb 2006 10:57:25 -0800 (PST)
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16493>

      
This should hopefully be the last set of bugfixes I have for git-svn.  I'm
pretty satisfied with it, as I haven't needed to directly invoke svn and wait
for it in any of my day-to-day operations for doing work on svn repositories.

Most of the major changes are in 'commit' functionality where several
corner-case bugs have been found and fixed.

      git-svn: fix a typo in defining the --no-stop-on-copy option
      git-svn: allow --find-copies-harder and -l<num> to be passed on commit
      git-svn: Allow for more argument types for commit (from..to)
      git-svn: remove any need for the XML::Simple dependency
      git-svn: change ; to && in addremove()
      contrib/git-svn.txt: add a note about renamed/copied directory support
      git-svn: fix several corner-case and rare bugs with 'commit'
      contrib/git-svn: add Makefile, test, and associated ignores
      git-svn: 0.9.1: add --version and copyright/license (GPL v2+) information

 .gitignore                 |    4 
 Makefile                   |   32 +++
 git-svn.perl               |  382 +++++++++++++++++++++++++++++++--------------
 git-svn.txt                |   16 +
 t/t0000-contrib-git-svn.sh |  216 +++++++++++++++++++++++++
 5 files changed, 532 insertions(+), 118 deletions(-)

-- 
Eric Wong
