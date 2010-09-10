From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/20] [CONTINUE] Add gettext support to Git
Date: Fri, 10 Sep 2010 17:17:02 +0000
Message-ID: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<7vd3sonq2n.fsf@alter.siamese.dyndns.org>
	<AANLkTinC59XFt8pPyUF3ifMTeVMSC1e44MDPto5Fy1+n@mail.gmail.com>
	<AANLkTimU6Cznnqp+SokZDK7fnhV712a9QcAAd5peo93m@mail.gmail.com>
	<7vaanpio4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 19:17:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou7Dr-0001Ba-Oe
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 19:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573Ab0IJRRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 13:17:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54446 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab0IJRRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 13:17:03 -0400
Received: by iwn5 with SMTP id 5so2378712iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ekbn4ou0gAUbt9UHIdSYaw9XWKQ6eC/3uk3xOLHDjnw=;
        b=hFxtH7PhUyyNiWEVvs2Xex9T6l4ag3+7suD+SNJJotUL8uCHZ723gIZ1o7FYuMfOps
         UFyws0mRX3hEJ560gCaNGdO1QFIkMvqtkGCz+oN309KUcETYbOc+qRvG/KwTqbo4rAmD
         dAehFaEHFNp/+GmyRGzqecFdeGLmFhb/OWtzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cLv7txsk3JCSVcjb9RwPRDbKWkZu1/T6w/Nk1Ytg1EstG6YCZaBgtEwxJi2NVU1j14
         2FHYiKjScP/b13wuIjxNVzJOiljcUnj7rLgkFCfcFurPEf1Td0r5NcSo9at4f26xz/AP
         LlIdkW2+07bhSksjEOEwfTmzO05vrSb0ynnmg=
Received: by 10.231.149.207 with SMTP id u15mr1332798ibv.13.1284139023103;
 Fri, 10 Sep 2010 10:17:03 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 10:17:02 -0700 (PDT)
In-Reply-To: <7vaanpio4n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155948>

On Fri, Sep 10, 2010 at 16:01, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Hi, since you didn't pick this up in the last push I fixed it up a b=
it
>> more.
>>
>> I rebased ab/i18n-all-continue on the new master:
>>
>> =C2=A0 =C2=A0 git fetch git://github.com/avar/git +ab/i18n-all-conti=
nue:ab/i18n
>>
>> But you probably want this instead:
>>
>> =C2=A0 =C2=A0 git fetch git://github.com/avar/git +ab/i18n-all-conti=
nue-with-hindi:ab/i18n
>>
>> I took the liberty of adding Ramkumar Ramachandra's hi.po patch to t=
he
>> series.
>
> I think that the latter is "i18n-continue-with-hindi" (no "all")

Yes, sorry. It's just "ab/i18n-continue-with-hindi".

> and also suspect that ab/i18n-all-continue either hasn't be pushed
> out or is stale?

Yes sorry, I pushed to "ab/i18n-continue"
instead. "ab/i18n-all-continue" is now up-to-date (equivalent to
"ab/i18n-continue"). Sorry abuot the mixup.

> The copy of "all-continue" I just fetched ends with 2b5170f (gettexti=
ze:
> git-shortlog basic messages, 2010-09-05) while hindi^ is at c4adf2e
> (gettextize: git-am printf(1) message to eval_gettext, 2010-09-07).

The hindi^ one was the right tip.

> I haven't formed an opinion as to what to do with the *.po files afte=
r the
> series hits 'next' (or anything more stable than 'pu'); my preference=
 is
> to delegate that part of the system to somebody who volunteers as an =
i18n
> coordinator, and pull from him/her from time to time, just like the w=
ay
> gitk and git-gui are managed.

We could certainly set up something like that. I going to wait and see
if we needed it before proposing such a thing.

After an initial spur of translation submissions po/ will probably
quiet down quickly. We aren't adding new strings that often, so
updating translations shouldn't represent much PATCH traffic on-list.

But it could be split up if that's preferred too.

> For now, I'll queue the whole thing and merge that to 'pu', but we wo=
uld
> want to squash l10n commits after (but not including) 8d65a35 (gettex=
t
> tests: test re-encoding with a UTF-8 msgid under Shell, 2010-08-30) t=
hat
> touch only one file in po/*.po into one commit per language, move the=
m
> near the tip after all the infrastructure enhancements (and fix-ups t=
o the
> infrastructure, if necessary) and individual command i18ns, to make t=
he
> end result a reasonably complete and clean "first cut for public test=
ing"
> of the series before it hits 'next'.

I can move those around, I didn't do so already because their position
in the series is semantically meaningful. I.e. at the time is.po is
added it's pretty much a 100% translation, but more strings are added
after that.

That's a trivial minor issue with msgmerge and msgfmt --statistics to
find out how much is translated though. So I've re-arranged them and
squashed 'em for you here:

    git://github.com/avar/git.git ab/i18n-for-junio

> As a companion update to 6495411 (gettext docs: add po/README file
> documenting Git's gettext, 2010-09-03), we would need a file in
> Documentation/ directory to describe the use of _() and N_() for
> programmers and point it from CodingGuidelines.

I can add that to ab/i18n-for-junio, but haven't already. Isn't it
better if I send that to the list for review instead of just tucking
something at the end of the series. I can do either.

> We might also want to move po/README to Documentation/ but I don't
> have strong preference either way.

I'd like to make it a manpage (as mentioned before), but i can't
figure out a good git-*.txt name for it.
