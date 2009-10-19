From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 1.2.1.0 Release
Date: Mon, 19 Oct 2009 14:58:02 +0800
Message-ID: <1976ea660910182358ubd9ab36l6985658c8facce69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
X-From: git-owner@vger.kernel.org Mon Oct 19 09:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzmJY-0001Qe-AP
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 09:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbZJSHFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 03:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753523AbZJSHFp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 03:05:45 -0400
Received: from mail-qy0-f202.google.com ([209.85.221.202]:41696 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZJSHFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 03:05:45 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 03:05:45 EDT
Received: by qyk40 with SMTP id 40so3122841qyk.22
        for <git@vger.kernel.org>; Mon, 19 Oct 2009 00:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=R6iQ77gwuYm1plhv6290k3aMlbdnBXnv2D6FKR2XUsI=;
        b=rHm55nWMKXF1ggHgRuW/HOzpWfUqgMpE3MRXiaWjaA6t7HDfsDyOQwh3JNp9R2kZ+c
         AYy1hn7DO+EDvsTMNzyPhHdXGCzpvC+gHhjYF7PvjzESQTqDYr1Nam3pLitrC+SVevKI
         o0WG4zWXfboNEqp66li6xTWpjQCgNdcQ87P4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WnXKNxwEfG2C31WFB8VdYLxhnLfHSEiR0sw8kLQ2K56djjENmtX7pLMPcxO0agAtWH
         62o34K7uwMtQAY/cohuOrPNE/QlOJf78tOE8ed9HsPquJFJEXrEedimQOM7ObX0LM0H5
         JyRstxA8bIyeBlyF9tN/lYPRjpnGPkcFYt0xQ=
Received: by 10.224.33.195 with SMTP id i3mr2409496qad.386.1255935482657; Sun, 
	18 Oct 2009 23:58:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130662>

Download:
http://tortoisegit.googlecode.com/files/TortoiseGit-1.1.1.0-32bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-1.1.1.0-64bit.msi


= Release 1.1.1.0 =
== Features ==

 * Improve Rebase Dialog
  Allow lanuch new rebase dialog again after finish rebase dialog
  Disable "force rebase" checkbox during rebase.

 * Git SVN
  Append svn:ignore settings to the default git exclude file Add
shell extension command to import svn ignore settings.
  Need press "Shift" key to show "import svn ignore" command.

 * Drag-drop copy\move support
  File only

 * Add paste command at shell extension
  Copy and paste file is okay. But there are problems when including
directory.
  Cut and paste working

 * Update notepad2 to 4.022

 * Sync Dialog
  Ability to sync submodules in TGit sync dialog

 * Statics
  Sort commits by dates before processed by StatGraphDlg

 * Log Dialog
  Show <No branch> replace ref error message at log dialog

 * Add Check software updater support.

== Bug Fix ==
 * Fixed issue #185. "Can't find Super-project" when pathname include space.
 * Fixed issue #190: Access violation in Blame and wrong path name
when root dir is git repository
 * Fixed issue #180: Create patch serial doesn't work when there is
"\" at end of path
 * Fixed issue #173: SVN Rebase does not work The correct handle below
case git config svn-remote.svn.fetch
myproject/trunk:refs/remotes/trunk
 * Fixed issue #169: Force rebase checkbox is fixed
 * Fixed issue #163: Conflict "theirs" and "mine" are reversed during a rebase
 * Fixed issue #165: Incorect path to Notepad2
 * Fixed issue #158: Rebase can act on the wrong branch
