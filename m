From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2011, #02; Wed, 6)
Date: Mon, 11 Apr 2011 11:00:43 +0200
Message-ID: <BANLkTinRRJAvMrbUUwGTcgK+9-Bh5QATcA@mail.gmail.com>
References: <7v8vvni1t3.fsf@alter.siamese.dyndns.org>
	<BANLkTinTVinnDLPnHGoF9DY97ky_MFiLAQ@mail.gmail.com>
	<4DA23551.4040304@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:00:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9CzK-0002vi-Iy
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab1DKJAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 05:00:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44313 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1DKJAo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 05:00:44 -0400
Received: by fxm17 with SMTP id 17so3419675fxm.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9tGiSMpLyL+0MEEuBY6XqzhhiMRKLTYAG+zEt1WPkIs=;
        b=OXGWEsZyprH9lURdpi5owDUsulDKFtUB0DtutNxarPIXed1icUjf5kr9DwpEIEdXVk
         /tlxk4GbLWBJoRQqDZlWK817naUZECxuscK12R7+x8X8Ts9b0TgTlE06dFiLxjqDv/qN
         b0WevJ1Uyax+A4NR5u8FxsFz76BUcWrCH5eMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a+F6CV5k2STjQyIDdtt91umL+VpQUKSlV7OQMQgRDezQKmjAr9srKntBShlGGcr8og
         pbOUKrjHVcAR7Lx30Ywy6gRSvQ2dTuuGvuVNYHH4qK7zycxbK+qyvO4dHstpPwY6qp5H
         VbgGVnoa3URvmVE7KobgS7aM6VtTdBb27ITps=
Received: by 10.223.161.194 with SMTP id s2mr6334fax.143.1302512443615; Mon,
 11 Apr 2011 02:00:43 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Mon, 11 Apr 2011 02:00:43 -0700 (PDT)
In-Reply-To: <4DA23551.4040304@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171317>

On Mon, Apr 11, 2011 at 00:55, Jens Lehmann <Jens.Lehmann@web.de> wrote=
:
> Am 10.04.2011 20:52, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> On Wed, Apr 6, 2011 at 22:04, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>>> * jl/submodule-fetch-on-demand (2011-03-06) 7 commits
>>> =C2=A0(merged to 'next' on 2011-03-20 at a5e452d)
>>> =C2=A0+ fetch/pull: Describe --recurse-submodule restrictions in th=
e BUGS section
>>> =C2=A0+ submodule update: Don't fetch when the submodule commit is =
already present
>>> =C2=A0+ fetch/pull: Don't recurse into a submodule when commits are=
 already present
>>> =C2=A0+ Submodules: Add 'on-demand' value for the 'fetchRecurseSubm=
odule' option
>>> =C2=A0+ config: teach the fetch.recurseSubmodules option the 'on-de=
mand' value
>>> =C2=A0+ fetch/pull: Add the 'on-demand' value to the --recurse-subm=
odules option
>>> =C2=A0+ fetch/pull: recurse into submodules when necessary
>>
>> This series needs to be fixed to not fail tests with GETTEXT_POISON=3D=
YesPlease.
>
> Maybe something like this? Junio, do you want me to squash the change=
s in
> the patch series and resend it or should I send a new commit?

Sorry about the short mail yesterday, I had to take care of something.

Anyway, that looks like it'll work, but the preferred way of doing it
is like it's done at the bottom of t3700-add.sh. I.e.:

test_expect_success 'git add --dry-run --ignore-missing of
non-existing file' '
    test_must_fail git add --dry-run --ignore-missing track-this
ignored-file >actual.out 2>actual.err
'

test_expect_success C_LOCALE_OUTPUT 'git add --dry-run
--ignore-missing of non-existing file output' '
    test_cmp expect.out actual.out &&
    test_cmp expect.err actual.err
'

That is, split up each test into a test that tests the functionality
(i.e. exit codes) and one that tests the output.

That way we make sure that only things dependent on C locale output
are skipped under non-C locales.

Sometimes that's hard, in which case it's fine to just skip the entire =
thing.
