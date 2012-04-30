From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 30 Apr 2012 21:20:16 +0200
Message-ID: <20120430192016.GQ4023@login.drsnuggles.stderr.nl>
References: <1335468843-24653-1-git-send-email-matthijs@stdin.nl> <20120427082118.GA7257@dcvr.yhbt.net> <20120427082559.GC4023@login.drsnuggles.stderr.nl> <20120429082341.GA32664@dcvr.yhbt.net> <7vvckihyqm.fsf@alter.siamese.dyndns.org> <7vk40yhv5q.fsf@alter.siamese.dyndns.org> <20120430081939.GA27715@dcvr.yhbt.net> <7vipghgq9a.fsf@alter.siamese.dyndns.org> <20120430165315.GO4023@login.drsnuggles.stderr.nl> <20120430190200.GA27108@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2XdB133IMUbxuUPz"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOw97-00047c-Se
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab2D3TUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 15:20:25 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:36289 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab2D3TUY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 15:20:24 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SOw8u-0003XK-I9; Mon, 30 Apr 2012 21:20:17 +0200
Received: (nullmailer pid 13595 invoked by uid 1000);
	Mon, 30 Apr 2012 19:20:16 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
Content-Disposition: inline
In-Reply-To: <20120430190200.GA27108@dcvr.yhbt.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196597>


--2XdB133IMUbxuUPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

> > This does textual comparison, so 1.6.6 > 1.6.12. To do proper version
> > comparison, I think the version numbers should be split into
> > major/minor/revision and each be compared numerically.
>=20
> Ah, thanks for the analysis, we were lucky in the past that all version
> components only had a single character.
Indeed. Note that this includes the released subversion versions. For
example, the code contains this check:

    $SVN::Core::VERSION le '1.5.4'

and 1.5.10 < 1.5.4. Fortunately, 1.5.9 was the last release in the 1.5
series, and no other checks compare against 1.6.x.

If subversion would ever reach the 1.10.x version number, things would
also start breaking.

> I think the former is preferable for git.  Sort::Versions isn't used
> anywhere else in git and I don't think it's widely installed.
I guessed as much. I'll have a look at providing a patch.

Gr.

Matthijs

--2XdB133IMUbxuUPz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk+e5fAACgkQz0nQ5oovr7wJYwCghcG22fuR79eGEHKq4annhKB5
0lIAn08sAvJUT8Z/H2bnrUDgI247K3OL
=TPyL
-----END PGP SIGNATURE-----

--2XdB133IMUbxuUPz--
