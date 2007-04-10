From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Tue, 10 Apr 2007 15:42:14 -0700
Message-ID: <20070410224213.GF18541@curie-int.orbis-terrarum.net>
References: <11762425341841-git-send-email-robbat2@gentoo.org> <20070410223826.GH2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Apr 11 07:56:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbP3H-0001ob-Jl
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 00:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbXDJWmB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 18:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030732AbXDJWmB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 18:42:01 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51993 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030726AbXDJWl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 18:41:59 -0400
Received: (qmail 29097 invoked from network); 10 Apr 2007 22:41:57 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 10 Apr 2007 22:41:57 +0000
Received: (qmail 29065 invoked by uid 10000); 10 Apr 2007 15:42:14 -0700
Mail-Followup-To: git@vger.kernel.org, junkio@cox.net
Content-Disposition: inline
In-Reply-To: <20070410223826.GH2813@planck.djpig.de>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44192>


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2007 at 12:38:27AM +0200, Frank Lichtenheld wrote:
> At least some MTAs (exim is the one I know for sure) can restrict -f
> usage to some users and deny it for others. Don't know how much this
> would really be a problem, but using -f unconditionally might be a bad
> idea none-the-less.
In those cases, the sendmail binary should fail gracefully, and then you
know that at least your email isn't lost into the ether.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGHBLFPpIsIjIzwiwRApZfAJ9zbEjeDxgODRnPER5vyosSvqOLqwCbBAHP
YdyS148HZjBUvNY/ukUtnZ0=
=3C/A
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
