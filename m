From: martin f krafft <madduck@madduck.net>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Fri, 19 Sep 2008 18:04:06 +0100
Message-ID: <20080919170406.GA22849@lapse.rw.madduck.net>
References: <20080914203043.GA4872@lapse.rw.madduck.net> <20080914210316.GJ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgziH-0007Pa-WF
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbYITK2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 06:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYITK2H
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:28:07 -0400
Received: from seamus.madduck.net ([213.203.238.82]:38791 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYITK2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:28:05 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Sep 2008 06:28:05 EDT
Received: from lapse.rw.madduck.net (host81-151-148-227.range81-151.btcentralplus.com [81.151.148.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id CDC4445AACD;
	Sat, 20 Sep 2008 12:18:46 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id CD3C280C3; Fri, 19 Sep 2008 18:04:06 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <20080914210316.GJ10360@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94/8290/Sat Sep 20 03:23:09 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96353>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Petr Baudis <pasky@suse.cz> [2008.09.14.2203 +0100]:
> 	tg depend fold RETIRED VANILLA
>=20
>   (i) Take the RETIRED _base_ branch
>=20
>   (ii) Merge in VANILLA
>=20
>   (iii) Merge in RETIRED head branch with -s ours
>=20
>   (iv) Now we have a commit that contains RETIRED topic branch, but with
> the RETIRED's changes taken from VANILLA instead of RETIRED
>=20
>   (v) Merge this into the base of your current branch
>=20
>   (vi) Merge base to the head of your current branch, replacing RETIRED
> with VANILLA (if not already there) in the .topdeps
>=20
>   (vii) You do not have to add VANILLA if you depend on it recursively
> and ran tg update before to get it from your dependencies
>=20
>   Maybe in your case this could be even simpler but this should be the
> general process. Does that sound right?

Yes, it does. One might want to consider to make the use of -s ours
in (iiii) configurable, but otherwise that's it.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
all information contained in the above is false,
for reasons of military security.
=20
spamtraps: madduck.bogus@madduck.net

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjT24MACgkQIgvIgzMMSnWfPQCgvhk9tkeSw4ZQHjgPOvyAOFrn
K+cAoIWDpEbjf0+75oZOPDVCRsmYemjC
=DAY6
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
