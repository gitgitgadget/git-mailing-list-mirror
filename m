From: Eric Anholt <eric@anholt.net>
Subject: Re: git merge in FreeBSD
Date: Wed, 15 Mar 2006 08:42:57 -0800
Message-ID: <1142440978.951.46.camel@leguin>
References: <44182A3C.80701@asianetindia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ykKGtnwrfRLUWsApodOc"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 15 17:43:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJZ5h-0005pz-LI
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 17:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbWCOQnP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 11:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWCOQnP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 11:43:15 -0500
Received: from 69-30-77-85.dq1sn.easystreet.com ([69.30.77.85]:40444 "EHLO
	leguin.anholt.net") by vger.kernel.org with ESMTP id S1752144AbWCOQnO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 11:43:14 -0500
Received: from leguin.anholt.net (localhost [127.0.0.1])
	by leguin.anholt.net (8.13.4/8.13.1) with ESMTP id k2FGh0EC098707;
	Wed, 15 Mar 2006 08:43:00 -0800 (PST)
	(envelope-from eric@anholt.net)
Received: (from anholt@localhost)
	by leguin.anholt.net (8.13.4/8.13.1/Submit) id k2FGgxFw098706;
	Wed, 15 Mar 2006 08:42:59 -0800 (PST)
	(envelope-from eric@anholt.net)
X-Authentication-Warning: leguin.anholt.net: anholt set sender to eric@anholt.net using -f
To: Rajkumar S <rajkumars@asianetindia.com>
In-Reply-To: <44182A3C.80701@asianetindia.com>
X-Mailer: Evolution 2.4.2.1 FreeBSD GNOME Team Port 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17611>


--=-ykKGtnwrfRLUWsApodOc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-15 at 20:22 +0530, Rajkumar S wrote:
> Hi,
>=20
> I get a "git-merge-recursive: not found" error when I try to do a merge i=
n FreeBSD. Same=20
> command in Linux does not give an error.
>=20
> # git merge "Merging from updates" RELENG_1 RELENG_1_origin
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> /usr/local/bin/git-merge: git-merge-recursive: not found
> No merge strategy handled the merge.
>=20
> I am using git version 1.2.4.gea75 in FreeBSD 6

This is probably the wrong python path in git-merge-recursive.  I've got
a fix on my laptop for this and gitk, but I haven't tried submitting it
again (I guess email was hosed, or it got lost, when I sent the first
version of it directly to Junio).

But might I also recommend ports/devel/git?  I'm keeping it pretty up to
date, and using it on a daily basis.

--=20
Eric Anholt                     anholt@FreeBSD.org
eric@anholt.net                 eric.anholt@intel.com

--=-ykKGtnwrfRLUWsApodOc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (FreeBSD)

iD8DBQBEGEQRHUdvYGzw6vcRApIoAJ9Un+oPCMf07u99/ax5ok6eLj2MmwCfbpKH
qKC3yPX+dPQ0Ms0yeREdr8I=
=LFUr
-----END PGP SIGNATURE-----

--=-ykKGtnwrfRLUWsApodOc--
