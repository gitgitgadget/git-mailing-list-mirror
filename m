From: Junio C Hamano <gitster@pobox.com>
Subject: 1.5.3.5 will be out tomorrow
Date: Tue, 30 Oct 2007 17:01:07 -0700
Message-ID: <7vfxzsjgos.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 01:01:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In11X-0007I2-DT
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 01:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949AbXJaABS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 20:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbXJaABS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 20:01:18 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59638 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbXJaABR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 20:01:17 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 98ABD2F2;
	Tue, 30 Oct 2007 20:01:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EF0078F554;
	Tue, 30 Oct 2007 20:01:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62763>

A fix for a segfaulting bug warrants a new maintenance release,
so 1.5.3.5 will be out tomorrow.

Here is the current shortlog:

Alex Bennee (1):
    Ensure we add directories in the correct order

Alex Riesen (1):
    Fix generation of perl/perl.mak

Andrew Clausen (1):
    helpful error message when send-pack finds no refs in common.

Aurelien Bompard (1):
    honor the http.sslVerify option in shell scripts

Benoit Sigoure (1):
    Fix a small memory leak in builtin-add

Brian Gernhardt (1):
    cvsserver: Use exit 1 instead of die when req_Root fails.

Frank Lichtenheld (1):
    git-config: don't silently ignore options after --list

Gerrit Pape (2):
    git-config: handle --file option with relative pathname properly
    git-config: print error message if the config file cannot be read

Jean-Luc Herren (2):
    git add -i: Fix parsing of abbreviated hunk headers
    git add -i: Remove unused variables

Jeff King (1):
    send-pack: respect '+' on wildcard refspecs

Joakim Tjernlund (1):
    Improve receive-pack error message about funny ref creation

Johannes Schindelin (5):
    clear_commit_marks(): avoid deep recursion
    rebase -i: use diff plumbing instead of porcelain
    Fix setup_git_directory_gently() with relative GIT_DIR &
      GIT_WORK_TREE
    fix filter-branch documentation
    filter-branch: update current branch when rewritten

Julian Phillips (1):
    fast-import: Fix argument order to die in file_change_m

Junio C Hamano (6):
    git-remote: fix "Use of uninitialized value in string ne"
    sha1_file.c: avoid gcc signed overflow warnings
    merge-recursive.c: mrtree in merge() is not used before set
    RelNotes-1.5.3.5: describe recent fixes
    Prevent send-pack from segfaulting (backport from 'master')
    git-merge: document but discourage the historical syntax

Linus Torvalds (6):
    Fix embarrassing "git log --follow" bug
    Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT
    git-blame shouldn't crash if run in an unmerged tree
    Avoid scary errors about tagged trees/blobs during git-fetch
    Fix directory scanner to correctly ignore files without d_type
    Fix diffcore-break total breakage

Mathias Megyei (1):
    Do not remove distributed configure script

Michael W. Olson (1):
    Documentation/git-cvsexportcommit.txt: s/mgs/msg/ in example

Michele Ballabio (2):
    git-reflog: document --verbose
    git-archive: document --exec

Nicolas Pitre (1):
    cherry-pick/revert: more compact user direction message

Patrick Welche (1):
    Define NI_MAXSERV if not defined by operating system

Ralf Wildenhues (1):
    gitk.txt: Fix markup.

Robert Schiele (1):
    fixing output of non-fast-forward output of post-receive-email

Sergei Organov (1):
    core-tutorial: Use new syntax for git-merge.

Shawn O. Pearce (18):
    git-gui: Display message box when we cannot find git in $PATH
    git-gui: Handle starting on mapped shares under Cygwin
    git-gui: Ensure .git/info/exclude is honored in Cygwin workdirs
    git-gui: Allow gitk to be started on Cygwin with native Tcl/Tk
    git-gui: Don't crash when starting gitk from a browser session
    Whip post 1.5.3.4 maintenance series into shape.
    Correct typos in release notes for 1.5.3.5
    Avoid 'expr index' on Mac OS X as it isn't supported
    Document additional 1.5.3.5 fixes in release notes
    Yet more 1.5.3.5 fixes mentioned in release notes
    Avoid invoking diff drivers during git-stash
    Further 1.5.3.5 fixes described in release notes
    Paper bag fix diff invocation in 'git stash show'
    git-gui: Correctly report failures from git-write-tree
    git-gui: Handle progress bars from newer gits
    git-gui: Don't display CR within console windows
    Merge branch 'maint' of git://repo.or.cz/git-gui into maint
    Describe more 1.5.3.5 fixes in release notes

Simon Sasburg (1):
    git-gui: Avoid using bold text in entire gui for some fonts

Steffen Prohaska (2):
    git-gui: accept versions containing text annotations, like
      1.5.3.mingw.1
    attr: fix segfault in gitattributes parsing code
