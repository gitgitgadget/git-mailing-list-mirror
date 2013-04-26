From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:00:11 -0500
Message-ID: <CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
	<CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
	<CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVoof-0007bf-1C
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab3DZUAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:00:14 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:57456 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab3DZUAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:00:13 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so1996437lba.26
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=2QMWNMRCfktzuIfY2HRY3PxMTYik0A/Z4puaiG+1YR0=;
        b=V/gAymMF7q2mpL9iTwymUbooyUGb+/gSdlce5vezthz0ej2iMdYGZsgbLLNlQGJtFP
         X+pkDgIguSmSKnoBpLtv/EBNoUx4Xn9awPeP3ZjI2Kt/pN9a7VOW6DVZsPCF65Dto/F1
         GxfPOaUuBIpXrcLV+evY9yTIwKm//Jgck950vtX1bbbfQQzeM30qnw0mTs7k/BKPe8Ix
         zVqoKEjVuKRyhFPnuDKJP7p7mc0QlD996RDKXDXsveR75+pXfMLET3SAJLepCBnD1Ftb
         w5vm2LVSarVVLeI20Hu++4Srbo51fAX2e84xiyemlC+1hJF1bTs+JiqiU9N62Jg4UQcc
         F8hw==
X-Received: by 10.152.20.134 with SMTP id n6mr11035797lae.19.1367006411656;
 Fri, 26 Apr 2013 13:00:11 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 13:00:11 -0700 (PDT)
In-Reply-To: <CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222570>

On Fri, Apr 26, 2013 at 2:30 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> [completely off-topic; don't worry, we're just having a friendly chat]
>
> Felipe Contreras wrote:
>> If you are not prepared to defend your review, so are others, why to
>> you blame that on me? If you were right, you would be shown to be
>> right. Period.
>
> Felipe, there are some things that are worth arguing about for a long
> time (like the new revision spec I'm proposing in [1]), and others
> that are not.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/222248/focus=222526

I agree, and I have discussed about issues with diff in the past,
unfortunately didn't reach any conclusion. I've tried to follow that
thread, but I don't really know what is actually being proposed
anymore.

If you are so keen in receiving feedback from your fellow developers,
you should eventually send an email summarizing the issues and the
proposal for everyone to understand.

In contrast, I take it you agree this trivial patch is not worth
discussing, which I agreed in my first reply.

>> No, we operate in evidence and reason, *not* opinion. Any reasonable
>> person would say "well, I *think* this commit message needs more
>> description, but I don't *know*, I don't have *evidence* for it, so
>> I'm not going to fight to the death, as if I had".
>
> Don't you think you're taking reason to an extreme here?  Reason is a
> tool that I use when I want.  I don't want reason when I'm browsing
> Google Art Project or listening to Gentle Giant.  Arguments like "is
> this commit message large enough?" are really not worth the time and
> effort.

Reason is not a tool for appreciating art, reason is a tool for
discovering truth, and if when arguing you are not interested in what
is actually true, I'm not interested in arguing with you.

>> Ultimately the decision to merge or not to merge comes to Junio, if
>> you don't like his decision, go complain to him, but I would be
>> prepared with points in time where people complained about these
>> patches, and there are no complains, so you have no ammunition at all
>> whatsoever.
>
> I have no desire to "attack" you, Felipe.  I respect you as a more
> experienced developer than myself, and am trying to offer constructive
> criticism.
>
> I don't have an ego (or consider myself important to the community).
> Whatever will happen will happen, with or without me.

I appreciate your criticism, but that doesn't mean I must agree with
it. And if I do agree, that doesn't mean I must act upon it.

>> And this is how communities die. When everybody thinks the same, and
>> everyone who thinks differently is displaced. A monoculture, a place
>> full of yes-men where nobody criticizes anybody, a circlejerk where
>> everyone palms the back of everyone else. Eventually things go south,
>> and nobody around you understands why.
>>
>> Diversity in a community is healthy. If you don't like people who
>> think differently, *you* have a problem. If you don't like standing up
>> and defending your ideas, *you* have a problem. If you don't like
>> discussing on the basis of evidence and reason, *you* have a problem.
>
> Diversity is certainly healthy, and I it would be nice to have you in
> the community.  We just have to find a way to keep the conflict down.

A fine way to start is to not rattle away in trivial inconsequential patches.

Cheers.

-- 
Felipe Contreras
