From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 17:58:10 -0500
Message-ID: <CAMP44s1CTzO6J+QTDw_tmbkf-jfVxBzpfqY08_6RXrMuPr+CFw@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<7vsj2e1d83.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 00:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVV7J-000591-PN
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 00:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758591Ab3DYW6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 18:58:13 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:62455 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab3DYW6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 18:58:12 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so1104360lab.23
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PkyqpObIeQXjb/sFU/cUW9OmdjgNF/gQv8N3mBiBnAA=;
        b=xJYeoUce4Z4WMTVyJvCgGZzB6cyD4C4jZqNrrgWPSEuyatx/iuthLxJ5u2vGlNqgef
         Y+v1AH2KFYx8VRoTWeYAHfvxHQX+Uwf9xYanCjx6iQ6eiThyGdo/f8DzdsvgK5MPkdBo
         eW1JPoETaaEwpspVZPjNJBMGWvmj4yecwDLNWw+Z/bXQMw8O4h801uTT6TW2YExzxBDI
         aUPMCm+aYnabJbKn0w46dmyyQLMKPZWQlQiy/WLWVC/DUCbrdfvnwPd/gUEznIEoX9kq
         fcTvN4hgc3VVdsNF77Ag8+N8oB4c7fx+bfa55ZFbYRWty+p1z1OHiuUW+EwUga5O5yal
         1Kkw==
X-Received: by 10.152.19.10 with SMTP id a10mr21255329lae.8.1366930690331;
 Thu, 25 Apr 2013 15:58:10 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 15:58:10 -0700 (PDT)
In-Reply-To: <7vsj2e1d83.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222459>

On Thu, Apr 25, 2013 at 5:01 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Having said that, I am more worried about wasting everybody's time
> (and this includes your time) with the impedance mismatch between
> you and the rest of us.
>
> Our standard for explaining the change (either in the log or in the
> comment) is to err on the descriptive side to be helpful even to
> people new to the codebase.  We do not require or encourage to state
> the obvious. The issue is the definition of "obviousness" varies
> even among the rest of us and even for a single person depending on
> how familiar that person is with the area of the code in question.
> But the divide between you (alone) and the rest of us seems to be
> far more vast than differences among the people other than you.

You are missing my point, this is *ONE INSTANCE*. Show me another
instance where a reviewer complained about the lack of a descriptive
commit messages on *remote-helpers*.

> Especially the criteria I used in the above example for "bmarks"
> need to be used carefully.  If a reviewer needs to follow a very
> deep callchain to convince himself why a change does not break
> things, it is no longer obvious and deserves to be explained.

So if I'm not willing to describe every little trivial cleanup change
I do, what should I do then? Avoid those trivial changes?

If your true purpose of having descriptive commit messages is to
improve maintainability, then actually doing these cleanups should
have priority over a descriptive commit message, because doing the
cleanups improves the maintainability even without a detailed
description.

Clearly, your reasoning is incomplete.

> So I dunno.  If you are not willing to change your ways and try to
> be more descriptive to help others to understand what you are doing,
> there is nothing I can do to help you.

I'm willing to change my ways when there's reason to change my ways,
and so far, nobody has provided any evidence that my commit messages
are indeed lacking, only *opinions*.

Other people are perfectly fine with them:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?qt=author&q=felipe.contreras

And the only reason we are wasting time, is that *you* make us waste
time. Any sensible reviewer would be context aware, notice that this
is a contrib patch, and focus on behavioral changes, notice the
mistake I made, and point that *one* of the changes was changing the
behavior, at which point I would agree and reroll either without that
change, or with the change in a separate commit (which I don't want to
do right now). The maintainer (you), wouldn't even have to reply at
all.

But the reviewer failed to do so, and other contributors went even
further, so the ball is in now in your court. IMO a sensible
maintainer would simply say "Guys, stay on topic, what do we do with
this patch?", but no, you allow people to suggest that not only the
whole series, but the whole sub-project be dropped, and to do so with
totally unrelated facts, and generalizing from *ONE INSTANCE* in the
actual sub-project, and generally from ad hominem arguments.

This doesn't help anybody.

Show me a systemic problem with the commit messages *in
remote-helpers*, and then perhaps it would be worth to start *a new
thread* to discuss them, but nobody has done so. We are still talking
about a *single patch*.

And if you really really don't like the patch, say "do X, or I drop
the patch", or the series, and there would be no need for other
reviewers to waste their time (if their comments were truly valid and
correct, which they are not). There's no need to say anything more.
And even if the reviewers were correct in their comments, allowing
suggestions such as that the whole sub-project should be dropped
because of one patch is going to waste people's times, no matter what.

Cheers.

-- 
Felipe Contreras
