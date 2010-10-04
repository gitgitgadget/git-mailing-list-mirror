From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Mon, 4 Oct 2010 18:51:24 -0400
Message-ID: <201010041851.46838.ComputerDruid@gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2926374.h2J0RZg3vh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephan Hugel <urschrei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 00:51:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tsY-0005VI-Cf
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab0JDWvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:51:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54869 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab0JDWvU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:51:20 -0400
Received: by qwh6 with SMTP id 6so3380519qwh.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=MLXBX1e5Ln/XpQuI2Ylqq04InwP3mdovk1JEHdraMfI=;
        b=K+Uh+bfWbJZieHoQi1PR9zjTsAycnJx/1F2NQ1cffWDBdP+FyCsc7Y47flleL5pilI
         u2qgzhCueLLZoCiMT15glqe3kl1JC5O/RxRjT/MKFGR0CHhfrPYIWQGc0ErZE6VJY0fL
         uqtQAJKpCQk895Xo7+IrQPFTzoYm9nbD65z2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=TnyCBCQElFLcj+KhdZlc+stFjU2Kbn9LVzPhkHS5kwftkXtE6USwZudVHxXlfuuboC
         iHTYG5VwM6kzzXXrKWiMsbj5TvfUXBe1HW4klg+qF95n3l7JCsc7pBY9gP2V7iSVMCwq
         zugdBrFUK4VYU5NOd7cNYcoHDvkOT2QRHbSjc=
Received: by 10.229.204.169 with SMTP id fm41mr7380888qcb.259.1286232679825;
        Mon, 04 Oct 2010 15:51:19 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu [129.21.115.231])
        by mx.google.com with ESMTPS id t1sm6118385qcs.33.2010.10.04.15.51.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 15:51:18 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.35.3; KDE/4.5.0; x86_64; ; )
In-Reply-To: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158138>

--nextPart2926374.h2J0RZg3vh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 04 October 2010 18:13:21 Stephan Hugel wrote:
> Hello, git list.
> I seem to be unable to verify tags I create and sign using the git -s
> command in 1.7.3.1
> Existing tags (i.e. created with 1.7.2.x, using the same key and GnuPG
> version) can be verified, but attempts to verify created tags result
> in the following:
>=20
> object 791abd4848d86ea98071f35bbce4d4b274ef0788
> type commit
> tag v1.4
> tagger name <name@host.com> 1286228562 +0100
>=20
> Better header detection and regex
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v1.4.9 (Darwin)
>=20
> iD8DBQBMqkph8Y2TgZsQ1pARAgxrAJ40ATxZw219CWI6FCaDAtbY8UHdoACePF6Q
> PyNkf67w7AA8hkQqLAYGcyI=3D
> =3DVLWl
> -----END PGP MESSAGE-----
> gpg: Signature made Mon  4 Oct 22:42:57 2010 IST using DSA key ID 9B10D690
> gpg: BAD signature from "name <name@host.com>"
> error: could not verify the tag 'v1.4'
>=20
>=20
> I have confirmed that my key is valid (have
> signed/encrypted/decrypted/verified using it after this error
> occurred). I have also tried to create a tag using a newly-created
> key, with the same result. I have attempted to created signed tags in
> multiple repos. Is this a known bug?

I can't reproduce this:

$ git --version
git version 1.7.3.1
$ git tag -s test_tag -m "test_message"
$ git tag -v test_tag
object dbc2fa2a8507f258a353238cde2d9ba5894a8296
type commit
tag test_tag
tagger Daniel Johnson <ComputerDruid@gmail.com> 1286231912 -0400

test_message
gpg: Signature made Mon 04 Oct 2010 06:38:38 PM EDT using DSA key ID 4A094E=
DC
gpg: Good signature from "Daniel Johnson <ComputerDruid@gmail.com>"

Is this not what you are doing? do you have any more info about what you ar=
e=20
doing to cause this failure?

--nextPart2926374.h2J0RZg3vh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyqWoIACgkQhP2Vm0oJTtzAtACfVmMk4OLffbK+qQPPaclesogz
f6QAoJWK14C6njK6cKAsEQbSgQbeOCAy
=NET4
-----END PGP SIGNATURE-----

--nextPart2926374.h2J0RZg3vh--
