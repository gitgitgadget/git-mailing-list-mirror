From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Wed, 15 Feb 2012 00:34:21 +0200
Message-ID: <CAMP44s0cJroUM2aahRQz2dVPe57XPPOnsxWy+5DfmjXGArz4wA@mail.gmail.com>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
	<20120214203431.GB13210@burratino>
	<20120214211402.GC23291@sigill.intra.peff.net>
	<CAMP44s0Dp9Av+ikFHa=QcqKFA5XL9ESBrzWLY0jkSCdH-NxhMw@mail.gmail.com>
	<7v8vk55a99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQxE-00023Z-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642Ab2BNWea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Feb 2012 17:34:30 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54841 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932608Ab2BNWeW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:34:22 -0500
Received: by lagu2 with SMTP id u2so462025lag.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=86AEWQnr2tegTGRhgVTUE7tkZh2YnXrS6hxXdzppiiY=;
        b=xURnQ3yQxk+hVVflOuyHzv933WlbbLFMhzEW5Jb2d0i4x4zsrZ3yEV3mQK6PLdPUYT
         6pmFWD+TUJy1cQJ003M83lQm8gYDuYP20r/Woi1wtKP59oC93I2muVWQv6/5V3NiWGX0
         YST3XMTkF2aIFklfaxH8rTpPPf9YdqlmGUEak=
Received: by 10.112.85.70 with SMTP id f6mr7958270lbz.16.1329258861067; Tue,
 14 Feb 2012 14:34:21 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Tue, 14 Feb 2012 14:34:21 -0800 (PST)
In-Reply-To: <7v8vk55a99.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190783>

On Wed, Feb 15, 2012 at 12:18 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Feb 14, 2012 at 11:14 PM, Jeff King <peff@peff.net> wrote:
>> ...
>>> =C2=A0 =C2=A0 The answer can
>>> =C2=A0 =C2=A0 be a simple "nobody bothered to write them", and that=
's OK.
>>
>> =C2=A0That can be derived from the word "add". You can't add somethi=
ng that
>> is already there.
>
> You are correct to say that you cannot add something that is already
> there, but that does not mean you explained why that new thing is a g=
ood
> thing to add. =C2=A0In other words, you can add a new thing that we d=
id not
> have, but it would not result in a good addition if that new thing is
> irrelevant. Relevance needs to be explained.
>
> I do think in this particular case, the new check *is* relevant, beca=
use
>
> =C2=A0 =C2=A0Although we did have "blame" test to see how the name pa=
rt is shown,
> =C2=A0 =C2=A0we had no "blame -e" test to see how the email part is s=
hown.
>
> I do not understand why you are resisting to explain how your additio=
n
> adds value to the system with such a simple two-liner, and instead ar=
e
> endlessly arguing. =C2=A0Is it to make sure you are the one to utter =
the last
> word in the thread?

And I don't understand why people want the obvious to be explained.
=46or each one of the questions I've heard, the answer can be derived
from the summary *directly*.

Your new point is "you can add a new thing that we did not have, but
it would not result in a good addition if that new thing is
irrelevant", but you already know what is the new thing from the
summary "'git blame -e' tests".

Everybody seems to assume that a simple commit message =3D bad. I disag=
ree.

> As I am sort of getting tired of seeing you making things more diffic=
ult
> for yourself,

The same argument can be applied both ways; you are the one that is
making things more difficult. And I already pointed out the double
standards.

> I'll refrain from commenting on this topic at least for a
> few days to wait until things cool down.

Does this mean that disagreement is discouraged? From the discussion
it seems we are in clear disagreement, but from the rhetoric it seems
to me that you all assume you are right by default, and that simple
commit messages are by bad definition.

If that's the case I am disappointed, but I would rather just drop the
discussion rather than defend my position.

Cheers.

--=20
=46elipe Contreras
