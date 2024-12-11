Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD815661
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733897696; cv=none; b=IIjNzMWr5aqsWoAwEjGeHqcAXbN1Yqux9Eal8Hp8osBpLjWp1atBj32bzm/UYaf4DZjyMe/NheTUukCBtexhW1vMV7xzeRG3evSHeZyY6umEC90SV773kz4W3wd85bqz8si1pqUieUOSRlVHXvZ4Ve7QmyWC4gp1KbdDbUdArOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733897696; c=relaxed/simple;
	bh=BlSmG8qy2MlisU/mm9Xpnhs1nYwYbQp/FcArIZsgB/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uHEzB6j3e4frH9y9VAE5O/xDTOiLlKB2tz3HOVt/bKdUeY4PSOOb0cTurLc6eHIokBCvhoo2hCbp3+96dhFxnKvGTc2zzNqvFLCAOLo57XyfCRXbPq58/smxwqmHMM8c7k35C4hriuubiKIVW/LFwg840aganWOib4p+YRUxFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CDbYb9tk; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CDbYb9tk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1733897685; x=1734156885;
	bh=BlSmG8qy2MlisU/mm9Xpnhs1nYwYbQp/FcArIZsgB/g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=CDbYb9tkGzhWxlEOJ4HXeBNJYt+CFLN7L9V3N4Fqo8l1W5kTNcaZkcK+aRahgitUO
	 vyN9tUi4CXs9RUXuRhyozCZNc4ulzc+5ZWiiR+xoGBdG1Pg/Z3H+bEtZm6hDHw8jq+
	 t1cveRU4Ly5NVsCA/Dm+coaiJmNKBheFMivXILj8jdDhjDXAEkrnrDi0UaDsAqMzoc
	 R02tMbY/pjEYvmSX80tZOSOKMKdFUDKQl6BG8LoutKLWbLl5dNHL4GzAlz7fNTtHaY
	 AKhxSW6ysSNXTP85TMMvJ7e5CtZjOesacPklkip8xKmOuhL9XbMV26Iw/EcEJmTK1i
	 T4UpkDB4/1BfA==
Date: Wed, 11 Dec 2024 06:14:41 +0000
To: calumlikesapplepie@gmail.com
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git verify-pack --stat-only is nonfunctional as documented
Message-ID: <08q-qTFvcLocW4XT7FvsEByB5_1V1a1gGkKOtPQL-3BO2ILt9z2Xt29LFd10bqUyfS5KzDVRmPN1KfIeaLOCw0NeNJoQgxAfaELOLQ9UFEc=@proton.me>
In-Reply-To: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
References: <1ee9f3ef2bffd148b6225138135462d2d4a5928d.camel@gmail.com>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: 43e42d3a3e90c8b9ff751dcc8e6873091c900e51
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_D9eE98tagc19d34k9LJnI6hRFK0K90anwT0GqXcgqGU"

--b1=_D9eE98tagc19d34k9LJnI6hRFK0K90anwT0GqXcgqGU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512




My reply to =C3=87alum is interspersed sparse quotes bottom posting.=20

from A_bughunter@proton.me

Sent with Proton Mail secure email.

On Sunday, December 8th, 2024 at 20:39, calumlikesapplepie@gmail.com <calum=
likesapplepie@gmail.com> wrote:
>=20
> Both issues were likley added when `verify-pack` was refactored to call
> `index-pack`. It may be simpler to edit the manpage to reflect the
> current behavior, rather than conduct the needed refactoring of `index- p=
ack`. A patch that does this is incoming..

You know I say documentations is a good half the application. It may be eas=
ier to make the good half reflect the other but it may be better that the o=
ther reflect the good half.


> Thank you,
> Calum McConnell
>=20
> P.S. Sorry if this message seemed rude or too short, it's the second
> time I've written it, since Evolution decided to discard my message
> text.

Yeah doesn't that urk you? Imagine using android where buttons get pressed =
by accident, smart algorithims change focus, and latency makes taps miss an=
d buttons move. Terrible.=20
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmdZLc0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAALUWAP9e3LHx+d8m8f87v3tGNw5lO4SvGIGFG2TlFIYdhHifEwEA25ce
fkfmYQNa3esNYmqbTbdVL3Fr02y1PYzkJhYgCgk=3D
=3DEYvS
-----END PGP SIGNATURE-----

--b1=_D9eE98tagc19d34k9LJnI6hRFK0K90anwT0GqXcgqGU
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_D9eE98tagc19d34k9LJnI6hRFK0K90anwT0GqXcgqGU
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmdZLc0JkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAAvuAPwJ5S1f
j7vi2liVMdl7vCgahIpDI6Cyl49qRumwPMIsgwEA3Ad2GQog1CysJOYK2N+eGfbVe0ULPSrZA6gu
cHuhCA0=

--b1=_D9eE98tagc19d34k9LJnI6hRFK0K90anwT0GqXcgqGU--

