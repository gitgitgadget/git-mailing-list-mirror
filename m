From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Git for Windows 1.6.2.1-preview20090322
Date: Tue, 24 Mar 2009 02:35:24 +0100
Message-ID: <200903240235.25192.markus.heidelberg@web.de>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvaI-0004Qu-E4
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbZCXBfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461AbZCXBfc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:35:32 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:53316 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345AbZCXBfb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:35:31 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3FE62FBFE0FE;
	Tue, 24 Mar 2009 02:35:26 +0100 (CET)
Received: from [89.59.75.248] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LlvY6-0001Aj-00; Tue, 24 Mar 2009 02:35:26 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0903222149330.10279@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/H+kXSYYF1jivrW8asu8T6gAq1LNJxK7JyMnOv
	glGSD9M0jIreufwjzws4zwngHQt+jkQBKCK9CA27M3MWGecQw2
	kk4PD6ham/WQppLZp0bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114388>

Hi,

the company I'm working for plans to switch from our current commercial
VCS, now I have the job to compare different tools (svn, git). Our
clients run on Windows and probably our offices in foreign countries
should work on our repository, too.

Johannes Schindelin, 22.03.2009:
> Disclaimer: Git for Windows is still in a state where I do _not_ recommend 
> using it unless you have the means to fix issues.  Unlike the git.git 
> developer community, the msysGit team is heavily undermanned.
> 
> Known issues 

I favor git, but I have to be objective and if there are serious issues,
this will obviously influence the decision. Since the list below is not
complete, I guess these are just the most serious issues, and then it
doesn't sound too scary for the everyday use. Let me comment on them for
our workflow:

> - Some commands are not yet supported on Windows and excluded from the 
>   installation; namely: git archimport, git cvsexportcommit, git 
>   cvsimport, git cvsserver, git filter-branch, git instaweb, git 
>   send-email, git shell.

Not necessary.

> - The Logitec QuickCam software can cause spurious crashes. See "Why does 
>   make often crash creating a sh.exe.stackdump file when I try to compile 
>   my source code?" on the MinGW Wiki 
>   (http://www.mingw.org/wiki/Environment_issues)

Not plugged-in.

> - The Quick Launch icon will only be installed for the user running setup 
>   (typically the Administrator). This is a technical restriction and will 
>   not change.

Never mind.

> - Git Bash launched through the Explorer shell extension does not have the 
>   git icon in its taskbar. This is a technical restriction and will not 
>   change.

Never mind. Probably I would be the only one using the CLI anyway.

> - git send-mail does not work properly (Issue 27).

Not necessary.

> - curl uses $HOME/_netrc instead of $HOME/.netrc.

Never mind.

> - If you want to specify a different location for --upload-pack, you have 
>   to start the absolute path with two slashes. Otherwise MSys will mangle 
>   the path.

Only for msysgit on the server side, right? Then, never mind.

> - git and bash have serious problems with non-ASCII file names (Issue 80, 
>   108, 149, 159, 188).

This may be a problem.

> - If configured to use plink, you will have to connect with putty first, 
>   as you cannot accept the host key due to the console window being 
>   blocked (Issue 96).

Just use OpenSSH?
Problem in GUIs or only CLI?

> - MinGW does not support IPv6 yet (Issue 182).

Not necessary.

> - When run from cmd.exe instead of Git Bash, some characters seem to be 
>   "swallowed" from Git's output (Issue 192).

Never mind.

> - There are a few issues with ssh hanging (Issue 197), permission denied 
>   on renaming pack files (mentioned in Issue 194), and spurious write 
>   errors during rebase (Issue 200) that seem not to be reproducible on 
>   most computers.

OK, strange and not reproducible errors are a little bit scary.

So, most of these issues I don't consider to be serious for us, but I
guess the remaining "real" issues let you stay at your opinion, not to
recommend using it, don't they?

I suppose there are already people using msysgit productive at work,
are these only people who know how to fix such problems?

Regardless of git's Windows problems, another problem will probably be
finding a decent GUI that suits my colleagues.

Markus
