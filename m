From: Mark Dodwell <web@mkdynamic.co.uk>
Subject: Re: Git (SHA1) problem on Mac
Date: Fri, 11 Apr 2008 00:58:24 +0100
Message-ID: <D23E2A3B-EBC4-4983-93F1-D08C7916DEF6@mkdynamic.co.uk>
References: <FAA4D842-DCB2-45B4-AB40-6F7D1F0A0320@mkdynamic.co.uk> <905315640804101617v25e70d2aw983718cb41c441c9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: tarmigan <tarmigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 01:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk6fS-0003na-PW
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 01:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbYDJX6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 19:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbYDJX6P
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 19:58:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51921 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbYDJX6O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 19:58:14 -0400
Received: from [192.168.1.66] (host86-158-113-105.range86-158.btcentralplus.com [86.158.113.105])
	by mrelayeu.kundenserver.de (node=mrelayeu7) with ESMTP (Nemesis)
	id 0ML2xA-1Jk6eg3dxZ-0003XX; Fri, 11 Apr 2008 01:58:13 +0200
In-Reply-To: <905315640804101617v25e70d2aw983718cb41c441c9@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
X-Provags-ID: V01U2FsdGVkX197KELWlmaeEVAmU+jsMPLMaALUwdVI3bD/3+j
 4KNo7uZbjvjrR9GfXsT/9N5Q6Gk4MOVcC/gh8zXAKZayOedlaT
 50K1aV7E9DEPj7O2PuExk9ibZbAy3TS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79258>

On 11 Apr 2008, at 00:17, tarmigan wrote:
> On Thu, Apr 10, 2008 at 2:12 PM, Mark Dodwell <web@mkdynamic.co.uk>  
> wrote:
>> Hi,
>>
>>  I've got a problem with Git on my Mac, and I've exhausted Google  
>> and #git
>> (irc), perhaps somebody can help?
>>
>>  I'm using git version X installed from source, I'm on Mac OS X  
>> 10.4.11.
>>
>>  Here's the problem I'm seeing:
>>
>>  [imac:~]$   mkdir git-test
>>  [imac:~]$   cd git-test
>>  [imac:~/git-test]$   git init
>>  Initialized empty Git repository in .git/
>>  [imac:~/git-test]$   touch README
>>  [imac:~/git-test]$   git add README
>>  [imac:~/git-test]$   git commit -m 'first commit'
>>  Created initial commit b6e6cb6: first commit
>>   0 files changed, 0 insertions(+), 0 deletions(-)
>>   create mode 100644 README
>>  [imac:~/git-test]$   git remote add origin
>> git@github.com:mkdynamic/git-test.git
>>  [imac:~/git-test]$   git push origin master
>>  Counting objects: 3, done.
>>  Writing objects: 100% (3/3), 215 bytes, done.
>>  Total 3 (delta 0), reused 0 (delta 0)
>>  fatal: final sha1 did not match
>>  error: unpack failed: unpacker exited with error code
>
> I think I had the same problem yesterday.  Do you have fink installed?
>  Specifically the openssl packages?  Uninstalling those through fink
> and recompiling git did the trick for me, though I'm not sure what the
> real problem was.
>
> You should also be able to define NO_FINK as well (see the beginning
> of the Makefile).
>
> Good luck,
> Tarmigan

Thanks so much, that did the trick. I had to remove the openssl  
packages through fink and then recompile git. Now it works!

Thanks,

~ Mark
