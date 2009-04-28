From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 0/9] Various StGit updates
Date: Tue, 28 Apr 2009 16:09:35 +0100
Message-ID: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp00-0002lt-20
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762109AbZD1PKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762102AbZD1PK3
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:29 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48876 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762067AbZD1PK1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:27 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6TZm026995;
	Tue, 28 Apr 2009 16:06:29 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:21 +0100
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:21.0471 (UTC) FILETIME=[72EB0AF0:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117786>

These are the patches in my "proposed" branch to be moved into master
once reviewed.

Thanks.


Catalin Marinas (9):
      Use the default git colouring scheme rather than specific scripts
      Add the log --clear option
      Reinstate the --annotate option for refresh
      Convert 'unhide' to the lib infrastructure
      Convert 'hide' to the lib infrastructure
      Convert 'clone' to the use stgit.lib
      Do not sleep after the last patch sent by e-mail
      Show some progress information when checking for upstream merges.
      Show "Pushing <patch>...done" when pushing a patch


 contrib/diffcol.sh        |   51 ---------------------------------------------
 examples/gitconfig        |    4 ++--
 setup.py                  |    3 +--
 stgit/commands/clone.py   |   30 +++++++++++---------------
 stgit/commands/common.py  |    8 +++++++
 stgit/commands/diff.py    |    2 ++
 stgit/commands/hide.py    |   44 +++++++++++++++++++++------------------
 stgit/commands/log.py     |    9 +++++++-
 stgit/commands/mail.py    |   15 ++++++++-----
 stgit/commands/refresh.py |   13 +++++++++--
 stgit/commands/show.py    |    1 +
 stgit/commands/unhide.py  |   39 +++++++++++++++++++---------------
 stgit/config.py           |   10 ++++-----
 stgit/lib/git.py          |    4 ++++
 stgit/lib/transaction.py  |   15 ++++++++-----
 15 files changed, 117 insertions(+), 131 deletions(-)
 delete mode 100755 contrib/diffcol.sh

-- 
Catalin
