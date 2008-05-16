From: "martin f. krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Fri, 16 May 2008 22:50:25 +0100
Message-ID: <20080516215025.GA8250@lapse.madduck.net>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org> <20080515101523.GA31719@lapse.madduck.net> <7vlk2bh45u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 00:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx8Be-0006fK-Lv
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 00:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbYEPWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbYEPWNK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 18:13:10 -0400
Received: from seamus.madduck.net ([213.203.238.82]:49159 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbYEPWNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 18:13:09 -0400
X-Greylist: delayed 1317 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 May 2008 18:13:09 EDT
Received: from lapse.madduck.net (ruou.ifi.unizh.ch [130.60.75.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id D7D6340A2FA;
	Fri, 16 May 2008 23:50:58 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id E55974FD5B; Fri, 16 May 2008 22:50:25 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <7vlk2bh45u.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7138/Fri May 16 22:02:17 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82318>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2008.05.15.1823 +0100]:
> I have a suspicion that "the whole different bug" is what bit you
> -- perhaps some places need to also set and export GIT_WORK_TREE
> as well when the do GIT_DIR.

Probably also true, worktree support is still riddled with a lot of
small little bugs... but I don't see how this would actually solve
the problem that caused me to write this patch...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
whatever you do will be insignificant,
but it is very important that you do it.
                                                     -- mahatma gandhi
=20
spamtraps: madduck.bogus@madduck.net

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILgGhIgvIgzMMSnURApIQAKCwhsv0jlUeyMeB1OI9BKIB1J8AmgCePNvz
J+k8/wADtCl7P/wAbgwgNfQ=
=2Typ
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
