From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Problems trying setup git assistance is needed.
Date: Thu, 5 Jun 2008 16:03:00 -0600
Message-ID: <Pine.LNX.4.64.0806051545260.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:04:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4NZH-0006ZQ-J2
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 00:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYFEWDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 18:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYFEWDE
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 18:03:04 -0400
Received: from zenez.com ([166.70.62.2]:14983 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbYFEWDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 18:03:03 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 48A5AE4A3D; Thu,  5 Jun 2008 16:03:01 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 2A51AE4A39
	for <git@vger.kernel.org>; Thu,  5 Jun 2008 16:03:01 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83987>

Hello,

I have been going through the various documents and I can not seem to find
what I need.  Could someone either tell me what commands to use or where
to read.

I have as follows

/master/cvs/
/master/git/
/master/hg/
/master/svn/

I download to the above the various source trees I need to work with.  I
have cron jobs to update the various source trees from the internet.  I
want to keep them clean of any and all local changes.

What I want to do is have a working directory as follows...

/working/cvs/
/working/git/
/working/hg/
/working/svn/

I want to bring into my /working/git/ the various source tress and have
them all managed bit git.  To meet the requirements for the various
management systems, I have to have their directory with a copy.  That is
why I have all the working/...

I have the enviroment variables set as follows

GIT_DIR=/master/git
GIT_WORK_TREE=/working/git

To start I have been trying to use git clone or the other tools to work,
such that I have working copies of all the /master/.... in my own
working git directory so I can compare changes between them.

git clone /master/git/git /working/git/git

worked and I am able to use the above to pull every thing for git, but the
tools to convert cvs, hg and svn do not seem to work.  What is the magic
to get them all in git?  I would prefer just to have the latest
development and stable branches in my working directory.  But I can fine
to the git clone of git from the docs.  Any assistance on getting
everythin over to git or hints is greatly appericiated.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
