From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: fetch for bare repository
Date: Fri, 13 Jan 2012 14:40:59 +0100
Message-ID: <20120113134058.GB2850@centaur.lab.cmartin.tk>
References: <4F100A7B.3030001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Cc: git@vger.kernel.org
To: "Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 14:41:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlhNR-0000pM-N7
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 14:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab2AMNlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 08:41:00 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:38582 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905Ab2AMNk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 08:40:59 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9f5ad.pool.mediaWays.net [77.185.245.173])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 48470461BE;
	Fri, 13 Jan 2012 14:40:44 +0100 (CET)
Received: (nullmailer pid 28821 invoked by uid 1000);
	Fri, 13 Jan 2012 13:40:59 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	"Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4F100A7B.3030001@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188511>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 02:42:03PM +0400, Dmitry A. Ashkadov wrote:
> Hello!
>=20
> I can't understand how to fetch branches from external repository
> for bare repository.

What you probably want is a mirror (git clone --mirror). Unless you
tell git that you want a mirror, it's going to assume that you want a
bare repo to push your own changes up to it. Such a repo has no need
to be kept up to date, so clone doesn't set up any fetch refspecs.

Stepping back, do you need to fetch those branches into the private
repo? If you still have access to the main repo and that's where the
main project development is happening, why not use upstream's repo to
get those changes to your local repo (as in the one you use to work)?
It sounds like you're trying to replicate a centralised VCS'
workflow. Git works like a network and you can merge a branch from
upstream if you need to and then push to the private repo.

   cmn


--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPEDRqAAoJEHKRP1jG7ZzTQocIAJnkCCqQ+5UD3m569ZLreQvE
Vq+HaUd7Q34VGOvUx04211gXjK3hn/b8ciVJVP4dygolDGM24fgQIV/v22SPk/ER
ZhgDANyJUJB3sqjO012Lh1bcs7lnfNgB2sThCBHwSxPEir47mk4IV8coarFrF2JL
2O4sDjNOnM2fStU+YIljBFGEobaZA5jjrk/cYetH/oiKQwsUJCTQt1fUIKd+zb7V
tEmmX8QLf++0iQ3nV+KGsoyz2Qn+iRk3FxI6NV/dDh+WbbKnsfWvnxYyKn72mcZW
TZ2Yzx61nIGMPotIKTiHxwle1g1feqynlSLwAxpAj2YPzcP25PD7eWWVN6v8oEM=
=VJ9t
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
