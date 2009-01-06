From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] fast-export: print usage when no options specified
Date: Tue, 6 Jan 2009 21:11:26 +0100
Message-ID: <20090106201126.GJ21154@genesis.frugalware.org>
References: <1230955152-23646-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0901062023100.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONTEBGf774apj9iN"
Cc: Junio C Hamano <gitster@pobox.com>, jidanni@jidanni.org,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:12:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKIIF-00016V-NJ
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 21:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZAFUL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 15:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZAFUL2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 15:11:28 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34624 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbZAFUL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 15:11:28 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id EF230580AC;
	Tue,  6 Jan 2009 21:11:27 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1554D4465E;
	Tue,  6 Jan 2009 21:11:26 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 61B2B11B8630; Tue,  6 Jan 2009 21:11:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901062023100.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104717>


--ONTEBGf774apj9iN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2009 at 08:28:59PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Maybe this should be part of the commit message?
>=20
> -- snip --
> Some people find it surprising that fast-export does not output a usage=
=20
> when called without parameters, as rev-list does.
>=20
> This assumes that a user usually does not want to export HEAD by default.
> -- snap --

OK, if this is the only problem, I can resend it with this included. ;-)

> However, I have to say that I would find exporting HEAD a rather sensible=
=20
> default.
>=20
> But I am not _that_ strongly opposed to the patch.  Just would like to=20
> hear some opinions first.

According to man git, fast-export is not a plumbing, though I think most
user won't type it manually multiple times, they'll write a script, that
checks if there is something to convert, then run git fast-export | foo
fast-import, so it's really like plumbing. That's why I found the
rev-list-like behaviour more logical.

However, I think defaulting to HEAD is still better than the current
situation, so if that's the consensus, I'm fine with that as well.

--ONTEBGf774apj9iN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkljuu4ACgkQe81tAgORUJb7yACeO6erXtBb2Y5WBTLsA8U/aEH2
QvwAoKX7HWu0Ynak//ivUBXqDvhsiqr3
=7pjG
-----END PGP SIGNATURE-----

--ONTEBGf774apj9iN--
