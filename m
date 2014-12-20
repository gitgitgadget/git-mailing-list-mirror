From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] list-objects: mark fewer commits as edges for
 non-shallow clones
Date: Sat, 20 Dec 2014 22:18:03 +0000
Message-ID: <20141220221803.GB137570@vauxhall.crustytoothpaste.net>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
 <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
 <CACsJy8DM17je-FJ7vq3SFZJWPL5KbZ=kE=iTFQ0X0bZUpKuNmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 23:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2SLq-0005pA-0b
	for gcvg-git-2@plane.gmane.org; Sat, 20 Dec 2014 23:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbaLTWSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2014 17:18:12 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55855 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331AbaLTWSL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Dec 2014 17:18:11 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BB7072808F;
	Sat, 20 Dec 2014 22:18:06 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <CACsJy8DM17je-FJ7vq3SFZJWPL5KbZ=kE=iTFQ0X0bZUpKuNmg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261606>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2014 at 05:51:54PM +0700, Duy Nguyen wrote:
> I'm glad it's now working better for you. Out of curiosity, have you
> enabled pack bitmap on this repo? I would expect it to reduce time
> some (or a lot) more, or we would find something to optimize further.

The client performs much, much worse with pack bitmaps.  The server has
bitmaps enabled, but it doesn't have any patches for this issue applied
to it.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUlfWbAAoJEL9TXYEfUvaLLhsP/RWKd9lxNN5cHbF6nSlDzIFV
zl87WLusjG/Gb3ucnodxRJDSAM33XHuZJjKgmd335qsUtiUVFXBDhj7xk6tiohf0
raYNbWOD8YOnp3Z/74/YcdQLkWsY0FWPWfpKDEmiN9CH6sNik5ze8nuVPM3niQE+
/R6oie+LD6vT+CyXwDOSpe2GAP7wct0Nub582dluC/zIdYTftIaAApUDLgWmK6K3
/q73RkkRsnQ2mPU1HEX9/4j1hr7aeynRLg5SQdXbhmnrBULBpqmcZPx4NurrYFnL
WuhRBDcC9NX4vz2DJ5dU2uvZDlVWFI71FXYffKgCAkO0Xu9AQgpeGta7hP0kJnz4
NiCjz1gKvyuTzc1Cfa1IomPJ2IIr7g8NxQbT0j/2ct3KSP6+z4RP8A0uHNkkIOmO
MNkNUGlYDNLIzmhiINs/hb+fq7fb4xLp6b/WdET/sigeGy5hsd6JHoj4xghN7nEq
7AkTQt/E153689Vp5zzHdfzzlWMhjhBxE83PVSFt907buQ7JMhE62MR3tSa0aM4k
rLQd8OpJ7Vz7iEItNwsz+mfpsdsoVM+ZL0R6oTm1Lb2tK4ciBy+teREhB+zA68/3
aOz+s1UaJpCl1wgCboUIGWbO9ENYHPhAsx4684Cg1rI0KMSgJXmUHA7ZJKrT8fId
mNpld1LAqnkcczXkHhEa
=pt/V
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
