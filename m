From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Automatically filling in git send-email arguments based on an
 existing e-mail
Date: Wed, 2 Oct 2013 10:25:25 +0200
Message-ID: <20131002082525.GU10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0KpsattHCfnnnbNf"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 10:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRHkY-0004Re-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 10:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab3JBIZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 04:25:34 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:54205 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3JBIZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 04:25:31 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1VRHkL-0000fn-RA
	for git@vger.kernel.org; Wed, 02 Oct 2013 10:25:26 +0200
Received: (nullmailer pid 2588 invoked by uid 1000);
	Wed, 02 Oct 2013 08:25:25 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235666>


--0KpsattHCfnnnbNf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

sometimes when I send a patch, I want to reply it to an existing e-mail,
using pretty much the same recipient list. Currently, I have to:

 - copy-paste the message id for --in-reply-to header
 - copy one address for --to
 - copy the other addresses for the --cc's

Since I can't just chuck a list of addresses into --cc and I need to
quote every one because of the <> and spaces in there, this feels like
it's more tedious than needed.

It seems like there should be a weay to just copy paste the headers from
the original e-mail into the stdin of git send-email or a wrapper script
and let it sort things out from there.


Is there any interest in something like this? Does anyone else perhaps
already have such a script lying around?

(After writing this mail, I just noticed "[PATCH] git-send-email: two
new options: to-cover, cc-cover", which could help a bit to simplify
things, but not quite as far as I'm proposing here...)

Gr.

Matthijs

--0KpsattHCfnnnbNf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAlJL2HUACgkQz0nQ5oovr7xESwCgki4hMW6UdlcVuh4VW70tyxK9
+SkAnicXbAQJ3brk7sExvEcet+FIFBv7
=VoKd
-----END PGP SIGNATURE-----

--0KpsattHCfnnnbNf--
