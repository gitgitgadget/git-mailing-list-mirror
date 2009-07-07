From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE]TortoiseGit 0.8.1.0
Date: Tue, 7 Jul 2009 12:46:57 +0800
Message-ID: <1976ea660907062146t46200f88jc57b6f59f69a0d17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com
X-From: git-owner@vger.kernel.org Tue Jul 07 06:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO2aK-0005nT-GR
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 06:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbZGGEq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 00:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbZGGEq6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 00:46:58 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:49837 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbZGGEq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 00:46:57 -0400
Received: by pzk31 with SMTP id 31so2724973pzk.33
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Zkh7ymhf/CDBMZMkx5O0Hj2IGg6KtsfNQ3OSPAn1+rU=;
        b=NrcczH+o2qgSZjae7Sz/DVKF7IrMNQN5MPgWci7czHV3G0le6lQfh5XYFvIBvHWicq
         9XraHwUzQc73eWEwTo8rjxOj3l0csNFUGjzCarG4wufIwKMCwDGcJX6ZiFQVoLgliPMq
         pY5bxG76/xoWSoE7KxoxLvE63U1+nwTzxw/Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=O0O+TqmTR/s3JKdXhiZMhe6i+qFT+rC7OCrEh5dXm2o/WjJjr5grJVf89v2XXITvjs
         43xXAaKSkcK67KdFSvUtIpMTsCthf7TX1kiLA0jrejrCcIT8GOm+QpyBPjtNKqnn1nGu
         U8bByh+qtsMGevvkElz1STVirOY6ui0wxJIvE=
Received: by 10.115.106.14 with SMTP id i14mr8782026wam.77.1246942019437; Mon, 
	06 Jul 2009 21:46:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122821>

http://code.google.com/p/tortoisegit/downloads/list

= Release 0.8.1.0 =
== Features ==

 * Improve work flow and reduce click
   Commit: Made user able to push after successful commit
   Show Push Dialog after close commit dialog
   Add messagebox to ask if stash change when rebase at dirty work space
   Show GUI friendly diffstat after pull

 * Rebase: Select default upstream based on current tracked remote

 * Improve BrowseRef Dialog
   Add Option to delete multiple refs
   Added 'Switch to this Ref' option
   Fetch context menu item added.
   Add "BrowseRef" to shell extension command.
   Add ability to diff two commits
   Added option to delete remote branch
   Always set initial ref
   Show context menu icons
   Save / Restore window size

 * Add Basic Git-SVN Operation
   Add SVN DCommit Command
   Add "SVN Rebase" and "SVN DCommit" command at shell contextmenu
   Support Git svn-clone at clone dialog.

 * Help Document Updated
   Add git basic book.

 * Add Help button at many dialog

 * Improve Format Patch
   May also select 'format patch...' if selection is continuous.
   Implemented browse buttons and added browsebutton for 'since'.

 * Add TortoiseIDiff to compare picture

 * Enable Bugtraq setting dialog

 * Improve Log dialog
   Ajust label colors when selected. (Not on Vista with themes enabled)
   Add compare with working copy at log dialog
   Ref label borders

 * FileDiffDlg: Make shift right-left button work

 * Branch/Tag dlg: Update 'track' option after browse-refs

 * StatusListCtrl: Implemented delete unversioned file.

 * RebaseDlg: Update rebase lines after browserefs


== BugFix ==

 * Fix Issue 64:  When the graph column is small, the graph sometimes
appears through the text of the next column on Vista
 * Fix log graph tree mass when dragon scroll bar from left to right
 * Fix Issue 104:  Doubleclicking changed submodule dir in Check For
Modifications dlg, crashes TGit
 * Pull: Fixed bug that when pulling from the configured remote
branch, git did not update the remote tracking branches.
 * Fix stash problem when svn dcommit at dirty working space
 * Modify Create repository error message
 * Fix Issue #102:  Invalid patch e-mails generated
 * Fix submodule update Crash when repository have not submodule
 * Fixed issue #88: Ambiguous dialog message
 * Correct format patch command -num argument
 * PushDlg: Fix: Wrong remote selected after selection via ref-browser.
 * Rebase: Skip in context-menu appeared twice. First one should be pick.
 * Fix Issue #89: Can't locate msysgit on x64
 * Fix Issue #95:  TortoiseBlame Icon disappears when selected in the
settings treeview
 * Fix Issue 94 Commit log showing incorrect timestamps
 * Fix pull don't launch putty key file
