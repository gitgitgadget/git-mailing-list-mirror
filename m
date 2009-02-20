From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 23:00:25 +0100
Message-ID: <499F27F9.8090506@trolltech.com>
References: <499EC48B.9070004@trolltech.com> <499EE324.4050305@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, Git Mailing List <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:01:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LadRQ-0004EL-8X
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 23:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbZBTWAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbZBTWAZ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 17:00:25 -0500
Received: from hoat.troll.no ([62.70.27.150]:35819 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbZBTWAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 17:00:24 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 1CA9A211E5;
	Fri, 20 Feb 2009 23:00:23 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id D3ECA211E3;
	Fri, 20 Feb 2009 23:00:22 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <499EE324.4050305@tedpavlic.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110895>

Ted Pavlic said the following on 20.02.2009 18:06:
>> +		if test "$(git config --bool core.bare)" == "true"; then
> 
> As discussed in another thread, to be consistent with local coding
>  convention, "test" should be replaced with "[ ... ]".
> 
> Additionally, double equality (==) should be replaced with single 
> equality (=).

Ok, I think I was based off of master at the time. I'll take a closer 
look. Thanks!

--
.marius
