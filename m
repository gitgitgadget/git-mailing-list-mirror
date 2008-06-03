From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Wed, 4 Jun 2008 01:11:51 +0200
Message-ID: <20080603231151.GR29404@genesis.frugalware.org>
References: <200806030314.03252.jnareb@gmail.com> <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org> <7v3anv5fy3.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0806030738340.3473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c6397Mob2532IpCX"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 01:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fgM-0004H5-Uj
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 01:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYFCXLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 19:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYFCXLy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 19:11:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54476 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbYFCXLy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 19:11:54 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 551181B255D;
	Wed,  4 Jun 2008 01:11:52 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9507F4469E;
	Wed,  4 Jun 2008 00:54:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BD4D51190ACA; Wed,  4 Jun 2008 01:11:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806030738340.3473@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83728>


--c6397Mob2532IpCX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2008 at 07:40:21AM -0700, Linus Torvalds <torvalds@linux-fo=
undation.org> wrote:
> Right. But git shouldn't do duplicate parents. I agree it's a mis-use of=
=20
> git merge, but either we should have errored out or we should have pruned=
=20
> the parents.
>=20
> Yes, the end result is "tecnically correct", but it's not optimal.

I think the current git-merge.sh already handles this: 6ea23343
introduced the usage of git-show-branch --independent to filter out
duplicated parents.

--c6397Mob2532IpCX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkhFz7cACgkQe81tAgORUJYskwCfeFhAoUbR7wixiNiROmq9G61T
kIAAmK5Lws8z2nOjJJh22ewYF//1gdo=
=FmLp
-----END PGP SIGNATURE-----

--c6397Mob2532IpCX--
