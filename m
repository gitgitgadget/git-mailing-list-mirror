From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Mon, 29 Jun 2009 13:27:39 -0300
Message-ID: <20090629162738.GE4327@vespa.holoscopio.com>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org> <1246289542-1596-1-git-send-email-cascardo@holoscopio.com> <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Cc: git@vger.kernel.org, Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJin-000416-OA
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759842AbZF2Q1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759578AbZF2Q1l
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:27:41 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:41955 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758883AbZF2Q1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 12:27:40 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id 12B6D198349;
	Mon, 29 Jun 2009 13:37:58 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 9A7AFC580; Mon, 29 Jun 2009 13:27:39 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122446>


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2009 at 09:08:00AM -0700, Junio C Hamano wrote:
> Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> writes:
>=20
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
>=20
> Thanks.
>=20
> > +Voc=C3=AA tamb=C3=A9m pode dar ao 'git-log' um "intervalo" de commits =
onde o
> > +primeiro n=C3=A3o =C3=A9 necessariamente um ancestral do segundo; por =
exemplo, se
> > +as pontas dos ramos "stable" e "master" divergiram de um commit
> > +comum algum tempo atr=C3=A1s, ent=C3=A3o
> > +
> > +-------------------------------------
> > +$ git log stable..experimental
> > +-------------------------------------
> > +
> > +ir=C3=A1 listas os commits feitos no ramo experimental mas n=C3=A3o no=
 ramo
> > +stable, enquanto
> > +
> > +-------------------------------------
> > +$ git log experimental..stable
> > +-------------------------------------
> > +
> > +ir=C3=A1 listar a lista de commits feitos no ramo stable mas n=C3=A3o =
no ramo
> > +experimental.
> > +
>=20
> I think you would want to update this part to match what you did in your
> [PATCH 1/2 v2].
>=20

Well remembered. Thanks.

>     By the way, I think your MUA sent quoted-printable UTF-8 but somewhere
>     between your keyboard and vger the message was marked with content-ty=
pe
>     charset=3DISO-8859-1); I fixed it up when quoting the above.
>=20

I am going to take a look at it.

> I am somewhat worried about the way how this translation will be
> maintained to keep in sync with the authoritative English version.
> Narita-san (CC'ed) who translated the document to Japanese did this:
>=20
>     gittutorial(7)
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     // =3D gittutorial(7)
>=20
>     NAME
>     ----
>     // =3D=3D NAME
>     gittutorial - A tutorial introduction to git (for version 1.5.1 or ne=
wer)
>     // gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=AA=E3=
=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1 =E4=BB=
=A5=E9=99=8D=E7=94=A8)
>=20
> and the idea seems that without // (comments in AsciiDoc markup) it
> matches the English copy, and after passing sed -ne 's|^// ||p' it yields
> Japanese version.  Narita-san's translation can be seen at
>=20
>     http://github.com/yasuaki/git-manual-jp.git/Documentation
>=20
> if anybody is interested.
>=20
> With this format, merging upstream changes may not work as smoothly as it
> could be, but at least you can check which part of your translation is
> based on a stale copy with something like this arrangement.
>=20
> I am wondering if it would be a good idea to extend Narita-san's scheme so
> that we can keep a single source, perhaps like:
>=20
>     =3D gittutorial(7)
>     // ja =3D gittutorial(7)
>     // pt =3D gittutorial(7)
>     =3D=3D NAME
>     // ja =3D NAME
>     // pt =3D NAME
>     gittutorial - A tutorial introduction to git (for version 1.5.1 or ...
>     // ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=AA=
=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1 =E4=
=BB=A5=E9=99=8D=E7=94=A8)
>     // pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (para =
vers=C3=A3o 1....
>=20
> Then whenever somebody makes a change to the English version, he can and
> should also mark the corresponding translated versions "stale", so that it
> is easier to spot by translators.
>=20
>     diff --git a/gittutorial.txt b/gittutorial.txt
>     index 4478300..02d67d3 100644
>     --- a/gittutorial.txt
>     +++ b/gittutorial.txt
>     @@ -4,7 +4,6 @@
>      =3D=3D NAME
>      // ja =3D NAME
>      // pt =3D NAME
>     -gittutorial - A tutorial introduction to git (for version 1.5.1 or n=
=2E..
>     -// ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=88=E3=83=
=AA=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=B3 1.5.1 =
=E4=BB=A5=E9=99=8D=E7=94=A8)
>     -// pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (para=
 vers=C3=A3o 1....
>     -
>     +gittutorial - A tutorial introduction to git (for version 1.6.3 or n=
=2E..
>     +// **stale** ja gittutorial - git =E3=83=81=E3=83=A5=E3=83=BC=E3=83=
=88=E3=83=AA=E3=82=A2=E3=83=AB (=E3=83=90=E3=83=BC=E3=82=B8=E3=83=A7=E3=83=
=B3 1.5.1 ...
>     +// **stale** pt gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao=
 git (par...
>=20
> As long as all the translations use the same encoding (I think UTF-8 is
> the only practical choice for this), keeping translated strings in a
> single file would be doable.
>=20
> I however am not sure how practical it would be to force people to look at
> the *.txt version of document, only 1/n lines of which is now readable by
> him (if you are like a typical American who understands only English ;-).
>=20
> Thoughts?

I think that using something like po would be better. There are tools
that can extract and update the template messages from many differente
sources. Adapting them to produce a template file from gittutorial.txt
would allow translators to verify how stale their translations are and
much smoother merges. How about that?

Regards,
Cascardo.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpI63oACgkQyTpryRcqtS3sdACbBsIAZpShYIToOEpqIKV9ztGD
Tf4AmQFeW4tOzF4G17wWSKTFbOq+WwfD
=nr6t
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--
