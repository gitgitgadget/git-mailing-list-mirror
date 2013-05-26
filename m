From: Gioele Barabucci <gioele@svario.it>
Subject: Re: git clone does not understand insteadOf URLs
Date: Sun, 26 May 2013 21:03:19 +0200
Message-ID: <51A25C77.6040205@svario.it>
References: <51A11DD0.4040802@svario.it> <CA+EOSB=ow9Vc2J8qb3GAp4xj2GgY8qes=5Q-k-rH6VsVLjzCsg@mail.gmail.com> <51A24C75.3090100@svario.it> <87a9nhhb9c.fsf@hase.home> <51A24FF4.4010102@svario.it> <20130526181430.GL27005@serenity.lan> <51A252B9.7040008@svario.it> <20130526190019.GM27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 26 21:03:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UggE3-0001Rs-QY
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 21:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab3EZTDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 15:03:24 -0400
Received: from camelia.svario.it ([164.138.26.129]:56385 "EHLO mail.svario.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab3EZTDX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 15:03:23 -0400
Received: from [192.168.2.4] (dynamic-adsl-84-223-204-159.clienti.tiscali.it [84.223.204.159])
	by mail.svario.it (Postfix) with ESMTPSA id 165F7214D6;
	Sun, 26 May 2013 19:03:20 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130526190019.GM27005@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225563>

Il 26/05/2013 21:00, John Keeping ha scritto:
>> Regardless of the implementation of the commands, if I do
>>
>>       mkdir projectA
>>       cd projectA
>>       git init .
>>       git remote add origin remote-repo/projectA.git
>>       git pull origin master
>>
>> I get a working repository. If I do
>>
>>       git clone remote-repo/projectA.git
>>
>> all I will get is an error.
>
> So the problem is that "git clone" does not seem to perform normal
> remote processing if you give it something that looks like a path.

I understand the problem. In the original email that started this thread 
I asked for...

> I suppose that git interprets the argument as a local directory. Git
> should see if the argument matches one of the known URLs before
> raising an error.

I think all the paths should mean the same in every git command. In this 
case, checking for insteadOf URLs before failing would solve this problem.

Regards,

-- 
Gioele Barabucci <gioele@svario.it>
