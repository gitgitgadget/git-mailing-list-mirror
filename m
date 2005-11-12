From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH Cogito] Fix t/t9300-seek.sh
Date: Sun, 13 Nov 2005 00:01:17 +0100
Message-ID: <20051112230117.GB13674@ferdyx.org>
References: <20051112223914.GA1150@ferdyx.org> <20051112224743.GJ30496@pasky.or.cz> <20051112225525.GA13674@ferdyx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
X-From: git-owner@vger.kernel.org Sun Nov 13 00:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb4NH-00057c-Mq
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 00:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVKLXBX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLXBX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 18:01:23 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:58259
	"EHLO smtp.ferdyx.org") by vger.kernel.org with ESMTP
	id S932353AbVKLXBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 18:01:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 8949A8D314
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 00:01:06 +0100 (CET)
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07664-06 for <git@vger.kernel.org>;
	Sun, 13 Nov 2005 00:01:04 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id E74088D30B
	for <git@vger.kernel.org>; Sun, 13 Nov 2005 00:01:03 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@ferdyx.org; Sun, 13 Nov 2005 00:01:18 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051112225525.GA13674@ferdyx.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at ferdyx.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11719>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 12, 2005 at 11:55:25PM +0100, Fernando J. Pereda wrote:
| On Sat, Nov 12, 2005 at 11:47:43PM +0100, Petr Baudis wrote:
| | Dear diary, on Sat, Nov 12, 2005 at 11:39:14PM CET, I got a letter
| | where "Fernando J. Pereda" <ferdy@ferdyx.org> said that...
| | > After 'seeking' to the first commit, identical should have 'identical'
| | > instead of 'nonconflicting'.
| |=20
| | Nope, since we locally change it to "nonconflicting", and cg-seek is
| | supposed to keep local changes.
|=20
| Ouch... I failed to see that. Then that test is failing for me,
| 'identical' actually contains 'identical'. I used cogito-0.16rc1 is it
| suposed to work? Or is it known to be broken?

Actually don't mind me. It justs fails under the Gentoo sandbox. Sorry
for the noise.

Cheers,
Ferdy

--=20
Fernando J. Pereda Garcimart=EDn
Gentoo Developer (Alpha,net-mail,mutt,git)
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdnQ9CkhbDGC9KNQRAtp3AKCQARo3eLugL2bffwp7kNAXjij3cgCbBaAM
NxUXQI0JSkVQ4LfpytzO4xw=
=j3Hn
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
