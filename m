From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 12:07:16 +0200
Message-ID: <20070521100716.GX5412@admingilde.org>
References: <11796842882917-git-send-email-skimo@liacs.nl> <20070520225252.GO5412@admingilde.org> <20070521085419.GG942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVXkb2QE2eH0aWe4"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon May 21 12:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq4nV-0002Xj-VA
	for gcvg-git@gmane.org; Mon, 21 May 2007 12:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbXEUKHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 06:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbXEUKHT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 06:07:19 -0400
Received: from mail.admingilde.org ([213.95.32.147]:33984 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXEUKHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 06:07:18 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hq4nM-0003II-PQ; Mon, 21 May 2007 12:07:16 +0200
Content-Disposition: inline
In-Reply-To: <20070521085419.GG942MdfPADPa@greensroom.kotnet.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48004>


--WVXkb2QE2eH0aWe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 10:54:19AM +0200, Sven Verdoolaege wrote:
> On Mon, May 21, 2007 at 12:52:53AM +0200, Martin Waitz wrote:
> > That leads to submodules which store their objects within the
> > supermodule .git directory,
>=20
> My code clones submodules in .git/submodules/<submodule>, so
> that could be a good default.

good.

> > which would automatically obsolete the
> > need to specify explicit submodule URLs.
>=20
> Absolutely not.  The subproject will likely have a life of its own.
> If you export it on the same machine, then why would you have two
> different URLs for the same project?
> Also, the subproject will typically not even be on the same site,
> so you _have_ to be able to specify a submodule URL.
> (I noticed that I forgot the "git://" protocol; I'll add that in
> the next round.)

Typically, you have to keep it on the same site because you have
some local adaptions which are only ment to be included within the
superproject.  Think about distributions which seldomly use upstream
software completely unmodified.
Being able to configure it for other URLs is nice but by default it
should work without.

> > So back to your code: I don't like absolute URLs in the cloneable part
> > of the repository.  We should try to stay with relative ones which
> > can stay the same everywhere.
>=20
> The problem with relative paths is that you don't know if the
> URL the user gave you points to the working directory or the
> git directory of the project, but I guess I can let dump-config
> tell you where it found the config file.

We have already solved that in clone & fetch so I don't think this is a
real problem.

--=20
Martin Waitz

--WVXkb2QE2eH0aWe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUW9Uj/Eaxd/oD7IRAiLiAJ9tzW6N/lr/AX4DV4sYAVdDDdfclgCghCp/
w00iIM1KPP+CWnQCZ7aAaF8=
=BNqj
-----END PGP SIGNATURE-----

--WVXkb2QE2eH0aWe4--
