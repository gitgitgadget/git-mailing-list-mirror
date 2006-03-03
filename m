From: Eric Wong <normalperson@yhbt.net>
Subject: contrib/git-svn: polishing up
Date: Fri, 3 Mar 2006 01:20:07 -0800
Message-ID: <11413776074123-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6SM-0003xs-0I
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbWCCJUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbWCCJUK
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:10 -0500
Received: from hand.yhbt.net ([66.150.188.102]:63106 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752194AbWCCJUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:08 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 51BE12DC08D;
	Fri,  3 Mar 2006 01:20:07 -0800 (PST)
In-Reply-To: 
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17141>


Mostly small things: documentation and code cleanups.

One bugfix of some significance:
    
    Edited commit messages are parsed back to remotes/git-svn
    correctly.  The sequential commit optimization broke this :x

Significant new features:
    
    --branch/-b is interesting and fun for those of you who miss 'real'
    branch support in SVN.

    --authors-file/-A support, because git-svnimport has it :)

None of the core commit/fetch tree-writing code was touched.

 git-svn.perl |  210 ++++++++++++++++++++++++++++++++++++++++-------------------
 git-svn.txt  |   34 ++++++++-
 2 files changed, 176 insertions(+), 68 deletions(-)
