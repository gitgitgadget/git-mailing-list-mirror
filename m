From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: html userdiff is not showing all my changes
Date: Wed, 15 Dec 2010 10:12:50 +0100
Message-ID: <20101215091250.GO3069@login.drsnuggles.stderr.nl>
References: <561247.22837.qm@web110707.mail.gq1.yahoo.com> <4D08850D.3010402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxmd2aOE9n9J83EO"
Cc: Scott Johnson <scottj75074@yahoo.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 15 10:13:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnQ3-0005Gh-61
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0LOJNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 04:13:00 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:53234 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab0LOJM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 04:12:58 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PSnPm-0000u6-8O; Wed, 15 Dec 2010 10:12:50 +0100
Received: (nullmailer pid 3473 invoked by uid 1000);
	Wed, 15 Dec 2010 09:12:50 -0000
Mail-Followup-To: Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Johnson <scottj75074@yahoo.com>, git@vger.kernel.org,
	trast@student.ethz.ch
Content-Disposition: inline
In-Reply-To: <4D08850D.3010402@drmicha.warpmail.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163748>


--qxmd2aOE9n9J83EO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

> If a wordRegex can make parts of diff disappear than there is problem
> deeper in the diff machinery.
It can do exactly that. The word regex determines what is a word, but
everything else is counted as "whitespace". The word diff view shows
only differences in words, not in whitespace (which is intentional,
since whitespace changes in things like LaTeX or HTML are not
interesting). Note that it doesn't show whitespace _differences_, but it
does show the whitespace itself (taken from the "new" version of the
file).


So, if the word regex somehow doesn't match the second line at all (or
at least not the differen part), the differences could get ignored.

> Can you trim this down to a minimal example?
That would be useful in any case.

Gr.

Matthijs

--qxmd2aOE9n9J83EO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0IhpIACgkQz0nQ5oovr7xuhQCfTjmMjNrk5Gz2hIVfadxRjU1k
Ox8AoLZk3EjFTa/IDfDQImUw0/i7JLo+
=jNhz
-----END PGP SIGNATURE-----

--qxmd2aOE9n9J83EO--
