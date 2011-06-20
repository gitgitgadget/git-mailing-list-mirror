From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: pushing a branch without merging
Date: Mon, 20 Jun 2011 17:03:03 +0200
Message-ID: <20110620150303.GA2782@bee.lab.cmartin.tk>
References: <BANLkTin4fpwX9NgnP0U1+z9tRA=akR6MDg@mail.gmail.com>
 <4DFF5B41.1000108@micronengineering.it>
 <BANLkTikWDzZD8b-aUMXJwByeN3tBsYipgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Cc: Massimo Manca <massimo.manca@micronengineering.it>,
	git@vger.kernel.org
To: Carlo Trimarchi <mr.spoon21@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:03:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYg0W-00081e-4l
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab1FTPDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 11:03:07 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:52280 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752471Ab1FTPDF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 11:03:05 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C9348461EB;
	Mon, 20 Jun 2011 17:02:31 +0200 (CEST)
Received: (nullmailer pid 10022 invoked by uid 1000);
	Mon, 20 Jun 2011 15:03:03 -0000
Content-Disposition: inline
In-Reply-To: <BANLkTikWDzZD8b-aUMXJwByeN3tBsYipgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176071>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2011 at 04:56:12PM +0200, Carlo Trimarchi wrote:
> 2011/6/20 Massimo Manca <massimo.manca@micronengineering.it>:
>=20
> > then you edit and add files on the newly branch, so as usually you have
> > to use:
> > =C2=A0 =C2=A0git add .
> > =C2=A0 =C2=A0git commit -m "what I change on this branch" -a
> >
> > When you have to update the remote then staying on experimental branch
> > you can:
> > =C2=A0 =C2=A0git push
>=20
> This is exactly what I did, but on the server it showed the old version.
> This is what appears when commiting:
>=20
> =E2=9E=9C  website git:(experimental) =E2=9C=97 git commit -a -m "commit =
message"
> [mario_style 7764c96] commit message
>  2 files changed, 315 insertions(+), 204 deletions(-)
>  rewrite index.html (88%)
> =E2=9E=9C  website git:(experimental) =E2=9C=97 git push website
> Counting objects: 7, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (4/4), done.
> Writing objects: 100% (4/4), 451 bytes, done.
> Total 4 (delta 2), reused 0 (delta 0)
> To ssh://myserver.bla.com/home/user/website.git
>    f93d62f..eb8e369  master -> master
>=20
> I'm in the experimental branch, but in the end it shows master ->
> master. Maybe that is what it is supposed to show, not sure.

By default, git-push only pushes matching branches (those that exist
both in the local and remote repos). What you want to do might be

   git push website experimental

if you want to create the branch 'experimental', or if your deployment
system only checks out the 'master' branch, you might find

    git push website experimental:master

useful. In this case you may have to force-push master again, which is
not recommended (though in your case it might be fine). You can find
more details about how to specify which branches you want to push in
the git-push manpage.

Cheers,
   cmn
--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN/2EnAAoJEHKRP1jG7ZzTmNMH/0AlrDMgB6YuQ9oTBeHT0gGV
63zQPy25u1Uot8HS3mqwGXL6GYU6uZxcAXIwL/pkhtaZFKV9CcSTHBs1dv2cuKcI
0LdpLqsLOHkwsJlK2ruWHBTPpFV39fhqo2mQ2OFUJylaZ4+VFdYQRvVfWKFr7Cko
ut84OzwB/Kpg8S0Z+It5iqAyU3Oi6mHoJ3c0WdMNL4/KBhRyhDT5SizLwNq2CUoP
UJZy41hI260Y1HvsAndwkDZG5Dbij+XH2wFMYE9Pn/mKFbADiF4Vi5YybgvKUfRy
8gCS6cGEoM2vgP/mgVzf7INyMzhWFauNudWhcs1yeg4nxPIFfrGH1mx7SutENt0=
=V69j
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
