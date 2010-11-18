From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
	create '//etc/.git/index.lock': No such file or directory
Date: Thu, 18 Nov 2010 16:52:11 +0100
Message-ID: <20101118155211.GE22067@login.drsnuggles.stderr.nl>
References: <AANLkTi=UPWTeZP9uF+FGtsSs7wH3AmwdeLtsPJQnKvez@mail.gmail.com> <20101117112042.GX22067@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zUTRIrZDJBcDzrkO"
To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 16:52:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ6mk-0000er-5S
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 16:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab0KRPwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 10:52:15 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:45617 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759032Ab0KRPwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 10:52:14 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PJ6mR-0001Wi-NZ; Thu, 18 Nov 2010 16:52:12 +0100
Received: (nullmailer pid 5867 invoked by uid 1000);
	Thu, 18 Nov 2010 15:52:11 -0000
Mail-Followup-To: Albert Strasheim <fullung@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101117112042.GX22067@login.drsnuggles.stderr.nl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161677>


--zUTRIrZDJBcDzrkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

> I've been using git for exactly this purpose succesfully for a while now
> (git 1.5.6.5 from Debian stable and I think also 1.7.2.3 from Debian
> testing).
Coming back to the testing machine I was using this on, I see this
problem as well now. I'm pretty sure it wasn't there before, which would
mean it was introduced by a recent upgrade.

Checking the logs shows that I was running 1.7.1 before, and now 1.7.2.3
is broken. Downgrading to 1.7.1 indeed removes the problem.

I've rummaged around in the source a bit, haven't found the cause yet
(and I'm out of time now).

The issue also still occurs with a fairly recent git master (ca209065f:
completion: fix zsh check under bash with 'set -u').

Gr.

Matthijs

--zUTRIrZDJBcDzrkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzlS6sACgkQz0nQ5oovr7xLQACgwzgla1Cor4lSMNYuvlH2WnGW
s0oAnjYoIskXd8tGqO+7xuub2VVKedMJ
=BzwE
-----END PGP SIGNATURE-----

--zUTRIrZDJBcDzrkO--
