From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Mon, 4 Oct 2010 19:59:27 -0400
Message-ID: <201010041959.48336.ComputerDruid@gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com> <201010041851.46838.ComputerDruid@gmail.com> <AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3546470.GgYf4bkDCr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Hugel <urschrei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 01:59:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2uwK-0000fj-1H
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 01:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444Ab0JDX7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 19:59:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45186 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab0JDX7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 19:59:22 -0400
Received: by qyk10 with SMTP id 10so1867968qyk.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 16:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=h8YyQooG81TsuBChacaEC1EnafqCUefALbM8IngFQD0=;
        b=q/BwyktWaK+KbYsAGbPELzWHOE7U6oXP4iDmHfbrKNhEAQtRIoyqkcj2SGesv1TAUj
         WVA3Q0PxdiVIWxL1KBlFHfEB3xaTr7LZM6gWq7US7c9SP/bMmTjpBfRlKdFztyCUaeMH
         oo3qinhX98ExXJ+k9fqMorGxXjQ00JWRWx3dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=ELmsh2jV0wik7wJJAoU7d+3u5Ym8caEGtocGQopWwhInpD749IUOCqZ02AsS3M9L5w
         yICFQPkNIU+Ce9EwR2VzsT+Qm4/4RXIU0IcjLSQD+gIvJVqGbcsXqwwr+qkGTp7NgJdH
         dpWPaHgVyh7kVYEh2hubDANGDqoWj+9tKdZek=
Received: by 10.224.45.142 with SMTP id e14mr7520912qaf.247.1286236761463;
        Mon, 04 Oct 2010 16:59:21 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu [129.21.115.231])
        by mx.google.com with ESMTPS id t4sm6193015qcs.40.2010.10.04.16.59.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 16:59:20 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35.3; KDE/4.5.0; x86_64; ; )
In-Reply-To: <AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158145>

--nextPart3546470.GgYf4bkDCr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:=20
> Daniel,
> Those are the exact steps I'm using.
>=20
> When I run tag -v on existing tags, I don't see the
>=20
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v1.4.9 (Darwin)
>=20
> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
> yZeXw/EddYrfdad/VvOrL1o=3D
> =3D/0PJ
> -----END PGP MESSAGE=E2=80=94=E2=80=94
>=20
> block. It's only present on tags created using the current version.
> I've also just upgraded to GnuPG 1.4.10, but the result is the same.
> I'm not sure how else I can determine where the problem arises; I'm
> using the git and GnuPG versions for OS X built by homebrew, and GnuPG
> is happy to use the same key for en/decryption and signing. I've also
> verified that none of the subkeys are expired, and that the trust db
> is OK.

If you have the tests available, can you try running t7004 to see if it fai=
ls=20
there too?

--nextPart3546470.GgYf4bkDCr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyqanQACgkQhP2Vm0oJTtx+gwCcCZMFqy2lo68hYZGG1eUHFyFh
6B0AoJpkXm9mByJlpDoZObUARhSPj9JT
=BqXe
-----END PGP SIGNATURE-----

--nextPart3546470.GgYf4bkDCr--
