From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: SSH version on Git 1.8.1.2 for Windows is outdated.
Date: Fri, 15 Mar 2013 21:03:25 +0400
Message-ID: <20130315210325.7b0a3505ffa4d46e7e716324@domain007.com>
References: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kristof Mattei <kristof@kristofmattei.be>
X-From: git-owner@vger.kernel.org Fri Mar 15 18:04:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGY35-0000lp-2t
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 18:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab3CORDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 13:03:40 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:38486 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab3CORDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 13:03:39 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r2FH3P8D016533;
	Fri, 15 Mar 2013 21:03:26 +0400
In-Reply-To: <CAJ5Q6vXTyaegQq2uMoK7QQVYiYS9GcJhCefkQs9tXxqU=M10Vg@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218253>

On Fri, 15 Mar 2013 11:05:11 +0100
Kristof Mattei <kristof@kristofmattei.be> wrote:

> We're having issues with the version of SSH included in git version
> 1.8.1.msysgit.1 (Git-1.8.1.2-preview20130201.exe)
> 
> The included version of SSH is from 2007:
> 
> C:\Program Files (x86)\Git\bin - Old>ssh -V
> OpenSSH_4.6p1, OpenSSL 0.9.8e 23 Feb 2007
> 
> Updating the OpenSSH component (downloaded with Cygwin, cumbersome!!!)
> resolves the issue:
> 
> C:\Program Files (x86)\Git\bin>ssh -V
> OpenSSH_6.1p1, OpenSSL 1.0.1e 11 Feb 2013
> 
> Is there any way you can incorporate this update in the installer?

Yes, you should grab the msysGit (the Git for Windows build
environment) [2], tweak it to include the new OpenSSH binary, ensure it
builds and works OK and then send a pull request (or post your patchset
to the msysgit mailing list [3].

A sort of crash course on how to get started is [1].
The main page for the msysGit/Git for Windows development is [4].

Note that there should be no Cygwin involved, of course.
Git for Windows is built completely from the sources of all the
components it includes, using MinGW/MSYS so no component of Git for
Windows depends on the Cygwin runtime DLL.

1. https://github.com/msysgit/msysgit/issues/102#issuecomment-13572331
2. http://github.com/msysgit/msysgit
3. http://groups.google.com/group/msysgit
4. http://msysgit.github.com/
