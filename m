From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Sat, 21 Feb 2009 20:43:20 +0100
Message-ID: <49A05958.7050703@trolltech.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Marius Storm-Olsen <git@storm-olsen.com>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 20:44:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaxmJ-0002gd-LT
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 20:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbZBUTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 14:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbZBUTnT
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 14:43:19 -0500
Received: from hoat.troll.no ([62.70.27.150]:36773 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbZBUTnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 14:43:19 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3A17721181;
	Sat, 21 Feb 2009 20:43:17 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 096DB2117D;
	Sat, 21 Feb 2009 20:43:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110978>

Junio C Hamano said the following on 21.02.2009 20:29:
> Marius Storm-Olsen <git@storm-olsen.com> writes:
>> Prefixes the branch name with "BARE:" if you're in a bare
>> repository.
> 
> The updated code may correctly detect when you are in such a
> situation, but I have to wonder why anybody would even want to be
> reminded that he is in a bare repository to begin with.

Yeah I just noticed that, when I got some few cycles to spare. So I 
pushed out a v3 of that patch *sigh*

> For doing any usual work of growing history, you would work inside
> a repository with an work tree.  The only occasion you would *go*
> to a bare repository would be to tweak, futz with and fix one that
> is used as a distribution point, isn't it?  You usually update such
> a repository by pushing into it, so your being there would be a
> result of very conscious act of chdir'ing into it yourself, and you
> wouldn't be spending too much time in there anyway.
> 
> There may be a different workflow where you would stay in a bare 
> repository for an extended period of time and you would benefit
> from such a reminder like this patch adds, but I do not think of
> one.
> 
> Care to enlighten?

Right, I have quite a few repos on my machine which are just bare, as 
I use them gather branches and push out again. 
(http://repo.or.cz/w/git/platforms.git is one of them) However, it's 
probably just me, since I could just as easily put them in a proper 
directory structure to indicate their bareness.

Anyways, I just thought it would fairly "low cost" to add, and nice to 
have.

Consider it, as Linus coined the term, a throw-away patch. I can 
easily put it in my .bashrc instead. :)

--
.marius
