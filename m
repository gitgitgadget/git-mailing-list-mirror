From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Mon, 23 Feb 2009 19:55:30 +0100
Message-ID: <49A2F122.7090607@trolltech.com>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com> <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com> <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com> <20090223161657.GL22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <git@storm-olsen.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:57:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbfzK-0000iu-JE
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbZBWSzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZBWSzc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:55:32 -0500
Received: from hoat.troll.no ([62.70.27.150]:54490 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbZBWSzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 13:55:31 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id E27D02108A;
	Mon, 23 Feb 2009 19:55:24 +0100 (CET)
Received: from [172.20.1.78] (unknown [172.20.1.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id A1D252125B;
	Mon, 23 Feb 2009 19:55:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 ThunderGit/0.1a Mnenhy/0.7.5.666
In-Reply-To: <20090223161657.GL22848@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111166>

Shawn O. Pearce said the following on 23.02.2009 17:16:
> Marius Storm-Olsen <marius@trolltech.com> wrote:
>> ^shrug^ at this point you and Junio can discuss what to do, as Junio  
>> already said
>>
>>   | "I do not understand the need for GIT_DIR! thing even
>>   |  less, but since we have that there already, I do not
>>   |  see a reason not to add this to the queue."
>>
>> And I have to agree with him. At this point, __git_ps1() is actually  
>> removing useful information from the prompt; at least it does for me.
> 
> *sigh*

Ops, I realize that it sounded like I was setting you two up against 
each other, which was not my intention! What I meant to say was, I've 
stated my case as clear as i can now, so you two can make a decision. 
I know Junio will listen to you, and I'd be fine if you said no, based 
on all the info I gave you. (Though I really didn't like the 
"GIT_DIR!"-branch, but oh well)


> OK.  I guess we include it then.
> 
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks, and again, sorry if you felt I put you up against Junio!

--
.marius
