From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 6 Aug 2010 14:03:54 +0000
Message-ID: <AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
	<7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
	<AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
	<7vmxszamwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 16:04:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhNWk-0002GI-AM
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 16:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab0HFOD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 10:03:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42782 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953Ab0HFOD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 10:03:56 -0400
Received: by iwn33 with SMTP id 33so1350003iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gqOQXqLlYej/Jki6XD9kKyYDikgDMorf6gNuWe6nlaI=;
        b=J89Xbb+J9ZtbAlfq43VUjxRnD/Vr0fhlSqN9EURh3xDGwHiOqeWzGpZMJrU2OyGMYg
         eHqzHMsFxS59ip4MPHSibydMCZilGl6WPc7eaF15Zey7e8xHK7dYWvFgSRfFANp0H3tt
         uE/M/ogR2t31x4qGUQvEObdTb6i2w+203m6pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NKwNeT1ctqBntD4rQ9KDZ/PfPCCXJk1U4JK4jVyz3nKCwi2kqG9hqSfcQEU8tok/pb
         8rpE675UNvGT7kerXmY/AprsBCxhCIkiZEurUuwbYsMwzc3CLqcXLUWBG1GynIAaTnJ7
         u5Rx1afkk67L3Ncx/9QLPQZD+bGhTxWyaFUNQ=
Received: by 10.231.157.207 with SMTP id c15mr14077192ibx.143.1281103435061; 
	Fri, 06 Aug 2010 07:03:55 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 07:03:54 -0700 (PDT)
In-Reply-To: <7vmxszamwd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152785>

On Fri, Aug 6, 2010 at 13:30, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Aug 5, 2010 at 22:18, Junio C Hamano <gitster@pobox.com> wro=
te:
>>>
>>> When people see the benefit of doing so. =C2=A0I currently do not s=
ee much need
>>> for it myself but I am a minority ;-).
>>
>> That's news to me. I'd assumed that it was mostly on track, i.e. tha=
t
>> it would get merged down after cooking for a while in pu.
>>
>> However, if it's a matter of gathering popular support maybe I shoul=
d
>> change my strategy a bit.
>
> The "popular support" needs to be qualified. =C2=A0If you ask any ran=
dom person
> "Is it a good thing if software package X supports i18n?", the answer
> would always be "yes"; popular support in that sense doesn't mean muc=
h.

I was thinking about support from the core contributors, which'd have
to deal with gettext in the long term in one way or another.

> I am more worried about unintended consequence of this particular
> execution. =C2=A0For example, I would want to be absolutely sure that=
 we won't
> break plumbing output in 'next' and the proposed mechanism helps othe=
rs
> avoid breaking things by mistake.

I'm also worried about that, and I have some plans to deal with it
after the merge.

The first and most obvious one is that the list will be reviewing
gettexizing patches as they go through. A patch which changes some
plumbing format would be called out, but not one that just changes the
UI messsage of e.g. "git init".

There's also more that can be done, e.g. altering the test-lib.sh so
that you can set an environment variable that causes it not to reset
LC_ALL to C. Then run the tests and see if anything breaks.

I was going to run a smoker with that setup on some of the major
languages if gettext and smoke support was accepted.

>> The follow-up work I was referring to was the project we'll need to
>> undertake once it's merged to convert "foo" to _("foo") as
>> appropriate.
>
> That is one good example. =C2=A0Perhaps we can get a list of messages=
 that we
> can place in Documentation/ area (e.g. "'Not up-to-date' - this messa=
ge is
> given when you have local changes in a file in the working tree; give=
n by
> command X, Y and Z") out of that effort for free? =C2=A0Perhaps such =
a list can
> help us verify that i18n does not break plumbing output (because the =
list
> does not contain plumbing messages)?

We'd get this sort of list out of "TRANSLATORS:" comments for
free. They're automatically extracted and presented to translators and
others with the xgettext program.

Maintaining a list of messages in Documentation/ somewhere that's
bound to get out of date with the source code doesn't make sense given
the TRANSLATORS support.
