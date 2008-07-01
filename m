From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 14/14] Build in merge
Date: Tue, 1 Jul 2008 14:55:18 +0200
Message-ID: <20080701125518.GX4729@genesis.frugalware.org>
References: <cover.1214879690.git.vmiklos@frugalware.org> <9201d4e13e574c10b1674cf1f6da23a44a73f8b2.1214879690.git.vmiklos@frugalware.org> <1b74bb93e518a906b0067d182fb29279baff3b25.1214879690.git.vmiklos@frugalware.org> <5e65b37998d1fdd9d314e48cea2cf67fd73ba8cd.1214879690.git.vmiklos@frugalware.org> <7vzlp2oyh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b9dEYEwnDXkv9lSy"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:57:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfPk-0000sV-Ky
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444AbYGAMzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757975AbYGAMzY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:55:24 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47107 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757201AbYGAMzV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 08:55:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2F3AA1B254C;
	Tue,  1 Jul 2008 14:55:19 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4574244668;
	Tue,  1 Jul 2008 14:26:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CD5CB11901F0; Tue,  1 Jul 2008 14:55:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzlp2oyh7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87034>


--b9dEYEwnDXkv9lSy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2008 at 12:27:48AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> I'll queue the fixed-up result in 'pu', but I have to tend to other topics
> before I can actually publish.  Together with the fix to "head_invalid"
> confusion I mentioned in another message squashed in to this commit, all
> the tests now finally seem to pass on the topic branch.
>=20
> Oh, by the way, you sent this and the previous round without marking them
> as RFC nor WIP, even though they obviously did not even pass the test
> suite.  For example, without the head_invalid fix, anything that runs
> merge on detached head, most notably "git rebase -i", would not work at
> all.

Thanks for pointing that out. I remember I used to run 'make test'
before sending a patch, but that took a lot of time and then I used to
run only t*merge*.sh, which - it turns out - was a bad idea, since I
haven't noticed breaking t3404.

I'm now running a full 'make test' before I send the patch.

--b9dEYEwnDXkv9lSy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhqKTYACgkQe81tAgORUJbZWQCcDxcrRuPz1vg6ZikQyhBVHK1g
XugAoIpQMAFrtU2K19VxaxDSoAY7lEhU
=ZokP
-----END PGP SIGNATURE-----

--b9dEYEwnDXkv9lSy--
