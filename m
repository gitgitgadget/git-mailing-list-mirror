From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: difference between "git reset --hard" and "git checkout -f"
Date: Wed, 30 Apr 2008 14:16:06 +0200
Message-ID: <20080430121606.GA23672@genesis.frugalware.org>
References: <2e24e5b90804300437t39ac16a6ga3cbe0b91d7e5565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:16:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrBEl-0000BY-O5
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 14:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756416AbYD3MPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 08:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761488AbYD3MPy
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 08:15:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59190 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756974AbYD3MPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 08:15:52 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DE0B01B2505;
	Wed, 30 Apr 2008 14:15:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5F580446E1;
	Wed, 30 Apr 2008 14:15:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E4C0F1190ACB; Wed, 30 Apr 2008 14:16:06 +0200 (CEST)
Mail-Followup-To: Sitaram Chamarty <sitaramc@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <2e24e5b90804300437t39ac16a6ga3cbe0b91d7e5565@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80833>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2008 at 05:07:40PM +0530, Sitaram Chamarty <sitaramc@gmail.=
com> wrote:
> I have two questions:
>=20
> (1) as in the subject line, what's the difference between these two
> commands?  (I'm talking about those exact commands, not variations).
> I am unable to see any.

git checkout is the tool to check out a branch or paths. git reset is to
reset HEAD (and as a side effect the working directory as well). so i
think only the sematics differ, there is no difference in practice.

> (2) shouldn't one of these have an option to throw away untracked
> files also, to get to a pristine HEAD-eqvt state?  Or is it better to
> force user to use git clean separately for that?

i would say so. we already require (by default) to use git clean -f, as
it may wipe out your work (in case you forgot to git add some important
files), so just adding an other option to perform this dangerous
operation would not be good imho.

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgYYwYACgkQe81tAgORUJbFbgCfcORflGuWPYbMam8gJxUauyWr
va8AoI/VQr/C7S7DKqFPIVDRFwaOoh4R
=5yMG
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
