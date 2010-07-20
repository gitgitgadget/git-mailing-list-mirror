From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 21:25:33 +0000
Message-ID: <AANLkTinStfwbIWdtowoPpYpuT99tfweHBJ6U5m0oRtOc@mail.gmail.com>
References: <20100720163822.GA8492@localhost.localdomain>
	<0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
	<7veieym3sh.fsf@alter.siamese.dyndns.org>
	<AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
	<7v1vaym27n.fsf@alter.siamese.dyndns.org>
	<AANLkTil5eq2radUKvle7Ez48CDRfb8dvWcEobXzGaKNA@mail.gmail.com>
	<20100720191655.GA1705@burratino>
	<AANLkTimjTxbw0FCujPNbkzuFAbdXZBgWMmDTQeAegvNq@mail.gmail.com>
	<8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, jaredhance@gmail.com,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 23:25:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObKJp-0007pZ-5w
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 23:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713Ab0GTVZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 17:25:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44444 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597Ab0GTVZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 17:25:34 -0400
Received: by iwn7 with SMTP id 7so6049990iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nDDw8q/VIOaylZ8ZHsbUPtXCSR6jtRiRq+MtxGOwMj4=;
        b=a7aNcJhXLEt7VTaCUah7mux2jlEuIpziI5IGjTZgO3ZTZYu1Uqo5HEDTlL2yF7gM+W
         UMLotoBwGQOjf2JfuTIBtD7IZHtVNE8ji8Qa2mYC2W/tUnX55HaGIXA3A5S3i0FfLUBv
         tosOsnjdgZpSqEL+9XMnlnR/o3NSZ6lR3QfaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gNkSMlgmrwn5iaksHP43ATbvDfBl52tTbOEBj6MPA/9c5VYB71X/SJEGp/Ch65Dml+
         TmEtY9YofMZFp2C621WAe4reA7w5owXHQMaW0BV21aqo21W/tv16dBsX3aRF5Rylr6xd
         lYm3jIY15E8NUbHPKAovIjlbCTRdnb+1n8klA=
Received: by 10.231.59.83 with SMTP id k19mr7586116ibh.178.1279661133418; Tue, 
	20 Jul 2010 14:25:33 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 14:25:33 -0700 (PDT)
In-Reply-To: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151368>

On Tue, Jul 20, 2010 at 21:12, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:
> On 07/20/2010 03:49 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Jul 20, 2010 at 19:16, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>>>
>>>> That's what we seem to be doing in the tests so far, i.e. test_mus=
t_fail
>>>> is reserved for git commands only.
>>> test_must_fail relies on conventions for return value that cannot
>>> necessarily be relied on from outside utilities.
>>
>> Right, someone should send a patch for these:
>>
>> =C2=A0 =C2=A0 ack 'test_must_fail (?!git)' *sh
>>
>> :)
>
> You joke, but thanks to your prodding, I discovered these broken
> tests that should definitely all be fixed:

Oh I'm completely serious, I'm just too lazy to do these myself today :=
)

> =C2=A0 $ perl -ne 'm/test_must_fail +[^ ]+=3D/ && print' *sh
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show de=
lta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show ep=
silon &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show ep=
silon
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show ze=
ta &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show et=
a &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show et=
a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail PAGER=3D git reflog show be=
ta
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail MSG=3D"yet another note" gi=
t notes add -c deadbeef &&
>
> one-shot variable assignment does not work with test_must_fail.
>
> See e2007832552ccea9befed9003580c494f09e666e for an explanation.

Good catch.
