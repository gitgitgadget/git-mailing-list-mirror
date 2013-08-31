From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 12:28:03 +0200
Message-ID: <5221C533.1070109@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com> <5221A510.2020206@web.de> <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com> <5221B324.7020908@web.de> <CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 12:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFiPh-0004Gm-5b
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 12:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab3HaK2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 06:28:12 -0400
Received: from mout.web.de ([212.227.15.3]:65363 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab3HaK2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 06:28:11 -0400
Received: from [192.168.2.102] ([79.253.149.114]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6DuI-1WDU3v3Bmc-00yAV3 for <git@vger.kernel.org>;
 Sat, 31 Aug 2013 12:28:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com>
X-Provags-ID: V03:K0:KOLopCFxPyoTcv3mWM2OEVxB872SObbZKTx4Y36mtMO5bJD3La0
 GVWsHTSeqOo/u8Bu5n4tzu2hWSMWq4YpCS5+BOE7pLY3RH845jZ0BGjjKF//QxnsDvXKjUB
 ZhUXMcLtoFzKgdrZAhAy3rpUEq25C18/1gvbYRt8USfG8b5rPkclHcSaJzraNDMLTkXLhKe
 Ui90k25XvByi8bD4M8qfw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233514>

Am 31.08.2013 11:22, schrieb Felipe Contreras:
> On Sat, Aug 31, 2013 at 4:11 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
>>> Subject: pull: trivial simplification
>>>
>>> With that summary, people would have an easier time figuring out if
>>> they need to read more about the patch or not.
>>
>>
>> "trivial simplification" is too generic; we could have lots of them.
>
> No, we can have only one, otherwise it would say simplificationS.

I was too terse again, let me rephrase that: We could have lots of=20
commits that fit the same description if we used such a generic one.

>> A summary should describe the change.
>
> You can never fully describe the change, only the diff does that.
>
> For example "use $curr_branch_short more" does not tell me anything
> about the extent of the changes, is it used in one more place? two?
> one hundred? Moreover, how exactly is it used more? Is some
> refactoring needed?
>
> And it still doesn't answer the most important question any summary
> should answer: why? Why use $curr_branch_short more?

A summary doesn't have to contain lots of details.  The what is=20
important, the why can be explained in the commit message.

>> Its low complexity can be derived from
>> it -- using an existing variable a bit more is not very exciting.
>
> You didn't say "a bit more" you said "more". And yes, the complexity
> can be derived from the summary, but not from this one.
>
>> But I wouldn't call that patch trivial because its correctness depen=
ds on
>> code outside of its shown context.
>
> Correctness is a separate question from triviality, and the
> correctness can only be assessed by looking at the actual patch.
>
> The patch can be both trivial and wrong.

Probably too terse again, let's say it differently: Only a patch whose=20
correctness can be judged without looking outside of the three lines of=
=20
context it includes qualifies as trivial in my book.  The patch in=20
question is not trivial because you can't see the value of=20
$curr_branch_short just by looking at the diff.

>> The reason for the patch isn't mentioned explicitly.  Perhaps it sho=
uld be.
>> I felt that using something that's already there instead of recreati=
ng it is
>> motivation alone.
>
> Why? Because it simplifies the code. That's the real answer.

I don't disagree.

Ren=C3=A9
