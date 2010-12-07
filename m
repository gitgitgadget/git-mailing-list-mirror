From: Scott Kyle <scott@appden.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 13:17:06 -0800
Message-ID: <AANLkTinnH4pFaEf=e4YE64f7cwLRx2R_2o_-=JGua30b@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com>
 <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
 <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org> <4CFEA249.907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4uq-0003xc-Jg
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab0LGVR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 16:17:29 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54823 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab0LGVR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 16:17:27 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so356411wyb.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 13:17:26 -0800 (PST)
Received: by 10.216.164.66 with SMTP id b44mr916714wel.85.1291756646304; Tue,
 07 Dec 2010 13:17:26 -0800 (PST)
Received: by 10.216.242.137 with HTTP; Tue, 7 Dec 2010 13:17:06 -0800 (PST)
In-Reply-To: <4CFEA249.907@web.de>
X-Google-Sender-Auth: ZrrO1I3OUzJk-8Z8gddmKsqqhtw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163137>

On Tue, Dec 7, 2010 at 1:08 PM, Jens Lehmann <Jens.Lehmann@web.de> wrot=
e:
> Am 07.12.2010 21:31, schrieb Kevin Ballard:
>> On Dec 7, 2010, at 4:15 AM, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason w=
rote:
>>
>>> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>>>> For those who often work on repositories with submodules, the dirt=
y
>>>> indicator for unstaged changes will almost always show because dev=
elopment
>>>> is simultaneously happening on those submodules. The config option
>>>> diff.ignoreSubmodules is not appropriate for this use because it h=
as larger
>>>> implications.
>>>
>>> Wouldn't it be a lot better to instead add support for showing
>>> submodule dirtyness as distinct from the main tree's dirtyness? The=
n
>>> you could easily spot if you had either your tree / submodule tree
>>> changes, without just ignoring them.
>>
>> That sounds like a good idea, but it doesn't necessarily have to com=
e with
>> this patch. Scott's use case here is he has a submodule that is _alw=
ays_ dirty,
>> and he simply doesn't want to see that stuff in the PS1. Having an o=
ption to
>> show it separately would be very useful for me, but should perhaps b=
e written
>> as a separate patch.
>
> I'm not sure if I understand your case correctly, but if there is onl=
y one
> submodule that is always dirty and everybody knows that but nobody ca=
res,
> won't it make sense to change the "submodule.<name>.ignore" config op=
tion
> for that peculiar submodule via .git/config or .gitmodules?
>

If I set the "submodule.<name>.ignore" then diffing around inside my
history will not show the changes to that particular submodule.  That
is what I meant by diff.ignoreSubmodules having larger implications.
