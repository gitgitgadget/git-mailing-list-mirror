From: Bob Cotton <bob.cotton@rallydev.com>
Subject: git svn rebase does not follow new svn tags and branches
Date: Tue, 01 Apr 2008 14:51:47 -0600
Message-ID: <m28wzx5me4.fsf@rallydevelopment.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 22:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgnTN-0003Wz-Bv
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 22:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYDAUwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 16:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753364AbYDAUwE
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 16:52:04 -0400
Received: from smtp.rallydev.com ([67.88.103.130]:2116 "EHLO
	maldives.f4tech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751886AbYDAUwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 16:52:03 -0400
Received: from boblaptop-2.local.rallydevelopment.com ([10.1.0.121]) by maldives.f4tech.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 1 Apr 2008 14:51:58 -0600
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1.50 (darwin)
X-OriginalArrivalTime: 01 Apr 2008 20:51:58.0830 (UTC) FILETIME=[3A5DD0E0:01C8943A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78664>


I've been using git-svn for several weeks. After replaying svn using
git-svn clone and git-svn fetch, all branches and tags were replicated
in the git repo.

Now, after a workflow that includes git-svn rebase, but no git-svn
fetch(s), the new svn tags and branches are not being replicated.

I've read the code, and tried rebase --follow-parent. 

Thoughts?
- Bob
