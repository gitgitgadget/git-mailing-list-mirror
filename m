From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Sat, 15 Dec 2012 01:45:44 -0600
Message-ID: <CAMP44s0=R3rdnD-Zpzz_7wY6HKKsAL1sPVYh4pc3z1CBbX2ODg@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
	<CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
	<F151B265-7E3E-4989-AA16-EB7CAC298126@quendi.de>
	<CAMP44s0r_KAKt7Lm1cdumN1cOWzjab3ruYqxp-s6OR1g1qqbcQ@mail.gmail.com>
	<50CC2244.4040103@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <postbox@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Dec 15 08:46:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjmRn-0003Be-Ay
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 08:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903Ab2LOHpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 02:45:46 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52604 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2LOHpp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 02:45:45 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so5180444vby.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 23:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZBodod2sRrUKOTg7LD0iLVsdSSxovfJ/Mz07kmCsuAA=;
        b=suh0PtgSdOY8L8Y3Ip2+VUvsYW5ZBhOZzi7XNIWFWjqmzG7uACJgL5Brr6Q9b8dv6J
         oA3JKECVXFLjpkzdZb0beKqPJNJaODMlxr+wxHu9GlBF/7qmFfZpVETnrbqj4xAQUzpI
         0ccWJbx8bWtLZcQr2mhrdKROCqC2HXu3ub5bgpmufrs3HC9+Lu4K2IgYaR8Do1Ll5lIr
         XnhrKV73togmnDdFCbf1rMrmr/NMSPyWEib7WOXrRVXDlTosWx3qGxg8ShoJxIlh/HXG
         isCEih4C/Qf77+NnZAz9yXGlvWxqEjhh0vLCLT/KwV19qjWyubi0DWjtX+G7SKFvtPpN
         mPgA==
Received: by 10.52.75.105 with SMTP id b9mr11530047vdw.28.1355557544394; Fri,
 14 Dec 2012 23:45:44 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Fri, 14 Dec 2012 23:45:44 -0800 (PST)
In-Reply-To: <50CC2244.4040103@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211521>

On Sat, Dec 15, 2012 at 1:09 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/15/2012 04:14 AM, Felipe Contreras wrote:
>> I'm going to say it one last time; merging this patch series either
>> creates issues for the users, or not. There is a reality out there,
>> independent of what you, Junio, or me think or say. And the fact is,
>> that if this patch series is going to create issues for the users,
>> *nobody* has pointed out why, so, since there's no evidence for it,
>> the only rational thing to do is believe that there will be no issues
>> for the users.
>>
>> There is no known issue with the code, that is a fact. This code could
>> be easily merged today, and in fact, it was merged by Junio already
>> (but then reverted). There are no positive outcomes from the delay,
>> only negative ones. I will address the minute issue about the extra
>> cruft, eventually.

Couple of facts first:
a) This code was already merged
b) This code is for a test
c) I'm the only developer so far

> Cruft in the codebase is a problem for git *developers* because it makes
> the code harder to maintain and extend.

A problem big enough to warrant the rejection of the patch series? No.

> And therefore cruft is a problem for git *users* because it slows down
> future development (in whatever small amount).

Don't confuse potential issues with real ones. It *might* slow down
future development, but will it do it with absolute certainty and
beyond any reasonable doubt? No, it might not slow anything at all.

And even if it does, by how much? 50%? 10%? 1%? Chances are it would
be barely noticeable to the users.

And even if it was substantial, this is on *test* code. Most users
survive just fine with most of the contrib code not having tests at
all, they can probably survive with the development of the test code
for remote-bzr being a tad slower.

But who are these developers that would be slowed down? So far I'm the
only contributor, and I'm not going to be slowed. If and when somebody
else contributes, and find his or her development is slowed down by
this, he or her would probably start by removing that code his or
herself, and submit the appropriate patch.

> Moreover, it is dangerous for a project to accept crufty code based on a
> contributor's promise to clean up the code later:

But it was already accepted:
http://git.kernel.org/?p=git/git.git;a=commitdiff;h=ad38af72b334150e6cf1978721c37077ae3c6d7f

The world didn't end the first time, presumably, if this code is
accepted again, the world will not end either.

> * The developer might not get around to it, or might take longer than
> expected.

Somebody else could do it. This is collaborative development after
all, is it not?

I don't see people halting because something is somebody else's code.

> * Until it is cleaned up, the cruft hinders other potential developers
> to that code.

How many *potential* developers are we talking about? By how much?

> * The presence of cruft lowers the expectation of quality for the whole
> project; cruft breeds more cruft.

Please. This is in test code for the contrib area, most code in that
area doesn't even have tests.

> It is simpler and fairer to have a policy "no crufty code" than to try
> to evaluate each instance on a case-by-case basis.

Even then, the problem can be easily solved by simply removing the
whole file (contrib/remote-helpers/test-bzr.sh), I say that has more
potential to hurt users and developers, but hey, "no crufty code".
Since most code in the contrib area doesn't have tests, we would still
be following the "policy".

None of this benefits the *real* users one iota.

Anyway, these theoretical minute problems aren't worth worrying about,
nor discussing. If you want to damage real users, go ahead.

Cheers.

-- 
Felipe Contreras
