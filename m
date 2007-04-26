From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 5/9] Perform correct quoting of recipient names.
Date: Wed, 25 Apr 2007 21:41:37 -0700
Message-ID: <20070426044137.GL7846@curie-int.orbis-terrarum.net>
References: <1177555043986-git-send-email-robbat2@gentoo.org> <11775550432104-git-send-email-robbat2@gentoo.org> <1177555043272-git-send-email-robbat2@gentoo.org> <11775550432268-git-send-email-robbat2@gentoo.org> <11775550433288-git-send-email-robbat2@gentoo.org> <11775550432746-git-send-email-robbat2@gentoo.org> <7vhcr3vkjd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Cc: robbat2@gentoo.org
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 26 06:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgvnU-0000IU-V6
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 06:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbXDZElX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 00:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754411AbXDZElX
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 00:41:23 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:55625 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754375AbXDZElW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 00:41:22 -0400
Received: (qmail 8297 invoked from network); 26 Apr 2007 04:41:21 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 04:41:21 +0000
Received: (qmail 2472 invoked by uid 10000); 25 Apr 2007 21:41:37 -0700
Content-Disposition: inline
In-Reply-To: <7vhcr3vkjd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45608>


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2007 at 09:15:02PM -0700, Junio C Hamano wrote:
> While this one is definitely an improvement, I am a bit unhappy
> about the way @to, @cc and @bcclist are not sanitized the same
> way.
@bcclist does not need the quoting, as everything except the email addresse=
s is
stripped out of it, see patch 6/9.

I'll do an additional patch for @to however, give me a moment.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGMC2BPpIsIjIzwiwRAiGCAJ9TwqtW6pgVvQbgmt0hLP9KM/7AiACfaA83
YKY1jEadsjmqxKd4o34kRiU=
=xtPz
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--
