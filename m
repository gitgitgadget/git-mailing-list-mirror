From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.6.2.1-preview20090322
Date: Sun, 22 Mar 2009 22:17:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sun Mar 22 22:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlV2J-0006ar-4a
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 22:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbZCVVPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 17:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbZCVVPY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:15:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:60703 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755075AbZCVVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 17:15:22 -0400
Received: (qmail invoked by alias); 22 Mar 2009 21:15:19 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp046) with SMTP; 22 Mar 2009 22:15:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pHcBCskbpaTybCRmsDxUWGs+cGny/owkexA8PSf
	+pER3sDaxTfUB0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114171>

Hi,

I just released a new version of Git for Windows (TAFKA WinGit).  It is 
basically Git 1.6.2.1 plus a few patches.  Please find the installer here:

	http://msysgit.googlecode.com/

Disclaimer: Git for Windows is still in a state where I do _not_ recommend 
using it unless you have the means to fix issues.  Unlike the git.git 
developer community, the msysGit team is heavily undermanned.

Known issues 

- Some commands are not yet supported on Windows and excluded from the 
  installation; namely: git archimport, git cvsexportcommit, git 
  cvsimport, git cvsserver, git filter-branch, git instaweb, git 
  send-email, git shell.

- The Logitec QuickCam software can cause spurious crashes. See "Why does 
  make often crash creating a sh.exe.stackdump file when I try to compile 
  my source code?" on the MinGW Wiki 
  (http://www.mingw.org/wiki/Environment_issues)

- The Quick Launch icon will only be installed for the user running setup 
  (typically the Administrator). This is a technical restriction and will 
  not change.

- Git Bash launched through the Explorer shell extension does not have the 
  git icon in its taskbar. This is a technical restriction and will not 
  change.

- git send-mail does not work properly (Issue 27).

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have 
  to start the absolute path with two slashes. Otherwise MSys will mangle 
  the path.

- git and bash have serious problems with non-ASCII file names (Issue 80, 
  108, 149, 159, 188).

- If configured to use plink, you will have to connect with putty first, 
  as you cannot accept the host key due to the console window being 
  blocked (Issue 96).

- MinGW does not support IPv6 yet (Issue 182).

- When run from cmd.exe instead of Git Bash, some characters seem to be 
  "swallowed" from Git's output (Issue 192).

- There are a few issues with ssh hanging (Issue 197), permission denied 
  on renaming pack files (mentioned in Issue 194), and spurious write 
  errors during rebase (Issue 200) that seem not to be reproducible on 
  most computers.

Changes since Git-1.6.2-preview20090308 

New Features 

- Comes with official git 1.6.2.1.

- A portable application is shipped in addition to the installer (Issue 
  195).

- Comes with a Windows-specific mmap() implementation (Issue 198).

Bugfixes 

- ANSI control characters are no longer shown verbatim (Issue 124).

- Temporary files are created respecting core.autocrlf (Issue 177).

- The Git Bash prompt is colorful again (Issue 199).

- Fixed crash when hardlinking during a clone failed (Issue 204). 

- An infinite loop was fixed in git-gui (Issue 205). 

- The ssh protocol is always used with plink.exe (Issue 209). 

- More vim files are shipped now, so that syntax highlighting works. 

Ciao,
Dscho
