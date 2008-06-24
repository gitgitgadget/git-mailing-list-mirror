From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 25 Jun 2008 00:10:49 +0200
Message-ID: <20080624221049.GE29404@genesis.frugalware.org>
References: <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <20080621121429.GI29404@genesis.frugalware.org> <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EC5xR003sDDu4cto"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:12:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBGkD-00065f-Rp
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbYFXWKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755284AbYFXWKx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:10:53 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55879 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697AbYFXWKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:10:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E9CA61B24FA;
	Wed, 25 Jun 2008 00:10:49 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9CFF244668;
	Tue, 24 Jun 2008 23:45:43 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 513D31770070; Wed, 25 Jun 2008 00:10:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86155>


--EC5xR003sDDu4cto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 01:44:34PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> >> bash: git-upload-pack: command not found
> >> fatal: The remote end hung up unexpectedly
> >
> > Hmm.  Probably the client needs to be newer, too.  This is going to be=
=20
> > painful.  Junio?
>=20
> Even with maint client accessing an account with next git-shell as its
> login shell, I do not get the above failure.
>=20
> Is git-shell installed and configured correctly at all in Miklos's setup?
> Why does the other side say "bash: git-upload-pack" when login shell is
> git-shell and not bash?

Sorry for the confusion, this is not about git-shell at all. I have
bash as the shell on the server, obviously.

So, in case the server runs next, the client runs master, and I try to
clone via ssh, I get the above error.

--EC5xR003sDDu4cto
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhhcOkACgkQe81tAgORUJbxGgCff1tVbKLb31bkNkFpp9IyZAu0
MCkAmgLo0hLy9tW6bHHkSAx1ybxbHKO+
=mz1C
-----END PGP SIGNATURE-----

--EC5xR003sDDu4cto--
