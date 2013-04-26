From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 14:19:21 -0500
Message-ID: <CAMP44s2SaKe7F-3H=b3ZBgDPDT+TrVPUBLrXg0XDY7n5ppdS0Q@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri Apr 26 21:19:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoB7-000345-9t
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758013Ab3DZTTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:19:24 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:46885 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757499Ab3DZTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:19:23 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so4121338lbc.13
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/aswy7UQ9nzntLDVzpLB714JfDT9LfitgfvvaJMmoxk=;
        b=uuq9j0WJ9SSoOb60kmZPoTBrm4gJDrKc7VJVQiaNlomCK5YzNvtQidvamUvQ8b+yjS
         gwwa7UzJEFDaGnNeFuXu4doWpZIJJOthyZhF1ODS3M4EXJupeSKiHo7ecFGgsLNV8bZ3
         hxji6kywkAPdanFFtyLbg78XYDumSs6SdfbGkXRnwv3ZG5ICD1SbO+ZdfQ8V1cE6IHLX
         dYF6bAL/SG0OYnx+jXG5UcK/inRJxAOy5GqumoW4km6PFKJQq/eJW0Vnp2HcBq/ysSk8
         9purKnGf2jpJtV1Vf6UKHo8v4qzsqur2Fl60VwZYu7zePVmBuKxXAkn+YOreAgLg8Foz
         /3eg==
X-Received: by 10.152.29.132 with SMTP id k4mr1262760lah.46.1367003961509;
 Fri, 26 Apr 2013 12:19:21 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 12:19:21 -0700 (PDT)
In-Reply-To: <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222558>

On Fri, Apr 26, 2013 at 4:32 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:

> Junio C Hamano wrote:
>> I do
>> not agree with Ram at all when he says that developers are more
>> important than users, and I agree with you that the project exists
>> for users, and not for developers.
>
> On this.
>
> If Peff were to suddenly stop working on git one day (because he was
> frustrated with the community/ development practices), we'd all lose a
> lot more than if one random end-user switches to using hg for his tiny
> personal projects.

Yeah but that's not happening is it? This is yet another hypothetical.
Last I checked Peff never threatened to leave the project. Did I miss
a memo?

The last time somebody announced he was going to leave the project we
did what was reasonable; investigate the reasons. And that's what we
would do if Peff threatened to leave.

But fine, lets assume there's a hypothetical Peff, with hypothetical
reasons to leave the project...

> I'm _not_ claiming that there's a split between
> users and users that are developers (we have one mailing list for
> everyone, and I like that).  What I'm claiming is that we cannot (and
> should not) pay equal attention to every user of git.  Some users are
> more important than others.  Again, that does _not_ mean that we push
> a change that benefits one important user but breaks everyone else's
> setup.

The importance of users changes all the time. The 15 year old kid in
Sao Paulo might not be important today, but he might be the single
most important contributor ten years from now. Hell, he might even
replace Junio as the maintainer.

Who are you to decide which users are important, and which are not?

> Ofcourse the project exists for its users; we're not doing research.
> However, we don't all have to write tutorials to keep in touch with
> end-users who are completely detached from the development process
> (our time is better spent elsewhere),

Maybe we should, and maybe we would see then some areas of
improvement. In fact, I have done so, and I do see lots of areas of
improvement in git's UI.

I agree that there are more important areas, or rather, more fun to
work with, but the fact that most git developers don't pay too much
attention to the pain of newcomers shows, and it's a very common
criticism of git; it's difficult to learn, it doesn't have a
consistent UI, many commands don't make sense. And I happen to agree
with that claim, but it's not an easy problem to solve, specially when
you care about *all* users, both old and new, which we do.

We should keep in mind the problems in git's UI for newcomers. There's
no reason no to.

> or even have an
> end-user-friendly bug tracker (where the SNR is very low).  We don't
> have to consciously reach out to people we're not connected to
> directly: if we're all sufficiently connected to the real world, the
> itches/ bugs worth working on will always find their way to us.  We
> live in a connected world.

Nobody is claiming we need a bug tracker, there's no point in arguing
about that. The rate at which we fix bugs or our tracking of them is
not a problem.

> Yes, I know.  You're going to respond to this email arguing about why
> you're Right and why I (and everyone else) is Wrong, either by quoting
> what Linus (TM) said and twisting it to mean what you want, belaboring
> over what you've already said, or something similar.

Where did I twist anything? You can see Linus talk himself:
http://www.youtube.com/watch?v=kzKzUBLEzwk

Point me exactly where does he say some users are more important than
others, in fact, he is saying the opposite, the amount of people that
needed the Linux version compatibility flag was really really small,
yet they did it, why? Because *all* users matter. Not that it matters
what Linus says, what matters is that it's right; the moment you start
balkanizing your user base, the moment you start giving some them
reason to fork the project. When was the last time Linux was forked?
GNOME did exactly that, they said; you, users over there, we don't
care about you anymore, what did they do? Fork. They lost so many
users they had to revert their decision.

Should we willingly and knowingly neglect some git user-base? No, why
would you want them to fork? In a way, git's UI has been so bad, that
some kind-of-forks have happened, that tells us something; the UI
needs some love, fortunately none of those forks worked, which tells
us something too; it's not too atrocious.

That's not to say we shouldn't fix the UI, we should, in a way that
everyone's happy, which is hard, but we will do it, eventually.

Cheers.

-- 
Felipe Contreras
