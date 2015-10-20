From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] pull: add angle brackets to usage string
Date: Tue, 20 Oct 2015 10:54:20 -0600
Message-ID: <CAMMLpeStjJY2sqGvC0wV_OqFSA3OuzmcDitvr53d=z8+y2dBYA@mail.gmail.com>
References: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
 <xmqqwpumg480.fsf@gitster.mtv.corp.google.com> <CAMMLpeQPngq-xM2vN4uX6+k5-uoOXyP3p0wgLO9LOkWxWtZBEA@mail.gmail.com>
 <xmqq4mhqg15y.fsf@gitster.mtv.corp.google.com> <CAMMLpeTf93NnqPM+SaxfhsSdMg1HUiVyo5FFdiuGF9o-KQbGog@mail.gmail.com>
 <xmqqbnbu9kzr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoaBR-0001QU-P5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 18:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbJTQym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 12:54:42 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37345 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbJTQyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 12:54:41 -0400
Received: by wicfv8 with SMTP id fv8so38263901wic.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 09:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xijRoErGSx3KhIX9h+gL5dej0LHrPk1CD1KBtJUwUiA=;
        b=cy4kYTwI7FOxLfa21VncpVOqfuM01O/rNlIUAYfVGfU4fYyMRwwm5njier3hSUHCh+
         qDvyxnfqA5io/L07kESRgo9SY5VKOYLP82kI9quD1TbU27v35TYSBEmULU/GASmI+fgf
         idNL0SZTZfDCmiGktyHu5RuFsOOBRA7dUTJ3lHpGKtupRrEzmwj9reYEbsBtUzcHQu/3
         Uc/CrI8w+5IgfrG+625l4quVPF3B2GTwFzbRZ6Jnz+YraX6VIiPoAR8LqT3IDzQY5t1a
         JXIqOJ4pF3dK5aAWwXWM0pKE6N3N71CRA+/zjyJSlJ/fLBW6Jh/esItdNQX85AFc/B4j
         KNBQ==
X-Received: by 10.194.114.133 with SMTP id jg5mr5224739wjb.98.1445360080069;
 Tue, 20 Oct 2015 09:54:40 -0700 (PDT)
Received: by 10.28.16.132 with HTTP; Tue, 20 Oct 2015 09:54:20 -0700 (PDT)
In-Reply-To: <xmqqbnbu9kzr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279925>

2015-10-19 23:17 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> 2015-10-16 11:42 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
>>>
>>> Yes, but that fixes historical "mistake", no?
>>>
>>> With this, you are breaking historical practice by changing only one
>>> instance to deviate from the then-current practice of saying
>>> 'options' without brackets.  It is based on the point of view that
>>> considers anything inside <bracket> and a fixed string 'options' are
>>> meant to be replaced by intelligent readers, which is as valid as
>>> the more recent practice to consider only things inside <bracket>
>>> are placeholders.
>>
>> OK, I see. You're saying that it's OK to fix typos and grammatical
>> errors in contrib/examples, but it's not okay to modernize the
>> scripts' designs.
>
> Please read it again, look at contrib/examples and realize that that
> is not what I said at all.
>
> This is not about modern vs old-school.  The reason why the part of
> the patch to contrib/ under discussion is wrong is because of
> (in)consistency.
>
> Look at the output from "git grep option contrib/examples/" and
> notice that in the old days, these scripted Porcelains consistently
> said "[options]" without "<bracket>".
>
> It would have been a different matter if the patch _were_ to update
> all "[options]" to "[<options>]" in contrib/examples/ consistently,
> and such a patch might have even been an improvement, especially if
> the modern style were clearly superiour than the old-school style
> (which is not, by they way [*1*]).
>
> But that is not what the patch did.  It turned only one of them into
> "[<options>]", making the single instance inconsistent from all the
> others around it.  That is why it was wrong.

I understand now, thanks. I really appreciate your commitment to being
consistent.

> [Footnote]
>
> *1* The "modern" style is not necessarily an improvement, by the
>     way.  The way we specify that a "thing" in the help text is a
>     placeholder and that there may be more instances of the same
>     "thing" is to say "[<thing>...]", but in your "modernized" form,
>     unlike all the other usual "things", possibly multiple options
>     are spelled "[<options>]" without having ellipses at the end,
>     which is an oddball.  If we are to treat options specially like
>     that anyway, intelligent readers can read an "old-school"
>     description "[options]" and understand that that token stands
>     for possibly multiple options just fine, and all we have gained
>     by going to the "modernized" form is to waste two characters for
>     <brackets>.
>
>     I am not saying that we should not apply the other half of the
>     patch that makes builtin/pull.c say "[<options>]".  These days,
>     many other commands nearby (i.e. the "modern" ones) do use that
>     form consistently, so it is an improvement.

I pushed to change [options] to [<options>] because even if the angle
brackets don't help new users or translators in this particular case,
the angle brackets encourage Git authors to use angle brackets when
writing commands that are not so easy to understand. If you think that
[<option>...] is better because it is even more consistent, I would be
happy to send a patch to make that change.

Anyway, thanks again for your attention to detail.

-Alex
