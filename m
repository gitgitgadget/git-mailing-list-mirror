From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 12:20:53 -0500
Message-ID: <CAMP44s39X2SsZC7f6=j=CX+9wky7YpiJUz3itCiqeLScD0TbNA@mail.gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
	<5221A510.2020206@web.de>
	<CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
	<5221B324.7020908@web.de>
	<CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com>
	<5221C533.1070109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 31 19:20:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFor4-0004xv-MR
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 19:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3HaRUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Aug 2013 13:20:55 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:44895 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRUy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 13:20:54 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2627238lbi.15
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cZUNEdUeS2RA+unb85QBE/Cf36YgORmPHOlXi7Xo8ms=;
        b=oQ67JFAObaYjVgGrCv32kOBbtBYbztjpe9xFD53X31536rHBcRF2Rm6UthpaYbt3l4
         5a+njHgBr+NupIMG0LLOskKhWEyxplDGfaBI9HBnQ1uxDv0WoVdYhlRv2RM7PQpG1uje
         53P4475Y5oS/KB4HrypNso5qPavx3AHQ2yJqU43O4JrT9aQwP+ThwEkJaSM3TdP5rGsr
         dF9eoEFeM0c3zhYBS96QWDizJmjkt2GTtlLSULxyeQgdPBH6wiFCdUD1z3w4wTds5JIk
         Eys3gJEBGwJ7XLSBTUyhKGZ7Wn+YAMvUm2bS6ZjxyXFEhU7/GAoTCshvtfAu0l2nZ4xK
         gBVw==
X-Received: by 10.112.14.3 with SMTP id l3mr12734279lbc.27.1377969653122; Sat,
 31 Aug 2013 10:20:53 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 10:20:53 -0700 (PDT)
In-Reply-To: <5221C533.1070109@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233524>

On Sat, Aug 31, 2013 at 5:28 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 31.08.2013 11:22, schrieb Felipe Contreras:
>
>> On Sat, Aug 31, 2013 at 4:11 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>
>>>> Subject: pull: trivial simplification
>>>>
>>>> With that summary, people would have an easier time figuring out i=
f
>>>> they need to read more about the patch or not.
>>>
>>>
>>>
>>> "trivial simplification" is too generic; we could have lots of them=
=2E
>>
>>
>> No, we can have only one, otherwise it would say simplificationS.
>
>
> I was too terse again, let me rephrase that: We could have lots of co=
mmits
> that fit the same description if we used such a generic one.

Yes, but they are all trivial, and they all simply the code.

>>> A summary should describe the change.
>>
>>
>> You can never fully describe the change, only the diff does that.
>>
>> For example "use $curr_branch_short more" does not tell me anything
>> about the extent of the changes, is it used in one more place? two?
>> one hundred? Moreover, how exactly is it used more? Is some
>> refactoring needed?
>>
>> And it still doesn't answer the most important question any summary
>> should answer: why? Why use $curr_branch_short more?
>
> A summary doesn't have to contain lots of details.  The what is impor=
tant,
> the why can be explained in the commit message.

A summary should contain as much information that would allow me to
skip the commit message as possible.

If I can't tell from the summary if I can safely skip the commit
message, the summary is not doing a good job.

"trivial simplification" explains the "what", and the "why" at the
same time, and allows most people to skip the commit message, thus is
a good summary.

>>> Its low complexity can be derived from
>>> it -- using an existing variable a bit more is not very exciting.
>>
>>
>> You didn't say "a bit more" you said "more". And yes, the complexity
>> can be derived from the summary, but not from this one.
>>
>>> But I wouldn't call that patch trivial because its correctness depe=
nds on
>>> code outside of its shown context.
>>
>>
>> Correctness is a separate question from triviality, and the
>> correctness can only be assessed by looking at the actual patch.
>>
>> The patch can be both trivial and wrong.
>
>
> Probably too terse again, let's say it differently: Only a patch whos=
e
> correctness can be judged without looking outside of the three lines =
of
> context it includes qualifies as trivial in my book.  The patch in qu=
estion
> is not trivial because you can't see the value of $curr_branch_short =
just by
> looking at the diff.

Again, triviality and correctness are two separate different things.
The patch is trivial even if you can't judge it's correctness.

To me, what you are describing is an obvious patch, not a trivial one.
An obvious patch is so obvious that you can judge it's correctness
easily by looking at the diff, a trivial one is of little importance.

>>> The reason for the patch isn't mentioned explicitly.  Perhaps it sh=
ould
>>> be.
>>> I felt that using something that's already there instead of recreat=
ing it
>>> is
>>> motivation alone.
>>
>>
>> Why? Because it simplifies the code. That's the real answer.
>
> I don't disagree.

Yet your commit message doesn't explain that anywhere.

--=20
=46elipe Contreras
