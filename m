From: Andreas Ericsson <ae@op5.se>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 12:42:41 +0100
Message-ID: <43787831.3030404@op5.se>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>	 <437870AF.8060607@op5.se> <cda58cb80511140322v686e4ee0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:46:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebckl-0007bq-3L
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 12:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVKNLmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 06:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVKNLmn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 06:42:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:10177 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751087AbVKNLmm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 06:42:42 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8CAF96BCBE; Mon, 14 Nov 2005 12:42:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140322v686e4ee0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11790>

Franck wrote:
> Hi Andrea
> 

Not sure why, but 85% of all people replying to me by email refer to me 
as "Andrea". Sort of cute I suppose, although I'm somewhat lacking in 
the TnA department.

> 2005/11/14, Andreas Ericsson <ae@op5.se>:
> 
>>Franck wrote:
>>
>>>Hi,
>>>
>>>I'm trying to use gitk --all command but it fails like this:
>>>
>>>"""
>>>Error executing git-rev-list: couldn't execute "git-rev-list": no such
>>>file or directory
>>>"""
>>>
>>
>>Is git-rev-list in your $PATH?
> 
> 
> yes:
>             # git-rev-list HEAD

This seems to imply you're running git-rev-list as root. The default 
installation directory for git is $HOME/bin which might not necessarily 
be in the $PATH once "wish" and friends have had their say.

>             3f1d5f26509defe2f691f5e94a2848848d1ba3a0
>             cd9a0ae21e015cc25a0ea98169451a59d49c0909
>             538310ad38629a1c1f983d982e52b568bc1dbe79
> 
> 
>>Did you compile (and/or install) with
>>
>>        make NO_OPENSSL=YesPlease
>>        make NO_OPENSSL=YesPlease install
>>
> 
> 
> nope I just did: "make; make install". I tried what you suggested but
> it's still failing the same way...
> 

So your binaries are installed in $HOME/bin then?

> 
>>Do other git commands work?
>>
> 
> 
> yes, at least some other commands like git-diff-xxx, git-checkout....
> 

Are you running all commands as the same user?

> 
>>>I'm running git on a fedora core 3. Can anybody give me some help ?
>>>
>>
>>Trying to, but a bit more verbosity in the error report wouldn't hurt.
>>
> 
> 
> I'm usig git v0.99.9h
> 

You could try installing from RPM. It should work nicely for all users.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
