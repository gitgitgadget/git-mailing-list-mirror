From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal    supports it.
Date: Mon, 22 Oct 2007 15:45:41 +0200
Message-ID: <20071022134541.GA9776@artemis.corp>
References: <20071022081341.GC32763@artemis.corp> <471C6510.8010300@viscovery.net> <20071022112401.GE32763@artemis.corp> <471C8B02.6080202@viscovery.net> <20071022121106.GA7151@artemis.corp> <471C950E.40702@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="tThc/1wpZn/ma/RB";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxbQ-0003zK-1k
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXJVNpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbXJVNpo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:45:44 -0400
Received: from pan.madism.org ([88.191.52.104]:46411 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbXJVNpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:45:43 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4CF27264C4;
	Mon, 22 Oct 2007 15:45:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 671CE3CC237; Mon, 22 Oct 2007 15:45:41 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <471C950E.40702@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62006>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2007 at 12:18:22PM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> >On Mon, Oct 22, 2007 at 11:35:30AM +0000, Johannes Sixt wrote:
> >>Pierre Habouzit schrieb:
> >>>On Mon, Oct 22, 2007 at 08:53:36AM +0000, Johannes Sixt wrote:
> >>>>Pierre Habouzit schrieb:
> >>>>>+say_color () {
> >>>>>+	[ "$nocolor" =3D 0 ] &&  [ "$1" !=3D '-1' ] && tput setaf "$1"
> >>>>>+	shift
> >>>>>+	echo "* $*"
> >>>>>+	tput op
>        ^^^^^^^^
> I am talking about this line.

  Oooh, good catch :P it should be guarded by a [ "$nocolor" =3D 0 ]
indeed :P (or use your solution).

> >>>>>+}
> >>I wanted to point out that if tput is not available, the second=20
> >>invocation will leave "tput: command not found" behind on stderr.=20
> >>Therefore, I proposed to make the definition of say_color() different=
=20
> >>depending on whether $color is set or not. Then you don't need to test=
=20
> >>for $color twice inside the function.
> >  Right we can do that. I'll try to rework the patch. and no it
> >shouldn't leave tput: command not found as I 2>/dev/null and I think the
> >shell doesn't print that in that case. At least my zsh doesn't.
>=20
> There is no 2>/dev/null. Am I missing something?

  I was.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHKmFvGr7W6HudhwRAq+IAJ9RvQhZ8HN1ZUn/a4DHheJdWyLAgwCeMfFf
dpA0x7C0kLjygSzcK3YiDts=
=QB7b
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
