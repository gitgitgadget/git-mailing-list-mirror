From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] unpack-trees: plug a memory leak
Date: Tue, 13 Aug 2013 23:32:46 +0200
Message-ID: <520AA5FE.1090208@web.de>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com> <CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com> <CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com> <CAMP44s1CAMPWXDSAc7WHahmrKRrB8aG_H9fnXAMi2LFOGy5EdA@mail.gmail.com> <520A7AAE.6010309@web.de> <7va9klwb03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 13 23:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9MDC-0003FR-Sf
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 23:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759337Ab3HMVdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Aug 2013 17:33:01 -0400
Received: from mout.web.de ([212.227.15.4]:60756 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759327Ab3HMVdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 17:33:00 -0400
Received: from [192.168.2.102] ([79.253.133.173]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MIvPJ-1V7RSs12fR-002aZU for <git@vger.kernel.org>;
 Tue, 13 Aug 2013 23:32:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <7va9klwb03.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V03:K0:cG/TUKet+kFm3DDLmLvrRAkg90fwB9g8EHmQ7kEX8b3Wg9LpDBy
 4zwzvRznRKAeERowGbcLduMwA1NK8wilkBSbrjzV1KB8Dv+lG2cOLBTWgpklZ7+lP9lNtyO
 xfgDos3nBD+lYsHYiTN1j3EYnvdVKT33r4d18rTq3cT3hvxYQyOnkZMy0IcBRlorb739C49
 jC3vsIGWFoZoiNzTrCMKA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232250>

Am 13.08.2013 23:12, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> From: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> Before overwriting the destination index, first let's discard its
>> contents.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> Tested-by: =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=D0=BD =D0=98=D0=
=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>> ---
>> Felipe sent this patch as part of multiple series in June, but it ca=
n
>> stand on its own.  This version is trivially rebased against master.
>> The leak seems to have been introduced by 34110cd4 (2008-03-06,
>> "Make 'unpack_trees()' have a separate source and destination index"=
).
>
> It was lost in the follow-up discussion and I missed it.

I had forgotten about it as well, until Felipe mentioned it again.

> I assume that this is signed-off by you as a forwarder?  I'd prefer
> to even mark it Reviewed-by: you.

Right, I did review the patch and you can tag it as such.

Thanks,
Ren=C3=A9
