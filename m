From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [ANNOUNCE] Git 1.7.2.3 for Windows
Date: Mon, 13 Sep 2010 19:54:20 +0100
Message-ID: <87bp81a2zn.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlecode.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 20:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEAk-0002jR-NP
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab0IMSya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:54:30 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:40350 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752780Ab0IMSy3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 14:54:29 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1OvEAb-0007lM-3b; Mon, 13 Sep 2010 19:54:26 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1OvEAX-0003zp-2F; Mon, 13 Sep 2010 19:54:21 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 5F32126187; Mon, 13 Sep 2010 19:54:20 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156113>

Git Release Notes (Git-1.7.2.3-preview20100911)
Last update: 11 September 2010

Find it at http://code.google.com/p/msysgit/downloads/list

These release notes describe issues specific to the Windows release.

General release notes covering the history of the core git commands are
included in the subdirectory doc/git/html of the installation
directory. Look for files starting with RelNotes.

Known issues

- Some commands are not yet supported on Windows and excluded from the
  installation; namely: git archimport, git cvsexportcommit, git
  cvsimport, git cvsserver, git instaweb, git shell.

- The Logitec QuickCam software can cause spurious crashes. See "Why
  does make often crash creating a sh.exe.stackdump file when I try to
  compile my source code?" on the MinGW Wiki
  (http://www.mingw.org/wiki/Environment_issues)

- The Quick Launch icon will only be installed for the user running
  setup (typically the Administrator). This is a technical restriction
  and will not change.

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you
  have to start the absolute path with two slashes. Otherwise MSys will
  mangle the path.

- git and bash have serious problems with non-ASCII file names (Issue
  80, 159).

- If configured to use plink, you will have to connect with putty first
  and accept the host key.

- There are a spurious write errors during rebase (Issue 200) that seem
  not to be reproducible on most computers.

- As merge tools are executed using the MSys bash, options starting with
  "/" need to be handled specially: MSys would interpret that as a POSIX
  path, so you need to double the slash (Issue 226).  Example: instead
  of "/base", say "//base".  Also, extra care has to be paid to pass
  Windows programs Windows paths, as they have no clue about MSys style
  POSIX paths -- You can use something like $(cmd //c echo
  "$POSIXPATH").

Changes since Git-1.7.1-preview20100612

New Features

- Comes with Git 1.7.2.3 plus patches.

Bugfixes

- Issue 519 (build problem with compat/regex/regexec.c) was fixed
- Issue 430 (size of panes not preserved in git-gui) was fixed
- Issue 411 (git init failing to work with CIFS paths) was fixed
- Issue 501 (failing to clone repo from root dir using relative path) was fixed

Changes since Git-1.7.0.2-preview20100309

New Features

- Comes with Git 1.7.1 plus patches.

Bugfixes

- Issue 27 (git-send-mail not working properly) was fixed again
- Issue 433 (error while running git svn fetch) was fixed
- Issue 427 (Gitk reports error: "couldn't compile regular expression
  pattern: invalid repetition count(s)") was fixed
- Issue 192 (output truncated) was fixed again
- Issue 365 (Out of memory? mmap failed) was fixed
- Issue 387 (gitk reports "error: couldn't execute "git:" file name too
  long") was fixed
- Issue 409 (checkout of large files to network drive fails on XP) was
  fixed
- Issue 428 (The return value of git.cmd is not the same as git.exe) was
  fixed 
- Issue 444 (Git Bash Here returns a "File not found error" in Windows 7
  Professional - 64 bits) was fixed
- Issue 445 (git help does nothing) was fixed
- Issue 450 ("git --bare init" shouldn't set the directory to hidden.)
  was fixed
- Issue 456 (git script fails with error code 1) was fixed
- Issue 469 (error launch wordpad in last netinstall) was fixed
- Issue 474 (git update-index --index-info silently does nothing) was
  fixed
- Issue 482 (Add documentation to avoid "fatal: $HOME not set" error)
  was fixed
- Issue 489 (git.cmd issues warning if %COMSPEC% has spaces in it) was
  fixed
- Issue 436 ("mkdir : No such file or directory" error while using
  git-svn to fetch or rebase) was fixed
- Issue 440 (Uninstall does not remove cheetah.) was fixed
- Issue 441 (Git-1.7.0.2-preview20100309.exe installer fails with
  unwritable msys-1.0.dll when ssh-agent is running) was fixed
