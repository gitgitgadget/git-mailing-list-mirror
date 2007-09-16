From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] New strbuf APIs: splice and attach.
Date: Sun, 16 Sep 2007 22:51:36 +0200
Message-ID: <20070916205136.GE26457@artemis.corp>
References: <20070916172134.GA26457@artemis.corp> <20070916172233.8B8AD1835F@madism.org> <874phugy6h.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Ns7jmDPpOpCD+GE/";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sun Sep 16 22:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX15l-0001dR-Rn
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbXIPUvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 16:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXIPUvl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 16:51:41 -0400
Received: from pan.madism.org ([88.191.52.104]:39053 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbXIPUvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 16:51:41 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 2ED0B20333;
	Sun, 16 Sep 2007 22:51:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 40F983565; Sun, 16 Sep 2007 22:51:36 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <874phugy6h.fsf@mid.deneb.enyo.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58345>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 16, 2007 at 08:20:06PM +0000, Florian Weimer wrote:
> * Pierre Habouzit:
>=20
> > +void strbuf_grow(struct strbuf *sb, size_t extra)
> > +{
> >  	if (sb->len + extra + 1 <=3D sb->len)
> >  		die("you want to use way too much memory");
>=20
> By the way, this comparison is always false because sb->len is signed.

  News to me. Actually it's not, it's a size_t :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7ZdYvGr7W6HudhwRAo3FAKCO2s+2ilnXyO6l74FcDKPsFedGSACbBGJb
axqfqkwFXq2+Lu3G1uKb9r0=
=W3On
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
