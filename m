From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 07/15] remote: die on config error when setting URL
Date: Tue, 2 Feb 2016 13:00:03 +0100
Message-ID: <20160202120003.GA22942@pks-pc.localdomain>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
 <1454413916-31984-8-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 13:00:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQZcz-0007sk-9T
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 13:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbcBBMAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 07:00:07 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54145 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163AbcBBMAG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 07:00:06 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 9B3D720FC3
	for <git@vger.kernel.org>; Tue,  2 Feb 2016 07:00:05 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 02 Feb 2016 07:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=eUWjEzwUHMFMaN6gHDH/UCnjaBM=; b=ZWpvq
	eNeJ1zQVyg+1WA+H3NZMT31nJYFXNPP9+GDSviBH8epWlqtaIorvhY9wwT0sN9og
	Vsos9m3bf4VZydlfpm+p3dZgR9LNESG+NfmdpWvWNwyCHbvrmwMbmcI4HL47e4f6
	b+lP/G7nG/inYpgYJPNr044gjW5u8WRLetOAJo=
X-Sasl-enc: z8LyNPZjqmkkaoJSJuG19Jl7gpZup/aWAq8De1qxRY4C 1454414405
Received: from localhost (f052008117.adsl.alicedsl.de [78.52.8.117])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0D17AC0001D;
	Tue,  2 Feb 2016 07:00:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1454413916-31984-8-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285266>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 02, 2016 at 12:51:48PM +0100, Patrick Steinhardt wrote:
> When invoking `git-remote --set-url` we do not check the return
> value when writing the actual new URL to the configuration file,
> pretending to the user that the configuration has been set while
> it was in fact not persisted.
>=20
> Fix this problem by dying early when setting the config fails.
>=20
> Signed-off-by: Patrick Steinhardt

Signed-off-by: Patrick Steinhardt <ps@pks.im>

Sorry, borked up that signed-off-by. Will fix in a later revision
(which I guess will be necessary anyway ;).

Patrick

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsJpDAAoJEBF8Z7aeq/Esl40P/356muzYE6Hvd5bkeqDOu620
plerS++B0xDdVh3qA0FeTdHuTAi4yRxYhdpn6I3E3bRCjLgKnwH4EIifLzP1ceQJ
xK0t9RjjREDO8CyN3kvYnXKITmpHrq15v/E2ztw97pAh8ZE3VmFYSzRDUpZ/1vkA
5Y2ruChsVVtNFlD0DMdL3rJ6XBSaRstSKanKf+F0/5aysR19oM1sM4t0ptAaNU0F
cLi/Ig9G1nMwEZx6G1Y+IX3VcPWaHIckmZ6jgWpn/iqZpocS/E9+3aXgmXhDpoaq
kzxyP2+TnPYnxxX9ppxfa9BG5I+kTehkUq90bFNOcYEEOn9mtgp7adxunqBQONke
6OZ4iwiFsjEx/co1ooq3PG5k1h97tYVUiTaukZnKF715V7miAG9+q7+eNogFtAPD
jiU9r+L4r4IASYLUGxMHISiac5gAhPhFBhuD6LDaL5GxDS0cUjyiOGY4/2GEoGT1
jEkku1BGmifAFmWaj+JrxaAb53OJZamYyEfwp4oex2KvMyM6JiOXUdyxyUZkfwfy
2L6oLDDfY9U9nze2mSSapcg8VPW+swuCCXv1C1VUKhFkB88kSOrZY5Q9ULuV55VH
s3DnBCYulMc1QKz/Cbhp8ue6rkqHR/GmmKF2Fe88x5z6oKeKBhHzaVIpbUahMVlR
6Q1L9D3I967AuoN7RZhr
=5omk
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
