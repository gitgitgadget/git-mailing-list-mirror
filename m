From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Fri, 25 Feb 2011 22:48:17 +0100
Message-ID: <AANLkTi=qK4vL7Zq1zp590jxPb1j-dqt6D7Jesy1uAni3@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<20110223234828.GA7286@elie>
	<7vd3mi44gx.fsf@alter.siamese.dyndns.org>
	<AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
	<20110224031414.GC7970@elie>
	<AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
	<20110224110029.GE14115@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt5aW-0002Uw-9b
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218Ab1BYVwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 16:52:32 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45419 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105Ab1BYVwb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 16:52:31 -0500
Received: by fxm17 with SMTP id 17so2134999fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 13:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UBMpR6nWhnvQDxMxsp35TBaebo00v6f3743wDTo0eUQ=;
        b=UgRJ2VRR/ozDuRRFOPopzYWKtUvZGSgqLxOLqGVGMOTNa4DqWFETbBSN50j5DA57px
         K6+FuUxqO4gWI22+uFnyR2Z6YD3wpwqr2tVJmQBFQzLZ4gXndPxEkaZCiSo+7M00t1au
         V2oe1yuLNhUZy+P2XjZYUdPZaPimFPnebyJ8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H4bG0q9nAa7xarMkyyJt09qBOlnpnjJZex7W/Mbwr8HWV/OC8+G4Ilr2Rhwv6EXNWy
         WMzcA8fAJ9l8/GhVEqJ6pq2az/varYk1trPiZmhSE6zojFqP0qMK3PnIXJ0FBkcHujKX
         Wz5Ps0+FU4H/gAmBYgGPDbFrHsN7hC53KK0uE=
Received: by 10.223.103.197 with SMTP id l5mr3311339fao.7.1298670497796; Fri,
 25 Feb 2011 13:48:17 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 13:48:17 -0800 (PST)
In-Reply-To: <20110224110029.GE14115@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167946>

On Thu, Feb 24, 2011 at 12:00, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> I don't mean it that way at all, I just mean that as a comment to
>> *this* particular patch series I don't think it's something we have =
to
>> worry about.
>
> This is really tiring and unpleasant. =C2=A0I don't want to stand in =
the
> way of a translated git happening or to take on the project myself
> so I can't just decree "it will be like so".
>
> It's your and Junio's (and lots other people's, of course) code. =C2=A0=
But
> that means that for me to be able to help, I need to be able to say,
> "here's a suggested change" and get an "okay" or "no, here's what's
> wrong with that and how you can improve it".
>
> And that just doesn't seem to be happening now. =C2=A0I don't know ho=
w to
> fix it, but I thought I should explain why I am probably so
> frustrating to work with right now.

=46irst off, I really appreciate having your input and help on all this=
,
really. And I didn't mean to cause frustration.

As for whether your code looks good, I've found it to be better than
the stuff I've come up with.

Sorry about not being more clear about that, and giving "ok"'s etc. I
think the improvements you've made are great, and if you're willing to
re-submit a better version of the series that would be even better
(depending on the status of the current one wrt Junio etc).

My apprehensiveness about adding extra things and fixing up the series
has really been about one thing, and one thing only. Which is that I
don't often have time to spend on git.git anymore, and haven't
submitted the series since October of last year.

I was hoping that I could get it into a form that would be acceptable
for fast-tracking. I.e. I could make a tiny patch at the tip of the
series, prove that it was OK, then the other 50 C/Shell etc. patches
could get in quickly.

Anyway, with the timeline Junio has in mind *that* probably won't be
possible. I'm rapidly approaching a time where I again won't have time
for Git.

But just getting this in would be great, I can submit more stuff later
when I have time, and it'll be less to juggle at once since there'll
already be something in git.git:master.

And if someone else wants to pick it up and shepard it along that
would be fantastic as well.
