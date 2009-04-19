From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: checkout @{-1} bug/oddity
Date: Sun, 19 Apr 2009 22:36:29 +0200
Message-ID: <200904192236.32554.trast@student.ethz.ch>
References: <20090419153740.GA12431@chistera.yi.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1860886.3SF1Q7yqLx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sun Apr 19 22:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvdn0-0002Uh-3p
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 22:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688AbZDSUhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZDSUhP
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 16:37:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20699 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbZDSUhO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 16:37:14 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Apr 2009 22:37:11 +0200
Received: from thomas.localnet ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 19 Apr 2009 22:37:11 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.27.21-0.1-default; KDE/4.2.2; x86_64; ; )
In-Reply-To: <20090419153740.GA12431@chistera.yi.org>
X-OriginalArrivalTime: 19 Apr 2009 20:37:11.0310 (UTC) FILETIME=[9D9342E0:01C9C12E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116912>

--nextPart1860886.3SF1Q7yqLx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Adeodato Sim=F3 wrote:
>   | % g co bar
>   | Already on 'bar'
>   |=20
>   | % g co -
>   | Already on 'bar'
>=20
> In my opinion the last command should switch to master, as in, switching
> to the current branch should not lose the @{-1} history.

This is by analogy with 'cd'.  Try 'cd .; cd -' in the shell.

See

  http://article.gmane.org/gmane.comp.version-control.git/106583

for the original mention; I don't have the time to re-read the entire
thread, but IIRC it was not discussed again.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1860886.3SF1Q7yqLx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAknri1AACgkQqUud07tmzP2ieACeJFy5JO+YEY5tz0nTqmeCzHvp
2J0An27zTg7IIS1CxpSPbtLWiBGHG78V
=42vH
-----END PGP SIGNATURE-----

--nextPart1860886.3SF1Q7yqLx--
