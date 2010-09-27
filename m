From: Chris Auston <causton81@gmail.com>
Subject: git-svn dcommit problem with subversion mirror
Date: Mon, 27 Sep 2010 15:13:18 +0000 (UTC)
Message-ID: <loom.20100927T170109-0@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 17:15:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0FQb-0008T5-9y
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130Ab0I0PPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:15:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:52426 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759579Ab0I0PPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:15:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P0FQ1-000893-5F
	for git@vger.kernel.org; Mon, 27 Sep 2010 17:15:05 +0200
Received: from pool-173-66-81-83.washdc.fios.verizon.net ([173.66.81.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:15:05 +0200
Received: from causton81 by pool-173-66-81-83.washdc.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:15:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.66.81.83 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.63 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157337>

Sorry if this has already been discussed.  I did not see it when I searched the
archive.  I love git and started using the git-svn bridge at work.  I found that
dcommit would sometimes stop abrubtly when dcommiting with a strange error
message; sorry, I didn't save the message, but I believe the problem was cloning
the svn mirror instead of the main svn repo.

I realized I was git-svn clone'ing our svn mirror instead of the main 
repository.  Our mirror is setup so that commits have to go back to the main
repo and then propogate back to the mirror, so sometimes the commit you just
made to the mirror isn't immediately available.  I think that tripped up
git-svn.  It might be helpful in the short term to make a note of that somewhere
when discussing git-svn.

Also, I realize that with Git it doesn't make sense to use the mirror since
there will be less interaction with the main repo.

I love the "Pro Git" book!  Great work.
