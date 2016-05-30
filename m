From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] t4051: rewrite, add more tests
Date: Mon, 30 May 2016 22:55:35 +0200
Message-ID: <574CA8C7.8070807@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de> <5749B1EA.10707@web.de>
 <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 22:57:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7UFX-0000lb-3J
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162345AbcE3U4I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 16:56:08 -0400
Received: from mout.web.de ([212.227.15.4]:60622 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161857AbcE3Uzt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 16:55:49 -0400
Received: from [192.168.178.36] ([79.213.117.50]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MMEyj-1b8sKm13Gv-007zS1; Mon, 30 May 2016 22:55:41
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:glT9JUeGBFEf+79HsSipIobat1ISCV4zksEeVzbFWbQjWFDzoVZ
 TtvLKrWV+2pjrZ0KPDt/ax0RfW0fU4Y994Y2ynR6sBnXAiVqAv2xL8pCW9Irv79eqMvbybA
 TdkuUE6U0goPtbyB+1+S4xOVnWOC2Z6453Vo/jSPdTBf+r68BwEqZUvgB7lhxgGEiwYb0tt
 8O770yjhL1r0exjcfTDyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g1ftyuWiVQE=:76TfVXWM1KSfvEOmSR5ccY
 oskEc9NV0hCrvhl9kUrpTM5452bi2BR4vDjbIIhbsKDvAWhstIny/03K8pONeZI7eqXAR+ky4
 7weGeBFRh0WY582k/PEeL7wbLR8i8FB3kTBIIKe/z2FT6xpSWjVOIiakaAcS3LQ5OfiLYSBcO
 Mnz4NpOICgTqHLM8uGlZU7WH1jKwt0k3S0GMyKQj1nhkkMAxsbd3ttcaPlXhPFef319f5oGVg
 0MknRTq2LdKVneRT/u62GgA9vbz2zvimyPs/RCejlzuO51eYNN8YYD7juK0SLA39Q31eBRn2v
 SMHmABOqDbySbfvOJUyqfwoOWW3duCTCjErIE1V+kSf5Brj6tSphfLc76roOu5hWVGk4HJ2hF
 DRHTUoCyCaQu9xL7db0jzbcPtS6bVGqG1/SvUwiDfsx1XgfU7crL+MIsHYPUKm1aWdI3xP60A
 OafeyNkvT6lQm/r3+rMcoF2IZ+DeHs3Sua2tGz/ZVbUe+EFXoJuEdHBxix1RN90S/k7f/fs+7
 eGBf70cIoVru82qfovcCOQ0hxIU47OqPifK9yQkCtzKxSH1DPZuytbvd8zqIGINcw5g/VxdGi
 MSqJ4cu5zmi8EvsyNb6JdDyRKjz1QNO2UwqxHj2VEJiZ5yY0UHbrolRGBpEgf0Yd11o3pCwM9
 m96UX3p7jtobGn0VjIjzkWBa4T7NenCyL1wlU3/lRnTCl95IESMiTgtlgaAlJc8fgykAXI2lg
 QQeapz2M9GOkzoJe4tVhUQHEvK7koeTr++N1ZfhRSvUnTj1A33Irz202B1zNVM3VhHRdmCX4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295931>

Am 30.05.2016 um 01:55 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> +commit_and_tag () {
>> +	message=3D$1 &&
>> +	shift &&
>> +	git add $@ &&
>
> Lack of dq around $@ makes me wonder if there is something funny
> going on (looking at the callers, there isn't, so we'd better quote
> it to avoid wasting time, I think).

OK.

>> +	test_tick &&
>> +	git commit -m $message &&
>> +	git tag $message
>>   }
>
> The use of $message as the sole argument to "git tag" makes the
> readers guess that it must be a single token without any funny
> character, so the readers would probably do not waste too much time
> wondreing if the lack of dq around $message in the last two is
> problematic.

Well, let's call it $tag; $message is a bit misleading here.  The saved=
=20
letters can be invested in quotes. ;)

>> +last_context_line () {
>> +	sed -n '$ p'
>>   }
>
> I have a vague recollection that some implementations of sed are
> unhappy to see that space between the address and the operation; I'd
> feel safer without it.

Indeed most sed calls in t/ have no space there (found counter-examples=
=20
only in annotate-tests.sh, t4201-shortlog.sh, t9824-git-p4-git-lfs.sh).

>> +check_diff () {
>> +	name=3D$1
>> +	desc=3D$2
>> +	options=3D"-W $3"
>> +
>> +	test_expect_success "$desc" '
>> +		git diff $options "$name^" "$name" >"$name.diff"
>> +	'
>> +
>> +	test_expect_success ' diff applies' '
>> +		test_when_finished "git reset --hard" &&
>> +		git checkout --detach "$name^" &&
>
> With the presence of ^ there, --detach is unnecessary; it would not
> hurt, though.

Right.  It's just there to make that intent clear.

>> +		git apply "$name.diff" &&
>> +		git diff --exit-code "$name"
>
> Even though we may know that $name.diff" will never have a creation
> of new paths, I'd feel safer if "apply" is run with "--index".

Makes sense; the less we assume about the diff to be checked the better=
=2E

Thanks a lot!

Ren=C3=A9
