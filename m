From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 21:27:44 +0000
Message-ID: <5473A2D0.5010101@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk> <5472DC24.9010008@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 22:27:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1An-00036z-35
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 22:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaKXV1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 16:27:48 -0500
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:33307 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbaKXV1s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 16:27:48 -0500
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 18C00AC40BF;
	Mon, 24 Nov 2014 21:27:46 +0000 (GMT)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id C1DF4AC408F;
	Mon, 24 Nov 2014 21:27:45 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Mon, 24 Nov 2014 21:27:45 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5472DC24.9010008@web.de>
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260151>

On 24/11/14 07:20, Torsten B=C3=B6gershausen wrote:
> On 2014-11-24 00.15, Ramsay Jones wrote:
>> On 23/11/14 18:53, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>>
>>>> On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
>>>>> gcc under cygwin reports several warnings like this:
>>>>>  warning: implicit declaration of function 'memmem'
>>>>>   [-Wimplicit-function-declaration]
>>>>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>>>>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>>>>
>>>> Heh, thanks for looking into this. Your email came at a good time,
>>>> since I was just about to boot my old laptop into windows XP to
>>>> test my patch on 32-bit cygwin! (If I had not been watching the
>>>> F1 Grand Prix on TV, I would already have done so! ;-) ).
>>>>
>>>> It's been a while since I updated my 32-bit cygwin installation
>>>> (about 6 months) but I'm a little surprised you found this issue
>>>> with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
>>>> just to see what versions of software it is running).
>>>
>>> So you have an old installation to check how well the patched
>>> version is accepted by the old set of header files?
>>
>> ... I can, indeed, use this old installation to test this on
>> 32-bit cygwin. sigh, I thought I had dodged that bullet! ;-)
>>
>=20
> It depends what we mean with "old":
> cygwin 1.5 is old, and I lost my test installation this summer:

I updated from cygwin 1.5 to cygwin 1.7 at the beginning of the year.
Since it is no longer supported, I don't think we need to worry about
version 1.5. When I said 'old installation' I meant my old version 1.7
32-bit installation.

> One netbook was converted from XP to Linux, the other machine needs t=
o be
> re-installed and CYGWIN 1.5 is no longer available for download.
>=20
> I can confirm that Ramsays patch works with CYGWIN 1.7 32 Bit.

Thanks!

ATB,
Ramsay Jones
