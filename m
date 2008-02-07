From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-tag HEAD
Date: Thu, 7 Feb 2008 13:13:24 +0100
Message-ID: <20080207121324.GL25954@genesis.frugalware.org>
References: <dfb262380802042024p49bfb0c3v689946dba350ac01@mail.gmail.com> <BAYC1-PASMTP15D0374A5A075B79E17284AE2C0@CEZ.ICE> <dfb262380802042112s324cc7dfx452a540e6bc54473@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Ramagudi Naziir <naziirr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 13:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN5dr-0002MX-S8
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYBGMNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbYBGMNj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:13:39 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45613 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbYBGMNi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:13:38 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JN5dC-0001ID-Dr
	from <vmiklos@frugalware.org>; Thu, 07 Feb 2008 13:13:36 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0967311901AA; Thu,  7 Feb 2008 13:13:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <dfb262380802042112s324cc7dfx452a540e6bc54473@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.0
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.0 required=5.9 tests=BAYES_50 autolearn=no SpamAssassin version=3.2.3
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4995]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72925>


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2008 at 07:12:39AM +0200, Ramagudi Naziir <naziirr@gmail.co=
m> wrote:
> > $ git tag -d HEAD
>=20
> Is it exactly the same as "rm .git/refs/tags/HEAD" ?

nope, as that won't create a reflog entry and won't work with packed
refs. at least i think so :)

- VMiklos

--81JctsDUVPekGcy+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHqvXke81tAgORUJYRAhiuAJ9dRibmWuuvctzdSA/q0DYnl8EUiACglq7G
Ov1obHlkRQZikuXgTKGvC+s=
=ulOy
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
