From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 10:04:36 +0200
Message-ID: <20070924080436.GB9112@artemis.corp>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="JYK4vJDZwFMowpUq";
	protocol="application/pgp-signature"; micalg=SHA1
To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 10:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZivt-0004CH-Jp
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 10:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXIXIEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 04:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbXIXIEj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 04:04:39 -0400
Received: from pan.madism.org ([88.191.52.104]:40107 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbXIXIEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 04:04:38 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 33F4921745;
	Mon, 24 Sep 2007 10:04:37 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CA657E1A4; Mon, 24 Sep 2007 10:04:36 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070924080134.GA9112@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59028>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 24, 2007 at 08:01:34AM +0000, Pierre Habouzit wrote:
> On Mon, Sep 24, 2007 at 07:57:31AM +0000, David Kastrup wrote:
> > "David Symonds" <dsymonds@gmail.com> writes:
> >=20
> > > On 24/09/2007, David Kastrup <dak@gnu.org> wrote:
> > >> Mike Hommey <mh@glandium.org> writes:
> > >>
> > >> > On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
> > >> >> -while case $# in 0) break ;; esac
> > >> >> +while test $# !=3D 0
> > >> >
> > >> > Wouldn't -ne be better ?
> > >>
> > >> Why?
> > >
> > > Because -ne does a numeric comparison, !=3D does a string comparison,
> > > and it's a numeric comparison happening, semantically speaking.
> >=20
> > I don't see the point in converting $# and 0 into numbers before
> > comparing them.  "!=3D" is quite more readable, and the old code also
> > compared the strings.
>=20
>   Fwiw $# already is a number. Hence test $# -ne 0 is definitely a
> better test.
>=20
>   $# !=3D 0 would yield sth like (strcmp(sprintf("%d", argc), "0"))
>   $# -ne 0 would yield sth like (argc !=3D atoi("0")).

  Of course this holds only for shell where test/[ is a builtin, which
is the at least the case for zsh, bash, and dash (but not posh).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG92+UvGr7W6HudhwRAixsAKCFnaC72+E7ETengyJ1vir6uAsnmgCgl2gS
N+cz65aVcn0bDTqoLYKW6+I=
=pEoj
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
