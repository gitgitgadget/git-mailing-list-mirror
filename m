From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal   supports it.
Date: Mon, 22 Oct 2007 14:11:06 +0200
Message-ID: <20071022121106.GA7151@artemis.corp>
References: <20071022081341.GC32763@artemis.corp> <471C6510.8010300@viscovery.net> <20071022112401.GE32763@artemis.corp> <471C8B02.6080202@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="BOKacYhQ+x31HxR3";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 14:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijw7w-0004uZ-05
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 14:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbXJVMLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 08:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXJVMLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 08:11:09 -0400
Received: from pan.madism.org ([88.191.52.104]:49889 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbXJVMLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 08:11:08 -0400
Received: from madism.org (def92-8-82-236-12-71.fbx.proxad.net [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6BE1E26473;
	Mon, 22 Oct 2007 14:11:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id BF9A33CC23E; Mon, 22 Oct 2007 14:11:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <471C8B02.6080202@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61995>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2007 at 11:35:30AM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> >On Mon, Oct 22, 2007 at 08:53:36AM +0000, Johannes Sixt wrote:
> >>Pierre Habouzit schrieb:
> >>>+say_color () {
> >>>+	[ "$nocolor" =3D 0 ] &&  [ "$1" !=3D '-1' ] && tput setaf "$1"
> >>>+	shift
> >>>+	echo "* $*"
> >>>+	tput op
> >>>+}
> >>What if tput is not available, like on Windows? How about this (at the=
=20
> >>end of the file, so it can obey --no-color):
> >  I answered to it already in my first mail: if tput isn't available,
> >the command fails, and $? is non 0. and nocolor is set. Or color isn't
> >set to 't' for your proposal.
>=20
> I was too terse, sorry. I wanted to point out that if tput is not=20
> available, the second invocation will leave "tput: command not found"=20
> behind on stderr. Therefore, I proposed to make the definition of=20
> say_color() different depending on whether $color is set or not. Then you=
=20
> don't need to test for $color twice inside the function.

  Right we can do that. I'll try to rework the patch. and no it
shouldn't leave tput: command not found as I 2>/dev/null and I think the
shell doesn't print that in that case. At least my zsh doesn't.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHJNavGr7W6HudhwRAid7AKCmIfq15uI/SunHlL1dGyHyXfsrYACgp0Lq
GeXwNNYuGZkRBb7hQvsKgA0=
=LAzQ
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
