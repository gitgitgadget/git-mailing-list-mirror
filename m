From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.6.3.2
Date: Sun, 7 Jun 2009 16:33:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 16:32:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDJQA-0002CC-Lz
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 16:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZFGOcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZFGOcQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 10:32:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:39621 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752466AbZFGOcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 10:32:16 -0400
Received: (qmail invoked by alias); 07 Jun 2009 14:32:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 07 Jun 2009 16:32:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BghgExM6BDiYN9aNVeO9ro3OE9XBY+geyvds00w
	YeAqMelyAFOqC5
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120975>

Hi,

this mail informs you that Git for Windows 1.6.3.2 is out.  Soon is the 
time that we switch to git.git's master.

Git Release Notes (Git-1.6.3.2-preview20090607)
Last update: 07 June 2009

Introduction
These release notes describe issues specific to the Windows release.

General release notes covering the history of the core git commands are 
included in the subdirectory doc/git/html of the installation directory. 
Look for files starting with RelNotes.

Known issues
- Some commands are not yet supported on Windows and excluded from the 
  installation; namely: git archimport, git cvsexportcommit, git 
  cvsimport, git cvsserver, git instaweb, git send-email, git shell.
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
  159).
- If configured to use plink, you will have to connect with putty first.
- MinGW does not support IPv6 yet (Issue 182). 
- When run from cmd.exe instead of Git Bash, some characters seem to be 
  "swallowed" from Git's output (Issue 192).
- There are a spurious write errors during rebase (Issue 200) that seem 
  not to be reproducible on most computers.
- As merge tools are executed using the MSys bash, options starting with 
  "/" need to be handled specially: MSys would interpret that as a POSIX 
  path, so you need to double the slash (Issue 226).  Example: instead of 
  "/base", say "//base".
- Also, extra care has to be paid to pass Windows programs Windows paths, 
  as they have no clue about MSys style POSIX paths -- You can use 
  something like $(cmd //c echo "$POSIXPATH").

Changes since Git-1.6.3-preview20090507

New Features
- Comes with official git 1.6.3.2.
- Uses TortoisePlink instead of Plink if available.

Bugfixes
- Plink errors out rather than hanging when the user needs to accept a 
  host key first (Issue 96).
- The user home directory is inferred from $HOMEDRIVE\$HOMEPATH instead of 
  $HOME (Issue 108).
- The environment setting $CYGWIN=tty is ignored (Issues 138, 248 and 
  251).
- The "ls" command shows non-ASCII filenames correctly now (Issue 188).
- Adds more syntax files for vi (Issue 250).
- $HOME/.bashrc is included last from /etc/profile, allowing .bashrc to 
  override all settings in /etc/profile (Issue 255).
- Completion is case-insensitive again (Issue 256).
- The "start" command can handle arguments with spaces now (Issue 258).
- For some Git commands (such as "git commit"), vi no longer "restores" 
  the cursor position.
