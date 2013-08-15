From: Tim Chase <git@tim.thechases.com>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Thu, 15 Aug 2013 09:21:10 -0500
Message-ID: <20130815092110.3dc5620a@bigbox.christie.dr>
References: <20130814124933.77b51a04@bigbox.christie.dr>
	<20130814182657.3c03c5df@bigbox.christie.dr>
	<20130815080058.GM2337@serenity.lan>
	<20130815061229.24dfe891@bigbox.christie.dr>
	<20130815113542.GN2337@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: Tim Chase <git@tim.thechases.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Aug 15 16:19:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9yP4-0006Kl-N5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 16:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757319Ab3HOOTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 10:19:50 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:41073 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755797Ab3HOOTu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 10:19:50 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:49989 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1V9yOz-0007Fx-5y; Thu, 15 Aug 2013 09:19:49 -0500
In-Reply-To: <20130815113542.GN2337@serenity.lan>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232347>

On 2013-08-15 12:35, John Keeping wrote:
>>>> Just a follow-up, I tried it within the "bash"ish shell
>>>> included in the git install and got the same error regarding
>>>> "/tmp/report.tmp".
>>> 
>>> It seems that report.tmp is something that SVN creates and for
>>> some reason the svn on your system is trying to create it in a
>>> Unix style temporary directory.
>>> 
>>> What happens if you export TMPDIR=C:/Windows/Temp before running
>>> git-svn?
>> 
>> Still getting the same results.
> 
> This should be TMPDIR - note the missing 'E'!

I wish I could blame it on my doofus mistype, but I tried the same 4
operations as my previous email, using "TMPDIR" this time instead of
"TEMPDIR" but got the same errors regarding "/tmp/report.tmp".

> You may also need to "export TMPDIR" but I don't know how cmd.exe
> decides what environment variables to export to subprocesses.

>From my understanding/experimentation, cmd.exe acts as if all
environment variables are exported all the time (i.e., there is no
such thing as a "local" non-exported environment variable).

Any further ideas to try?

Thanks,

-tkc
