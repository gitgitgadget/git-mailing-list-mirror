From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sun, 6 Nov 2011 01:37:49 +0100
Message-ID: <CAGdFq_hw1630ELQP3+AEaCmUTEjYq7K1j8ZB-n0_rb1VN=wQgA@mail.gmail.com>
References: <1320501759-27236-1-git-send-email-srabbelier@gmail.com> <7v39e2852t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	=?UTF-8?Q?Jonas_Flod=C3=A9n?= <jonas@floden.nu>,
	Eric Herman <eric@freesa.org>, Fernando Vezzosi <fv@repnz.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:38:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqkv-0002QY-By
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab1KFAic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 20:38:32 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36729 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab1KFAib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 20:38:31 -0400
Received: by gyc15 with SMTP id 15so2812990gyc.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=58W9NYQUvvR0yBhaRTKG3FnUEZqCAZI0+LTf3oItWYI=;
        b=ph1yv/b6yLzRp1VP8LYPPnLc2XHRXQfeJguTxaH82JDFjUYIwT3dSOqZdYdh+A1hvg
         O+/RJdJWafXY4gUyN16SKgNU6Vhh401+PQjlvPk96A2mJ6TFT0f/9gRgvbKY4b3Jd6k7
         ysY0ttTHiLFkhObOaBfJObHPwTHjIxLCT+GuI=
Received: by 10.182.45.102 with SMTP id l6mr1126982obm.0.1320539911132; Sat,
 05 Nov 2011 17:38:31 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Sat, 5 Nov 2011 17:37:49 -0700 (PDT)
In-Reply-To: <7v39e2852t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184889>

Heya,

On Sun, Nov 6, 2011 at 01:31, Junio C Hamano <gitster@pobox.com> wrote:
> We can guess that 7-hexdigit is an abbreviated commit object name but=
 the
> above description and the title do not tell the most important thing.=
 What
> commit are you trying to describe, and why is it a good idea to show =
it?

The same commit that the title and number are already being displayed
for. It's a good idea to show that as that's a lot more convenient way
to look up the commit that failed to apply than just a rather
arbitrary number and the title.

>> Reviewed-by: Eric Herman <eric@freesa.org>
>> Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
>
> I wouldn't have issues if these were Helped-by or Asked-by or somethi=
ng,
> but a patch with Reviewed-by for which I do not see any trace of
> discussion on this list triggers some WTF at least for me.
>
> Where did these reviews take place? What were their inputs and how wa=
s the
> patch improved based on them? Why I should trust the judgements of th=
ese
> people?

We had a little Git hackathon in Amsterdam today, the review was done
IRL. In this case it consisted of Fernando pointing out that we should
stick to the git cherry-pick format of displaying the hash/title (with
the hash in square brackets before the title), rather than in
parenthesis after the title like I had before. I wanted to give credit
to their offline review somehow. If you'd prefer the "Helped-by" nomer
for this case I'm fine with that.

> What happens when threeway is not enabled, and especially when "git a=
m" is
> used for applying patches, not within rebase?

The same thing that already happens. I'm not sure what it is, but
whatever title/number is shown, the matching hash is now shown as
well. This patch does not change that behavior.

--=20
Cheers,

Sverre Rabbelier
