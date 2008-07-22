From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [SCNR] Re: [FYI PATCH] git wrapper: DWIM mistyped commands
Date: Tue, 22 Jul 2008 22:34:22 +0200
Message-ID: <20080722203422.GC11831@artemis.madism.org>
References: <alpine.DEB.1.00.0807222100150.8986@racer> <20080722201648.GB11831@artemis.madism.org> <alpine.DEB.1.00.0807222118030.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="qtZFehHsKgwS5rPz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:35:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOZx-0000Bz-6F
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYGVUeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYGVUeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:34:25 -0400
Received: from pan.madism.org ([88.191.52.104]:58439 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbYGVUeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:34:24 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D7C5D37454;
	Tue, 22 Jul 2008 22:34:23 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C1A38CDF7; Tue, 22 Jul 2008 22:34:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222118030.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89524>


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 08:19:13PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 22 Jul 2008, Pierre Habouzit wrote:
>=20
> > <SCNR>
> >     Or use a decent shell:
>=20
> I tried that:
>=20
> 	git reab<tab><tab><TAB><TTAAABBB!>

It yields the following here:

    $ git read-tree
    ---- corrections (errors 1)
    read-tree  -- read tree information into the directory index
    rebase     -- rebase local commits to new upstream head
    ---- original
    reab

and indeed, it should really suggest rebase first, I suppose I should reord=
er
my zsh completion error weights. but oh well...

> > Despite that, I really like your idea. **hint hint**
>=20
> I said that _I_ did not mean it for inclusion.  **hint hint**

Damn...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGRE4ACgkQvGr7W6HudhxMlgCaAhmhv7uMJ8nbVjK0sZZGkFPc
0OQAnRPc/hLN/dN3gqTV8tYSWJuaW0nE
=4wWi
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
