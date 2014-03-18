From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Bug report -- "Illegal instruction" on Mac 10.6.8 without XCode
 installed
Date: Tue, 18 Mar 2014 14:35:55 +0400
Message-ID: <20140318143555.a2bee40a8010066a34c755c1@domain007.com>
References: <CAJjOWVqtWMrexdDyfVWY4=s=XT28RfD5Mbi9j1rdasU9v_rYAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ray Hengst <rkhengst@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 11:36:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPrNf-00012B-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 11:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbaCRKgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 06:36:17 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:56975 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbaCRKgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 06:36:16 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id s2IAZtLH002258;
	Tue, 18 Mar 2014 14:35:56 +0400
In-Reply-To: <CAJjOWVqtWMrexdDyfVWY4=s=XT28RfD5Mbi9j1rdasU9v_rYAw@mail.gmail.com>
X-Mailer: Sylpheed 3.3.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244349>

On Tue, 18 Mar 2014 01:33:25 -0700
Ray Hengst <rkhengst@gmail.com> wrote:

> Hi,
> I am running a Mac 10.6.8 and tried to install git-1.9.0 off of the
> installer (git-1.9.0-intel-universal-snow-leopard.dmg). The
> installation worked fine and gave no error messages. But whenever I
> type in a git command (see below for some I tried), it gives me this
> error message:
> Illegal instruction
> 
> I am completely new to git and mostly new of Unix, but here are some
> commands I tried:
> git
> git help
> git config
> git init
> git clean
> git config --global user.name "John Doe"
> git status
> 
> However, typing "man git" displays typical man pages.

This has nothing to do with your problem: the `man` program is not part
of Git and presumably works; it just finds and reads the specified
manual page--which is just plain text--renders it and shows to you.
And your problem is with misbehaving Git binary.

> I do not have Xcode installed. (it's very hard to find a legacy copy);
> the "make" command also is not present, so I can't use any of the
> workarounds I saw listed.
> I uninstalled git-1.9.0 successfully using the provided script, then
> downloaded the same file again (and installed it) to make sure I
> didn't get a corrupt copy. I had the same problem, however.
> If I can provide any more information just let me know.
> Thanks for any help you can provide.

I once came across this thread [1] on SO which says this might be due
to the binaries compiled for a newer version of the OS than you have
installed.  In any case, [2] suggests the installer is prepared by the
guy behind [3], and that project's bug tracker has a bug for exactly
your problem already filed [4].  You might want to chime in there
with more details if you feel like it.

1. http://stackoverflow.com/q/14268887/720999
2. http://git-scm.com/download/mac
3. http://sourceforge.net/projects/git-osx-installer/
4. http://sourceforge.net/p/git-osx-installer/tickets/97/
