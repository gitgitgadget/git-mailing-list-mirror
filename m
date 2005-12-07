From: Joshua N Pritikin <jpritikin@pobox.com>
Subject: prevent git-daemon from running as root?
Date: Wed, 7 Dec 2005 10:53:12 +0530
Message-ID: <20051207052312.GE10371@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
X-From: git-owner@vger.kernel.org Wed Dec 07 06:19:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejri0-0007yy-MI
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 06:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVLGFSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 00:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVLGFSc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 00:18:32 -0500
Received: from thorn.pobox.com ([208.210.124.75]:55430 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932528AbVLGFSb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 00:18:31 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id BDED1B8
	for <git@vger.kernel.org>; Wed,  7 Dec 2005 00:18:52 -0500 (EST)
Received: from emit.nirmalvihar.info (house.nirmalvihar.info [61.17.90.7])
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id ACD7C1236
	for <git@vger.kernel.org>; Wed,  7 Dec 2005 00:18:51 -0500 (EST)
Received: by emit.nirmalvihar.info (sSMTP sendmail emulation); Wed, 7 Dec 2005 10:53:12 +0530
To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Key: 06E3 3D22 D307 AAE6 ACB4  6B44 A9CA A794 A4A6 0BBD
X-Request-PGP: http://openheartlogic.org/personal/pubkey.asc
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13319>


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

git-daemon seems to work fine when running as a non-root account.

Maybe it should refuse to start when running as root?

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDlnHAqcqnlKSmC70RAi6mAKCqwTwr80CJ6dD+x9zpZQxpqNojjgCcC/H1
9PjawgTdmIQszH8RClMHy+c=
=IVaw
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
