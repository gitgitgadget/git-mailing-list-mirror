From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: git-difftool
Date: Wed, 31 Dec 2008 15:20:47 -0600
Message-ID: <200812311520.47999.bss@iguanasuicide.net>
References: <20081226013021.GA15414@gmail.com> <vpqhc4kz5zh.fsf@bauges.imag.fr> <402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3661209.63DSc9LlQF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Matthieu Moy" <Matthieu.Moy@imag.fr>
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 06:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIGRg-0004QU-T3
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 06:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbZAAFsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 00:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbZAAFst
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 00:48:49 -0500
Received: from rei.iguanasuicide.net ([209.20.91.252]:37694 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbZAAFst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 00:48:49 -0500
Received: from ip70-185-247-131.ok.ok.cox.net ([70.185.247.131] helo=[192.168.1.106])
	by rei.iguanasuicide.net with esmtpsa (TLS-1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LIGQI-0006zi-Ep; Thu, 01 Jan 2009 05:48:46 +0000
User-Agent: KMail/1.9.10
In-Reply-To: <402731c90812311211p548c49d3p100f79ddee7163b0@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy.
X-Virus-Scanned: clamav@iguanasuicide.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104291>

--nextPart3661209.63DSc9LlQF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 2008 December 31 14:11:07 you wrote:
> On Wed, Dec 31, 2008 at 8:04 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrot=
e:
> > David Aguilar <davvid@gmail.com> writes:
> >> The usual use case for this script is when you have either
> >> staged or unstaged changes and you'd like to see the changes
> >> in a side-by-side diff viewer (e.g. xxdiff, tkdiff, etc).
> >>
> >>       git difftool [<filename>*]
> >
> > Is it not a complex way of saying
> >
> >        GIT_EXTERNAL_DIFF=3Dxxdiff git diff
> >
> > ?
>
> Hmm... in theory, yes, but in practice, no.
> xxdiff is too gimp to handle what 'git diff' hands it =3D)

What about something like:
git diff | xxdiff -

I normally use:
git diff | kompare -

and it works fine.
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart3661209.63DSc9LlQF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklb4i8ACgkQdNbfk+86fC1vFwCfWuoKujPH/3ahyT8ZYGsUs/gk
3jAAn2Y90de4hXcrZUvGLVPSbX4PpmmK
=oxc7
-----END PGP SIGNATURE-----

--nextPart3661209.63DSc9LlQF--
