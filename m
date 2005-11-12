From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH Cogito] Fix t/t9300-seek.sh
Date: Sat, 12 Nov 2005 23:55:25 +0100
Message-ID: <20051112225525.GA13674@ferdyx.org>
References: <20051112223914.GA1150@ferdyx.org> <20051112224743.GJ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
X-From: git-owner@vger.kernel.org Sat Nov 12 23:56:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb4HW-0003qp-PJ
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVKLWzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVKLWzb
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:55:31 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:52883
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S932353AbVKLWzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:55:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id A42248D314
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 23:55:14 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07664-04 for <git@vger.kernel.org>;
	Sat, 12 Nov 2005 23:55:12 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id AA5C88D30B
	for <git@vger.kernel.org>; Sat, 12 Nov 2005 23:55:11 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Sat, 12 Nov 2005 23:55:26 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051112224743.GJ30496@pasky.or.cz>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11718>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 12, 2005 at 11:47:43PM +0100, Petr Baudis wrote:
| Dear diary, on Sat, Nov 12, 2005 at 11:39:14PM CET, I got a letter
| where "Fernando J. Pereda" <ferdy@ferdyx.org> said that...
| > After 'seeking' to the first commit, identical should have 'identical'
| > instead of 'nonconflicting'.
|=20
| Nope, since we locally change it to "nonconflicting", and cg-seek is
| supposed to keep local changes.

Ouch... I failed to see that. Then that test is failing for me,
'identical' actually contains 'identical'. I used cogito-0.16rc1 is it
suposed to work? Or is it known to be broken?

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdnLdCkhbDGC9KNQRAthrAJwNJG20CPa91kW4koVJiM0imL1A+ACfS1Sq
0SepkeEJhjbWFRznW7omook=
=kapc
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
