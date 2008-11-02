From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] add instructions on how to send patches to the mailing list with Gmail
Date: Sun, 02 Nov 2008 10:10:06 +0100
Message-ID: <20081102091006.GA4066@artemis>
References: <b97024a40811010028l36606128v61172807f4cf503a@mail.gmail.com> <adf1fd3d0811010300ye0aca83t12d271388d35b8d4@mail.gmail.com> <b97024a40811011340s92a1c24jb81b75dfb25e43c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="AhhlLboLdkugWU4S";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tom Preston-Werner <tom@github.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:11:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwYzb-0000pv-TH
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYKBJKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbYKBJKN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:10:13 -0500
Received: from pan.madism.org ([88.191.52.104]:38204 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbYKBJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:10:11 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 9DEAF3B7E2;
	Sun,  2 Nov 2008 10:10:08 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id A393B2A299; Sun,  2 Nov 2008 10:10:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b97024a40811011340s92a1c24jb81b75dfb25e43c5@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99823>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 08:40:27PM +0000, Tom Preston-Werner wrote:
> On Sat, Nov 1, 2008 at 3:00 AM, Santi B=C3=A9jar <santi@agolina.net> wrot=
e:
> > On Sat, Nov 1, 2008 at 8:28 AM, Tom Preston-Werner <tom@github.com> wro=
te:
> >> Gmail is one of the most popular email providers in the world. Now tha=
t Gmail
> >> supports IMAP, sending properly formatted patches via `git imap-send` =
is
> >> trivial. This section in SubmittingPatches explains how to do so.
> >>
> >> Signed-off-by: Tom Preston-Werner <tom@github.com>
> >> ---
> >>  Documentation/SubmittingPatches |   27 +++++++++++++++++++++++++++
> >>  1 files changed, 27 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/Documentation/SubmittingPatches b/Documentation/Submittin=
gPatches
> >> index a1e9100..f0295c6 100644
> >> --- a/Documentation/SubmittingPatches
> >> +++ b/Documentation/SubmittingPatches
> >> @@ -456,3 +456,30 @@ This should help you to submit patches inline usi=
ng KMail.
> >>
> >>  5) Back in the compose window: add whatever other text you wish to the
> >>  message, complete the addressing and subject fields, and press send.
> >> +
> >> +
> >> +Gmail
> >> +-----
> >> +
> >> +Submitting properly formatted patches via Gmail is simple now that
> >> +IMAP support is available. First, edit your ~/.gitconfig to specify y=
our
> >> +account settings:
> >> +
> >> +[imap]
> >> +       folder =3D "[Gmail]/Drafts"
> >> +       host =3D imaps://imap.gmail.com
> >> +       user =3D user@gmail.com
> >> +       pass =3D p4ssw0rd
> >> +       port =3D 993
> >> +       sslverify =3D false
> >
> > Warning: It is not secure.
>=20
> It is true that the certificate is not verified, but since the patches
> are destined for a public mailing list, this does not represent a
> large problem.

What he means is that the password is cleartext ;)
(I think)


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNbmkACgkQvGr7W6Hudhw+9gCfQAWmfcD5U6b+g4ZKIQt5ZhgS
UpQAn12odFWOMN5hWGuEByVwCQ3rmD2m
=gyzZ
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
