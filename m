From: Sascha Peilicke <sasch.pe@gmx.de>
Subject: Re: Unable to remove git branch
Date: Fri, 29 Oct 2010 10:31:38 +0200
Message-ID: <201010291031.42305.sasch.pe@gmx.de>
References: <201010290943.13177.sasch.pe@gmx.de> <4CCA7DA8.3020607@debugon.org> <4CCA7E42.7080906@debugon.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3695365.yROK4AON6Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: Mathias Lafeldt <misfire@debugon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 10:31:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkNQ-0005gA-Fn
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760717Ab0J2Ibv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:31:51 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:45059 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1760681Ab0J2Ibs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:31:48 -0400
Received: (qmail invoked by alias); 29 Oct 2010 08:31:45 -0000
Received: from charybdis-ext.suse.de (EHLO bort.localnet) [195.135.221.2]
  by mail.gmx.net (mp063) with SMTP; 29 Oct 2010 10:31:45 +0200
X-Authenticated: #30943063
X-Provags-ID: V01U2FsdGVkX18dPnU5xDEd0g8oGILxb1RVjNDU5BcFTUYl7MsGk0
	2xKSGPfN5xeJTR
User-Agent: KMail/1.13.5 (Linux/2.6.34.7-0.5-desktop; KDE/4.5.2; x86_64; ; )
In-Reply-To: <4CCA7E42.7080906@debugon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160318>

--nextPart3695365.yROK4AON6Y
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 29 October 2010 09:56:50 you wrote:
> Mathias Lafeldt wrote:
> > Sascha Peilicke wrote:
> >> Hi guys,
> >>=20
> >> I accidentally did an 'git co -b --track origin/foo' ending up with a
> >> local branch '--track'. Sadly, git is unable to remove or rename that
> >> branch because it always interprets it as a parameter.
> >>=20
> >> As a consequence, 'git br -d "--track"' does nothing and 'git br -m
> >> "--track" foo' even renames the current branch, say, master,  to 'foo'.
> >> Any hints on how to get rid of that pesky branch?
> >>=20
> >> BTW please CC me as I'm not subscribed to this list.
> >=20
> > Try:
> >=20
> > $ git br -D -- --track
>=20
> It really should be:
>=20
> $ git branch -D -- --track

Thanks, that worked. Maybe '-' should not be allowed as the first char in a=
=20
branch name?
=2D-=20
Mit freundlichen Gr=FC=DFen,
Sascha Peilicke
http://saschpe.wordpress.com

--nextPart3695365.yROK4AON6Y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkzKhm4ACgkQDq/ykSrZt1U7WQCgoGm8EtQ2YxUIzLiBwK6U19yX
jjMAmwWxR2jZRzNkwSDjuERldqaL2GIR
=K3zy
-----END PGP SIGNATURE-----

--nextPart3695365.yROK4AON6Y--
