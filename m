From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 08:20:04 +0100
Message-ID: <5472DC24.9010008@web.de>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com> <54726A8C.4040600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 08:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsnwi-0004gb-HM
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 08:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbaKXHUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2014 02:20:24 -0500
Received: from mout.web.de ([212.227.15.4]:64438 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbaKXHUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 02:20:24 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MM1eu-1Xrfsw38TE-007nAc; Mon, 24 Nov 2014 08:20:06
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54726A8C.4040600@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:Rt5+kGN6TpzzOHv2DzcJaHegE1FPxsdkPk8ZBx8sGHPJWGYgcse
 ryDcddhBymYABOwyC5MCUFqBBOQkEqAUptFdmKmKfAwhHEqLU6DlVxtC+CvGCYcmTlcF1lF
 Igk0s+Og3+4SJvwNY2pgW048i+VV8WBSj4kE+rKntfBG8dkKLvtkBtJyu8pL3CJd9X5+jSL
 CZf608DHlyhm1yibPnS1g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260114>

On 2014-11-24 00.15, Ramsay Jones wrote:
> On 23/11/14 18:53, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
>>>> gcc under cygwin reports several warnings like this:
>>>>  warning: implicit declaration of function 'memmem'
>>>>   [-Wimplicit-function-declaration]
>>>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>>>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>>>
>>> Heh, thanks for looking into this. Your email came at a good time,
>>> since I was just about to boot my old laptop into windows XP to
>>> test my patch on 32-bit cygwin! (If I had not been watching the
>>> F1 Grand Prix on TV, I would already have done so! ;-) ).
>>>
>>> It's been a while since I updated my 32-bit cygwin installation
>>> (about 6 months) but I'm a little surprised you found this issue
>>> with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
>>> just to see what versions of software it is running).
>>
>> So you have an old installation to check how well the patched
>> version is accepted by the old set of header files?
>=20
> ... I can, indeed, use this old installation to test this on
> 32-bit cygwin. sigh, I thought I had dodged that bullet! ;-)
>=20

It depends what we mean with "old":
cygwin 1.5 is old, and I lost my test installation this summer:
One netbook was converted from XP to Linux, the other machine needs to =
be
re-installed and CYGWIN 1.5 is no longer available for download.

I can confirm that Ramsays patch works with CYGWIN 1.7 32 Bit.

=20
