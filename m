From: Pirate Praveen <praveen@debian.org>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 19:48:22 +0530
Message-ID: <552E732E.20107@debian.org>
References: <552E628C.7040809@debian.org> <552E6D07.5030903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VQQdf4NkI54pemMC9UuJHTLDnxhNAmNdi"
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 16:18:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiO9H-0000eZ-KX
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 16:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbbDOOSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 10:18:34 -0400
Received: from latitanza.investici.org ([82.94.249.234]:63213 "EHLO
	latitanza.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbbDOOSc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 10:18:32 -0400
Received: from [82.94.249.234] (latitanza [82.94.249.234]) (Authenticated sender: praveen@autistici.org) by localhost (Postfix) with ESMTPSA id E7132122A36;
	Wed, 15 Apr 2015 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=debian.org;
	s=stigmate; t=1429107510;
	bh=10c+u1UPX4RZcREW5dGIUFY7BeShceOMclKJywMO6mE=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=TQm4x+fXEgPAdSWMW5g4MAZe2/0qjplYIZ0Utf+pQNJZSKI4mcGNANuCTLtvLj3XB
	 2wlmXPFS6VH8sI4FVqt6cVATthCAGaWAvCZOP9vuxqi34bxshhXLNwMumWe/f+vmNe
	 7L3uOeS71fg4FSuv2N1oiS3LMvA/cSmOpJL8Ro/c=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <552E6D07.5030903@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267200>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VQQdf4NkI54pemMC9UuJHTLDnxhNAmNdi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday 15 April 2015 07:22 PM, Michael J Gruber wrote:
> What would that require git to do, beyond taking whatever you tell it
> (using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for=
 ssh?
>=20
> Michael
>=20

May be support git+mosh as a protocol, since it is not a drop in
replacement. It is redesigned remote shell. The ideas it uses for
session resumption needs to be reimplemented. This will need support
from git, because it needs server side to be modified. Use SSP to return
the the current progress for a particular session (it uses AES session id=
s).

So when a client connect with a session id, git server side can respond
with the current state, how many objects received in that session, and
client can continue from where it stopped. Client also will need to
store session information.




--VQQdf4NkI54pemMC9UuJHTLDnxhNAmNdi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJVLnMuAAoJEM4fnGdFEsIqt9EP/3Rf4j1fJVnvwi5T00BUeyQj
486KOHffBfGAk4rYFIeURB3Uai/Aw2XWutg8leSLncPlAYud05RMmzMo5AN8M6LD
H3gNMkwWTAZODco4C2Bp+K55UqI22QA8CmfcPGlTj+wiPYGmyE4STq/Fz5vNsyYu
APLhTFoRJxnTQaiVfI9gLBLdhtRNi1y4MCbaN7uPAdWKVCWZZSMW7ZWBJYMKJ0RO
31EOxJoZ+2CMjbxoWDuVyA5l7SRzqhgYb19KgioUOLR7gJPMwoZlP7QxQ/ogFYEN
fwVvu3WnHK7ZMh0TgNpqRwe/nSLuLHjHJpKbcEYRjepVRazQUwJ1x9oGWneWOxUC
c24qJBsppEw6dZ+tAhZzbmj7bXCrfiOciGA12m0KzUcmU/E91hdQ3pYfHkPlS1Ts
2ZXXigABxoxfudJ5r0dS4nGDmy+bJ6dkcGMgYaKtjpW/GH9vidOa/OxsreaV1Ug1
Eau6NED0zaKGekkTJDrtjxEJ4PcUAXPXUG4eCxAkocsVzKLrretA5KRh7q5vACWQ
dzh0HDKrZnWPa4VCrypoPGO1j2tMuHpMmaVs6gj91ZawB242tX5OxOwVqg6PZMnO
uTyVwWn1ESrBvFydIFyyfN+IwGO0Nrqum0gy0Z+A63C9OajU82AAGTwbJoT+KX2H
n9qc5VdilhiUMwoH8ltI
=PXJi
-----END PGP SIGNATURE-----

--VQQdf4NkI54pemMC9UuJHTLDnxhNAmNdi--
