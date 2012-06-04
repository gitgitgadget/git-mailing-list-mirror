From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH 1/2] git-svn: use platform specific auth providers
Date: Mon, 4 Jun 2012 11:00:16 +0200
Message-ID: <20120604090016.GA4023@login.drsnuggles.stderr.nl>
References: <7vvckihyqm.fsf@alter.siamese.dyndns.org> <7vk40yhv5q.fsf@alter.siamese.dyndns.org> <20120430081939.GA27715@dcvr.yhbt.net> <7vipghgq9a.fsf@alter.siamese.dyndns.org> <20120430165315.GO4023@login.drsnuggles.stderr.nl> <20120430190200.GA27108@dcvr.yhbt.net> <20120430192016.GQ4023@login.drsnuggles.stderr.nl> <7vy5pcd7xu.fsf@alter.siamese.dyndns.org> <20120603104914.GA21276@hashpling.org> <7vfwacxe7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hqh6tPEz2ENDxQev"
Cc: Charles Bailey <charles@hashpling.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 11:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbT9L-0000xr-1i
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 11:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab2FDJA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 05:00:27 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:49034 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab2FDJA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 05:00:26 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1SbT96-0001PJ-Cs; Mon, 04 Jun 2012 11:00:17 +0200
Received: (nullmailer pid 5409 invoked by uid 1000);
	Mon, 04 Jun 2012 09:00:16 -0000
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
Content-Disposition: inline
In-Reply-To: <7vfwacxe7p.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199121>


--hqh6tPEz2ENDxQev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey folks,

> It is possible that '1.6.12' is not the right cut-off point and the
> logic may require a version newer than that but that is outside the
> scope of f760c90.
It seems this is indeed the case. I can't remember what I based the
1.6.12 on, but looking at the svn changelog [1], the first working version
is 1.6.15:

    Version 1.6.15
    [...]
       * improve some swig parameter mapping (r984565, r1035745)

[1]: http://svn.apache.org/repos/asf/subversion/trunk/CHANGES

Gr.

Matthijs

--hqh6tPEz2ENDxQev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk/MeSAACgkQz0nQ5oovr7ytBACfYX/oRx/9YBvU2z1uk7BC/WKO
dJIAniJqZvc9+K4oL2SQ0r5WhCsyS6v3
=Tav1
-----END PGP SIGNATURE-----

--hqh6tPEz2ENDxQev--
