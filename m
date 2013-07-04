From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] commit: reject invalid UTF-8 codepoints
Date: Thu, 4 Jul 2013 00:17:24 +0000
Message-ID: <20130704001724.GQ862789@vauxhall.crustytoothpaste.net>
References: <20130629174023.GB226907@vauxhall.crustytoothpaste.net>
 <7v7ghcl50r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o99acAvKqrTZeiCU"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 02:17:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuXEv-0002M8-7h
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 02:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab3GDARd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 20:17:33 -0400
Received: from qmta06.westchester.pa.mail.comcast.net ([76.96.62.56]:43945
	"EHLO qmta06.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab3GDARc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 20:17:32 -0400
Received: from omta09.westchester.pa.mail.comcast.net ([76.96.62.20])
	by qmta06.westchester.pa.mail.comcast.net with comcast
	id vzpl1l0020SCNGk560HXkQ; Thu, 04 Jul 2013 00:17:31 +0000
Received: from castro.crustytoothpaste.net ([173.11.243.49])
	by omta09.westchester.pa.mail.comcast.net with comcast
	id w0HW1l00G14fh3h3V0HWtp; Thu, 04 Jul 2013 00:17:31 +0000
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 16FEF28074;
	Thu,  4 Jul 2013 00:17:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v7ghcl50r.fsf@alter.siamese.dyndns.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-rc4-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1372897051;
	bh=TvkeGm1UJLXPXAF0MkRski0CpGbdWF7MsZOVnHWsSaI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=nEjxDeKQENXt98nKmB21C87dMatlmYD9Wi1yQBooMmq30TBSeue/w7lZuRXAmGu6x
	 pYt1RJJkYwAFCUP5D9oXm2LbylcTb9Mm8eUMuYGaQTCqZARqo6HFsG51xdddJyRqG+
	 fIwM7PIPT7Andx+QPykjD3ruv5c4s3dAuJQKTbHuVpZmH2qCB1tWepM8GfRyCodzRB
	 tXBgTwDJCv2wiIbMxNKRBuN7PTVrNMzO8QhwyJyF4IXy1oFt5l/KiRXFgHsySv9fgh
	 bfGflV5rjsGMRO1+HrBt6O/eTUSYZF8ZTP70KFzRVhV2Q5qsZLDb69JpZpVU/dOyz2
	 9JSBv9jxgxfXg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229552>


--o99acAvKqrTZeiCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2013 at 07:13:40PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > diff --git a/t/t3900/UTF-8-invalid.txt b/t/t3900/UTF-8-invalid.txt
> > new file mode 100644
> > index 0000000..343684d
> > --- /dev/null
> > +++ b/t/t3900/UTF-8-invalid.txt
> > @@ -0,0 +1,3 @@
> > +Commit message
> > +
> > +Invalid surrogate:???
>=20
> I suspect that I did not receive what you intended to send.  Do you
> want to send this part as a binary patch perhaps?

git format-patch --binary seems to produce the exact same output as
without the --binary option.  Is there a different way I should be
selecting the binary option?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--o99acAvKqrTZeiCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCgAGBQJR1L8UAAoJEL9TXYEfUvaL4WAP+QH1slR0RzsBgY4usnCY+tE1
qBo6Qelp6+0xJ268aU/GIMPE2hfup37hPeKXGgoIWWja59Vu+u0IR+GvfvCliqor
lavZYnurBWbLXQxiyyUTiSpJJm/KItVeAduJZ+rz7cPgDoHqCKcEgmZ4jp8v9fSa
9+iRXQI3wFJLkaqAvbT5Iuy0qxilM1nBP8qWd9haZfnTCxtj0YqJhXVRWGgDCWds
SUPEpTbZA+TfAcmJ4HDr9OLZ/F5xVFu1RKykzISyyjtOv2A1T8M+KkYr4eZe8Q8g
UFIiN0XRxiD4yr+UHaM/HZ3o4bCbWbGnT1j68W4S7zG62P5eP3Esc0ZJ2Wuihn2g
EPnqNPgO9PSL9+zyKWfDICEPbl2O88ApuJTDe02Wj0s6JDprnrKhlmsmP0W+B6hX
8luzp3CD0p4DdwlorQJmmDtXpm+lIvBY17yeOgKj/IHEm5xhzOhNE2jHYNsnXS2K
+NZy4+67xZu5701F6pTwoeXu6vq+6tCHSLwAYqxKnxOQMM/edkbjK1yifC0ibxFL
CGbOyFHqZyd0JtT+vqxkO/FJOcPRnmEs0Labou2lN8eDRjc9SOmNLgEIzD3wRtPa
itxzjW5kk/MOxc0WGDSHdOLUqelr9kgamM05mD/uXLCPb7GwEdC+rZ5tIRqToSpe
0xOyfxiTSQRe6JoIM6XL
=wIqH
-----END PGP SIGNATURE-----

--o99acAvKqrTZeiCU--
