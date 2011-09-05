From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: Special characters in file name
Date: Mon, 05 Sep 2011 14:14:53 +0200
Message-ID: <4E64BD3D.6060900@intland.com>
References: <4E60C6D0.7090609@intland.com>	<loom.20110902T143646-347@post.gmane.org>	<20110903144617.GA17893@elie> <20110904000933.195d5bf4@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Mon Sep 05 14:15:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Y52-0005KJ-QK
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 14:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab1IEMPG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 08:15:06 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55668 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab1IEMPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 08:15:03 -0400
Received: from [192.168.1.101] (94-21-178-53.pool.digikabel.hu [94.21.178.53])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MMcW2-1R6ZQc27P4-008PiH; Mon, 05 Sep 2011 14:14:59 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <20110904000933.195d5bf4@zappedws>
X-Provags-ID: V02:K0:e86gX8Hk2mw1Efk41/FKMwlLuld/l4S3RAm3vsFZ3bB
 fTzXcx3NjX+im5pyhn0am8RdWqE8SbiRLCHkPmvpzKT8sidcnt
 hwumEUMY6qSHw8xKTox7WYK6VgShqzqKj1Dm88dEjo55xCuiHp
 LwDPAPSJ6nYRIGUOO9pcifLnNmQVOaLkFBmKstbwuMCvI9ifWT
 bs24Fx0IPNKs20yJfX2424dSLJu7KjmjLgtI27iGy6bQ/4kDL4
 6oy/MBqxJFccXNFaGWx5SgosgNEwxwt33heVUPUkDCI2VFjAE/
 F7nycRNLgFfkfqMlvOer0R6mpztmH4jK5y0h3agdzvjTiOKjb+
 FaTWQgAQbVQJ5Dj3rYxQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180739>

Thanks four your answer. However, it didn't help. After setting the=20
core.quotepath option to false I get this:

diff --git a/<E1>rv<ED>zt<FB>r<F5> b/<E1>rv<ED>zt<FB>r<F5>

Is there a solution?

Thanks,
=C3=81kos Tajti

2011.09.03. 22:09 keltez=C3=A9ssel, Alexey Shumkin =C3=ADrta:
>> Hi Alexey,
>>
>> Alexey Shumkin wrote:
>>> Tajti =C3=81kos writes:
>>>> I have a file named "=C3=A1rv=C3=ADz.txt" in my repository. When m=
odify that
>>>> file and execute git diff, the first line looks like this:
>>>> diff --git "a/\303\241rv\303\255z.txt" "b/\303\241rv\303\255z.txt"
>>>>
>>>> Is there an option that (if specified) will get git to print
>>>> "=C3=A1rv=C3=ADz.txt" instead of this escaped string?
>> [...]
>>> please, refresh your memory )))
>>> http://comments.gmane.org/gmane.comp.version-control.git/177849
>>>
>>> see my comment
>>> http://permalink.gmane.org/gmane.comp.version-control.git/177857
>> Cc-ing =C3=81kos so he can actually get your message this time. :)  =
(FWIW
>> the convention on this list is always to reply-to-all.)
> Yes, I know, but I replied with the gmane.org site form, and it did n=
ot
> CC-ed
