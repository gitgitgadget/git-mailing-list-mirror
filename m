From: "martin f. krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 19:28:06 +0100
Message-ID: <20080515182806.GA14799@lapse.madduck.net>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org> <20080515101523.GA31719@lapse.madduck.net> <7vlk2bh45u.fsf@gitster.siamese.dyndns.org> <20080515175555.GA13003@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 20:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwiCb-0001fP-GK
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 20:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268AbYEOS20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 14:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbYEOS20
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 14:28:26 -0400
Received: from clegg.madduck.net ([82.197.162.59]:48601 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYEOS2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 14:28:25 -0400
Received: from lapse.madduck.net (ruou.ifi.unizh.ch [130.60.75.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id A9698A8286;
	Thu, 15 May 2008 20:28:07 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 28C283FAD5; Thu, 15 May 2008 19:28:06 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <20080515175555.GA13003@atjola.homenet>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7130/Thu May 15 19:37:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82217>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> [2008.05.15.1855 +0100=
]:
> It kind of feels like a bug that git-pull does not export GIT_DIR there,
> but you could probably also argue that it is wrong not to have GIT_DIR
> set in the environment when using a non-standard name for the git dir.
> Hm?

Ah, but it is a standard name: .

If git does not find .git, it *does* seem to look into the current
directory too; that's why commands work inside bare repos...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
click the start menu and select 'shut down.'
=20
spamtraps: madduck.bogus@madduck.net

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILIC2IgvIgzMMSnURAqmwAKDfJJpx5XEkEkAQttq0+GCY/vFJ5gCgqWPm
92ynz7lPu0Sk7rahBGOOn2w=
=1bAX
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
