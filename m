From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: Changled submodule cannot be "git added"
Date: Tue, 15 Jun 2010 09:37:20 +0200
Message-ID: <20100615073720.GB3260@schottelius.org>
References: <20100615072514.GA3260@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 09:38:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOQjF-0005VM-VT
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 09:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab0FOHiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 03:38:19 -0400
Received: from mx3.schottelius.org ([77.109.138.221]:50503 "EHLO
	mx3.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab0FOHiR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 03:38:17 -0400
Received: from kr.localdomain (mx3.schottelius.org [77.109.138.221])
	by mx3.schottelius.org (Postfix) with ESMTP id 6592A197A035
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:38:16 +0200 (CEST)
Received: by kr.localdomain (Postfix, from userid 1000)
	id B0F76943CA; Tue, 15 Jun 2010 09:37:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100615072514.GA3260@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Netzseite: http://www.nico.schottelius.org/
X-System-Info: kr (Linux 2.6.34-NS-08528-gb3f2f6c x86_64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149164>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nico -telmich- Schottelius [Tue, Jun 15, 2010 at 09:25:14AM +0200]:
> And another interesting behaviour of git with submodules:
>=20
> -------------------------------------------------------------------------=
-------
> % git status
> #       modified:   modules/tftpd_hpa (modified content)

Ok, found out that I changed stuff within modules/tftpd_hpa, instead of
merging from the source.

Imho the git status output is a bit misleading, as I assume that
I can git add stuff that's modified.

Perhaps git add should print a warning / error if I try to add the
changed submodule and not silently ignore it.

Regarding the other problem

> - Why does git checkout not remove modules/ethz_systems_private/,
>   when switching from the master to the private branch?
>   (the module is only registered in the private branch)

I'm still not sure what's the reason for that.

Nico

--=20
New PGP key: 7ED9 F7D3 6B10 81D7 0EC5  5C09 D7DC C8E4 3187 7DF0
Please resign, if you signed 9885188C or 8D0E27A4.

Currently moving *.schottelius.org to http://www.nico.schottelius.org/ ...

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwXLbAACgkQ19zI5DGHffBcXwCdGFrCalmaCsiqpc3duHJeraY6
dhAAn1MoP6Wz9LGXScSJYF4U1VJRH8ru
=mWFo
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
