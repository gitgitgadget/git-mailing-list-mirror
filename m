From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 12:36:43 -0600
Message-ID: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:38:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6rg4-0005AF-OT
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 20:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbYFLSgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbYFLSgq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 14:36:46 -0400
Received: from zenez.com ([166.70.62.2]:5638 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753092AbYFLSgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 14:36:45 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 54CF1E7F1F; Thu, 12 Jun 2008 12:36:43 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 48D8AE7F0C
	for <git@vger.kernel.org>; Thu, 12 Jun 2008 12:36:43 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84770>

Hello,

I have a local svn of about 100 svn projects.  I have sripts that update 
via svn all these repo's daily.  What I want to do is to import these 
local svn tree's into git.  I can not seem to get it to work.

This is the latest attempt.

git-svnimport -C /working/git/project /master/svn/pub-svn/category/project

The above seems to work with the remote url's, but I really need to be 
able to update my working copies of svn and cvs into git.

I have as follows...

/master/cvs/category/project/
/master/svn/category/project/
/master/git/categroy/project/

/working/cvs/category/project/
/working/svn/category/project/
/working/git/category/project/

All my master stuff is being updated automatically.  My working is being 
updated as well via the various management systems.  What I am having 
problems doing is the automation of cvs and svn into my working git.

Git pulls from master git to the working git project without a problem.  
I want all the projects under git.  What I have now or want is in

/working/git/category/project

Examples of categories are

X11
audio
db
devtools
ebus
emulators
fileutils
gnome
interp
java
libraries
mail
net
qt
shells
shellutils
sysadmin
textproc

so for example

I want to have

/working/git/interp/perl
/working/git/interp/php
/working/git/interp/python

And have it updated via cron from my master repo's.  Could anyone shed 
some light on the best way to do this?

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
