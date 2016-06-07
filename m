From: Pirate Praveen <praveen@debian.org>
Subject: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Tue, 7 Jun 2016 13:57:22 +0530
Message-ID: <5756856A.4020406@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CDALsHaN7pkIUjoc1Fm8FVlUuomPclGPw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 10:27:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACMR-0004JS-19
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 10:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbcFGI1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 04:27:37 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:59771 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcFGI1g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 04:27:36 -0400
Received: from homiemail-a124.g.dreamhost.com (caibbdcaaaib.dreamhost.com [208.113.200.81])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 911D79478F
	for <git@vger.kernel.org>; Tue,  7 Jun 2016 01:27:35 -0700 (PDT)
Received: from homiemail-a124.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a124.g.dreamhost.com (Postfix) with ESMTP id 3F13E60002B91
	for <git@vger.kernel.org>; Tue,  7 Jun 2016 01:27:34 -0700 (PDT)
Received: from [192.168.1.110] (unknown [14.96.231.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: me@j4v4m4n.in)
	by homiemail-a124.g.dreamhost.com (Postfix) with ESMTPSA id 671E460002B8E
	for <git@vger.kernel.org>; Tue,  7 Jun 2016 01:27:33 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296614>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CDALsHaN7pkIUjoc1Fm8FVlUuomPclGPw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to rebuild git 2.8.1 on debian jessie/stable and I get this
error (tests upto this succeeds).

not ok 32 - should avoid cleaning possible submodules

I added debian stretch repo to apt sources.list and ran apt-get source
-b git.

You can see the build options passed here
http://repo.or.cz/git/debian.git/blob/HEAD:/debian/rules

Since it is a working fine on debian sid/unstable, I did not want to
report it to debian package maintainers.

I noticed the same failure for git 2.8.0-rc3 as well. I could ignore the
test failure and go ahead, but I'd like to fix this if possible.

Thanks
Praveen


--CDALsHaN7pkIUjoc1Fm8FVlUuomPclGPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVoVsAAoJEM4fnGdFEsIqF/UP/juLFMNrh6hyiEqiig03fJ4k
CVJlR6QVjm9kbPU1WEGY9hjqf0DzvqbE+Iw7b1cXDVPYJp3nimXMD0sqorxTOjf2
nhCJL7i1wA0loELz3d2UMGfxfDtW7ZD3EQcn/okBAPtv2S6yY7QC5d+torKVPGU/
VH3K1zufyeOUomXLPdm9hwE0KmTMX93Xb8GXEHAtAFUHU/rhIvuzoR1NkoLe1vtx
S/fO7XsKJ5kqkQbsQNjIvRQHehAZAfLTY9fMqlccZtVNtG4n5Bo0MIb1xUk86M2I
iWCeAZ04be2GXtNq6DdzTr/7LjEjkTMX8HkiW/FdAr5pQldJgsDN2dpVQGsEjKke
MbfhLgMStQNGNwbrw5QV3YI6+aonnf4gZAtMaimMf+1Gdv112vZ7JJ11OfHtGd3t
L5yzORhk8NZC2ZuGq4+s+3NkWZGAXxYAnSXjy08jhl259rBZygHMfyVFLB3KG53o
qnDg5OP9PD/qp9if3WCcDX6kBcBVI+aaH/3+jXeNBy3HbcAOZ9KnSFRm7MhOEw9f
NQLJ7cLO1xhNkH426ClyZqTyXamaseGrtOb5KJ/JshQkn5s09YQMU5m0aSkcKY3h
mJUJkQVryd0hVyzY3cplJj+lnaySFWE/IwQ9tWUdmrQKLc7UznW9Y9G2WT9DWaEZ
ey8+2ZtQBS1Js2+JROCY
=PK5U
-----END PGP SIGNATURE-----

--CDALsHaN7pkIUjoc1Fm8FVlUuomPclGPw--
