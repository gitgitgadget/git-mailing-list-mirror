From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Indelible actions only
Date: Wed, 29 Jun 2011 00:45:19 +0200
Message-ID: <20110628224519.GA11733@centaur.lab.cmartin.tk>
References: <BANLkTinUSoB=GGe+qXpPh+WFgRU2S2jnGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: git@vger.kernel.org
To: Walther Bauer <2313218@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jun 29 00:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbh2G-0002ud-0P
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 00:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab1F1WpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 18:45:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38008 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab1F1WpT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 18:45:19 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9fa7d.pool.mediaWays.net [77.185.250.125])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id BA7FF461F0;
	Wed, 29 Jun 2011 00:44:42 +0200 (CEST)
Received: (nullmailer pid 12465 invoked by uid 1000);
	Tue, 28 Jun 2011 22:45:19 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Walther Bauer <2313218@googlemail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <BANLkTinUSoB=GGe+qXpPh+WFgRU2S2jnGw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176428>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2011 at 12:18:36AM +0200, Walther Bauer wrote:
> Hello,
> how do I configure a git repository in a way, that no modifications of
> existing history (eg "commit --amend", "branch -d", "rebase") are
> allowed?

=46rom the git-config man page

       receive.denyNonFastForwards
           If set to true, git-receive-pack will deny a ref update which is
           not a fast-forward. Use this to prevent such an update via a pus=
h,
           even if that push is forced. This configuration variable is set
           when initializing a shared repository.


so set that variable to true. This has to be in the repository you use
to synchronize. IIRC it can't be avoided locally (but that's not a
problem, because you shouldn't be working directly on the public repo
anyway).

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOCll+AAoJEHKRP1jG7ZzTGSUH/23J4Rys/rVwOKKWlbKgqSYl
tjxaU7xHFYVq8s/yWwVL7OmzTli+pTEB+PpJI+wdPmEqZs7iTNfdDDFwcDUe2iO5
USmUFIykxKKK89g3imxt6ZTrtP9bAYW1+khyh7qDVQyZ9qmN8lQNaRZheiz6K0Mi
ZUl9Lz9t814WAvBAWBjJoEAap0Lmcomq0hHxDSDSc5Tfv2875idwl/VFuSRfnmsM
M6pqa4GxZK1YeCBOfatRdBHTPZwRecaoH3jf187QH0bM/ac7rHjBw9N0JukIqrsa
TJJulsY3llAcsTHlqrDyvydqgPpfIiU34O7pt3LehoBoWtUaFKZL6kqohEFod7E=
=iQZm
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
