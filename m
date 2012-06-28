From: salmanmanekia <salmanmanekia@gmail.com>
Subject: Git Submodule would not work. The push does not work
Date: Thu, 28 Jun 2012 15:54:15 -0700 (PDT)
Message-ID: <1340924055050-7562323.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 00:54:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkNbQ-0007n5-D5
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 00:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836Ab2F1WyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 18:54:16 -0400
Received: from sam.nabble.com ([216.139.236.26]:50957 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853Ab2F1WyP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 18:54:15 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <salmanmanekia@gmail.com>)
	id 1SkNbL-0001be-2R
	for git@vger.kernel.org; Thu, 28 Jun 2012 15:54:15 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200798>

I have been trying to create a submodule in git After issuing the git
submodule init i see the folders for the submodule. After that i add, commit
and try to push those files in the master repo but it would not allow me to
do soo

Salman@PC_HOME ~/git/breakit-web-app (master)
$ git push origin master
error: refs/heads/master does not point to a valid object! 
Counting objects: 4, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 421 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
remote: bb/acl: salmanmanekia is allowed. accepted payload.
error: Ref refs/heads/master is at 6a47a0fd398610a75bdab8976f842dc0efd89f86
but expected 00000000000000000000000000000000000000000
remote: error: failed to lock refs/heads/master

To ssh://git@bitbucket.org/majuri/breakit-web-app.git
! [remote rejected] master -> master (failed to lock)
error: failed to push some refs to
'ssh://git@bitbucket.org/majuri/breakit-web-app.git'

--
View this message in context: http://git.661346.n2.nabble.com/Git-Submodule-would-not-work-The-push-does-not-work-tp7562323.html
Sent from the git mailing list archive at Nabble.com.
