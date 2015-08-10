From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Bug report Windows 10
Date: Mon, 10 Aug 2015 15:34:44 +0300
Message-ID: <20150810153444.d6ae43f44ef285e834711370@domain007.com>
References: <017101d0d367$d2009490$7601bdb0$@ms-informatique.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "MS-Informatique" <info@ms-informatique.be>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:34:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOmI1-0006ET-GL
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbbHJMet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:34:49 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:43447 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbbHJMet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 08:34:49 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t7ACYiYP029916;
	Mon, 10 Aug 2015 15:34:45 +0300
In-Reply-To: <017101d0d367$d2009490$7601bdb0$@ms-informatique.be>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275613>

On Mon, 10 Aug 2015 14:26:44 +0200
"MS-Informatique" <info@ms-informatique.be> wrote:

> My Windows notebook got updated to Windows 10 and now my Git Bash
> doesn't start and when I open an existing repository from Git Gui, I
> am getting next error: 
> "0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error
> 487 AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x410000,
> State 0x10000
> C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
> cygwin's heap, Win32 error 0"
> 
> I am running GIT version 1.9.5 (latest build for Windows).

This version is essentially abandoned because the development
happens on packaging the 2.x series for Windows, and using the updated
runtime (MSYS2 instead of MSYS).

So please try this:

1) Fetch the latest version of the new Git for Windows available --
   currently its 2.4.6 RC5 [1].
   Supposedly you should try 64-bit version.

2) If the bug still does manifest itself, prease report it to the
   project's tracker [2].

1. https://github.com/git-for-windows/git/releases/tag/v2.4.6.windows.1
2. https://github.com/git-for-windows/git/issues/
