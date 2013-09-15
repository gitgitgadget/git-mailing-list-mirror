From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sun, 15 Sep 2013 13:42:43 +0200
Message-ID: <52359D33.508@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com> <5221A510.2020206@web.de> <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com> <5221B324.7020908@web.de> <CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com> <5221C533.1070109@web.de> <CAMP44s39X2SsZC7f6=j=CX+9wky7YpiJUz3itCiqeLScD0TbNA@mail.gmail.com> <522C95F3.5030308@web.de> <CAMP44s0LOhGWpgy6iy==WC7tBtjUjG-CTJ6jXNm+Jumu-5OkXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 15 13:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLAjM-0002xO-Hm
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 13:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab3IOLnA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Sep 2013 07:43:00 -0400
Received: from mout.web.de ([212.227.17.12]:57644 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab3IOLmt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 07:42:49 -0400
Received: from [192.168.2.102] ([79.253.143.104]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LzKJV-1VyRUc2mob-014Wdr for <git@vger.kernel.org>;
 Sun, 15 Sep 2013 13:42:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0LOhGWpgy6iy==WC7tBtjUjG-CTJ6jXNm+Jumu-5OkXw@mail.gmail.com>
X-Provags-ID: V03:K0:VZ4iynxU5s+TyYHtwXzyKgn2cQPom6caNlM/8T9U6zWODswt71k
 IntvhiJ36VWa7dnFNI++LySw0LkMwg6VLElIGttsNMozY+R4e7xBievXIFmBu0QhNbNv4J6
 0eLa5oz50MopoGHAehUOZWtqM8BdSF0A/9aO29kUlY913vajH6NTphgT8x7ZdAAWj/DgDDU
 lTxKQ07AmQYS91KqPiU8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234813>

Am 09.09.2013 01:13, schrieb Felipe Contreras:
> On Sun, Sep 8, 2013 at 10:21 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> Am 31.08.2013 19:20, schrieb Felipe Contreras:
>>
>>> A summary should contain as much information that would allow me to
>>> skip the commit message as possible.
>>>
>>> If I can't tell from the summary if I can safely skip the commit
>>> message, the summary is not doing a good job.
>>>
>>> "trivial simplification" explains the "what", and the "why" at the
>>> same time, and allows most people to skip the commit message, thus =
is
>>> a good summary.
>>
>>
>> No patch should be skipped on the mailing list.  As you wrote, trivi=
al
>> patches can still be wrong.
>
> What patches each persons skips is each person's own decision, don't
> be patronizing, if I want to skip a trivial patch, I will, I can't
> read each and every patch from the dozens of mailing lists I'm
> subscribed to, and there's no way each and every reader is going to
> read each and every patch. They should be prioritized, and trivial
> ones can be safely skipped by most people.

Yes, of course; someone needs to review every patch in the end, but eac=
h=20
reader decides for themselves which ones to skip.  I can't keep up with=
=20
the traffic either.

By the way, the bikeshedding phenomenon probably causes trivial patches=
=20
to receive the most attention. :)

>> When going through the history I can see that quickly recognizing
>> insubstantial changes is useful, but if I see a summary twice then i=
n my
>> mind forms a big question mark -- why did the same thing had to be d=
one yet
>> again?
>>
>> As an example, both 0d12e59f (pull: replace unnecessary sed invocati=
on) and
>> bc2bbc45 (pull, rebase: simplify to use die()) could arguably have h=
ad the
>> summary "trivial simplification", but I'm glad the author went with
>> something a bit more specific.
>
> Well I wont. Because it takes long to read, and after reading I still
> don't don't if they are trivial or not, I might actually have to read
> the commit message, but to be honest, I would probably go right into
> the diff itself, because judging from Git's history, chances are that
> somebody wrote a novel there with the important bit I'm looking for
> just at the end, to don't ruin the suspense.

Ha!  It's better to write it down at all than to miss it years later,=20
when even the original author has forgotten all about it.

> In the first commit, it's saying it's a single invocation, so I take
> it it's trivial, but what is it replaced with? Is the code simpler, i=
s
> it more complex? I don't know, I'm still not being told *why* that
> patch is made. It says 'unnecessary' but why is it unnecessary?

The sed call is unnecessary because of the fact that it can be replaced=
=2E=20
:)  I'm sure I would have understood it to mean a conversion to Shell=20
builtin functionality in order to avoid forking and executing an=20
external command, even if I hadn't read the patch.

> In the second commit, it's saying it's a simplification, but I don't
> know if it's just one instance, or a thousand, so I don't know what
> would be the impact of the patch.
>
> Either way I'm forced to read more just to know if it was safe for me
> to skip them, at which point the whole purpose of a summary is
> defeated.

I don't see how using "trivial simplification" as the summary for both=20
could have improved matters.

>>> Again, triviality and correctness are two separate different things=
=2E
>>> The patch is trivial even if you can't judge it's correctness.
>>
>> Well, in terms of impact I agree.
>
> No, in all terms. A patch can be:
>
> Trivial and correct
> Trivial and incorrect
> Non-trivial and correct
> Non-trivial and incorrect

Well, yes, but I thought your statement that "The patch is trivial" was=
=20
referring to my actual patch which started this sub-thread.  And I mean=
t=20
that the benefit of that patch to users and programmers was small.

>>> To me, what you are describing is an obvious patch, not a trivial o=
ne.
>>> An obvious patch is so obvious that you can judge it's correctness
>>> easily by looking at the diff, a trivial one is of little importanc=
e.
>>
>> That's one definition; I think I had the mathematical notion in mind=
 that
>> calls proofs trivial which are immediately evident.
>
> We are not talking about mathematics, we are talking about the Englis=
h
> human language.

Here we were talking about source code patches.  As formal descriptions=
=20
of changes to (mostly) programming language text they are closer to=20
mathematics than English.  Using math terms when talking about them is=20
not too far of a stretch.

Ren=C3=A9
