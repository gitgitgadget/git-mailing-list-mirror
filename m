From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sun, 8 Sep 2013 18:13:00 -0500
Message-ID: <CAMP44s0LOhGWpgy6iy==WC7tBtjUjG-CTJ6jXNm+Jumu-5OkXw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 09 01:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIoAF-00085n-H6
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 01:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab3IHXND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 19:13:03 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:40866 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3IHXNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Sep 2013 19:13:02 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so4331906lab.35
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ba5bIMN/2C+ns5Rl0z/n5Do11NDUehwyO71okOb7pBk=;
        b=tL5uuDV2C1WYcP8fIXSIHyiHTag2Eo+QwHfIYuNACyR/SMKkFdz9d8n0V/a8XKDbTg
         Iky5TMIIwDWvAoswjnwsujxKgXEgFgbAq6QYD4oIjUr+eXVacyhCv1m5lJZFFzwarXIo
         g4VuNwT/Frr4UofwCrVaLqQXCt9dyKmGIEsvZMEq1KVCJDACfHOP2b0/wkRw135FTwNc
         Iyk7ywC37DfcNC8Nswt+Zdm62U+l7VuMzOZAWrjxDMYGl07aqxACbvmNy7adQLsMm2td
         1iau9YerBEz7C1xryyo3Ndue/QLM6rZJUtu6NX8LTENQqAJzFhSkkbtWHFD27cKkjrbV
         SCSg==
X-Received: by 10.152.44.225 with SMTP id h1mr13844097lam.15.1378681980507;
 Sun, 08 Sep 2013 16:13:00 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 16:13:00 -0700 (PDT)
In-Reply-To: <522C95F3.5030308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234281>

On Sun, Sep 8, 2013 at 10:21 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 31.08.2013 19:20, schrieb Felipe Contreras:
>
>> A summary should contain as much information that would allow me to
>> skip the commit message as possible.
>>
>> If I can't tell from the summary if I can safely skip the commit
>> message, the summary is not doing a good job.
>>
>> "trivial simplification" explains the "what", and the "why" at the
>> same time, and allows most people to skip the commit message, thus i=
s
>> a good summary.
>
>
> No patch should be skipped on the mailing list.  As you wrote, trivia=
l
> patches can still be wrong.

What patches each persons skips is each person's own decision, don't
be patronizing, if I want to skip a trivial patch, I will, I can't
read each and every patch from the dozens of mailing lists I'm
subscribed to, and there's no way each and every reader is going to
read each and every patch. They should be prioritized, and trivial
ones can be safely skipped by most people.

Here's a good example from a simple summary that I didn't write:

t2024: Fix inconsequential typos
http://article.gmane.org/gmane.comp.version-control.git/234038

Do I have to read this patch? No. I know it's inconsequential, I can
safely skip it, the key word being *I*. *Somebody* should read it,
sure, and I'm sure at least Junio would, but I don't need to.

> When going through the history I can see that quickly recognizing
> insubstantial changes is useful, but if I see a summary twice then in=
 my
> mind forms a big question mark -- why did the same thing had to be do=
ne yet
> again?
>
> As an example, both 0d12e59f (pull: replace unnecessary sed invocatio=
n) and
> bc2bbc45 (pull, rebase: simplify to use die()) could arguably have ha=
d the
> summary "trivial simplification", but I'm glad the author went with
> something a bit more specific.

Well I wont. Because it takes long to read, and after reading I still
don't don't if they are trivial or not, I might actually have to read
the commit message, but to be honest, I would probably go right into
the diff itself, because judging from Git's history, chances are that
somebody wrote a novel there with the important bit I'm looking for
just at the end, to don't ruin the suspense.

In the first commit, it's saying it's a single invocation, so I take
it it's trivial, but what is it replaced with? Is the code simpler, is
it more complex? I don't know, I'm still not being told *why* that
patch is made. It says 'unnecessary' but why is it unnecessary?

In the second commit, it's saying it's a simplification, but I don't
know if it's just one instance, or a thousand, so I don't know what
would be the impact of the patch.

Either way I'm forced to read more just to know if it was safe for me
to skip them, at which point the whole purpose of a summary is
defeated.

>> Again, triviality and correctness are two separate different things.
>> The patch is trivial even if you can't judge it's correctness.
>
> Well, in terms of impact I agree.

No, in all terms. A patch can be:

Trivial and correct
Trivial and incorrect
Non-trivial and correct
Non-trivial and incorrect

>> To me, what you are describing is an obvious patch, not a trivial on=
e.
>> An obvious patch is so obvious that you can judge it's correctness
>> easily by looking at the diff, a trivial one is of little importance=
=2E
>
> That's one definition; I think I had the mathematical notion in mind =
that
> calls proofs trivial which are immediately evident.

We are not talking about mathematics, we are talking about the English
human language.

--=20
=46elipe Contreras
