From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Tue, 30 Sep 2008 10:39:40 +0200
Message-ID: <20080930083940.GA11453@artemis.corp>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="k+w/mQv8wyuph6w0";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:40:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkams-0003uu-4K
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYI3Ijo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYI3Ijo
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:39:44 -0400
Received: from pan.madism.org ([88.191.52.104]:43549 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbYI3Ijn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:39:43 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 88FD022346;
	Tue, 30 Sep 2008 10:39:41 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6A4A42AF00; Tue, 30 Sep 2008 10:39:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080929150127.GB18340@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97081>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2008 at 03:01:27PM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> > diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
> > index c4dbc2a..9cc8c2f 100644
> > --- a/Documentation/git-describe.txt
> > +++ b/Documentation/git-describe.txt
> > @@ -30,7 +30,8 @@ OPTIONS
> > =20
> >  --tags::
> >  	Instead of using only the annotated tags, use any tag
> > -	found in `.git/refs/tags`.
> > +	found in `.git/refs/tags`. Though if an annotated tag is found in the
> > +	ancestry, it will always be preferred to lightweight tags.
>=20
> As technically correct as the statement is, I read this and go
> "why do we even have --tags?".
>=20
> If I read builtin-describe.c right we only honor --tags on an exact
> match, or if there are no annotated tags at all in the history.
> I wonder if docs like this aren't better for --tags:
>=20
> --tags::
> 	If a lightweight tag exactly matches, output it.  If no
> 	annotated tag is found in the ancestry but a lightweight
> 	tag is found, output the lightweight tag.

sounds better indeed.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjh5coACgkQvGr7W6HudhwSjQCgnJSiU5rdqYP8qT3tAcbYsyDc
11QAn1fQryuqUQNLbAfdvBXoQh28MU1a
=lXwn
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
