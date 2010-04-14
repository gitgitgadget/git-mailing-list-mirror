From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.4.4.0 Release
Date: Wed, 14 Apr 2010 10:19:59 +0800
Message-ID: <u2r1976ea661004131919s6210d992t822655ea5a84bee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-announce@googlegroups.com,
	tortoisegit-users@googlegroups.com, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 04:20:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1sD5-0001a1-Dz
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 04:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0DNCUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 22:20:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51404 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480Ab0DNCUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 22:20:00 -0400
Received: by pwj9 with SMTP id 9so5945975pwj.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=LwoTepcRZM2LGTfJZDJXHj1B3sFN7QSmrwHi5XmRolw=;
        b=Bwp/MgUH0TrFbkfPv24p3uvS84i2xBzUQPm7o0eGWH5aSrA/JmeuImByvGjQeFSuhw
         MvzpgFOGHAJWIopjTDflM2AzzlnCY+oqBmkDZs1RUE8tfjQnOl1KXf98oZGhwYbNJC/a
         Tq3vCuFBdPLea6Ahez9Xx3Ntr2doT80GwWvYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MD9FKVGWBE99MrZfH7WIVI/fVCG6DUWVqIAGudz94W+pKSCIBMcNE+QkhG/OP2Yztz
         /C8QrMko5ZJMPu5MBxje/05BpsezHFQXH5nefGWlYk3rwSqlWZcAIL1tC+YtOD+g0WJh
         Met44HOu78zgiWk3FrijdnT5xTtZn09lDUul8=
Received: by 10.140.186.6 with HTTP; Tue, 13 Apr 2010 19:19:59 -0700 (PDT)
Received: by 10.141.2.8 with SMTP id e8mr6365316rvi.205.1271211599621; Tue, 13 
	Apr 2010 19:19:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144845>

Highlight:
=======
     Rewrite Icon overlay code. Improve status fetch speed and reduce
CPU loading.
     Many bugs is fixed

Download:
=======
http://tortoisegit.googlecode.com/files/TortoiseGit-1.4.4.0-32bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-1.4.4.0-64bit.msi

= Release 1.4.4.0 =
== Features ==
 * #379:  Create Branch for remote branch do not set branch name

== Bug Fix ==
 * Fix log show mass when encode is cp1251
 * Fixed issue #357: Fix line endings merging issue

= Release 1.4.3.0 =
 * Fix explore crash when there are ignore patten at .git/info/exclude
 * Fixed issue #367: Last line of .gitignore ignored
 * Fixed issue #368: TortoiseGitBlame should not spell check by default
 * Fixed issue #369: TortoiseGitBlame should expand its menu items by default
 * Fixed issue: Compare submodule dialog show wrong subject at log dialog
 * Fixed issue #365: Log - enter closes dialog
 * Fixed issue #358: Renamed files are not properly committed, after
refreshing the commit dialog
 * Fixed issue .git\* locked when remove git repository

= Release 1.4.2.0 =
== Features ==
 * Log dialog find support search tag and branch
 * #354: impliment revert of this commit at log dialog
 * Add Merge command at log context menu
 * #350: Implement "Copy and rename" from context menu

== Bug Fix ==
 * Fixed issue #346: can't remove remote repos
 * Fixed issue #280: "Use recycle bin when reverting" does not work
 * Fix ignore over lay show wrong when second level directory exist
.gitignore file
 * Fixed issue #240: Setting "Do not show the context menu for
following paths:" not working properly

= Release 1.4.1.0 =
== Features ==
 * #349:  Offer "DCommit" instead of "Push" when working as SVN client

== Bug Fix ==
 * Fixed clone fail if msysgit version below 1.7.0.2
 * Fixed Folder keep "X" delete icon after commit
 * Fixed some small repository can't reflect "add"
 * Fixed show "?" at second level directory when icon overlay using "shell"
 * Fixed Issue #351: "Search log messages..." in Log context menu does nothing
 * Fixed Issue #226: tortoisegit is searching for .git share on network drives
 * Fixed number of files selected is wrong at commit dialog
 * Fixed Issue 353: Fix Help button in the git sync dialog

= Release 1.4.0.0 =
== Features ==
 * Improve Icon Overlay
   Rewrite icon overlay implement. TGitCache will call gitdll.dll to
get HEAD tree. And direct read index files. Read .gitignore file and
call gitdll.dll to judge ignore files.
   Can't watch untracked directroy to reduce TGitCache loading.

 * Git Clone
   Add --progress at clone dialog

 * Log Dialog
   Add antiAlias when draw cycle at log dialog

 * Add minimize and maximize button at rebase and sync dialog

== Bug Fix ==
 * Fixed Issue #344:  Force is the default in the sync dialog
 * Fixed issue #343: Wrong behaviour of Show Unversioned Files
checkbox at Commit dialog
 * Fixed issue #281: show wrong character after finish commit
 * Fix commitdlg can close after commit and progress scroll too much
 * Fixed Issue #299: Do nothing "Check For Updates..."  at about dialog
 * Fixed Issue #333:  Can't abort CherryPick
 * Fixed Issue #336:  Text of context menu slightly wrong; replace svn with git
 * Fixed Issue #340:  OpenSSH password dialog focus
 * Fixed issue #312: The number of changed files in 'Show log' window
 * Fixed issue #325: Would be nice to see current directory in the commit dialog
 * Fixed issue #329: path wrong at "Save revision to...
 * Fixed issue #327: Crash in the commit dialog after you changed a
file for Linux formatted
 * Fixed issue #321: Wrong Company/Product name in Metadata
 * Fixed Issue  Issue 309:	Mispelled words in the Git Synchronization dialog
 * Fixed  Issue 304:	Adding a file in the commit dialog resets selection
 * Fixed issue #305: Filtering showlog make crash
