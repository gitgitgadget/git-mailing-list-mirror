From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] patch series to sketch a less verbose and frightening output
Date: Sat, 29 Sep 2007 12:49:45 +0200
Message-ID: <20070929104945.GB4216@artemis.corp>
References: <20070929090121.GA4216@artemis.corp> <1191062758-30631-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="St7VIuEGZ6dlpu13";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 12:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZtV-0006ZZ-08
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 12:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbXI2Ktu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 06:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXI2Ktu
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 06:49:50 -0400
Received: from pan.madism.org ([88.191.52.104]:52680 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755523AbXI2Ktu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 06:49:50 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3576222590
	for <git@vger.kernel.org>; Sat, 29 Sep 2007 12:49:46 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D846049CF; Sat, 29 Sep 2007 12:49:45 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1191062758-30631-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59458>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 10:45:54AM +0000, Pierre Habouzit wrote:
>   Follow 4 patches that rework progress.c a bit so that one stage only
> takes one line of output with a progress bar.
>=20
>   Some of the patch fix (IMHO) pointless lines to print on screen (even
> for debugging purposes).
>=20
>   With those patches, running git gc looks like:
>=20
>     $ git gc
>     Counting objects    : 10095
>     Deltifying objects  : [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 100%
>     Writing objects     : [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>                        ] 50%
>=20
>     [...]
>=20
>     Counting objects    : 10095
>     Deltifying objects  : [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 100%
>     Writing objects     : [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 100%
>     Pruning objects     : [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 100%
>=20
> I don't believe those patches are 100% okay yet, because it doesn't
> plays that nice during a clone (it's not horribly broken, merely
> surprising). But it sketches what it could look like.

  Okay, sorry this was supposed to answer to
<20070929090121.GA4216@artemis.corp>

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/i3JvGr7W6HudhwRApTiAKCfC54BFFYR4toxi/lEhw6MpFvYKACeKQef
wp6iJZcHDWi/kXmKvzp1BrM=
=9wbe
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
