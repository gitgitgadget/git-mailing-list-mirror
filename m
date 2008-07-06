From: Nathan Kontny <nate@inklingmarkets.com>
Subject: git/refs/heads/master was not found in commit?
Date: Sun, 6 Jul 2008 15:53:13 -0500
Message-ID: <52B60E25-779D-446F-B24F-1EADD37FB541@inklingmarkets.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 22:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFbFS-00033M-7P
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 22:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbYGFUxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 16:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757451AbYGFUxT
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 16:53:19 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43864 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378AbYGFUxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 16:53:18 -0400
Received: by yw-out-2324.google.com with SMTP id 9so870310ywe.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 13:53:15 -0700 (PDT)
Received: by 10.151.113.5 with SMTP id q5mr6748041ybm.135.1215377595360;
        Sun, 06 Jul 2008 13:53:15 -0700 (PDT)
Received: from ?10.0.1.199? ( [207.181.242.141])
        by mx.google.com with ESMTPS id a48sm10872187pyh.20.2008.07.06.13.53.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 13:53:14 -0700 (PDT)
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87554>

I'm a newb to git.  I'm trying to "git svn clone" a tried and true  
subversion repo but it fails after scanning
the 2069 commit, and spits out:

vendor/plugins/locking/.git/refs/heads/master was not found in commit
484775a7dc66b9c91188a5ad52c30c371ff8d702 (r2068)

Which is right.  It isn't in 2068, it was checked in at 2069.

The 2069 commit was some code I had "git clone"d from github into a  
subfolder of the parent project
that's checked into subversion.  I've tried to replicate this behavior  
by checking in this same git repo into a
smaller svn repo and doing the git svn clone, but alas that time it's  
successful.

Anyone have any ideas how I can get around this?  Thank you!
