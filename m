From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Log is always empty in OSX
Date: Fri, 27 May 2011 22:28:46 +0200
Message-ID: <4DE0097E.6020601@kdbg.org>
References: <BANLkTim4iBtNPm65vTiJYyA4csTHu9gd2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Diego Gonzalez <diegog.lagash@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 22:29:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ3f8-0001RI-Oc
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 22:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615Ab1E0U2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 16:28:50 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:3761 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752961Ab1E0U2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 16:28:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AEF72CDF86;
	Fri, 27 May 2011 22:28:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 793BD19F3C6;
	Fri, 27 May 2011 22:28:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <BANLkTim4iBtNPm65vTiJYyA4csTHu9gd2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174647>

Am 27.05.2011 21:38, schrieb Diego Gonzalez:
> Hi guys,
> I'm using GIT in a specific folder on OSX and I'm not able to get any
> output from the git log command, do you know what it means? Is this a
> bug or just some missconfiguration. I've installed through Homebrew.
> 
> $uname -a
> Darwin Diego-Gonzalezs-MacBook-Pro.local 10.7.0 Darwin Kernel Version
> 10.7.0: Sat Jan 29 15:17:16 PST 2011; root:xnu-1504.9.37~1/
> RELEASE_I386 i386
> $ git version
> git version 1.7.5.2
> $ git log
> $ git commit -a -m "message"
> [master 445dab2] message
>  2 files changed, 1 insertions(+), 23 deletions(-)
>  mode change 100644 => 100755 c
>  delete mode 100644 ur.js
> $ git log
> $

Do you happen to have the environment variable LESS set to a combination
of options such that less terminates when it does not get a screenfull
of data to show? In this case, less would switch to the alternate
screen, shows the data, and before it terminates, it switches back to
the primary screen.

Try git --no-pager log; I bet it shows output.

-- Hannes
