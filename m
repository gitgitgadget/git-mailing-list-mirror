From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] SubmittingPatches: Clarify the Signed-off-by rules
Date: Wed, 28 Jul 2010 19:23:25 +0200
Message-ID: <AANLkTi=wT_-1dq-TEb=XNLnh9BM_q4krArwfR8NV+eSk@mail.gmail.com>
References: <1280326379-10257-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAM8-0002yk-KK
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab0G1RXc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:23:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45173 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0G1RX2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:23:28 -0400
Received: by gwb20 with SMTP id 20so1012417gwb.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RcWifHflzYumya5T7nNxu3oIlgMmYfaBepQp4B5Rudk=;
        b=Tj3oXze6yDRFcajEwEIlgVAerqo2BWNnecn107i1I0M+HZG2+qtQ2UTgdyXnavjRnP
         /NlGtaY8x8efxubvqSzy5SnHGgwT4vPnseNO20GAShXpjYP+5AFpxKCcVqwxyJV0Dh2R
         kuzAUPxhyfwmTBPDZWLi3fFDd7mfFy7+V5Er4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AYFY0ho1wG2OFrNMLRiCCrVpoXNE49ewAcrq+hDuDEGTN52W1JkzOYmTFPzkNAxo9e
         klU7lyNDqc3vHbYAeSRXY5LBlbPehgSEYgiCLSpZ9HvH60Nk+sY3X1ECEmn301Z/NroL
         uCmTpa1t1Cy348jcTt/Zm61NDTTpwgpZXtLXs=
Received: by 10.151.138.13 with SMTP id q13mr10109109ybn.189.1280337805520; 
	Wed, 28 Jul 2010 10:23:25 -0700 (PDT)
Received: by 10.231.162.10 with HTTP; Wed, 28 Jul 2010 10:23:25 -0700 (PDT)
In-Reply-To: <1280326379-10257-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152105>

On Wed, Jul 28, 2010 at 16:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> The wording of the Signed-off-by rules could be read as stating that
> S-O-B should only be added when the submitter considered the patch
> ready for inclusion in git.git.
>
> We also want Signed-off-by to be used for e.g. RFC patches, in case
> someone wants to dig an old patch out of the archive and improve
> it. Change the wording to recommend a Signed-off-by for all submitted
> patches.
>
> The problem with the wording came up in the "[PATCH/RFC] Hacky versio=
n
> of a glob() driven config include" thread[1]. Bert Wesarg suggested[2=
]
> that it be removed to avoid confusion, which this change implements.
>

Thanks for resurrecting this.

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>

> =C2=A01. <1273180440-8641-1-git-send-email-avarab@gmail.com>
> =C2=A02. <AANLkTimziTKL13VKIOcaS1TX1F_xvTVjH8Q398Yx36Us@mail.gmail.co=
m>
>
> Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
> =C2=A0Documentation/SubmittingPatches | =C2=A0 =C2=A08 +++-----
> =C2=A01 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
> index 099b238..ece3c77 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -14,11 +14,9 @@ Checklist (and a short version for the impatient):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0not "ch=
anged" or "changes".
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- includes mot=
ivation for the change, and contrasts
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0its imp=
lementation with previous behaviour
> - =C2=A0 =C2=A0 =C2=A0 - if you want your work included in git.git, a=
dd a
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Signed-off-by: Your Name <you@example.=
com>" line to the
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit message (or just use the option =
"-s" when
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 committing) to confirm that you agree t=
o the Developer's
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 Certificate of Origin
> + =C2=A0 =C2=A0 =C2=A0 - add a "Signed-off-by: Your Name <you@example=
=2Ecom>" line to the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit message (or just use the option =
"-s" when committing)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 to confirm that you agree to the Develo=
per's Certificate of Origin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- make sure that you have tests for the bu=
g you are fixing
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- make sure that the test suite passes aft=
er your commit
>
> --
> 1.7.0.4
>
>
