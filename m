From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] git-svn: don't blindly append '*' to branch/tags config
Date: Fri, 14 Mar 2008 20:39:41 +0100
Message-ID: <20080314193941.GA24022@piper.oerlikon.madduck.net>
References: <20080313112738.GA28589@piper.oerlikon.madduck.net> <20080314180123.GB3107@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 20:41:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaFmR-0006Hy-E4
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 20:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbYCNTkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 15:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbYCNTkB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 15:40:01 -0400
Received: from clegg.madduck.net ([82.197.162.59]:49542 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758822AbYCNTj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 15:39:59 -0400
Received: from wall.oerlikon.madduck.net (84-75-151-30.dclient.hispeed.ch [84.75.151.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 02E41A803F;
	Fri, 14 Mar 2008 20:39:42 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 1BB109F18E;
	Fri, 14 Mar 2008 20:39:42 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 05D5E3F29; Fri, 14 Mar 2008 20:39:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080314180123.GB3107@hand.yhbt.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6234/Fri Mar 14 19:12:40 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77277>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Eric Wong <normalperson@yhbt.net> [2008.03.14.1901 +0100]:
> Previously, git-svn would blindly append '*' even if it was specified by
> the user during initialization (for certain SVN setups, it is
> necessary).
>=20
> Now, the following command will work correctly:
>=20
>   git svn init -T trunk/docutils \
>                -t 'tags/*/docutils' \
>                -b 'branches/*/docutils' \
>                svn://svn.berlios.de/docutils

I can confirm this. Thanks, Eric for the blazing turnaround time.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the surest way to corrupt a youth is to instruct him to hold in
 higher esteem those who think alike than those who think
 differently."
                                              -- friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH2tR9IgvIgzMMSnURAgYdAKDDWt46r2q14eWrD+EYIQKWXaTJNQCfd/3n
jHK8qxdITSMEJU+nuhNEEKg=
=HB02
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
