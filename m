From: David Soria Parra <sn_@gmx.net>
Subject: [ANNOUNCE] gc-utils 0.1.0
Date: Mon, 31 Mar 2008 02:00:11 +0200
Message-ID: <fsp9i8$flq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 03:05:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg8T6-0005EE-B8
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 03:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbYCaBFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 21:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbYCaBFF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 21:05:05 -0400
Received: from main.gmane.org ([80.91.229.2]:44395 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbYCaBFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 21:05:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jg7Rh-00011u-FO
	for git@vger.kernel.org; Mon, 31 Mar 2008 00:00:17 +0000
Received: from p57aed30e.dip.t-dialin.net ([87.174.211.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 00:00:17 +0000
Received: from sn_ by p57aed30e.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 00:00:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p57aed30e.dip.t-dialin.net
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78540>

Hello,

I would like to announce a porcelain on git-cvsimport and
git-cvsexportcommit which I'm working on for a few month now.
It tries to provide a simple import, update, commit commandset
to synchronize your GIT repository with CVS. It runs on most shells
like bash, zsh, ash (not csh and tcsh).

gc-utils 0.1.0 is available from http://gcutils.sourceforge.net

Description:
 gc-utils is a set of bash scripts (git-cvs* porcelain) wrapping git-cvsimport
 and git-cvsexportcommit to make importing from CVS and commiting back easier.

Tarballs can be found here:
  http://downloads.experimentalworks.net/gcutils-v0.1.0.tar.gz

GIT tree can be found here:
  http://git.experimentalworks.net/?p=gcutils.git

This release tries to focus on improving the test suite and to fix smaller
bugs as well as doing some code clean up.

Feedback and patches are welcome.

            David

------------------------------------------------------
The changes since 0.0.4:

David Soria Parra (25):
      Add a "Update..." message to gc-update.sh
      Check if the a .cvs directory is present.
      Fix the check for the .cvs directory.
      Aggregate duplicated code into on library file.
      Add license header
      Test to invoke gc-utils from subdirectories
      Testcase for gc-commit
      Import branches into refs/remotes/cvs/* by default
      When running cvsclean, gc-commit didn't return to the working directory
      Check if the directory to import already exists.
      Change required git version from 1.5.0 to 1.5.4
      Tests: Test merge strategy option in gc-update
      Tests: Display filename when a test fails
      Tests: Silence cleanup script
      gc-utils version 0.0.5beta1
      Add UPDATE-NOTES containing informations about compatiblity breaks
      Silence git-stash when gc-update is not in verbose mode
      Pop stashed status always, not only when we rebase
      Fix the check for the .git and .cvs directory
      Cleanup manpages
      Use die shortcut instead of echo >&2 && exit 127
      Show a message that we run cvs update
      Silence errors due to non integer inputs in our select
      Simplify code
      gc-utils version 0.1.0

Eduardo Cardoso (2):
      Uses --no-pager to retrieve log messages.
      Added flags to `cvs update' to allow creation of directories and
      pruning of empty directories.
