From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 00/20] [CONTINUE] Add gettext support to Git
Date: Fri, 10 Sep 2010 12:00:43 +0000
Message-ID: <AANLkTimU6Cznnqp+SokZDK7fnhV712a9QcAAd5peo93m@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<7vd3sonq2n.fsf@alter.siamese.dyndns.org>
	<AANLkTinC59XFt8pPyUF3ifMTeVMSC1e44MDPto5Fy1+n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Antriksh Pany <antriksh.pany@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 14:00:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou2Hi-0004q8-9m
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 14:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab0IJMAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 08:00:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40392 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab0IJMAo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 08:00:44 -0400
Received: by iwn5 with SMTP id 5so2138896iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gOvRfsS40oVWbHJJgJdrVUtYkMnvN6TKEidITuPsp0M=;
        b=SwOGH8An8svSIkke80lD+z1te3SEyrD8dlyITqEcdrTqzO+uX918VtNe/ezyr7DaL7
         fXTGt5gQyMSmYwqW2Q8KTjuVR24VFdZme0Adv1kIAv/XgW5AfK+q0JVgQuSeLyCSQagl
         5HOVmjuGF2kGhUbC0Q5T0QSWORGAyJGFh75w8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EpBl0xhOMhOEpRHOIBzgvad/PuP0rWCEW6Ml6vArQL5bdss6qkvSDlufs4HP7YDZtm
         fVeuu9TF59The4Autcv1b/m5nfgRP5dmkhlrB7HDk6zJQ4hUyLXNJq4LKRe3i2zvvWl6
         7csFOdCI3afACGUOaVVHH7xTmZUfd7h0HPdwo=
Received: by 10.231.149.3 with SMTP id r3mr903049ibv.109.1284120043277; Fri,
 10 Sep 2010 05:00:43 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 05:00:43 -0700 (PDT)
In-Reply-To: <AANLkTinC59XFt8pPyUF3ifMTeVMSC1e44MDPto5Fy1+n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155926>

On Wed, Sep 8, 2010 at 23:32, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Wed, Sep 8, 2010 at 16:43, Junio C Hamano <gitster@pobox.com> wrot=
e:
>> I've done
>>
>> =C2=A0 =C2=A0git fetch git://github.com/avar/git +ab/i18n-all-contin=
ue:ab/i18n
>>
>> and rebuilt 'pu' with it (I am not quite ready to push the results o=
ut,
>> though).
>>
>> Please squash in the following to appropriate patches in the series.
>> Thanks.
>
> Thanks, those fixes were actually already part of the series, but I
> hadn't squashed those yet.
>
> I've gone ahead and done so:
>
> =C2=A0 =C2=A0pick 8e9b49d gettextize: git-clone "Cloning into" messag=
e
> =C2=A0 =C2=A0fixup 73f08a1 gettextize: git-clone "Cloning into" messa=
ge braces
>
> and:
>
> =C2=A0 =C2=A0pick 8e9b49d gettextize: git-clone "Cloning into" messag=
e
> =C2=A0 =C2=A0fixup 73f08a1 gettextize: git-clone "Cloning into" messa=
ge braces
>
> I've also fixed up the whole mess with the "me" messages. I.e. droppe=
d
> the revert commits and just fixed the originals so they make sense in
> the first place.

Hi, since you didn't pick this up in the last push I fixed it up a bit
more.

I rebased ab/i18n-all-continue on the new master:

    git fetch git://github.com/avar/git +ab/i18n-all-continue:ab/i18n

But you probably want this instead:

    git fetch git://github.com/avar/git +ab/i18n-all-continue-with-hind=
i:ab/i18n

I took the liberty of adding Ramkumar Ramachandra's hi.po patch to the
series.

It also doesn't have your "Style fixups: explicitly disambiguate
nested if/if/else correspondence" commit since I fixed that in my
copy, and fixes the "me" issues by rewriting some old commits.
