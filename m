From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: Git for Windows 1.6.3.2
Date: Mon, 8 Jun 2009 12:01:32 +0200 (CEST)
Message-ID: <13638.77.61.241.211.1244455293.squirrel@hupie.xs4all.nl>
References: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 08 12:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDbfy-0004O1-48
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 12:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbZFHKBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 06:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZFHKBe
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 06:01:34 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:56393 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752712AbZFHKBd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 06:01:33 -0400
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 6434658BDD4; Mon,  8 Jun 2009 12:01:33 +0200 (CEST)
Received: from 77.61.241.211
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 8 Jun 2009 12:01:32 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0906071629460.26154@pacific.mpi-cbg.de>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121057>

Hi,

I just installed it and it seems that ~ now points to /c ...
which is odd and break stuff.

Is this expected or a bug?
Or am I doing something wrong?

I installed default: using git bash, unix line endings, ssh, etc

-- 
Ferry Huberts



On Sun, June 7, 2009 16:33, Johannes Schindelin wrote:
> Hi,
>
> this mail informs you that Git for Windows 1.6.3.2 is out.  Soon is the
> time that we switch to git.git's master.
>
> Git Release Notes (Git-1.6.3.2-preview20090607)
> Last update: 07 June 2009
>
> Introduction
> These release notes describe issues specific to the Windows release.
>
> General release notes covering the history of the core git commands are
> included in the subdirectory doc/git/html of the installation directory.
> Look for files starting with RelNotes.
>
> Known issues
> - Some commands are not yet supported on Windows and excluded from the
>   installation; namely: git archimport, git cvsexportcommit, git
>   cvsimport, git cvsserver, git instaweb, git send-email, git shell.
> - The Logitec QuickCam software can cause spurious crashes. See "Why does
>   make often crash creating a sh.exe.stackdump file when I try to compile
>   my source code?" on the MinGW Wiki
>   (http://www.mingw.org/wiki/Environment_issues)
> - The Quick Launch icon will only be installed for the user running setup
>   (typically the Administrator). This is a technical restriction and will
>   not change.
> - Git Bash launched through the Explorer shell extension does not have the
>   git icon in its taskbar. This is a technical restriction and will not
>   change.
> - git send-mail does not work properly (Issue 27).
> - curl uses $HOME/_netrc instead of $HOME/.netrc.
> - If you want to specify a different location for --upload-pack, you have
>   to start the absolute path with two slashes. Otherwise MSys will mangle
>   the path.
> - git and bash have serious problems with non-ASCII file names (Issue 80,
>   159).
> - If configured to use plink, you will have to connect with putty first.
> - MinGW does not support IPv6 yet (Issue 182).
> - When run from cmd.exe instead of Git Bash, some characters seem to be
>   "swallowed" from Git's output (Issue 192).
> - There are a spurious write errors during rebase (Issue 200) that seem
>   not to be reproducible on most computers.
> - As merge tools are executed using the MSys bash, options starting with
>   "/" need to be handled specially: MSys would interpret that as a POSIX
>   path, so you need to double the slash (Issue 226).  Example: instead of
>   "/base", say "//base".
> - Also, extra care has to be paid to pass Windows programs Windows paths,
>   as they have no clue about MSys style POSIX paths -- You can use
>   something like $(cmd //c echo "$POSIXPATH").
>
> Changes since Git-1.6.3-preview20090507
>
> New Features
> - Comes with official git 1.6.3.2.
> - Uses TortoisePlink instead of Plink if available.
>
> Bugfixes
> - Plink errors out rather than hanging when the user needs to accept a
>   host key first (Issue 96).
> - The user home directory is inferred from $HOMEDRIVE\$HOMEPATH instead of
>   $HOME (Issue 108).
> - The environment setting $CYGWIN=tty is ignored (Issues 138, 248 and
>   251).
> - The "ls" command shows non-ASCII filenames correctly now (Issue 188).
> - Adds more syntax files for vi (Issue 250).
> - $HOME/.bashrc is included last from /etc/profile, allowing .bashrc to
>   override all settings in /etc/profile (Issue 255).
> - Completion is case-insensitive again (Issue 256).
> - The "start" command can handle arguments with spaces now (Issue 258).
> - For some Git commands (such as "git commit"), vi no longer "restores"
>   the cursor position.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
