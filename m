From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [ANNOUNCE] Git for Windows 1.7.3.1
Date: Sat, 02 Oct 2010 14:56:16 +0100
Message-ID: <877hi0n1fj.fsf@fox.patthoyts.tk>
References: <7vtyl8krzu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 02 15:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P22a0-00026r-9O
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 15:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab0JBN4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 09:56:38 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:37625 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755480Ab0JBN4h (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 09:56:37 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P22Zn-0006L5-8X; Sat, 02 Oct 2010 14:56:35 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P22Zb-00055h-EQ; Sat, 02 Oct 2010 14:56:24 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 1B07A201CF; Sat,  2 Oct 2010 14:56:17 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
CC: Johannes Schindelin <johannes.schindelin@gmx.de>
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vtyl8krzu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 29 Sep 2010 17:13:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157806>

Announcing Git for Windows 1.7.3.1.
This now is available for download at http://msysgit.googlecode.com/


Git for Windows Release Notes (Git-1.7.3.1-preview20101002)
Last update: 2 October 2010

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

- The Logitec QuickCam software can cause spurious crashes. See "Why does
make often crash creating a sh.exe.stackdump file when I try to compile
my source code?" on the MinGW Wiki
(http://www.mingw.org/wiki/Environment_issues)

- The Quick Launch icon will only be installed for the user running setup
(typically the Administrator). This is a technical restriction and will
not change.

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have
to start the absolute path with two slashes. Otherwise MSys will mangle
the path.

- git and bash have serious problems with non-ASCII file names (Issue 80,
159).

- If configured to use plink, you will have to connect with putty first
and accept the host key.

- As merge tools are executed using the MSys bash, options starting with
"/" need to be handled specially: MSys would interpret that as a POSIX
path, so you need to double the slash (Issue 226).  Example: instead of
"/base", say "//base".  Also, extra care has to be paid to pass Windows
programs Windows paths, as they have no clue about MSys style POSIX
paths -- You can use something like $(cmd //c echo "$POSIXPATH").


Changes since Git-1.7.2.3-preview20100911

New Features

- Comes with Git 1.7.3.1 plus patches.
- Updated to Vim 7.3, file-5.04 and InnoSetup 5.3.11

Bugfixes

- Issue 528 (remove uninstaller from Start Menu) was fixed
- Issue 527 (failing to find the certificate authority bundle) was fixed
- Issue 524 (remove broken and unused sdl-config file) was fixed
- Issue 523 (crash pushing to WebDAV remote) was fixed
