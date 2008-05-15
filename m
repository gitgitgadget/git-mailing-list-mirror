From: "martin f. krafft" <madduck@madduck.net>
Subject: Re: [PATCH] Export GIT_DIR after setting it
Date: Thu, 15 May 2008 11:15:23 +0100
Message-ID: <20080515101523.GA31719@lapse.madduck.net>
References: <1210807401-11201-1-git-send-email-madduck@madduck.net> <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 12:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwaVl-0005tp-FN
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 12:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbYEOKPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 06:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbYEOKPl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 06:15:41 -0400
Received: from clegg.madduck.net ([82.197.162.59]:40476 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbYEOKPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 06:15:40 -0400
Received: from lapse.madduck.net (ruou.ifi.unizh.ch [130.60.75.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id B2413A8287
	for <git@vger.kernel.org>; Thu, 15 May 2008 12:15:23 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 715013FA4E; Thu, 15 May 2008 11:15:23 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <7vod78i9r7.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/7126/Thu May 15 11:40:39 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82196>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you, Junio, for taking the time to reply to this!

also sprach Junio C Hamano <gitster@pobox.com> [2008.05.15.0325 +0100]:
> trying to solve like this patch does, but this change needs very
> careful vetting to make sure that you did not break other scripts
> with this change.

Absolutely agreed. It occured to me as I lied down to sleep that
this fix could quite possibly have repercussions. And it's been in
my head all the walk to my work this morning. I ended up thinking
about it in this way:

If GIT_DIR is exported by git-sh-setup and we can assure that
git-sh-setup gets it right, then it's effectively the same as if the
user had set it explicitly, before calling the shell script: all
external commands called by the shell script will have GIT_DIR set
appropriately in all cases then.

The only problem I see now is when an external command (or the shell
script) can't properly deal with GIT_DIR being set, but then that's
a whole different bug.

I understand you're worried about this, but I can't really see
specifics, now having thought about this for a bit.

> This arrangement predates separate work-tree by many months.  It
> could be that what needs fixing is the separate work-tree code.

Oh yeah, and I've been meaning to look into that for a long time.
Sigh.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"she was rather too intelligent and competent-looking to be
 considered entirely beautiful, but all the more attractive because
 of it."
                           -- george spencer-brown, "a lion's teeth"
=20
spamtraps: madduck.bogus@madduck.net

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILA07IgvIgzMMSnURAuM9AKDhG3OGUfeiDlE5tMTefRFZeNHDygCfZwnH
wmsdhDEockbUIsrNHB6Dr/k=
=/w/L
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
