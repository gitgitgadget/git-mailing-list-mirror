From: Steven Scott <steven@codemettle.com>
Subject: git-svn dcommit Filesystem has no item
Date: Thu, 17 Feb 2011 20:51:17 -0500
Message-ID: <AANLkTi=xsUu2MNXUDDV_UC-62CX=agswC-2FT=TP8ezC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 02:51:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqFVa-0002rr-Me
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 02:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab1BRBvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 20:51:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41554 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab1BRBvi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 20:51:38 -0500
Received: by iyj8 with SMTP id 8so3017193iyj.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 17:51:38 -0800 (PST)
Received: by 10.231.34.201 with SMTP id m9mr104646ibd.81.1297993898332; Thu,
 17 Feb 2011 17:51:38 -0800 (PST)
Received: by 10.231.11.133 with HTTP; Thu, 17 Feb 2011 17:51:17 -0800 (PST)
X-Originating-IP: [173.160.92.129]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167152>

I've been having a problem that I can't find any answers for online.

I'm using git 1.7.3.4 on OSX 10.6 from the installer.

I've got a subversion repository cloned that has a space in the URL. I
put "%20" in the URL when i cloned the repository.

Sometimes when I do a git svn dcommit - usually when I'm going to
commit a new file or (especially) a renamed file it errors out like
so:

> git svn dcommit
Committing to http://10.0.0.1/svn/Internal Projects/project/trunk ...
Filesystem has no item: '/svn/!svn/bc/1467/Internal' path not found at
/usr/local/git/libexec/git-core/git-svn line 574


The "1467" is always (I believe) the latest svn commit.

I've already git svn rebase'd before this.

The only way I've found around it is to make a patch and make the
change directly in subversion, checkin with the same comment, and then
rebase my git.

Please tell me somebody has some insight into this...

--
Steven Scott
