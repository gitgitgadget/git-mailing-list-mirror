From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sun, 15 May 2011 15:25:48 +0200
Message-ID: <BANLkTin3hVusWc-oubW5T-L=mCatubHiKA@mail.gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
	<1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
	<7vtycy7d9z.fsf@alter.siamese.dyndns.org>
	<BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
	<20110514192154.GA17271@elie>
	<BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
	<20110515130856.GB3178@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 15:26:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLbKa-0007w6-GT
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119Ab1EONZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 09:25:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153Ab1EONZu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 09:25:50 -0400
Received: by fxm17 with SMTP id 17so2550898fxm.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VZ/xbwz5UCTFdW6EIRnj+V4jrJlCBkgzn9PuS+wCnxk=;
        b=DXwryNvrzoX8fyQKKc3ZJFdD4agDmKVUTBsF+3pkZnLQ/YrYRXax4WEB9Xe0asDPFi
         K6SutzQ9r506nXAIWJgfD+/Lcrhg1syjJ8uZQW9zdiGoGQeoWDvhJf2FsPh8xU5d4qg2
         KkyVWKNh9vnngn/gm4Kjmlgwb81F5quqSFzwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RP+DQJjmb/1Qmz7sZlc8lhOywwvnWRVaOpYKMbS+AxM//84qAVVhACwJfeICNrLXMZ
         7sxud9akVo0hbHwoeR5owLO/E9FQJ0irvC8ekzyjvHHI/iiKUmbYtwAIDyjcCCI2vdUX
         jJSBU3KPFh8iZetkBsfbtVYC3lp5YjSt40PaE=
Received: by 10.223.145.78 with SMTP id c14mr3571826fav.75.1305465948782; Sun,
 15 May 2011 06:25:48 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 15 May 2011 06:25:48 -0700 (PDT)
In-Reply-To: <20110515130856.GB3178@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173636>

On Sun, May 15, 2011 at 15:08, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hi again,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> We went over this for the main gettext series. Not commiting the lin=
e
>> numbers is unworkable, because it means that users who check out
>> git.git can't run msgmerge, because it completely fails without line
>> numbers.
>
> Please feel free to ignore my other reply. =C2=A0You were saying some=
thing
> helpful there, not just calling me out, and I completely misunderstoo=
d.

No problem. Sorry about the terseness. I don't have a lot of time for
mailing list trawling these days.

> I assume you were referring to this discussion:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/147973/f=
ocus=3D148044
>
> I'm confused about the msgmerge comment above. =C2=A0I'll have to try=
 it.
> But anyway, of course I agree with the more important point that not
> providing line numbers would make life harder for humans.
>
>> Having a merge strategy to deal with them would be nice, but that ca=
n
>> be done by using the existing gitattributes config + msgmerge(1) to =
do
>> the work.
>
> I'm still curious about this part, of course.

Maybe I'm just adding confusion here. I mean that as far as I can tell
we need to have the line numbers in the *.po files, I've been unable
to not make merges go horribly wrong without them.

Whenever I did a merge from git.pot to LANG.po where LANG.po didn't
have line numbers I ended up with issues like msgmerge confusing
strings between program A and program B, which doesn't happen if the
PO file has file:line comments.

But having them will result in merge conflicts using Git's default
merge strategy, which can be mitigated by using msgmerge(1) to resolve
the conflicts, since it knows to ignore the line numbers and to look
at the actual content.

We should be able to have a merge driver defined for git.git to do
that using the "Defining a custom merge driver" facility defined in
gitattributes(5), but I haven't actually tried to make one. But it
looks easy enough, I'll look at doing that when this becomes a problem
I have to deal with, and I'm hoping someone beats me to it :)
