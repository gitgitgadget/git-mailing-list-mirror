From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC PATCH] Allow cloning branches selectively
Date: Sun, 25 Dec 2011 19:00:53 +0000
Message-ID: <20111225190053.GC6361@beez.lab.cmartin.tk>
References: <1324671199-7074-1-git-send-email-cmn@elego.de>
 <CACsJy8ANZvkY+na-tM95prHEfXD+N2OT8+3NLeccycGL1BmbCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 25 20:01:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RetJf-00050A-RC
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 20:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab1LYTA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 14:00:59 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:41715 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab1LYTA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 14:00:58 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id CA2AB461B9;
	Sun, 25 Dec 2011 20:00:48 +0100 (CET)
Received: (nullmailer pid 13477 invoked by uid 1000);
	Sun, 25 Dec 2011 19:00:53 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CACsJy8ANZvkY+na-tM95prHEfXD+N2OT8+3NLeccycGL1BmbCg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187687>


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 24, 2011 at 11:31:51AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Sat, Dec 24, 2011 at 3:13 AM, Carlos Mart=EDn Nieto <cmn@elego.de> wro=
te:
> > Sometimes it's useful to clone only a subset of branches from a remote
> > we're cloning. Teach clone the --fetch option to select which branches
> > should get fetched.
>=20
> What about tags? Are all tags fetched or only ones part of the
> selected branches?

I haven't really touched that part of the code, so I think it'll fetch
every tag, as that's what clone does by default. Certainly something
that should get fixed.

   cmn

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO93LlAAoJEHKRP1jG7ZzT5LkIAIDA8cxvtRe0CbGjBs54pK4N
/ma/IT2FPlIJonnhwIF4nqYA7VzLP82wKzCj4j6uCcf0tNhuJro+dafnxsus+HT7
rRqLSCMeLMpmRRezgrihyGlYIMzQIREQoO7ai71nJEIdCp76Qvq7FXu/IkxJZ5ij
4Ey6b1VRUhNKs8fK8LevwGZt6Kgs7+TEevPk+rQpHAkBWAi7v2yYuVNfuEDbJGBe
HWKcU1dqKtd8KWg7fMayrVP5eT9ZrbDi54D4qAPbzs5A9WhePctdlAZkFOXDrLyw
G5ARJb34W4sNrfb1xKDPT6HCvnu1ppB1SM5lxHkE+ANRAfWO//8V5+YfoxVhobc=
=fbf2
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
