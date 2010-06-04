From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] documentation: git-mergetool updated to warn against 
 builtin tools invocations
Date: Fri, 04 Jun 2010 23:29:30 +0200
Message-ID: <1275686970.2510.1.camel@kheops>
References: <1275501453-13081-1-git-send-email-srabot@steek.com>
	 <7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
	 <AANLkTikPHdRWsHUI-YwEkECtIbj425hKxzy8_JrA4_ny@mail.gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zhGcw2rU4rwFdHOMHEZK"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 04 23:29:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKeSe-0002Vo-3u
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 23:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756866Ab0FDV3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jun 2010 17:29:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:43451 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767Ab0FDV3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 17:29:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OKeSX-0002Rp-80
	for git@vger.kernel.org; Fri, 04 Jun 2010 23:29:45 +0200
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 23:29:45 +0200
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 23:29:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <AANLkTikPHdRWsHUI-YwEkECtIbj425hKxzy8_JrA4_ny@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148440>


--=-zhGcw2rU4rwFdHOMHEZK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-06-03 at 12:55 +0200, Sylvain Rabot wrote:
> On Thu, Jun 3, 2010 at 01:38, Junio C Hamano <gitster@pobox.com> wrote:
> > Sylvain Rabot <srabot@steek.com> writes:
> >
> >> +Be aware that 'git mergetool' has some predefined invocation commands=
 builtin
> >> +for known diff tools like meld, diffuse, p4merge ... etc. It means th=
at if
> >> +you set the merge.tool configuration to one of these tools, the
> >> +mergetool.<tool>.* configurations will not be taken care of. If you
> >> +really want to customize the invocation of one of these tools,
> >> +set `merge.tool` to "custom" or whatever you want and `mergetool.cust=
om.cmd`
> >> +to "/usr/bin/<tool> $LOCAL $MERGED $REMOTE"
> >
> > Two half-points and three points (that makes them four in total ;-):
> >
> >  o If I read the above without "It means that", it still makes sense;
>=20
> Ok
>=20
> >
> >  o "If you really" can go without "really";
>=20
> Ok
>=20
> >
> >  * I had to read "will not be taken care of" twice; "are ignored" is
> >   probably easier to understand;
>=20
> Ok
>=20
> >
> >  * The description and the example makes it sound as if the command lin=
e
> >   has to have these three tokens in the given order, but the whole poin=
t
> >   of this mechanism is that you can launch whatever external command wi=
th
> >   a custom command line, so "and `mergetool.custom.cmd` to a command li=
ne
> >   to invoke the command.  $LOCAL $MERGED and $REMOTE on this command li=
ne
> >   are substituted by ...." may be more reader-friendly.
>=20
> Ok
>=20
> >
> >  * As a documentation update it is perfectly fine to describe this glit=
ch,
> >   but I wonder if we might want to lift this restriction (read: conside=
r
> >   this as a bug and fix it).
>=20
> I agree, I wil take a look, I'm not a sh expert but I can try.
> If I succeed I will send you a patch, otherwise I will send you a
> corrected version of this patch.

I'm about to send a patch, before, can I assume that all users have
sed ?=20

>=20
> >
> >> ++
> >> +-------------
> >> +[merge]
> >> +    tool =3D diffuse-custom
> >> +[mergetool "diffuse-custom"]
> >> +    cmd =3D diffuse $LOCAL $MERGED $REMOTE
> >> +-------------
> >> ++
> >
> > Thanks.
> >
>=20

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-zhGcw2rU4rwFdHOMHEZK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwJcDMACgkQ+TklUoyVcydGDgCgr+iAaPuK4m/Agqwovhh1Y3A3
NXUAoLIAn9mp3uYlOcb2qRvJ6oqdy/A8
=iuGU
-----END PGP SIGNATURE-----

--=-zhGcw2rU4rwFdHOMHEZK--
