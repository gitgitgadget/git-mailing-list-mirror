From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] gitk: improve dark background support
Date: Mon, 8 Nov 2010 14:14:12 +0100
Message-ID: <20101108131412.GE22067@login.drsnuggles.stderr.nl>
References: <20101104003524.GI7835@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nz+5OzHEKtBHuvb9"
Cc: git@vger.kernel.org
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFRYJ-0007rb-N8
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab0KHNOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 08:14:18 -0500
Received: from drsnuggles.stderr.nl ([94.142.244.14]:49595 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0KHNOS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:14:18 -0500
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1PFRY4-0001Cg-NJ; Mon, 08 Nov 2010 14:14:13 +0100
Received: (nullmailer pid 4625 invoked by uid 1000);
	Mon, 08 Nov 2010 13:14:12 -0000
Mail-Followup-To: David Fries <david@fries.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101104003524.GI7835@spacedout.fries.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160933>


--nz+5OzHEKtBHuvb9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I've been using gitk with a gray-on-black color-scheme for a while now,
so I've given your patch a test drive. It seems to work as expected and
indeed makes gitk a bit more pleasant to use with a dark color scheme.

I've reviewed the code a bit and it looks ok as well (though I'm hardly
familiar with git internals, and not at all in this area).

I did encounter one minor issue, though: If you change the foreground
color, the current view is not updated until you restart or switch views
(or otherwise trigger a redraw, I guess). A quick look at the code shows
that the "setfg" function contains some code that updates all canvases
and all contexts in $fglist with the new fg color. I guess that
something similar should be done for these tag colors to get them
updated right away (though perhaps that should be a second patch)?

A final note: There are still some other problems with working with
grey-on-black color scheme. In case your interested in working on those,
I've listed them at http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=568470

Gr.

Matthijs

--nz+5OzHEKtBHuvb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzX96QACgkQz0nQ5oovr7wnhACdEQ6n0S/UdpalhG+QL/itFLry
HcwAoJQKdeSBAlQMoXMXjL5IbJnfaQj1
=cYvD
-----END PGP SIGNATURE-----

--nz+5OzHEKtBHuvb9--
