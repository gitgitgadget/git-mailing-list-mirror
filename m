From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 17/73] gettextize: git-branch "Deleted branch [...]" message
Date: Fri, 25 Feb 2011 20:58:50 +0100
Message-ID: <AANLkTi=Ua=2zm3GhHJVfECJ5VcZaMnRf9MYjSONoWcP4@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-18-git-send-email-avarab@gmail.com>
	<20110225075429.GF23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3p4-0002bh-ME
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867Ab1BYT70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 14:59:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65138 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab1BYT7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 14:59:25 -0500
Received: by fxm17 with SMTP id 17so2020998fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=37/MsGGeOB7abJCfgPeAT4iu6fwhAsq8XtYsZapufJc=;
        b=TdjpmDMofnylRifXHMYYCmKfWcGlZt2Qfv9/Oqcz9jUR4zMFkjE6LQX9n5uvVHt4FH
         IENjULwAyDkAj68VtGjSRHTFN7AbiYnUG7PluW8HzZ0RDo1jEdffdVw2VBoqZDt9lqkq
         qJLdY+RAJizKDto1vzYMreDUiveBfdSSQdr0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DzNU0+DC3o/YB501m5QOQkdFZaJXOQClAoRWVkUrJjRqlV2+ZcLdRkUVNk1UamGvri
         uHyVjlSAW0Yj+Pt94Kwrz4VtCwmenwRo4WqutvPn0GNdN4YkW+ABGyqAFuPc9fn0ynTA
         YuSQV6vD58Et1mexKRA+NuPkopGapzSOEBP4s=
Received: by 10.223.112.81 with SMTP id v17mr2622959fap.102.1298663930059;
 Fri, 25 Feb 2011 11:58:50 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 11:58:50 -0800 (PST)
In-Reply-To: <20110225075429.GF23037@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167930>

On Fri, Feb 25, 2011 at 08:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -214,7 +214,7 @@ static int delete_branches(int argc, const char =
**argv, int force, int kinds)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ret =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct strbuf buf =3D STRBUF_INIT;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 printf("Deleted %sbranch %s (was %s).\n", remote,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 printf(_("Deleted %sbranch %s (was %s).\n"), remote,
>
> This patch might be might easier to read squashed with the previous
> one (both for the sake of providing context to reviewers and avoiding
> mixed-language output :)).

I split it up from the rest because I always tried to group
translations with the tests they broke, and only the tests they broke
and vice versa.

It was often a lot of work figuring out what translation broke what
tests. IIRC splitting this all took me around half a day at the time.

So while it's easy to find out what message is the relevant one in
this case, this is an attribute of the series I'd really like to keep
for future bookkeeping. It's nice to be able to annotate a line in the
test suite and see a patch that changes *just* that message and
related tests, not a lot of other unrelated messages.
