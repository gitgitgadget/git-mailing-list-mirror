From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Track /etc directory using Git
Date: Sat, 15 Sep 2007 17:27:24 +0200
Message-ID: <20070915152724.GC27494@artemis.corp>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com> <20070913123137.GA31735@piper.oerlikon.madduck.net> <38b2ab8a0709140108v2a9c3569i93b39f351f1d4ec3@mail.gmail.com> <20070914091545.GA26432@piper.oerlikon.madduck.net> <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com> <20070914212643.GA10970@amy.inscure.wireless.home.vilz.de> <20070915142932.GB27494@artemis.corp> <20070915152455.GA16223@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="QRj9sO5tAVLaXnSD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Nicolas Vilz <niv@iaglans.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 17:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWZYP-0004Mi-Vf
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 17:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbXIOP10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 11:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbXIOP10
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 11:27:26 -0400
Received: from pan.madism.org ([88.191.52.104]:56103 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbXIOP10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 11:27:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 39A181FF20;
	Sat, 15 Sep 2007 17:27:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5AF9110329; Sat, 15 Sep 2007 17:27:24 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	martin f krafft <madduck@debian.org>, git@vger.kernel.org,
	Nicolas Vilz <niv@iaglans.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070915152455.GA16223@piper.oerlikon.madduck.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58256>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 15, 2007 at 03:24:55PM +0000, martin f krafft wrote:
> also sprach Pierre Habouzit <madcoder@debian.org> [2007.09.15.1629 +0200]:
> >   I fear that you'll end up with quite a big bloat of git, for a use
> > case that is fairly limited.
>=20
> I think it doesn't get bloated until you try to support the model of
> tracking different stuff for different files in the same repo. If
> you just track one set of data across all files in the repo, I don't
> think it'll cause too much bloat.

  Yeah but if the stuff is opaque to git, you'll definitely end up with
security issues, which makes it also a no-go for /etc versionning.

  Note that I don't specifically care about git being able to deal with
/etc, I was just pointing out some issues I can see with it, but I'm
neiter in favor nor against it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6/ncvGr7W6HudhwRAl9KAKCH/OstUrz/q4L4EcTOtjGGJ43c0wCeMJ+r
gVyt/pttYAv1Ofkcp8HeSUk=
=Mh2O
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
