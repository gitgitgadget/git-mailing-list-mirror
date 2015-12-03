From: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Thu, 3 Dec 2015 11:32:22 +0100
Message-ID: <56601A36.1060803@informatik.uni-hamburg.de>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
 <5655D755.8060503@atlas-elektronik.com>
 <5655DAE7.2000008@informatik.uni-hamburg.de>
 <20151202005826.GE28197@sigill.intra.peff.net>
 <565EE63A.3040006@informatik.uni-hamburg.de>
 <20151202154948.GA9525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CbBNPCqBRLOLSGWX7lAqsba0i054i62A2"
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	stefan.naewe@atlas-elektronik.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 03 11:32:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4RBk-0004qH-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 11:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759582AbbLCKcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 05:32:31 -0500
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:50347 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759571AbbLCKc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Dec 2015 05:32:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 2ED47DA7;
	Thu,  3 Dec 2015 11:32:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id beTvNUoXZItb; Thu,  3 Dec 2015 11:32:27 +0100 (CET)
Received: from [136.172.14.25] (unknown [136.172.14.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: huebbe)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 25427DA1;
	Thu,  3 Dec 2015 11:32:27 +0100 (CET)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <20151202154948.GA9525@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281950>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CbBNPCqBRLOLSGWX7lAqsba0i054i62A2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Peff,
I have no problem working around this bug/feature.

I just happen to think that the current *default* behaviour
is not the default behaviour that users have a right to expect:
I believe that users have every right to expect `git format-patch`/`git a=
m`
to preserve commit messages perfectly by default.

Since I see that people are using the current behaviour as a feature,
I tried to come up with an alternative behaviour that would do both:

 1. Respect user assumptions to preserve commit messages by default.

 2. Allow users to prepend stuff when mailing a patch, that will get stri=
pped automatically.

Just because the current behaviour is ... irritating.


Cheers,
Nathanael



On 12/02/2015 04:49 PM, Jeff King wrote:
> On Wed, Dec 02, 2015 at 01:38:18PM +0100, huebbe wrote:
>=20
>> As such, I would like to ask whether it would be possible/sensible
>> to somehow escape square brackets, or mark the beginning
>> of the original commit message in the `git format-patch` output?
>> This would allow `git am` to reproduce the exact commit message by def=
ault
>> without breaking the "[]" convention.
>=20
> I am not sure why "git format-patch -k | git am -k" does not do what yo=
u
> want. That is what those options were added for (and what git-rebase
> uses internally to make sure commit messages are left unmunged).
>=20
> -Peff
>=20


--=20
Please be aware that the enemies of your civil rights and your freedom
are on CC of all unencrypted communication. Protect yourself.


--CbBNPCqBRLOLSGWX7lAqsba0i054i62A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWYBo6AAoJEO3tJW5NCfoMOWIP/0edeS3Pc9p88iEaBRSzcW5L
9OGArjvDUOWCGLnjtrbciueITjqnXlZJRK5Ua3ajQG7bhH7ZChsWnV142E9OGjKm
ag4afkh5iJOv5983VWKVMGoCWw+eb9QCtrxck7T6tm4vRMOEii2ZPFSvbU8tpTgs
btuZ+FxKcJ5xv6VFfukLbHxMOAjX0SpkFI5agsW1rn1IwrC6a2wedbGBhlBdz7p7
CiwGz7wKdLVRJaDgvM6+7Nr49k0T/D+xhSFnIyP4FM2lIjdTY/Og9zbHqWXkDgVP
Rd8ZWBs39MF4nmpq3aoPsGcwnB7t0aay7+4xYSVbYPPtSksJWWqEDIBsMQjHEZty
4IGgs6ulXLQfWO1POE/XL4I5r6KXeavYJfGZmYwFAo8Ys4r7t4pS9BBwvaxj0iq0
9qejsh5iExe4WwH1SvTaEEoNbNomsjuXtoy+OJBYu00cruZ6jrfBVIlsy+zfPnTh
BU14KIEEFNC4IGei4xo0+MUowtNNDmX9geMmiZMbtg4W3rPCqao3sYCfuDGnOfvp
fFw8HhhaqCfJ0sdnxxvmhgCqlDcYGQ7ohYP3IK5PnVZwFposXR+PuxqTM9K6KY8M
8I4a6jNljMCrm+axQ+JpXRkSX7wwkzEG8t8MtbM6NrhfKG0E/O9arJ7sft344QTC
gPLxmrkWYV62Fakr3lVp
=s6Gt
-----END PGP SIGNATURE-----

--CbBNPCqBRLOLSGWX7lAqsba0i054i62A2--
