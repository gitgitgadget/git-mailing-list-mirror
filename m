From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [Announce] teamgit v0.0.10 - visual mergetool
Date: Sat, 28 Mar 2009 15:23:33 +0530
Message-ID: <1238234013.24658.4.camel@bain-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 10:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnVJ3-0005Sn-TU
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 10:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbZC1J4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZC1J4y
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 05:56:54 -0400
Received: from ti-out-0910.google.com ([209.85.142.190]:62467 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbZC1J4x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 05:56:53 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1071290tid.23
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 02:56:50 -0700 (PDT)
Received: by 10.110.90.9 with SMTP id n9mr4512932tib.6.1238234210364;
        Sat, 28 Mar 2009 02:56:50 -0700 (PDT)
Received: from ?192.168.1.211? ([59.95.20.229])
        by mx.google.com with ESMTPS id d1sm4145715tid.34.2009.03.28.02.56.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 02:56:49 -0700 (PDT)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114944>

Hi people,
teamGit is a functional git gui written in qt, its ultimate aim is to
add functionality on top of git targeted at small closely knit teams.

I have tagged the repo with v0.0.10!!!
You can now get the .deb from ubuntu intrepid ppa
deb http://ppa.launchpad.net/bain-devslashzero/ubuntu intrepid main
package name is teamgit.
The main project website is http://www.devslashzero.com/teamgit

Changes from v0.0.9 include a visual interactive merge conflict
resolution.

Changelog from v0.0.9 follows
Abhijit Bhopatkar (32):
      Revert "Check, whether valid data is parseable or not"
      guifycommanddialogimpl.cpp: Avoid crashing for unparsable man
pages
      gitprocess: whitespace cleanup
      Add slot to check for merge conflicts
      Add merge conflict label
      Add merge conflict checking in refresh
      settings_ui: Add mergetool path text box and select button
      Move git specific settings from mainwindow to settings for easier
management
      Add merge tool path setting
      Add mergetool selction and fix writing it to settings file
      whitespace fixes
      Fix merge conflict label
      Merge branch 'master' of git://gitorious.org/teamgit/mainline
      Show files with merge conflicts only once
      Move GIT_INVOKE from mainwindowsimpl to gitthread
      Added merge dialog ui file
      Added merge dialog implementation
      Added merge dialog file to the qmake project
      Execute merge dialog when merge conflict label is clicked
      Connect filediff signal from git thread to mergedialog
      Show conflicting files in the merge dialog
      Added slot for getting merge conflict file's contents
      Gather conflicting file contents for unmerged files
      Disable merge tool options group box
      Fix: Clear previous contents in merge dialog on init
      gitprocess: append the filename to the conflict contents signal
      Disable the mergetool settings
      mergedialog: execute meld to resolve merge conflict
      Set commit message in commit dialog if COMMIT_EDITMSG exists
      diffviewer: Move font setting from mainwindowimpl to diffviewer
      User .git/MERGE_MSG instead of COMMIT_EDITMSG
      Fix merege conflict message while commiting

Terje Rosten (1):
      fixing .desktop file
