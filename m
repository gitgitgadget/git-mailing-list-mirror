From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Wed, 18 Feb 2015 22:23:21 +0800
Message-ID: <293AD985-D133-4454-BBBA-B4106F16E91D@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> <vpqr3tozzs5.fsf@anie.imag.fr> <CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com> <54E3804D.6020301@web.de> <vpq61azab52.fsf@anie.imag.fr> <E28114B6-86FA-4F4A-9D5F-BFC03B9D79B8@gmail.com> <vpqr3tn2u3f.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_7D6365AA-902C-4CD4-BD50-25E9FF21DA8A"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 18 15:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO5XI-0007Hs-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 15:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbbBROX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 09:23:27 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:38067 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbBROX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 09:23:27 -0500
Received: by pdbfp1 with SMTP id fp1so1448336pdb.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2015 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=0J4gdOhxUh/ska0lFm8uY+Mbl9XuAG8IKCCLhBYd5JY=;
        b=Rtza7LHQhhYjB+wmJ4xNW7tJzgUxi5ZE6KBb2ke705scQfKFD80s8birXj9jP7Tlam
         iT5BqAp3wugSjuk/cl4+5ZtnwZCNUXPQtAeISK1KcDvOx1GpcvWl34azZUGposOcTEbk
         UL/oDfzIysqAhAcwLkpGJsCBWGbhgt6d7nz5wTneFryYAvkllbtl3/uSpEniTOylWm1e
         1vtQyLBOfUvG2aWpy8cqTGFRU1hA6RPHPqn57+k1n0OLW+Z/KxGPmgXKdXs93Uoi6PxF
         zT9xHUzq074eraPIk4weCWX0Cc3KgrmcRXAhVzkBPOSPuTqf4iXxnsoINqHHC+LMGmsY
         WDvg==
X-Received: by 10.68.237.2 with SMTP id uy2mr58463502pbc.72.1424269406850;
        Wed, 18 Feb 2015 06:23:26 -0800 (PST)
Received: from ?IPv6:2001:e68:5422:4c50:d102:fd4c:acd2:e1ca? ([2001:e68:5422:4c50:d102:fd4c:acd2:e1ca])
        by mx.google.com with ESMTPSA id fx13sm9283202pdb.7.2015.02.18.06.23.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Feb 2015 06:23:25 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <vpqr3tn2u3f.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264019>


--Apple-Mail=_7D6365AA-902C-4CD4-BD50-25E9FF21DA8A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 18, 2015, at 10:05 PM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>=20
> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>=20
>> Client: OS X 10.9 - 10.10.2
>> git client: git version 1.9.3 (Apple Git-50) and git version 2.2.1
>>=20
>> Server : Linux 3.2.40 (Synology DSM 5.1)
>> AFP : Netatalk afpd 3.1.1
>=20
> Any chance you can test this with a Mac OS server?
>=20
> Perhaps because the server is not a Mac OS, it doesn't have the uchg
> flag, and maps it to the w bit in the POSIX permission system (this is
> pure speculation from me).
>=20
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/

I don=E2=80=99t have any Mac OS X server in my disposal at this moment =
but if you want to test out with netatalk AFPD I believe it=E2=80=99s =
available in debian & ubuntu apt repo

Regards,
Fairuzan

--Apple-Mail=_7D6365AA-902C-4CD4-BD50-25E9FF21DA8A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU5KBZAAoJEKrU1IvC77KVlacH/AxdfLZgxjDjzKKhiGS+CNFg
diWsiePgd8bZq/NO5KlewvOMNmkQaM1LGJeqUSjozmjF8GuiJhDVN6n4SQiEXko/
nVLlQ669LxcOeQVLQRwO8okiLzW9gfsvv5LSdpF9lEKS+c2qniJqbxWJTycVfFAb
JhIlivIUekpulO0/uXKLSH+cQcMsq4GZd6daXUMk/hX+sYnfZOrnU3aAMxmM+EQE
8+QSenNoYPgC0cstj7cN6N1Z17SV96pkxJAaSEuf0ApUm1gzqj67rViXpV5aWUJt
MdWYlIasPM4NBOmslVhsOZhR5C0RAAj33CmCJQpayx/muQWyqXaiR3K72Z1mPGo=
=h04s
-----END PGP SIGNATURE-----

--Apple-Mail=_7D6365AA-902C-4CD4-BD50-25E9FF21DA8A--
