From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: What are the correct arguments to git-svnimport?
Date: Sun, 30 Oct 2005 16:48:41 -0500
Message-ID: <20051030214841.GA8366@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 30 22:50:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWL2k-0000lr-BD
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 22:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVJ3Vsn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 16:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJ3Vsn
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 16:48:43 -0500
Received: from eastrmmtao05.cox.net ([68.230.240.34]:3045 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932355AbVJ3Vsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 16:48:42 -0500
Received: from localhost ([24.250.31.7]) by eastrmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030214837.MSFU28234.eastrmmtao05.cox.net@localhost>
          for <git@vger.kernel.org>; Sun, 30 Oct 2005 16:48:37 -0500
Received: from chris by localhost with local (Exim 4.43)
	id 1EWL2f-0002Xt-B3
	for git@vger.kernel.org; Sun, 30 Oct 2005 16:48:41 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10833>

I was trying to test the git-svnimport script but I've been unable to
get it to run. The docs really aren't very clear about the correct
values of <SVN_repository_URL> and <path>, so maybe I've gotten them
wrong.  Or maybe it just doesn't work.

I get tons of 'Unrecognized path: /project/trunk/...'

and I've tried various combinations of SVN_repository_URL and path:

SVN_repository_URL:
    http://svn.myhost.com/repo
    http://svn.myhost.com/repo/
    http://svn.myhost.com/repo/project
    http://svn.myhost.com/repo/project/
    http://svn.myhost.com/repo/project/trunk
    http://svn.myhost.com/repo/project/branches/mybranch

and <path>:
    *nothing*
    project
    project/trunk
    project/branches/mybranch
    http://svn.myhost.com/repo/project
    ...etc...

Can someone who actually uses svn-import send me the command-line they
use? Thanks.

-chris
