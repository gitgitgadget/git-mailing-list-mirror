From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 07 Dec 2010 22:28:28 +0100
Message-ID: <4CFEA6FC.90008@web.de>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com> <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org> <4CFEA249.907@web.de> <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybQ==?= =?UTF-8?B?YXNvbg==?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: Scott Kyle <scott@appden.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ56I-0001m7-0W
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0LGV3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 16:29:13 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47242 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0LGV3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:29:12 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id D552617C662BA;
	Tue,  7 Dec 2010 22:28:28 +0100 (CET)
Received: from [93.240.100.207] (helo=[192.168.178.51])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQ55I-0000TO-00; Tue, 07 Dec 2010 22:28:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/un51SzrZ9guWjxVu8yRW/vkplAfR3YZR1U+Mz
	4Mn6v8/7VYhA/s5zetPLjgfwq1v9xLxwDsbE9b10vbKRUEUXjs
	4Kj7JHHPIJOkhUxd//NA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163139>

Am 07.12.2010 22:17, schrieb Scott Kyle:
> On Tue, Dec 7, 2010 at 1:08 PM, Jens Lehmann <Jens.Lehmann@web.de> wr=
ote:
>> Am 07.12.2010 21:31, schrieb Kevin Ballard:
>>> On Dec 7, 2010, at 4:15 AM, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason =
wrote:
>>>
>>>> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>>>>> For those who often work on repositories with submodules, the dir=
ty
>>>>> indicator for unstaged changes will almost always show because de=
velopment
>>>>> is simultaneously happening on those submodules. The config optio=
n
>>>>> diff.ignoreSubmodules is not appropriate for this use because it =
has larger
>>>>> implications.
>>>>
>>>> Wouldn't it be a lot better to instead add support for showing
>>>> submodule dirtyness as distinct from the main tree's dirtyness? Th=
en
>>>> you could easily spot if you had either your tree / submodule tree
>>>> changes, without just ignoring them.
>>>
>>> That sounds like a good idea, but it doesn't necessarily have to co=
me with
>>> this patch. Scott's use case here is he has a submodule that is _al=
ways_ dirty,
>>> and he simply doesn't want to see that stuff in the PS1. Having an =
option to
>>> show it separately would be very useful for me, but should perhaps =
be written
>>> as a separate patch.
>>
>> I'm not sure if I understand your case correctly, but if there is on=
ly one
>> submodule that is always dirty and everybody knows that but nobody c=
ares,
>> won't it make sense to change the "submodule.<name>.ignore" config o=
ption
>> for that peculiar submodule via .git/config or .gitmodules?
>>
>=20
> If I set the "submodule.<name>.ignore" then diffing around inside my
> history will not show the changes to that particular submodule.  That
> is what I meant by diff.ignoreSubmodules having larger implications.

Ah, seems I misunderstood your submodule being dirty as modified or
untracked files being present in it's work tree. But your submodules
HEAD seems to differ from the commit recorded in the superproject,
and then of course "submodule.<name>.ignore=3Ddirty" won't help you.
