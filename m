From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Wed, 25 Sep 2013 09:29:03 -0500
Message-ID: <CAMP44s2EtgXXdfa+QtUmmRh6wZ1fD8YTWtzLJ2mN6y_6faMM_g@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5WQLx4rsN+yRs62fgTBWkuAhCSWDRkoCc8M_akpSqMKvg@mail.gmail.com>
	<CAMP44s3nQv97B2=mq-mn8S41sMA43qRfr+nC7eQ=Jft=zRgTRw@mail.gmail.com>
	<CAEBDL5V1kyRwtKSM+L_E_XbJRauvdmOLc+g2acbixt0+pd6_ag@mail.gmail.com>
	<CAMP44s2j_ra_Tk_s-tjwwvX=T8y=bKPTaUdOQk1jD8QpUm+-zA@mail.gmail.com>
	<CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Sep 25 16:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOq5Y-0007yk-JL
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 16:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab3IYO3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 10:29:06 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:62153 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab3IYO3F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 10:29:05 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so5058454lbi.24
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OHSw4XG/oVDhC/jG0T5TTLW1pQc3R+L8FjFJrM3yYSs=;
        b=sqwo2Pi0q+F+172L08LM5ni+Kfop/i5Uu7anvXRwrh2/Cin19DKyt5BjaKSitZIsUT
         TUaD6mgegegQj3c1CgJ087gwJ3It1qHD1+Lswo8v3wNfeDYmweDae9nzImy3JpSMZbdE
         6CxvvM4Zm7vVpA2bdP0/yQg7IFFFHEH1oN1oF5ENnR2KnJa5U1/zhv9HWh5aD0to7MpK
         L7M59IB3SMD0ZJ9ss50XoDwxQV/Jspd8bcwCNUfjQEalKjWx7sxyZOeimcu7wUTaoct/
         Zfq7YradroliMhmVHPyQJjbOVSYilzYlfPilBHF4hRndoLYZ9AiKHmjARRNwRI7VdbAM
         OD7A==
X-Received: by 10.152.120.37 with SMTP id kz5mr30086435lab.21.1380119343246;
 Wed, 25 Sep 2013 07:29:03 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Wed, 25 Sep 2013 07:29:03 -0700 (PDT)
In-Reply-To: <CAEBDL5X1QRLaTvxhEu4e5_NE5fEWc6fd60YJyA8wye4d4T3wpQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235348>

n

On Wed, Sep 25, 2013 at 8:33 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Tue, Sep 24, 2013 at 10:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Tue, Sep 24, 2013 at 6:06 AM, John Szakmeister <john@szakmeister.net> wrote:
> [snip]
>>> There's nothing objective about "Nobody every (sic) agrees changes are
>>> good".  If it were true, no changes would get in.
>>
>> It is true, where by "changes" I mean "changes from common user's
>> point of view", actually, a tiny amount of then do sneak in, so let me
>> be precise: "Virtually nobody ever agrees important changes from the
>> common user's point of view are good".
>>
>> So now that I'm being clear, do tell, name one important change in Git
>> from the user's point of view that happened in the last two years.
>
> Credential helpers.

That's not a change, that's a new feature, and it could hardly be
called important.

By change I mean something that was one way before, and it's a
different way now.

But let me help you; you can't mention one, because there isn't any.

>>> Also, you don't know that any of those changes would benefit "99% of
>>> all users".  It's a guess or an estimate but it's not based on
>>> anything concrete.  It might be a good guess--and in this case, I
>>> think it is--but it's not a concrete fact.  Don't make it sound like
>>> it is.
>>
>> Sure, it's not a concrete fact, but the actual probability most likely
>> follows a beta distribution with alpha=15 and beta=1. Is that more
>> precise for you?
>
> It's not about precision, it's that you don't have any actual facts to
> stand on but you speak like you do.  Then when someone questions it,
> you accuse them of being against fixes for the user.  I wish you'd
> stop it and do something more constructive to help move things along.

I have as many facts as you or anybody does.

If I cannot use the claim that 99% (or any overwhelming number) of
users would benefit, then nobody can make the claim that X amount of
users would be affected negatively, because the actual number can be
close to or equal to 0. But one claim is more likely than the other.

As for doing something more constructive to help move things along,
what you don't get is that there is nothing to do to move things
along. I send the patches, the patches are good, the patches should be
applied. That's what any decently run project would do, concentrate on
the technical side.

Do you think if I hold hands with the people involved and we all sing
Kumbaya things would move along? Well it shouldn't, if the patches are
good the patches are good. What should move things along is the
technical merits of the patch.

>>>> If you don't agree my comment is accurate, that's one thing, but
>>>> labeling it as an attack is another.
>>>
>>> Don't turn it around.  A number of your patches and emails poke at the
>>> community of the Git project and you know it.  It's simply not helping
>>> the situation.
>>
>> Show me a patch that "pokes" at the community. All my patches have
>> technical descriptions, and help improve Git.
>
> You're filtering what I said again.  Take a look at the first message
> is this thread.
>
> I'll agree the patches themselves have been free of this, but the
> cover letters--which I consider to be part of the patch--and ensuing
> conversation has not.  If you need another example, look at the cover
> letter for your transport helper patches.

I don't consider the cover letter part of the patch. And the
conversation is irrelevant, all the users care about is the code.

Not introducing a good feature for users because a developer said a
nasty word (which I haven't) in the cover letter of the patch series
is ridiculous.

>>>> I would admit I was wrong if an /etc/gitconfig is indeed shipped by
>>>> default, and agree that the Git project is indeed welcome to change,
>>>> but that's not going to happen.
>>>
>>> And there it is again.  Predicting the future now?  Objectively and
>>> accurately?  Please stop.
>>
>> Yes I am. Feel free to go back to this mail and tell me I was wrong
>> when they do what I said they won't.
>
> I have no need for that, and I'm done talking to you about any of this.

Doesn't matter, because it's not going to happen.

-- 
Felipe Contreras
