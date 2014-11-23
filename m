From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Sun, 23 Nov 2014 23:15:24 +0000
Message-ID: <54726A8C.4040600@ramsay1.demon.co.uk>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk> <xmqqegstychq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 00:15:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XsgNS-0007CN-H4
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 00:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbaKWXP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Nov 2014 18:15:29 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:53327 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752299AbaKWXP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 18:15:28 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 4CE6E18CD66;
	Sun, 23 Nov 2014 23:15:48 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 0239A18CD64;
	Sun, 23 Nov 2014 23:15:48 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sun, 23 Nov 2014 23:15:47 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqegstychq.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260108>

On 23/11/14 18:53, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>=20
>> On 23/11/14 14:16, Torsten B=C3=B6gershausen wrote:
>>> gcc under cygwin reports several warnings like this:
>>>  warning: implicit declaration of function 'memmem'
>>>   [-Wimplicit-function-declaration]
>>> This has been observed under CYGWIN-32 with GCC 4.7.3 as well
>>> as CYGWIN-64 with gcc v4.8.3-5 x86-64
>>
>> Heh, thanks for looking into this. Your email came at a good time,
>> since I was just about to boot my old laptop into windows XP to
>> test my patch on 32-bit cygwin! (If I had not been watching the
>> F1 Grand Prix on TV, I would already have done so! ;-) ).
>>
>> It's been a while since I updated my 32-bit cygwin installation
>> (about 6 months) but I'm a little surprised you found this issue
>> with gcc 4.7.3 (I'm _almost_ tempted to boot that laptop anyway
>> just to see what versions of software it is running).
>=20
> So you have an old installation to check how well the patched
> version is accepted by the old set of header files?

=2E.. I can, indeed, use this old installation to test this on
32-bit cygwin. sigh, I thought I had dodged that bullet! ;-)

[I can't do this tonight and I'm pretty busy tomorrow, so it
may have to wait until tomorrow evening at the earliest. sorry
about that. :( ]

This does not help much with 64-bit cygwin. They are effectively
two different 'distributions'.

ATB,
Ramsay Jones
