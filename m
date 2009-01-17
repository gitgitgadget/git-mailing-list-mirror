From: Abhijit Bhopatkar <bain@devslashzero.com>
Subject: [Announce] teamgit v0.0.9 - visual interactive rebase
Date: Sat, 17 Jan 2009 13:08:11 +0530
Message-ID: <1232177891.16881.8.camel@bain-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 08:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO5sL-0002qL-9C
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 08:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbZAQHif convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 02:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbZAQHif
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 02:38:35 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:24684 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754737AbZAQHie (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 02:38:34 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1226139tic.23
        for <git@vger.kernel.org>; Fri, 16 Jan 2009 23:38:32 -0800 (PST)
Received: by 10.110.41.17 with SMTP id o17mr1965201tio.43.1232177911963;
        Fri, 16 Jan 2009 23:38:31 -0800 (PST)
Received: from ?192.168.1.207? ([59.95.2.80])
        by mx.google.com with ESMTPS id a14sm2856227tia.32.2009.01.16.23.38.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Jan 2009 23:38:30 -0800 (PST)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106032>

Hi people,

teamGit is a functional git gui written in qt, its ultimate aim is to
add functionality on top of git targeted at small closely knit teams.

I have tagged the repo with v0.0.9!!!
You can now get the .deb from ubuntu intrepid ppa
deb http://ppa.launchpad.net/bain-devslashzero/ubuntu intrepid main
package name is teamgit.
The main project website is http://www.devslashzero.com/teamgit

The major changes from v0.0.8 include
1. Added preliminary interactive rebase support, now edit reabse queue
visually
2. Advanced menu is now disabled, since its still long way from being
stable
3. You can now drag and drop emailed patches straight from evoluion (ma=
y
be others as well) or drop patch files/mboxes from nautilus.

Shortlog since v0.0.8 appended
Abhijit
---

Abhijit Bhopatkar (23):
      guifydialogui: Fixed a groupbox title
      Added a rebase ui binary
      gitprocess: make rebase editor a variable and unset it after
rebase
      mainwindowui: Added interactive rebase action to tools
      gitprocess: make rebase take an argument for rebase point
      mainwindowimpl: don't crash if git binary is not found
      Added rebase interactive functionality
      rabse-interactive: Added rebase control file reading
      Made teamgit a global project for main and rebase projects
      Added install target for rebase-interactive
      Added teamgit-rebase and editor for teamgit control file
      Removed stray merge conflict file
      Added suporject for main teamgit app
      Added basic merge command support
      mainwindowimpl.cpp: Use save/restoreGeometry function for window
state.
      White space cleanup
      Drag and drop patch support
      mainwindowsimpl.cpp: fix stupid commenting
      Build advanced menu only if settings is true
Abhijit Bhopatkar (23):
      guifydialogui: Fixed a groupbox title
      Added a rebase ui binary
      gitprocess: make rebase editor a variable and unset it after
rebase
      mainwindowui: Added interactive rebase action to tools
      gitprocess: make rebase take an argument for rebase point
      mainwindowimpl: don't crash if git binary is not found
      Added rebase interactive functionality
      rabse-interactive: Added rebase control file reading
      Made teamgit a global project for main and rebase projects
      Added install target for rebase-interactive
      Added teamgit-rebase and editor for teamgit control file
      Removed stray merge conflict file
      Added suporject for main teamgit app
      Added basic merge command support
      mainwindowimpl.cpp: Use save/restoreGeometry function for window
state.
      White space cleanup
      Drag and drop patch support
      mainwindowsimpl.cpp: fix stupid commenting
      Build advanced menu only if settings is true
      settings.ui:Add showAdvanced checkbox
      Enable advanced menu only on selecting it from options
      settings.ui: Add a warning label in advanced about unstability
      v0.0.9 hurra!!!

Markus Br=C3=B6ker (13):
      src/gitprocess.cpp: unicode aware encoding
      src/gitprocess.cpp: White space corrections
      utf8 aware encoding - part 2
      Check, whether valid data is parseable or not
      Unicode aware diffing
      Remove trailing spaces during package build
      Interactive Rebase
      Rebase: Sorting Order
      QtextEdit replaces the moving puzzle
      Rebase: UTF-8 Writer
      Rebase: edit and drop buttons added
      Rebase: Write Access when writing
      c++ std header

Rajesh Sola (1):
      gitporcess:Added git rebase interactive
