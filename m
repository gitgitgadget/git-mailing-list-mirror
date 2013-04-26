From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 13:34:10 -0500
Message-ID: <CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:34:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnTd-0001K1-G9
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757224Ab3DZSeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:34:14 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:56829 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab3DZSeM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:34:12 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so1982007lba.12
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=79QM27KA1TCrAKxC4VsboOIG/WGT7yOMEIbPgUciOvo=;
        b=tLijBKcJ/cxEaagoEoRDKKMbtQC5eqAdOrVAxGSVgpB5W8yAqWhEJMt7wPAvVMu01b
         xUjnuSIsgwfskaUKo1XXqV++C25vURQotUPukZsOsrHlwwa4yUlF0bVUCzJQJrxLKRs2
         DlNtlIp9xDurtdzi2vdXe6vthQBzzi4rgkfa8JkDB048PGjtE/hLf7htjrBszsU3Nc6I
         Xj3EYqu0eJVT1Gb4hpXThZkJ8hJgGTMOgpFNlMppyY5DiedofYXBDNUM1AJRsnYUe//x
         SCyT9R1s8bKwytCSW3uCgVdfLVjLsdn5SZiG/7+37/EkxiDTeQNyUvFhAbIzbg09XzpF
         legA==
X-Received: by 10.152.5.134 with SMTP id s6mr23179439las.24.1367001250255;
 Fri, 26 Apr 2013 11:34:10 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 11:34:10 -0700 (PDT)
In-Reply-To: <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222549>

On Fri, Apr 26, 2013 at 4:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I am helping my fellow developers by replying to the comments they
>> make when I send the patches for review. Unfortunately, the only
>> developer other than you that has made any comment at all, Ramkumar
>> Ramachandra, did so in a bellicose tone, but I replied to all his
>> comments either way, which where invalid.
>
> I've never wanted to pick fights with anyone, and I don't foresee
> having a desire to do so in the future.  I was just saying what was on
> my mind, which is along the lines of: you have written this patch with
> the attitude "I know what I'm doing, my users will benefit, and nobody
> else is going to look at this patch anyway";

That is an assumption, it's wrong, and it's antagonistic. There's no
need for that.

> I'm worried about what
> your other patches look like if this is your attitude towards
> development.

More assumptions and hypotheticals. Why don't we limit ourselves to
facts and reality?

>> The history *is* readable. If anybody has any problems with the commit
>> messages, the place to mention such problems is IN THE PATCH REVIEW.
>> Nobody has done that, because either nobody has any problems, or they
>> are not interested. Either way, there's nothing I can do about it.
>
> That's what I've been trying to say over and over again: _why_ are
> people not reviewing your patches?
>
> 0. Because nobody has any problems with them.
>
> 1. Because nobody on the git list cares about remote-hg.
>
> 2. Because you're stubborn as a mule, and the resulting thread often
> results in long-winded discussions like this one (which wastes
> everyone's time).  Therefore, the potential reviewer's reasoning is
> that their review time is better spent elsewhere, where their review
> is actually appreciated.
>
> Hint: it's not (0).
>
> If you're claiming that (1) is the case, then why are you posting to
> the git list and hitting everyone's inboxes?  Maintain your project
> outside git.
>
> I'm claiming that it's (2).  In which case, it's you who needs changing.

This is the false dichotomy fallacy, why does it have to be only one
of these reasons? Couldn't it be a mixture of them? Maybe most people
don't care about remote-{bzr,hg}, maybe for the ones that do, most
don't see any problems in the patches, and maybe the ones that do see
problems in the patches don't bring them up, because of various
reasons, like for example, they don't see them as major, and would
rather fix them themselves later after investigation if they are
indeed import problems, or maybe they just don't have time to engage
in discussions.

Yes, there's a possibility that my stubbornness is a factor, and given
their possible lack of time, and possible lack of interested, they
choose to not engage.

But to claim that *everyone* is in (2), and that there are no other
factors that made them land in (2) but my stubbornness is disingenuous
at best.

What would you think of a scientist that says, oh, "I'm not going to
review that paper, because each time I do that, the reviewee defends
it, and we end up with long-winded discussions". This scientist
doesn't have the right spirit.

If you submit a review comment, you should be prepared to do defend
it, just like you do when you submit a patch. And you should be
prepared to accept that your patch has mistakes, just like you should
be prepared to accept that your review has mistakes. In this view,
stubbornness is a good thing, because it brings the best in the
reviewer, and in the reviewee, and in the end everyone benefits by
trying to achieve the higher quality possible. Just like stubbornness
is a good thing in science, if both reviwer and reviewee fight for
their point of view, only the best science wins, and we all benefit.

This is all of course if the stubbornness is warranted, but you
haven't claimed that it wasn't, simply that I was stubborn. Well, so
what? Isn't that good?

Show me where I was unreasonable, show me where I was wrong, not where
I was stubborn. One can be stubborn and be right, in fact, when one is
right, it's when one has all the more right to be stubborn.

If you are not prepared to defend your review, so are others, why to
you blame that on me? If you were right, you would be shown to be
right. Period.

>> I'm willing to change my ways when there's reason to change my ways,
>> and so far, nobody has provided any evidence that my commit messages
>> are indeed lacking, only *opinions*.
>
> You want a formal mathematical proof?  We operate on opinions, and
> freeze what we think we all agree with into "community guidelines".

No, we operate in evidence and reason, *not* opinion. Any reasonable
person would say "well, I *think* this commit message needs more
description, but I don't *know*, I don't have *evidence* for it, so
I'm not going to fight to the death, as if I had".

Any reasonable person would know the difference between an opinion,
and an objective fact. And react accordingly when another person
attacks an opinion, which is not a big deal, and when an objective
fact is attacked, which is a big deal.

>> Other people are perfectly fine with them:
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=felipe.contreras
>
> So you're now claiming that we're the ones at fault (Peff, Thomas,
> Junio, and me, among others).  Okay, so why are you forcing your
> changes and opinions down our throats?

Where am I doing that?

First of all, lets not act like bitching girlfriends arguing about who
didn't throw the trash three years ago. We are talking about
*remote-bzr*, in fact, the subject is "[PATCH 1/9] remote-bzr: trivial
cleanups". *NONE* of this discussion is relevant to that patch.

If we go one step above, to remote-helpers in general, nobody has
commented *ANYTHING* negative on those patches, you are the first to
do so. So how exactly did I managed to shove 71 patches down you
throat if everybody complained all the way?

Ultimately the decision to merge or not to merge comes to Junio, if
you don't like his decision, go complain to him, but I would be
prepared with points in time where people complained about these
patches, and there are no complains, so you have no ammunition at all
whatsoever.

If you are talking about something else, FFS, change the subject line.
If you want to argue about who didn't take out the trash three years
ago, fine, but lets do so clearly in another thread, not this one
about a *single trivial patch*.

> You're in the wrong community:
> join a community of people who are more like you (or start your own
> project), and stop wasting our time.

And this is how communities die. When everybody thinks the same, and
everyone who thinks differently is displaced. A monoculture, a place
full of yes-men where nobody criticizes anybody, a circlejerk where
everyone palms the back of everyone else. Eventually things go south,
and nobody around you understands why.

Diversity in a community is healthy. If you don't like people who
think differently, *you* have a problem. If you don't like standing up
and defending your ideas, *you* have a problem. If you don't like
discussing on the basis of evidence and reason, *you* have a problem.

Cheers.

-- 
Felipe Contreras
