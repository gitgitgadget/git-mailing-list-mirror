From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:02:33 +0530
Message-ID: <CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
 <1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
 <CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
 <7vip3a2vq0.fsf@alter.siamese.dyndns.org> <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 11:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVf20-000839-8J
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 11:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411Ab3DZJdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 05:33:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:58172 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759176Ab3DZJdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 05:33:14 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so4706157iec.14
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LQYXA+MB/DjcDTMG13Wk7TskPwLP/nCKQpR3Z8bSlsA=;
        b=yiOAES0SeF2V2+3YL47qg1PvhUXD4clw3GkhIfmG0Jp3sj47dyHItdkr8dyLXPXxqb
         0j/7yOrx7Nv6k84WAAkbA/zWgBscw+Z1UNyt2Kd0hYE3qeDodvZPI8TS3WmTpWzGkOkb
         HVZLqJnqcvD4oEzqWjJtk19cdcmJx/GigQ7JSPd/SSUDGrYbkW/SgibitqAVvS8FYQe6
         kGZD9a6167eAZu+N9CLp8MOuv4+WiQCj8f4rVOHXjRc8RP5r6iRqeD1fCxpq9UDrpEWi
         11PlvP4K+rTtxSTTF2GlwS1LUNOWCH9y/d1RI1Gxx8imG0jxmMTt+nTk+RAvvmvzidrl
         QoEA==
X-Received: by 10.50.73.65 with SMTP id j1mr1389782igv.49.1366968793701; Fri,
 26 Apr 2013 02:33:13 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 26 Apr 2013 02:32:33 -0700 (PDT)
In-Reply-To: <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222523>

Felipe Contreras wrote:
> I am helping my fellow developers by replying to the comments they
> make when I send the patches for review. Unfortunately, the only
> developer other than you that has made any comment at all, Ramkumar
> Ramachandra, did so in a bellicose tone, but I replied to all his
> comments either way, which where invalid.

I've never wanted to pick fights with anyone, and I don't foresee
having a desire to do so in the future.  I was just saying what was on
my mind, which is along the lines of: you have written this patch with
the attitude "I know what I'm doing, my users will benefit, and nobody
else is going to look at this patch anyway"; I'm worried about what
your other patches look like if this is your attitude towards
development.  Junio is harping about the same thing: the impedance
mismatch between you and the rest of us.

> The history *is* readable. If anybody has any problems with the commit
> messages, the place to mention such problems is IN THE PATCH REVIEW.
> Nobody has done that, because either nobody has any problems, or they
> are not interested. Either way, there's nothing I can do about it.

That's what I've been trying to say over and over again: _why_ are
people not reviewing your patches?

0. Because nobody has any problems with them.

1. Because nobody on the git list cares about remote-hg.

2. Because you're stubborn as a mule, and the resulting thread often
results in long-winded discussions like this one (which wastes
everyone's time).  Therefore, the potential reviewer's reasoning is
that their review time is better spent elsewhere, where their review
is actually appreciated.

Hint: it's not (0).

If you're claiming that (1) is the case, then why are you posting to
the git list and hitting everyone's inboxes?  Maintain your project
outside git.

I'm claiming that it's (2).  In which case, it's you who needs changing.

> I'm willing to change my ways when there's reason to change my ways,
> and so far, nobody has provided any evidence that my commit messages
> are indeed lacking, only *opinions*.

You want a formal mathematical proof?  We operate on opinions, and
freeze what we think we all agree with into "community guidelines".

> Other people are perfectly fine with them:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=felipe.contreras

So you're now claiming that we're the ones at fault (Peff, Thomas,
Junio, and me, among others).  Okay, so why are you forcing your
changes and opinions down our throats?  You're in the wrong community:
join a community of people who are more like you (or start your own
project), and stop wasting our time.

Junio C Hamano wrote:
> I do
> not agree with Ram at all when he says that developers are more
> important than users, and I agree with you that the project exists
> for users, and not for developers.

On this.

If Peff were to suddenly stop working on git one day (because he was
frustrated with the community/ development practices), we'd all lose a
lot more than if one random end-user switches to using hg for his tiny
personal projects.  I'm _not_ claiming that there's a split between
users and users that are developers (we have one mailing list for
everyone, and I like that).  What I'm claiming is that we cannot (and
should not) pay equal attention to every user of git.  Some users are
more important than others.  Again, that does _not_ mean that we push
a change that benefits one important user but breaks everyone else's
setup.

Ofcourse the project exists for its users; we're not doing research.
However, we don't all have to write tutorials to keep in touch with
end-users who are completely detached from the development process
(our time is better spent elsewhere), or even have an
end-user-friendly bug tracker (where the SNR is very low).  We don't
have to consciously reach out to people we're not connected to
directly: if we're all sufficiently connected to the real world, the
itches/ bugs worth working on will always find their way to us.  We
live in a connected world.

Yes, I know.  You're going to respond to this email arguing about why
you're Right and why I (and everyone else) is Wrong, either by quoting
what Linus (TM) said and twisting it to mean what you want, belaboring
over what you've already said, or something similar.

I've given up on you, and I suspect a lot of other people have too.
