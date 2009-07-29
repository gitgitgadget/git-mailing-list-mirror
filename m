From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Git for Windows 1.6.4
Date: Wed, 29 Jul 2009 23:40:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907292331090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 23:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWGtJ-0003sa-HD
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 23:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbZG2Vkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 17:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbZG2Vkq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 17:40:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55279 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754171AbZG2Vkp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 17:40:45 -0400
Received: (qmail invoked by alias); 29 Jul 2009 21:40:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 29 Jul 2009 23:40:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Gx7cTa8iGv0AGPu8BOAbLS8sRXMMBSI4bEoCptu
	3a3xkP64IjNsIb
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124393>

Hi,

this mail informs you that Git for Windows 1.6.4 is out.  It is less well 
tested than the previous versions, mainly because I was busy with other 
things and asked for help with testing on the msysGit mailing list and I 
am very impatient.

Git Release Notes (Git-1.6.4-preview20090729)
Last update: 29 July 2009

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

- curl uses $HOME/_netrc instead of $HOME/.netrc.

- If you want to specify a different location for --upload-pack, you have 
  to start the absolute path with two slashes. Otherwise MSys will mangle 
  the path.

- git and bash have serious problems with non-ASCII file names (Issue 80, 
  159).

- If configured to use plink, you will have to connect with putty first 
  and accept the host key.

- When run from cmd.exe instead of Git Bash, some characters seem to be 
  "swallowed" from Git's output (Issue 192).

- There are a spurious write errors during rebase (Issue 200) that seem 
  not to be reproducible on most computers.

- As merge tools are executed using the MSys bash, options starting with 
  "/" need to be handled specially: MSys would interpret that as a POSIX 
  path, so you need to double the slash (Issue 226).  Example: instead of 
  "/base", say "//base".  Also, extra care has to be paid to pass Windows 
  programs Windows paths, as they have no clue about MSys style POSIX 
  paths -- You can use something like $(cmd //c echo "$POSIXPATH").

Changes since Git-1.6.3.2-preview20090608

New Features

- Comes with official git 1.6.4.

- Supports https:// URLs, thanks to Erik Faye-Lund.

- Supports send-email, thanks to Erik Faye-Lund (Issue 27).

- Updated Tcl/Tk to version 8.5.7, thanks to Pat Thoyts.

Bugfixes

- The home directory is now discovered properly (Issues 108 & 259).
- IPv6 is supported now, thanks to Martin Martin Storsj (Issue 182).
