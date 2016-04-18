From: Christoph Paulik <cpaulik@gmail.com>
Subject: Re: git merge branch --no-commit does commit fast forward merges
Date: Mon, 18 Apr 2016 09:23:18 +0200
Message-ID: <87a8krpehl.fsf@gmail.com>
References: <874mb0kkkk.fsf@gmail.com> <alpine.DEB.2.20.1604180825170.2967@virtualbox> <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 09:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1as3Wu-0005gq-E5
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 09:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbcDRHX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 03:23:28 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32928 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcDRHX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 03:23:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id y144so21930310wmd.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=87q2M+MqPo+3FGRIHNvTlIvGIpx7jCh+QFuYe2POvDM=;
        b=E9CleaUJBxxA3DbJd8Am7t5PO4xjRYP2UClAp3mt9rET9MXxFCo1lQyNxSpOO8xB5F
         5UH8TylkHQ24JfyfCc/2C0nzr3MBbOYG2Be6dIs7J/A6QrRteA15cvUfTXj9J5lWV44I
         qv+81uylbO0pqZzYsqchtRaFmNCbazF6GeKdxMvW8g/UGE6BiYBKZD3y/w/K8tu03ERg
         Ut6tqj/dSAHZagtQBgWEPBiDjb2RQ4IvAxdjmk9seCaLzkObYbO3gIbSuvtgcWPExt3W
         3IY5sSGxEOTu/1ic4BZK6Tu2LfAbArg1GqZB2VbM6qK8jlkx3utXWR0KoLUr6AiDohk8
         CoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=87q2M+MqPo+3FGRIHNvTlIvGIpx7jCh+QFuYe2POvDM=;
        b=Ruf5Ngmu5mxxc8tJwbb1kZo6xqT1hj/PIUNWTtGC+ej/EkcCnr2OztG719BjxBnapZ
         mI8NDvNGs6TBq9BeV5meEz1ssC4oT/Prwbb6+yAebv3Uqh8343oQ8my7H1qI+NTEsN9j
         fWz6ZXDFiE677fZ6Y5yqHQJjjYiUDa/R8D+4fLdMLWps+xhn1+5boolVPwEYYgZkllJw
         NWoxVgleJHlFtFqV07QEbzYp+VjEVaJ0QPeyxWAXq2T2xLX3ooDBeS7HHwoA0FCaf+Ic
         /wDwr4CTtS9ZpuXvjSDFZgbQ6VZ5vK0j+7jBOvb/FDmFIglengv29r0p7afLP9iNqcno
         PfkA==
X-Gm-Message-State: AOPr4FU1GcT43H9LZhoBmDZXihjg0tZ9D9oeS0Y3TQ0lMP6kw0pSjbSTA5OtOKLeWmmDVg==
X-Received: by 10.194.221.37 with SMTP id qb5mr2363541wjc.171.1460964206193;
        Mon, 18 Apr 2016 00:23:26 -0700 (PDT)
Received: from cp-laptop ([62.178.79.172])
        by smtp.gmail.com with ESMTPSA id us3sm44810724wjc.41.2016.04.18.00.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Apr 2016 00:23:25 -0700 (PDT)
User-agent: mu4e 0.9.16; emacs 24.5.1
In-reply-to: <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291800>

--=-=-=
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable


My expectations from what should happen came mainly from the=20
description of the --no-commit flag in the help:

With --no-commit perform the merge but pretend the merge failed=20
and do not autocommit, to give the user a chance to inspect and=20
further tweak the merge result before committing.=20

So in the case of a fast-forward the flag does not pretend that=20
the merge failed.=20

Regards,
Christoph=20
=20

Andrew Ardill writes:

> On 18 April 2016 at 16:26, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > The command only works as expected when also adding the=20
>> > --no-ff flag.
>>
>> Then you need to fix your expectations ;-)
>
> I *think* the core of this problem is that the intent of the=20
> end-user does not align with the command options available.
>
> In this use case (as far as I can tell), the user wants to see=20
> what the result of a merge from somewhere else will look like,=20
> without changing their HEAD.
>
> While you are correct in saying a fast-forward does not create=20
> any new commits, for the user it certainly looks like a whole=20
> slew of new commits have been added. Moreover, the nature of the=20
> option means that the user has to investigate if the merge is a=20
> fast-forward in order to know what the outcome of the command=20
> will be.
>
> If the merge is a fast-forward, --no-commit has no effect on the=20
> outcome. If the merge is not a fast-forward, --no-commit has a=20
> huge effect on the outcome.
>
> If I see a --no-commit option, as an inexperienced user, I would=20
> be quite surprised to find my HEAD changed after using it. It=20
> would be far more intuitive, for that user, for --no-commit to=20
> imply --no-ff however I suspect that such a change may well=20
> cause more problems then it fixes.
>
> What I wonder is, in what situation is the current behaviour is=20
> desirable?
>
> While I agree that the option works as designed, I think its=20
> behaviour is more surprising to the end user then it should be.
>
> Regards,
>
> Andrew Ardill


=2D-=20

=2D------------------------------------------------------
Christoph Paulik
Twitter, Github: @cpaulik
PGP: 8CFC D7DF 2867 B2DC 749B  1B0A 6E3B A262 5186 A0AC

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXFItnAAoJEG47omJRhqCs9xoP/RLC8J6F+f0ZESAA9RZx51TM
hHvP35AM3OP/DK9x/ZEqbV7pbPHyKN3lrs2G6wMkpwGQ2g5ORgQyt6qPWPizaRqL
H1aVvZNZ1vA3Y4RjGuZbntZGD4gm0fKGTUmcjFbMAcWeejeu8oWOfjf/Xb44S/8M
2EfoxC+iu2mm9QF3yHXmB6YxwIjG02o1JK+M2NChh3HXsUE3SRL1NxIFb8ziBrHG
YyyLR7diLsmOfPYn5nWX0A6TOJjV5oeSCQmhwfg8sMPFI5EZm3Gs6jwT6HZmgyDe
MGWsDMXlYs4wBwTSj9BUCtmthyh3EmTXGHdaGO/eatSz/OkHFn88CPCARlpVIjqI
mA7sHjQHxJvy3lPEdd6xcFQkQIcgx5QLRnhQibOr0dMFf2mPppYi2+OMLqsegpBW
Uifqy5vF+WENq7uSjr7EfLhAFOxIkIacKvlZ4Fg1AxADDhzxlRsV3jdoUgFCXrXu
boTd8baDzPv28s8efU6eA++qbyfTERBzK2UiIiM+yhONVtqL5c4YI8qloHMenx0P
Ux2+wHP4rjF2dhHj7RiBkd3HFVTotvC2YAAIvSvOsEJ19bu2LO7W8X8zg0otnYhE
JG9xYJZX4wl4DJf2xt6CaIH5SaGhEQqJTZSr/ax8036zqkmLlrOappHWmwkZnu95
qYGeOvcL62PFcHnmmUy/
=73bK
-----END PGP SIGNATURE-----
--=-=-=--
