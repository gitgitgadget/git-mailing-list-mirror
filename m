From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/3] git send-email: make the message file name more   specific.
Date: Mon, 03 Nov 2008 09:53:37 +0100
Message-ID: <20081103085337.GB13930@artemis.corp>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225456609-694-1-git-send-email-madcoder@debian.org> <1225456609-694-2-git-send-email-madcoder@debian.org> <7vwsfm3b33.fsf@gitster.siamese.dyndns.org> <20081102093533.GE4066@artemis> <alpine.LFD.2.00.0811021629110.25369@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="6sX45UoQRIJXqkqR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 09:54:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwvD2-0001xl-Ni
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 09:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811AbYKCIxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 03:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754772AbYKCIxj
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 03:53:39 -0500
Received: from pan.madism.org ([88.191.52.104]:45821 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648AbYKCIxj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 03:53:39 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 0E95B3BBA8;
	Mon,  3 Nov 2008 09:53:38 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2DA0355AC1C; Mon,  3 Nov 2008 09:53:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811021629110.25369@sys-0.hiltweb.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99914>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 09:34:53PM +0000, Ian Hilt wrote:
> On Sun, 2 Nov 2008, Pierre Habouzit wrote:
> > On Sun, Nov 02, 2008 at 06:18:08AM +0000, Junio C Hamano wrote:
> > > Having said that, if we were to do this, let's do it the right way an=
d put
> > > these "temporary" files under $GIT_DIR.
> >=20
> > Agreed, I should have done that.
>=20
> Perhaps like this:
>=20
> 	my $compose_filename =3D $repo->repo_path() . "/sendemail.msg.$$";
>=20
> where $repo is a repository instance.

$repo is a repository instance, I'm waiting for all the comments to fade
up to take them into account and resend a proper series.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkOvBEACgkQvGr7W6HudhxgxACdEK6zBQ4kh6ESCJIyMZdlzbkj
IJwAoKS2/Oi4peplevAYR6nOTFwWzjKR
=3FKj
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
