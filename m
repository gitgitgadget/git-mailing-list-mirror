From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:46:15 -0500
Message-ID: <CAMP44s1J1c7YfKZRwU6RwE8k1jFUvC_j77xQ-rzstvJimkxj_w@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
	<CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
	<CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
	<CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
	<CALkWK0kTf_U3NMLTXS-spW-TbZ2x6-46EyEQtD6ZrZK2Tw-91w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpXB-0004Hc-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab3DZUqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:46:17 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52914 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755721Ab3DZUqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:46:16 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so4175161lbd.16
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=N4i5MYDK6t7EPnirRepeaGAqUqddjpF46sKdlZ5auno=;
        b=y+G0V3H/4yHWfyOpCChvMNRDAl8cHbwr3RNEqnd2hfKd0Q3ZR+SJa9hudUf8UXIr5l
         twJk1Z+GT4iG16n/1KfmS+2NV6gq26/RO+5UwCIVasWfCt0iC1tn6iy2U94cHvaG9VKB
         Xh0b4Dl/mOFEXh99gJmh6xExrdoY0GhyeistS9p2cgs+67gfx6CagpwM7IWaqK1G7/CH
         PSlLwowl9fUkM0BvI0KtRbUX5bkvt51oVhVlS1NivXx0L2aMB8UjFGlNzRuVu3t2EA/c
         tRDEs8Ovr2Op8vlAI/gRmxpvRscLRNjxrfqNSFUrPCyHb49BBh9csLDl6xYKALs53AUR
         JBZw==
X-Received: by 10.112.22.198 with SMTP id g6mr18631306lbf.135.1367009175200;
 Fri, 26 Apr 2013 13:46:15 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 13:46:15 -0700 (PDT)
In-Reply-To: <CALkWK0kTf_U3NMLTXS-spW-TbZ2x6-46EyEQtD6ZrZK2Tw-91w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222579>

On Fri, Apr 26, 2013 at 3:28 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:

>> Reason is not a tool for appreciating art, reason is a tool for
>> discovering truth, and if when arguing you are not interested in what
>> is actually true, I'm not interested in arguing with you.
>
> There is no great truth to be discovered by arguing about the length
> of commit messages, Felipe.  There are some "guidelines" or "axioms"
> upon which we build reason.

And based on what do you build these guidelines and axioms if not
truth? Do you ask a computer to throw a number randomly from 0 to
infinite and that shall be the new axiom for what the perfect number
of words a commit message should have?

No, you determine that based on experience, and convenience. You find
a number that convenient to write, not hundreds of pages, and a number
that would help the reader if the patch in case a bug in the changes
is found on a later time, and that would help reviewers of code find
issues, and understand it. But most importantly, the number depends on
the complexity of the code changes. Note that I'm not saying on size,
because even one-liners can be extremely complex.

It's not arbitrary.

> If you want to argue till everything
> breaks down to Peano's Axioms, do Foundations of mathematics or
> Analytical philosophy.  From personal experience, it's much more
> satisfying than arguing with other humans (who aren't exact
> creatures).

I do not want to argue the fundamentals of logic and reason, but
unfortunately most people don't have a strong grasp on them.

So let me simply; truth matters, and how we find truth mattes. Which
is why the degree of certainty we have on certain facts matters; you
shouldn't act the same about a claim you are 10% sure it's true, than
with a claim you are 90% sure.

If you are 100% sure my commit messages are too short, then there's no
point in arguing with you. Nor if you think it doesn't matter if it's
90%, or 50%, or even 0%. Because it's an opinion, and an opinion
doesn't need any facts, or certainty, it just needs a person to hold
it, whatever unreasonable or unlikely it is.

>> I appreciate your criticism, but that doesn't mean I must agree with
>> it. And if I do agree, that doesn't mean I must act upon it.
>
> Why not?  Am I being unreasonable in asking you to justify your
> changes, so I can understand what you've done with one quick reading?

I did justify everything, I just didn't act the way you wanted. I
didn't immediately resend the series with a full description of the
changes, because the changes, as I described before, are trivial. I
simply dropped the change you had a problem with, and moved on. It's
perfectly reasonable.

Cheers.

-- 
Felipe Contreras
