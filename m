From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 08:08:55 -0500
Message-ID: <CAMP44s32Aa0zCPB0X_XoR3i6wdRLrV2gccuMGb9zpdObS10AaA@mail.gmail.com>
References: <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 15:09:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlfMk-0002u5-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 15:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766Ab3FINI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 09:08:58 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39819 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab3FINI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 09:08:57 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so5011926lbf.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VwbfHqghtI5Rzl+TLDKuwIfCvas44naawYyxRv2W8+A=;
        b=JMMN0heW3Sv8kShA8jYILn1xDaEGlzdJATvu42yEAxEUfNz3VuCQ8vn8zM4G1vj2MO
         vuh8ZBGkqK7xl2PHxGczQrIb6Uu8RUh76Hg+lcHwu17GSBmecZ5hatqWdqimhs8l3nL6
         v8LnQllq9qFqQJw/bZRVFiwsK6u3oLo9oEYoOb+aaWbgT4jrCgNXdXv9FT8jyyy2/zUJ
         Ne8EOBx/APr6COMA9CfUeObh6q9FOArR80oy4sr0MrNUELc+/JgRoV5y5p8iz9S98qyU
         d2AblzD7ykuhgRkjZLvbaLAPiwuO3z9H7ASa/TWyrwXNXa6EqIEgzUn+DXqnW3jS0lIS
         zGwQ==
X-Received: by 10.112.157.226 with SMTP id wp2mr4562510lbb.65.1370783336278;
 Sun, 09 Jun 2013 06:08:56 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 06:08:55 -0700 (PDT)
In-Reply-To: <CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226961>

On Sun, Jun 9, 2013 at 7:48 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jeff King wrote:
>>> > Definitely, yes.  Even if you look at the impact on code alone and
>>> > don't care about the people, destroying a collegial work environment
>>> > is harmful enough to the code to outweigh the (admittedly often
>>> > useful) patches.
>>>
>>> A collegial work environment is overrated, and proof of that the Linux
>>> kernel, where honest and straight talk is the bread and butter of the
>>> mailing list. And the Linux kernel is the most successful software
>>> project in history by far. It's code that speaks.
>>
>> I have consistently found your demeanor on the list to be very
>> unfriendly and difficult to work with. It is one thing to have honest
>> and straight talk, and another thing to be obstinate, unmindful of
>> feedback (both with respect to technical details, as well as to
>> communication styles), and disrespectful of other people.
>
> While I agree that being rude and obstinate is definitely undesirable,
> and that a healthy on-list environment is important, I have something
> to add:
>
> Being super-tactful comes at a cost.  Regulars on the mailing list
> have to spend 3~4x the amount of time to compose an email (reading and
> re-reading their drafts to see how to express them in a more friendly
> way); this leads to a lot of inefficiency and creates a suffocating
> environment in which people don't have freedom of expression.

That's exactly the reason why they don't put emphasis on that in the
Linux kernel mailing list.

Besides, when something is really fucked up, the most effective way to
convey the fact that you think it's totally fucked up, is to say
precisely that. If somebody's feelings get hurt along the way, and
they decide to leave the project, they were not cut for Linux
development anyway.

> I would
> much rather prefer straight talk where nobody reads into what is
> written and takes offense.  In this case, jrn took offense and talked
> about how he would ban fc from the list if he were managing it: while
> I'm not defending fc's tone, I'm not defending jrn's comment either.
> jrn has been around since mid-2008, and fc has been around since
> early-2009.  It's mid-2013, and they still haven't learnt to work with
> each other.

We don't _need_ to work with each other. If he helps the project, and
I help the project, what's wrong with that?

> Disagreement is healthy, and is the foundation of progress.  When it
> comes to sensitive issues, stern disagreement is often mis-interpreted
> as disrespect (or worse).  If we keep beating up disagreements on the
> basis of tone and demeanor, git.git would go nowhere.  Sure, it would
> be more ideal if fc's tone were friendlier [*1*], but it isn't: let's
> deal with the issue instead of constantly whining about it.

Completely agree. Disagreement is not disrespect. Besides, ideas don't
have feelings, ideas don't need respect; ideas should be criticized.
Any rational person, specially scientists, understand that it's not
healthy to have an emotional attachment to ideas; they might be wrong,
and they need scrutiny. If one doesn't tolerate criticism of one's
ideas (however straightforward or delicate it might be), one is never
going to find the truth.

-- 
Felipe Contreras
