From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Thu, 19 Feb 2015 20:35:57 +0000
Message-ID: <20150219203556.GC5021@vauxhall.crustytoothpaste.net>
References: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
 <1420676960-492860-1-git-send-email-sandals@crustytoothpaste.net>
 <7930FE25-8206-43A8-9678-C56D789E09CE@cisco.com>
 <xmqqk30hyock.fsf@gitster.dls.corp.google.com>
 <CA01B76E-F3D4-40AC-B524-32BFBA930108@cisco.com>
 <xmqqa90cxg89.fsf@gitster.dls.corp.google.com>
 <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: "Dan Langille (dalangil)" <dalangil@cisco.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 21:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOXpP-0005Nt-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 21:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbbBSUgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 15:36:03 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49015 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751795AbbBSUgB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 15:36:01 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:e5aa:2c88:b0cf:ba1e])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 550992808F;
	Thu, 19 Feb 2015 20:36:00 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <1B14107C-FC87-4F69-AEBE-9EA1BAF50A17@cisco.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264113>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 04:17:46PM +0000, Dan Langille (dalangil) wrote:
> I just built from =E2=80=98master=E2=80=99, on FreeBSD 9.3:
>=20
> cd ~/src
> git clone https://github.com/git/git.git
> cd git
> gmake
>=20
> Then tried ~/src/git/git clone https://OUR_REPO
>=20
>  It cores too, and I see: git-remote-https.core

Can you compile with debugging symbols and provide a backtrace?  I'm not=20
seeing any such behavior on my end, and I'm not sure whether it's my=20
patch or something else that might be present in master.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU5kksAAoJEL9TXYEfUvaLEWEQALjT+VMXe3sQC+VmoZ++iQoP
2szOZVvfJkI1sVawsf3t2YmJdbhLekKckQREqQbbnNiuYEDaLhf0PEtR1t6o/peL
fITOCDGxEWjlAlyvgH2YwfG+UNVwESRVre8impNjwlqF0XvZHfAIukXIigP2g1sX
0o4ODa80YDPsdgj6MUP/b4uhxc7aWXOrf/lo0yvtSbzy5hp0sUVU/vbFxdgmZnGy
RM/cA8gJgipcFq9znU+PWsBMpf8YvUaTM2Fm2zbQ8OBwR4/AUxdG9YjVL3lXdhdH
sx62mxK+En+s1Iv2NS0GvMVjLpECZRuTTml+IZPRIjYTfEU3At9cCQhFvmo7vgnE
4slM4tVKw87QFulQcERi7E9tVHUwpiHYT4uQTyolqGAzUBkMuwNNbtY0K2y+OJuU
wD3wBSbuQrEI5vOh6NaZ7eBjZ6H/hzF7jMGamvNfw05sMxPui0OuO5TP/0VdFU9U
6fTVTGXspL7x339jU/7quCDxR0K8q0Vx9MNeyGf2AGBCxU6vg/kdCRTxJw4Nhmwl
8gJ2R3axdP4MasNb9tlwwFm3vij1elw5AS4kERRH2GORTu6BDVmQrsmde8pOR0Yk
qfi9VDAtmMC2BuudOjlUYOyNnmLNQA/QzG5AODroPCXtErw/w8YQR4PvOwdj3hiH
+ZDuUkVHMS/3r/Lyh+LA
=huI8
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
