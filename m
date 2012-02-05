From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sun, 5 Feb 2012 23:07:10 +0200
Message-ID: <CAMP44s0gf196UWQabdqPXF=YwJ0WYtU2P4Y6DCEONvkCDhbJAw@mail.gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
	<20120204201027.GE22928@burratino>
	<CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
	<20120204211351.GB3278@burratino>
	<CAMP44s2djXurzMSXLOAkx84Sm8P2YV67M1yS2AuidkfGbTdmEQ@mail.gmail.com>
	<7vvcnlggno.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Marius Storm-Olsen <marius@trolltech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9It-0007jx-KX
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab2BEVHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:07:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36951 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843Ab2BEVHM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:07:12 -0500
Received: by lagu2 with SMTP id u2so2655337lag.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7oiP41WhUlddAgHhr83Qdo1qHGGBk142jHViffZCrrQ=;
        b=Saa2lhMknMWzi5rvv+u2g8K9shPG1uYJsHXx+w9Fu0YYeyEorozQPbqKtezSXXLxDi
         U95Zb/45N8KbTvTyU1EQ7I96GhLoGeYSzg7PqMoNFANdFWuk/Y4HHXy/xyTDqbkJh5Ot
         wToV+meDNz0edsHZcacFRqGYa55iLwcsc8GJU=
Received: by 10.152.114.169 with SMTP id jh9mr7991042lab.20.1328476030695;
 Sun, 05 Feb 2012 13:07:10 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Sun, 5 Feb 2012 13:07:10 -0800 (PST)
In-Reply-To: <7vvcnlggno.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189961>

On Sun, Feb 5, 2012 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> Look at the title:
>>>> add 'git blame -e' tests
>>>>
>>>> s/blame/blame -e/
>>>
>>> And? =C2=A0After copy/pasting this particular test with that substi=
tution,
>>> what do we get a test for?
>>
>> For 'git blame -e'.
>>
>>> What class of problem is it supposed to catch?
>>
>> Problems related to 'git blame -e'?
>
> You very well know that we know you better than that, so it is no use=
 to
> pretend to be dumb. =C2=A0It does not do anything other than wasting =
bandwidth
> and irritating readers.

That description is *perfectly* fine. It's succinct, there's nothing
wrong with that.

There's *nothing* else to say. There's no tests for 'git blame -e',
the patch adds tests for 'git blame -e', that's all, thus the title
"add 'git blame -e' tests.

The patch is good by itself, it doesn't _need_ any other context. It
would detect regressions on 'git blame -e', obviously, which is good.

> You know that you are not addressing "git blame with the -e option sh=
ows
> wrong line numbers on its output". =C2=A0The symptom you are checking=
 with is
> "e-mail address output from 'blame -e' used to add an extra '>' at th=
e end
> when only name is mapped, and I fixed it with the previous patch."

No, that's not true. This patch doesn't do that.

> Why is it so hard to either
>
> =C2=A0(1) give the more descriptive answer upfront when somebody who =
did not
> =C2=A0 =C2=A0 read the first patch of the 3-patch series pointed it o=
ut the comment
> =C2=A0 =C2=A0 is not descriptive enough the first time; or

Because it's not needed. Adding tests for 'git blame -e' is good in its=
elf.

Some tests =3D better than no tests.

> =C2=A0(2) give the more descriptive answer and then say "we could do =
that, but
> =C2=A0 =C2=A0 when somebody views this change in "git log" as a part =
of 3-patch
> =C2=A0 =C2=A0 series, it should be clear enough---so let's aim for br=
evity instead
> =C2=A0 =C2=A0 of adding that two-line description" to defend the line=
 in the patch?

What is unclear of "add 'git blame -e' tests"? It adds tests, that's go=
od.

>> Or just apply it. Don't let the perfect be the enemy of the good.
>
> Perfect is the enemy of the good, but it is not an excuse to be slopp=
y.
>
> I tend to think that a single line "# blame -e" is sufficient if this=
 were
> a part of just a single patch that has the fix and the test to guard =
the
> fix against future breakage (i.e. "not sloppy"). I would even say tha=
t not
> even "# blame" is necessary in such a case.
>
> But if this is a standalone patch to add this test, it does not descr=
ibe
> what it wants to test very well.

It wants to test the output of 'git blame -e', as it can be obviates
from the title. Is there something wrong with that?

> In any case, I have doubts that the fix should go to blame and not to
> map_user(), so I'll see what happens in the further discussions.

This patch is orthogonal to that; there are no tests for 'git blame -e'=
=2E

--=20
=46elipe Contreras
