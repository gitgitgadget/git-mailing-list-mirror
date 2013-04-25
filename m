From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 16:35:48 -0500
Message-ID: <CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:35:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVTpc-0003Wt-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230Ab3DYVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:35:51 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43959 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883Ab3DYVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:35:50 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so2357202lbh.34
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Fj047Ew9hUt4Xr9RywLfg1y4TR1HeuHuz1/n1WvlYaQ=;
        b=OVUsx92JC15lGGsx3MrbYO90MPbwwk0sY0D6wTfGmyd7NulD1BdNTSy+LVW0D0D211
         OzxGga4qzlsR0Dq8jjxg5V5FRSPt0F19BS/JT8M7zIJwf0Ym8HawB46j3GB8IqJe8DD7
         JLDgEcMZjjGDactPIj+JQqen0L6IixSf3O+waTjEfhGOEpqVdBXAgYYYKoG7EpI1IxP3
         Wcjc6kLOteje0/ikO6y4f8zQ1M2qgGvGnBG3bmLtkEP6+m4bh8UmsLL+ZWboeWfyMzw5
         VP9IInUkZ7+Mo0JHhjOHRCAD0RZszzPyms8Ifodof3ecm7sGs7ZrtC4HM7h6/IUGLKbv
         jccQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr19171655lbb.8.1366925748583;
 Thu, 25 Apr 2013 14:35:48 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 14:35:48 -0700 (PDT)
In-Reply-To: <7vip3a2vq0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222452>

On Thu, Apr 25, 2013 at 3:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> But I do not care that much really. The patch is good either way, if
>> you don't like it, you go ahead and fix it, because I won't. I have
>> 174 remote-helper related patches in my queue, and nobody benefits
>> from rambling about a one liner that is obviously correct, not you,
>> not me, not the users, not the developers.
>
> Three random points.
>
>  * For this particular patch [1/9], especially because this would
>    land close to the corresponding remote-hg fixes (e.g. "has_key is
>    deprecated"), I think it is sufficient to say "port fixes from
>    corresponding remote-hg patches" (you said it in 0/9 and didn't
>    say it in 1/9, though) without going into individual details.
>    Anybody who wonders what these changes were about will have a
>    clue to check contemporary patches to remote-hg that way.

I don't see the value of pointing that out in the particular commit,
since you are the only one that would do anything with that
information, and it seems the message came across.

If there's any issues with that, just drop the patch, and if there's
issues with the rest of the series, just drop them. I'll resend when
the stuff is merged to master.

>  * You may want to hold onto those 174 patches and polish their
>    explanation up to save the list audiences' time by avoiding this
>    kind of useless "why no explanation" exchanges.

That's exactly what I've been doing.

You are extrapolating from this particular patch, which I already
admitted I made a mistake, and it's not really important in any way.

>  * If you do not want to keep a readable history, it would mean that
>    nobody but you will fix problems discovered in the future in
>    remote-hg, and there is no point carrying it in my tree for other
>    Git developers to look at it.  The users are better off getting
>    them from your tree and that will make it clear for them whom to
>    ask help/fix for when they hit a snag.

The history *is* readable. If anybody has any problems with the commit
messages, the place to mention such problems is IN THE PATCH REVIEW.
Nobody has done that, because either nobody has any problems, or they
are not interested. Either way, there's nothing I can do about it.

*This* patch is an exception, and I'm not willing to waste time on
this extremely trivial patch. Drop it.

>> Junio of course might disagree and drop this patch, but then he would
>> need to deal with the fallout of possible conflicts.
>
> A much more sensible thing in such a case for me to do actually is
> to drop the whole thing. I do not want to do that unless necessary.

You want to drop the whole series because of a cleanup patch with a
less-than-perfect commit message? Even though there quite likely won't
be any conflicts if you drop the single patch. Fine, drop the whole
series.

>> ... I think the less-than-perfect commit messages in a
>> *contrib* script that is extremely recent is a small price to pay for
>> having nice and workable bzr and mercurial remote-helpers as soon as
>> possible
>
> I do not share this view at all. The users survived without it long
> enough; they can wait for a well maintained version.  On the other
> hand, shipping something that will not be maintainable is not the
> way to help end users. It is being irresponsive to them.

Are you saying that because *ONE PATCH*, introduces a fix without
mentioning it in the commit message, *THE WHOLE* project becomes
unmaintainable?

If not, then why are we discussing about something that is not happening?

> Helping other developers understand your code is a way to ensure
> that your code that would help users will be kept maintained.  I do
> not agree with Ram at all when he says that developers are more
> important than users, and I agree with you that the project exists
> for users, and not for developers.  But you need to help your fellow
> developers anyway by spending effort to keep your history readable,
> in order to help them help the users.

And I am. Because I made a mistake in this patch doesn't mean the same
happened in all the patches.

I am helping my fellow developers by replying to the comments they
make when I send the patches for review. Unfortunately, the only
developer other than you that has made any comment at all, Ramkumar
Ramachandra, did so in a bellicose tone, but I replied to all his
comments either way, which where invalid. The only comment where he is
right and I acknowledged making a small mistake, is trivial, does not
cause any issues, and can be easily dropped.

> Do not take the "users matter" mantra to the extreme. You need other
> developers to put users first.

No, I don't. It would be nice, yes, but not necessary.

Now, let's drop this pointless discussion and deal with the actual
issue. What do you want to do?

1) Drop this patch
2) Drop the whole series
3) I reroll without the change that was not described

Anything else, I'm not interested in doing. There's tasks with actual
value to do.

Cheers.

-- 
Felipe Contreras
