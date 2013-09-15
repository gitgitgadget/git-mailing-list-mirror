From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sun, 15 Sep 2013 08:02:31 -0500
Message-ID: <CAMP44s3f=TzDGkMZawKm-KZozCfSvLQbhvQ83KrM9dqbNBm-pg@mail.gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
	<5221A510.2020206@web.de>
	<CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
	<5221B324.7020908@web.de>
	<CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com>
	<5221C533.1070109@web.de>
	<CAMP44s39X2SsZC7f6=j=CX+9wky7YpiJUz3itCiqeLScD0TbNA@mail.gmail.com>
	<522C95F3.5030308@web.de>
	<CAMP44s0LOhGWpgy6iy==WC7tBtjUjG-CTJ6jXNm+Jumu-5OkXw@mail.gmail.com>
	<52359D33.508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 15 15:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLByK-0001Ep-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 15:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab3IONCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Sep 2013 09:02:34 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:52884 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289Ab3IONCd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Sep 2013 09:02:33 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so3355666lbi.17
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2XxROZn6DEupJvSWrN8P9ouVu3hOuI+oD/5i6rHe2B0=;
        b=nABBSB6yEvtQXJ3z/Q7zGuGMYTqt0CzTkw8BKpig+k018ww0RH0Dyek25PAYNTsT+6
         6piCi4xH9TsMgcNLiI454EFk34ebmLA3u8x4Ow6i5rb6VmSjHrNYzbJyElqMGadt3vLE
         9lRJI0bAUtJEV2J+RaZZ7JD7zkZTQoOCzNDq+tzTeF5IKaqPSiNx/hyQ5VykHc+E5kRK
         re2m6g6kBK1YtFZcAPS+hubv6laSE+4c/2ZWdrrsCv0PaKob1e7BHbvf/Cpe6SNEroIt
         WWHuIq+hn10JHPWWhlKnmjOHc9sMCP69tWFr6NVFSeachtMscbTdIDwKEunumOzlpjVT
         5Q1A==
X-Received: by 10.112.89.100 with SMTP id bn4mr20671543lbb.16.1379250152075;
 Sun, 15 Sep 2013 06:02:32 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 15 Sep 2013 06:02:31 -0700 (PDT)
In-Reply-To: <52359D33.508@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234816>

On Sun, Sep 15, 2013 at 6:42 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 09.09.2013 01:13, schrieb Felipe Contreras:
>
>> On Sun, Sep 8, 2013 at 10:21 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>>>
>>> Am 31.08.2013 19:20, schrieb Felipe Contreras:
>>>
>>>> A summary should contain as much information that would allow me t=
o
>>>> skip the commit message as possible.
>>>>
>>>> If I can't tell from the summary if I can safely skip the commit
>>>> message, the summary is not doing a good job.
>>>>
>>>> "trivial simplification" explains the "what", and the "why" at the
>>>> same time, and allows most people to skip the commit message, thus=
 is
>>>> a good summary.
>>>
>>>
>>>
>>> No patch should be skipped on the mailing list.  As you wrote, triv=
ial
>>> patches can still be wrong.
>>
>>
>> What patches each persons skips is each person's own decision, don't
>> be patronizing, if I want to skip a trivial patch, I will, I can't
>> read each and every patch from the dozens of mailing lists I'm
>> subscribed to, and there's no way each and every reader is going to
>> read each and every patch. They should be prioritized, and trivial
>> ones can be safely skipped by most people.
>
>
> Yes, of course; someone needs to review every patch in the end, but e=
ach
> reader decides for themselves which ones to skip.  I can't keep up wi=
th the
> traffic either.
>
> By the way, the bikeshedding phenomenon probably causes trivial patch=
es to
> receive the most attention. :)

Exactly, so if the summary of the commit message allows people to skip
a patch, that is fine.

>>> When going through the history I can see that quickly recognizing
>>> insubstantial changes is useful, but if I see a summary twice then =
in my
>>> mind forms a big question mark -- why did the same thing had to be =
done
>>> yet
>>> again?
>>>
>>> As an example, both 0d12e59f (pull: replace unnecessary sed invocat=
ion)
>>> and
>>> bc2bbc45 (pull, rebase: simplify to use die()) could arguably have =
had
>>> the
>>> summary "trivial simplification", but I'm glad the author went with
>>> something a bit more specific.
>>
>>
>> Well I wont. Because it takes long to read, and after reading I stil=
l
>> don't don't if they are trivial or not, I might actually have to rea=
d
>> the commit message, but to be honest, I would probably go right into
>> the diff itself, because judging from Git's history, chances are tha=
t
>> somebody wrote a novel there with the important bit I'm looking for
>> just at the end, to don't ruin the suspense.
>
>
> Ha!  It's better to write it down at all than to miss it years later,=
 when
> even the original author has forgotten all about it.

Yes, of course, but that still means the commit message summary failed
it's purpose.

>> In the first commit, it's saying it's a single invocation, so I take
>> it it's trivial, but what is it replaced with? Is the code simpler, =
is
>> it more complex? I don't know, I'm still not being told *why* that
>> patch is made. It says 'unnecessary' but why is it unnecessary?
>
>
> The sed call is unnecessary because of the fact that it can be replac=
ed. :)
> I'm sure I would have understood it to mean a conversion to Shell bui=
ltin
> functionality in order to avoid forking and executing an external com=
mand,
> even if I hadn't read the patch.

The problem is that the commit message is not for you, it's for every
reader, so the fact that you would have understood it that way is
irrelevant.

Maybe this is an exercise in the lack of empathy, and an example of
mono-culture.

>> In the second commit, it's saying it's a simplification, but I don't
>> know if it's just one instance, or a thousand, so I don't know what
>> would be the impact of the patch.
>>
>> Either way I'm forced to read more just to know if it was safe for m=
e
>> to skip them, at which point the whole purpose of a summary is
>> defeated.
>
>
> I don't see how using "trivial simplification" as the summary for bot=
h could
> have improved matters.

It would say "trivial", which allows me and a lot of other people to
safely skip them, it's as simple as that.

>>>> Again, triviality and correctness are two separate different thing=
s.
>>>> The patch is trivial even if you can't judge it's correctness.
>>>
>>>
>>> Well, in terms of impact I agree.
>>
>>
>> No, in all terms. A patch can be:
>>
>> Trivial and correct
>> Trivial and incorrect
>> Non-trivial and correct
>> Non-trivial and incorrect
>
>
> Well, yes, but I thought your statement that "The patch is trivial" w=
as
> referring to my actual patch which started this sub-thread.  And I me=
ant
> that the benefit of that patch to users and programmers was small.

I don't understand what you are trying to say, the point remains; a
patch being trivial says nothing about its correctness.

>>>> To me, what you are describing is an obvious patch, not a trivial =
one.
>>>> An obvious patch is so obvious that you can judge it's correctness
>>>> easily by looking at the diff, a trivial one is of little importan=
ce.
>>>
>>>
>>> That's one definition; I think I had the mathematical notion in min=
d that
>>> calls proofs trivial which are immediately evident.
>>
>>
>> We are not talking about mathematics, we are talking about the Engli=
sh
>> human language.
>
>
> Here we were talking about source code patches.  As formal descriptio=
ns of
> changes to (mostly) programming language text they are closer to math=
ematics
> than English.  Using math terms when talking about them is not too fa=
r of a
> stretch.

No, we are not. Commit messages have nothing formal about them, they
are human oriented and colloquial.

--=20
=46elipe Contreras
