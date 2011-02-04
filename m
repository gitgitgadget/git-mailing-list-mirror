From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [ANNOUNCE] Git for Windows 1.7.4
Date: Fri, 04 Feb 2011 14:14:14 +0000
Message-ID: <87lj1vkhu1.fsf@fox.patthoyts.tk>
References: <7vaaihacj6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 15:14:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlMQn-0001ec-3D
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 15:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1BDOOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 09:14:30 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:33933 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751843Ab1BDOOa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 09:14:30 -0500
Received: from [172.23.170.147] (helo=anti-virus03-10)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PlMQe-0000TL-Ap; Fri, 04 Feb 2011 14:14:28 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PlMQQ-0000oh-Qe; Fri, 04 Feb 2011 14:14:14 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 75BC320265; Fri,  4 Feb 2011 14:14:14 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vaaihacj6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Jan 2011 21:05:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166043>

Announcing Git for Windows 1.7.4.
This now is available for download at http://msysgit.googlecode.com/

Git for Windows Release Notes (Git-1.7.4-preview20110204)
Last update: 4 February 2011

Introduction

These release notes describe issues specific to the Git for Windows
release.

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

- As merge tools are executed using the MSys bash, options starting with
  "/" need to be handled specially: MSys would interpret that as a POSIX
  path, so you need to double the slash (Issue 226).  Example: instead
  of "/base", say "//base".  Also, extra care has to be paid to pass
  Windows programs Windows paths, as they have no clue about MSys style
  POSIX paths -- You can use something like $(cmd //c echo
  "$POSIXPATH").

Changes since Git-1.7.3.2-preview20101025
  Comes with Git 1.7.4 plus patches.
  Includes antiword to enable viewing diffs of .doc files
  Includes poppler to enable viewing diffs of .pdf files
  Removes cygwin paths from the bash shell PATH
