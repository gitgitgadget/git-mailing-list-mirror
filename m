From: martin f krafft <madduck@madduck.net>
Subject: Re: git-remote: Use of uninitialized value in string ne, line 248
Date: Wed, 24 Oct 2007 13:59:43 +0200
Message-ID: <20071024115943.GA1016@piper.oerlikon.madduck.net>
References: <20071024110807.GA12501@piper.oerlikon.madduck.net> <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
To: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 14:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkeuJ-0000Fj-GA
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 14:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXJXL75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 07:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbXJXL75
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 07:59:57 -0400
Received: from clegg.madduck.net ([82.197.162.59]:53948 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbXJXL74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 07:59:56 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 19B76A808F;
	Wed, 24 Oct 2007 14:00:26 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 06A9A9F13B;
	Wed, 24 Oct 2007 13:59:44 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id D6F254408; Wed, 24 Oct 2007 13:59:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwstc68bk.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4589/Wed Oct 24 11:55:55 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62212>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2007.10.24.1349 +0200]:
> -		next if ($branch->{$branchname}{'REMOTE'} ne $name);
> +		next if (!$branch->{$branchname}{'REMOTE'} ||
> +			 $branch->{$branchname}{'REMOTE'} ne $name);

Confirmed: this fixes the issue. Thanks.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"convictions are more dangerous enemies of truth than lies."
                                                 - friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHzOvIgvIgzMMSnURAsTVAKCYF7lmmngzhAXYG+TNDxyawWNHkwCgjHyx
6C0CMbJVyynMR6OOutGvVqo=
=/9N2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
