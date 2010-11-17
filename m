From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
	create '//etc/.git/index.lock': No such file or directory
Date: Wed, 17 Nov 2010 12:20:42 +0100
Message-ID: <20101117112042.GX22067@login.drsnuggles.stderr.nl>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cQhetzcoY2fnMuoN"
Cc: git@vger.kernel.org
To: Albert Strasheim <fullung@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 12:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIg4J-0005VT-Qn
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 12:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934050Ab0KQLUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 06:20:46 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:51137 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962Ab0KQLUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 06:20:45 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PIg4A-0006fW-Pg; Wed, 17 Nov 2010 12:20:43 +0100
Received: (nullmailer pid 25634 invoked by uid 1000);
	Wed, 17 Nov 2010 11:20:42 -0000
Mail-Followup-To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161610>


--cQhetzcoY2fnMuoN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

> su
> cd /
> git init

I've been using git for exactly this purpose succesfully for a while now
(git 1.5.6.5 from Debian stable and I think also 1.7.2.3 from Debian
testing). The only problem I've found was that, with the former version,
a lot of operations need to happen while the current dir is /, otherwise
it wouldn't find the git repository properly (or do other weird stuff).
This problem was gone in the latter version.

> fatal: Unable to create '//etc/.git/index.lock': No such file or directory

This sounds like git assumes /etc/.git exists, but it really doesn't.
Not sure why that happens.

Gr.

Matthijs

--cQhetzcoY2fnMuoN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzjuooACgkQz0nQ5oovr7y32QCfb4JYlNMFqgsLJ52fvMZYjpi6
dK8AniJ/H2dx38v2LfqsEXGIs7hlz72x
=ZO/X
-----END PGP SIGNATURE-----

--cQhetzcoY2fnMuoN--
