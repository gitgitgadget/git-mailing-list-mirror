From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 22:55:52 +0100
Message-ID: <499F26E8.5090105@trolltech.com>
References: <499EC48B.9070004@trolltech.com> <499EDCCC.3030700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 22:57:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LadN8-0002aA-Hk
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 22:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZBTVz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 16:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbZBTVz5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 16:55:57 -0500
Received: from hoat.troll.no ([62.70.27.150]:40172 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZBTVz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 16:55:56 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0D6F5211E1;
	Fri, 20 Feb 2009 22:55:51 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 80C16211E0;
	Fri, 20 Feb 2009 22:55:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <499EDCCC.3030700@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.7
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110894>

Michael J Gruber said the following on 20.02.2009 17:39:
>> User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
>> rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19
>> ThunderGit/0.1a Mnenhy/0.7.6.666

Heh, you noticed the user-agent extra \o/ :-)


> Marius Storm-Olsen venit, vidit, dixit 20.02.2009 15:56:
>> Prefixes the branch name with "BARE:" if you're in a bare 
>> repository.
>> 
>> Signed-off-by: Marius Storm-Olsen <marius@trolltech.com> ---
>> Patch tried sent via ThunderGit extension. Sorry if it's mangled
>> :-)
> 
> Now what's that ThunderGit thingy? ;)
> 
> Seriously, I see you and Dscho have been carrying this on, and soon
> external commands may be lauched. Is this going in a git specific 
> direction rather than attaching patch files unmangled (UnflowedTB)?

Well, Dscho's intentions was, as the project name says, to simply send 
patches unflowed. I have, however, had many other features which I 
would like to see in a Git extension, which is why called it 
ThunderGit instead. First I want the extension to help with Best 
Practices for sending patches. Second, I want the extension to have 
neatness like:

   1) Saving a whole patch series as a mailbox, for easy apply. Maybe
      even a "create new branch based on <branch>, and apply series"
      feature? ^shrug^

   2) Send patch (series) based on a selected email
      (ie. setting "references" based on selection)

   3) Showing Git patches with diff coloring (maybe also in the
      editor, but mostly for received mails)

   4) Basic validation of patch before sending, like
      a) trailing whitespace
      b) consistent preceding whitespaces
      c) <add favorite>

This is my first extension though, so any help from people "in the 
know" would be great!

If all attempts fail to make the extension fool proof wrt sending 
proper unflowed patches, we could always just use Thunderbird as the 
front-end for 'git send-email' ;-) I'm almost tempted to already go 
that route, simply to avoid all the hassle. Then we could also just 
use the plaintext composer, instead of the HTML composer which isn't 
exactly "fool proof" for plaintext patches.

--
.marius
