From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Tue, 09 Aug 2011 18:26:33 +0100
Message-ID: <4E416DC9.2080907@ramsay1.demon.co.uk>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 09 20:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqr5b-00036K-1A
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1HISbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:31:40 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:59381 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752384Ab1HISbj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 14:31:39 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Qqr5V-0006iF-eL; Tue, 09 Aug 2011 18:31:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179040>

Erik Faye-Lund wrote:
> On Fri, Aug 5, 2011 at 6:10 PM, Pascal Obry <pascal@obry.net> wrote:
>> In fact Cygwin supports both, so make Git agree with this.
>> The failing case is when a file is committed in a sub-dir of the
>> repository using a log message from a file specified with a DOS
>> style path-name. To reproduce:
>>
>>   $ cd src
>>   $ git commit -F c:\tmp\log.txt file.c
>>   fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
>>   or directory.
> 
> Cygwin is a unix-layer on top of Windows, designed to play by the
> POSIX-rules. So why would you want to support Windows-style paths on
> Cygwin?
> 
> If you want a Git that handles Windows paths, use Git for Windows...

Indeed, I have to agree. This takes the cygwin port in the wrong
direction ...

ATB,
Ramsay Jones
