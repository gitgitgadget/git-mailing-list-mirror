Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3A1A8401
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389189; cv=none; b=pyD13Bfx+Z/LHVKm/oSyA7T/z8S+JgqaD0lDPrInQifrycHZuuaYWml1a7ODHoya1jPaGSy9183jR7TijoUCJKkRu1WjNQnVMY1jRt6NYScBq6yMFtXMgOl0/E3IWMKkcmhQ6bXKS6MLQvoFbi7tXJvsgVitjioGiQ07gdhq7Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389189; c=relaxed/simple;
	bh=bEQPMvQTxNNU26jAWaNbf31f3UjNjD1xvXYbiF++EWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvShQoIeMa6j/AIyO5r+svW52F4OHc4X5WiKqUwbyovwiTHx7Imim3CQDWTzBQewfZpwv4rt0UhnSjLfmk+ATiLBbSmJtrW81fRPxQSQ/4SQ21cUsa03pYGB9Fs6T25JFlJ/JFLgkPx2iq6TmZNac+1K5RRFOex9l4SDaHXKiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Y931rEoZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Y931rEoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751389179;
	bh=bEQPMvQTxNNU26jAWaNbf31f3UjNjD1xvXYbiF++EWM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Y931rEoZi/s2CtHgyE1m6eTrwSnYbxArauc/5vYQFSXyFC5g601vLQYPp8es2EdMa
	 EAg7c+DRdnnY40wAT01JrF0rXyNly5vtNb/G0VkSaX9QI//w4I2DioPtopUxez5P5q
	 EeAWRPpREgEn/cxXJMMypd6quK4JP0MVtOD6IPvMDSNLfBz9jDA9l6UTcTgJt/IQ7n
	 nz2xzGZkSJfyJZJbAz7fFwnuxDjXizTO/76OpLa2qwe+7dUpfjM4unC9SfcvL36rRt
	 c8TtFeQ6Lhm3xHSCe04hSH8f/adxgo11m99eUfZgt08BArjWPs85F9IjYTKmwP3gQk
	 9BHTgHIQf3tIvObyXu7ckIAb0JUxRULMQYmmMtPcEAm78yF73znqDp0SMdtGqrjtB5
	 oc/nMN2mL8x0WVGiB5tt5Pz6VLT/4B2JDaUSv9ekR5bA/I2XzIg+a0t11p1ggN007Y
	 Rl56cRkK9feXhtzzbBlozErY1Hzgt60q9WABGPix4tnBwntYC8o
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a75c:9d59:319d:c156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C472420067;
	Tue,  1 Jul 2025 16:59:39 +0000 (UTC)
Date: Tue, 1 Jul 2025 16:59:38 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
Message-ID: <aGQT-svTIIgXdb6X@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJkVb/EKzV67uP6O"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YJkVb/EKzV67uP6O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-01 at 15:49:10, Aditya Garg wrote:
> Hi

Hi,

> I am having this issue with Git for Windows that in case I configure a cr=
edential helper by following the git
> credentials documentation (https://git-scm.com/docs/gitcredentials), the =
Git Credential Manager still pops up.
> I simply close the pop up window, and then it seems to be getting the pas=
sword from my credential manager.

I think this is because Git allows multiple credential helpers.  It's
likely that, as you mentioned below, the Git Credential Manager is
actually in the system file and the one you've specified is just
interpreted as an additional helper.

> I removed it using git config --edit --system, but after every update, it=
 pops out again.

Is it the case that it gets re-added to this file on upgrade?  That
would explain why it keeps showing up.

> I wonder if some proper fix is there for this.

Ideally, you'd configure Git for Windows not to add this helper.  I
think there's a configuration option when you install it.

If you can't or don't want to reinstall Git for Windows to reconfigure
it, you could try setting the `credential.helper` option to an empty
string and then configuring the helper you want.  For instance, it might
look like this (not valid for Windows, just an example):

    [credential]
        helper =3D
        helper =3D libsecret

The empty string resets the list to remove any existing helpers and then
you can append whatever values you want (in my case, libsecret, but
again, that almost certainly does not work on Windows).
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--YJkVb/EKzV67uP6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGQT+QAKCRB8DEliiIei
gaPAAQCh8yBcBzFNYDJLakPhMb+LC779xFhGhMq35KKZUi+ncAEAlmqyMJf1Vmq/
muxtg2qLNmxlwxe3iCT04SKyR1ZNfwo=
=WgF6
-----END PGP SIGNATURE-----

--YJkVb/EKzV67uP6O--
