From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 14:56:33 +0200
Message-ID: <20070929125633.GC32142@artemis.corp>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com> <20070929123724.01BB045EC@madism.org> <85ve9t8wh7.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ALfTUftag+2gvp1h";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 14:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbbsB-0000TT-Kh
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 14:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbXI2M4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbXI2M4g
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 08:56:36 -0400
Received: from pan.madism.org ([88.191.52.104]:47968 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbXI2M4f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 08:56:35 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 53DFA22480;
	Sat, 29 Sep 2007 14:56:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id A27AE445F; Sat, 29 Sep 2007 14:56:33 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85ve9t8wh7.fsf@lola.goethe.zz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59465>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 29, 2007 at 12:52:36PM +0000, David Kastrup wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>=20
> > -				if (strcmp(argv[i], "-z"))
> > -					revs->diff =3D 1;
> > +				revs->diff =3D strcmp(argv[i], "-z")
> > +					&& strcmp(argv[i], "--color")
> > +					&& strcmp(argv[i], "--no-color");
> >  				i +=3D opts - 1;
> >  				continue;
>=20
> This can clear a previously set value of revs->diff.

  Good catch, that should be |=3D of course.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/kuBvGr7W6HudhwRAhOfAJ9gdbndTgwqtyue/QFwNFB/p9uYywCfZ0vl
+bsgDUPVOXPoXg7nhRRNQZ4=
=FJNG
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
