From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 09:35:28 +0100
Message-ID: <20080130083528.GC8698@artemis.madism.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <47A01162.7070503@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="NKoe5XOeduwbEQHU";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 09:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK8QL-0007h9-Kl
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 09:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbYA3Ifb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 03:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbYA3Ifa
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 03:35:30 -0500
Received: from pan.madism.org ([88.191.52.104]:48968 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754355AbYA3Ifa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 03:35:30 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 53B19311B5;
	Wed, 30 Jan 2008 09:35:29 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 9170A142339; Wed, 30 Jan 2008 09:35:28 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Sam Vilain <sam@vilain.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <47A01162.7070503@vilain.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72053>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2008 at 08:50:33AM +0000, Sam Vilain wrote:
> Shawn O. Pearce wrote:
> > I just read the GnuPG manual and you are obviously correct.  The only
> > way to get GnuPG to process a key is to load it onto a keyring.
> > We could extract the armored (or binary) public key and load it
> > onto a temporary keyring created just for the purpose of verifying
> > this connection, but that's rather messy.
>=20
> It should be fine just to throw the lot into a single keyring, and just
> check which key verified it after the fact and whether that key was allow=
ed.
>=20
> The Perl Crypt::OpenPGP module doesn't suffer from this problem (and is
> performant), though it suffers from a dependency stack that will hurt
> everyone except Debian users ;-).

  Actually, if it's engineered like libgpgme (gpg made easy) is, well,
it basically wraps calls to gpg, a thing that we can do ourselves easily
usually :)

  And here is the tool I mentioned in my other mail and forgot to give
an url to: http://kitenet.net/~joey/code/jetring/
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoDbQvGr7W6HudhwRAvvTAJ49MkGv+AHhUAoRbzdAtniig4XV6QCgl1k2
n8P7Jpom1whLfxBrlZrOCNc=
=1Wyl
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
