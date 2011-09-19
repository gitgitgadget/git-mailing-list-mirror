From: Manuel Reimer <manuel.spam@nurfuerspam.de>
Subject: Where is information of "git read-tree" stored?
Date: Mon, 19 Sep 2011 08:46:31 +0000 (UTC)
Message-ID: <loom.20110919T103707-867@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 10:46:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5ZV4-0005z4-1h
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 10:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1ISIqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 04:46:45 -0400
Received: from lo.gmane.org ([80.91.229.12]:50051 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1ISIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 04:46:44 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R5ZUx-0005ww-5l
	for git@vger.kernel.org; Mon, 19 Sep 2011 10:46:43 +0200
Received: from http-v.fe.bosch.de ([194.39.218.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 10:46:43 +0200
Received: from manuel.spam by http-v.fe.bosch.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 10:46:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.39.218.10 (Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110820 Firefox/6.0 SeaMonkey/2.3.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181668>

Hello,

following situation:

- Project hosted on GIT. Have a local copy and push to remote server.
- Small addon is hosted on a remote SVN server
- I now cloned the SVN to a local GIT (svn git clone)
- Then I used the instructions from here:

<http://git-mirror.googlecode.com/git-history/7444c60/howto/using-merge-subtree.html>

to get the local SVN copy merged into a subdirectory on my project GIT. Anything
worked well.

To test the worst case, I cloned my project GIT to a new local repository. The
remote connection to the local SVN copy was lost, so I recreated it.

Now, for some reason, I can immediately call

git pull -s subtree Bproject master

to pull changes from the SVN copy to the subdir... I didn't have to call "git
read-tree" again. Where is this information stored? Why does GIT know where the
remote repository data has to be placed to? Can I view this information? Can I
edit it?

Is there some information available somewhere on which data is pushed to server
and which is only in my local repo?

What will happen if my SVN checkout to local GIT repo gets lost? Can I just
clone this from SVN again, connect this to my project GIT and it will work just
well without problems? Or should I keep a copy of this GIT repo on server just
to be sure nothing bad happens?

Thanks in advance

Yours

Manuel
