From: martin f krafft <madduck@madduck.net>
Subject: Re: [TopGit PATCH] put die() messages to stderr
Date: Fri, 21 Nov 2008 13:36:54 +0100
Message-ID: <20081121123654.GB20537@piper.oerlikon.madduck.net>
References: <1227261900-23420-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 13:38:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3VHE-0007mW-IY
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 13:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbYKUMhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 07:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYKUMhJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 07:37:09 -0500
Received: from clegg.madduck.net ([193.242.105.96]:54690 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbYKUMhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 07:37:06 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 06DA71D40A9;
	Fri, 21 Nov 2008 13:36:55 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 943D39F355;
	Fri, 21 Nov 2008 13:36:54 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 30F7145F5; Fri, 21 Nov 2008 13:36:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227261900-23420-1-git-send-email-bert.wesarg@googlemail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.26-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8658/Fri Nov 21 11:54:22 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101521>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2008.11.21.1105 +0100=
]:
> -	info "fatal: $*"
> +	info "fatal: $*" >&2

Shouldn't info also output to stderr?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"i have made good judgments in the past.
 i have made good judgments in the future."
                                                      - george w. bush
=20
spamtraps: madduck.bogus@madduck.net

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkmq2UACgkQIgvIgzMMSnVBsgCeI0wLrqDJouD9Ao+LNMns3mgF
Qy4AoJiD2CQkuodpxTiybBxsC1avrtR+
=ZlDy
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
