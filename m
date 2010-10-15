From: Pretty Boy Floyd <boxerab@gmail.com>
Subject: Git Stash stages files if there is a conflict
Date: Fri, 15 Oct 2010 20:13:27 +0000 (UTC)
Message-ID: <loom.20101015T220924-952@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 22:15:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6qgt-0000bB-Au
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 22:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552Ab0JOUP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 16:15:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:53007 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932498Ab0JOUPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 16:15:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P6qgB-0000Az-H8
	for git@vger.kernel.org; Fri, 15 Oct 2010 22:15:03 +0200
Received: from 199.212.7.17 ([199.212.7.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 22:15:03 +0200
Received: from boxerab by 199.212.7.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 22:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 199.212.7.17 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.10) Gecko/20100914 AskTbFXTV5/3.8.0.12304 Firefox/3.6.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159136>

Hello!

I am running msysgit 1.7.3.1.  If I run stash apply, and there is a conflict,
all of my stash changes get staged. Is this the correct behaviour? I found it a
little surprising.

Another question: if I have stashed 10 files, and there is a conflict in one of
them, will stash apply abort when it has a conflict, or will it apply all
non-conflicted files.


Finally, if I do the following:

git stash
git pull
git stash apply

and another developer has removed a file that I have stashed, then I am unable
to apply the stash  on this file. How can I retrieve my changes from the stash?


Thanks!
