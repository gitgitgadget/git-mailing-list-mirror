From: Felipe Micaroni Lalli <micaroni@walltime.info>
Subject: Re: Git feature request: mark a commit as minor
Date: Sat, 3 Oct 2015 03:44:31 -0300
Organization: Walltime
Message-ID: <560F794F.2010809@walltime.info>
References: <560EF966.3000501@walltime.info>
 <CA+P7+xq8Ds3hYjv2x8S4v8+6F3G+ciGreiZxHxDfzzft520ChQ@mail.gmail.com>
 <CAHYJk3Qb89YhVJoOpBLYMoNJX5GvVHnJhf41Gdbtypcp+Yq96g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wk6EuCiMW0He3kOtkXlj5Kl24ucEnntJ3"
Cc: Git List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 08:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiGZ3-0008MG-Vy
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 08:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbbJCGo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 02:44:56 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36555 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbbJCGog (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 02:44:36 -0400
Received: by qgx61 with SMTP id 61so112592299qgx.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 23:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type;
        bh=xZwD/F1TuOqAfvGR9AXqV2BURuVhJrXI5z2uhxw1jr4=;
        b=HB78Ifkyx+IXlrs7b4GmdSfCOSMQpBmotvxSiJsZfVSWm1ixqMpEaFDUfilt5IQm54
         R694JW5H5hnVlT9RfrdcJZMnbFDmHKwSXWjIe7Tl15Fx/XjCmnryX/xpCkuGGzsdwPmH
         X1YXRD03VcJHQ4m78+LGTX7RoMVYITu4MZVUu+ZVGfneqxWCcbbW4TQYmZmWLJT1DYxM
         6Jx9mJQDX4wZ385fDM3ZmXCWYpcRMg3DKQ/+Ed2uljLyzI0CIBayTPruz8i+nToG5lBZ
         hT3KRPBe+rXaUnHbfk60R2ODwdaqelnCoR3MCV+sG/Tgfif3zvhMNKlbonNCQnWEApuJ
         ZgwA==
X-Gm-Message-State: ALoCoQkRPDjhmBilNIT2hbt8/eeuSH+i1U17ccBiRcFMMwz0IVP7EImk388D5ad7BRLapMdbyaKw
X-Received: by 10.140.133.69 with SMTP id 66mr27045951qhf.18.1443854675806;
        Fri, 02 Oct 2015 23:44:35 -0700 (PDT)
Received: from [192.168.1.56] ([179.110.8.33])
        by smtp.googlemail.com with ESMTPSA id 65sm6249420qha.41.2015.10.02.23.44.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2015 23:44:35 -0700 (PDT)
X-Enigmail-Draft-Status: N0110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CAHYJk3Qb89YhVJoOpBLYMoNJX5GvVHnJhf41Gdbtypcp+Yq96g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278958>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wk6EuCiMW0He3kOtkXlj5Kl24ucEnntJ3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you Jacob.

Actually we already use the keyword MINOR for that, exactly as you said.

The suggestion was made because I think it is a common behavior and it
would be nice to be a meta info to standardize this (today each team
adopt a different pattern for that - you used "TRIVIAL" e.g.). Nice
things could be done with this meta-info. It could be totally ignored
(current git operation) or it could be used to filter, to sort, to group
commits, to show the log pretty etc.

> The issue is that not everyone considers these changes as "minor".

I understand this issue, I know it is subjective. But if someone don't
want to make the distinction just don't use the argument --hide-minor
for example.




On 03/10/2015 03:17, Mikael Magnusson wrote:
> On Sat, Oct 3, 2015 at 8:11 AM, Jacob Keller <jacob.keller@gmail.com> w=
rote:
>> On Fri, Oct 2, 2015 at 2:38 PM, Felipe Micaroni Lalli
>> <micaroni@walltime.info> wrote:
>>> A minor change (also called "cosmetic") usually is a typo fix, doc
>>> improvement, a little code refactoring that don't change the behavior=
 etc.
>>>
>>> In Wikipedia we can mark an edition as "minor".
>>>
>>> It would be nice to have an argument like "--minor" in git-commit to
>>> mark the commit as minor. Also, filter in git-log (like --hide-minor)=
 to
>>> hide the minor changes. The git-log could be optimized to show minor
>>> commits more discreetly.
>>>
>>>
>>
>> This should just be part of the commit message log, generally projects=

>> use something like TRIVIAL in the patch subject or similar. You could
>> also standardize for your project(s) what would be considered a minor
>> change. The issue is that not everyone considers these changes as
>> "minor". You should be able to use a combination of the --grep option
>> in log to search for all commits who don't contain that string in the
>> right format.
>=20
> Could also be a good use for notes, since you might want to add this
> markup after the fact.
>=20


--Wk6EuCiMW0He3kOtkXlj5Kl24ucEnntJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWD3lQAAoJEEwK/M/tXN4UZhwQANzW8q0V8RvNRPxwSB9x2ZIi
SWZX8I0PRWCZC9jWO1VUetIvcYQ+Gsx7XVa020tQeDxxx5oviGlJaDLP82u9JKbe
3QSLs3E7/Oumd+89QCrfgv73gpP/DCutMNgInQpPUdq4Y7euCkRZY1xJbpJczoCN
aeZNlhDYyZMlhPI2JwxpKHXMQ4h5my18WC3AcvlZgxh8q5XKN5zCLXgpcijHFHpW
MzlxOGRSnFC0pDYPbeRQUAR9J0K3YWR5peP+MnfEeejUQ/oqq2XdDTReojw+YX4s
Nu5NWJyDeYYlGR8i08per+aMGLilpwwUqIBwjumBqfze1/ndYd9jeJqyfzroO9cL
/s3Be7KcYmm7muGHCb9iPqddq/n9u8yhVw/WiCXZVgvWec3asly/fxRSb6WvL9LX
DErpgE0yHTO8YtuIWQ6mlxLjFN4LytOLLl107OYbLrx1D4cdeakcu4V+CfFu1UdQ
4Q0QHy/NZT09DUo6dAB3AtuPTU5tvmSD4bXY1elK1a503SHFCHh8k/AWNGQOPOpg
8gNdPsXZoSezvZnpfaSdjOAEA4BnQt7UHmJ4AoqXcjDbEz6wXfvcuPZ0uNMSUsRW
MFiK4t2gEHbjuD3SESdzyTrM+GNt2mIy323ILVJqp2uFhjEGQbIEAShyYlG4tVwY
aKJJI+udYJStEqPZWBas
=hRWs
-----END PGP SIGNATURE-----

--Wk6EuCiMW0He3kOtkXlj5Kl24ucEnntJ3--
