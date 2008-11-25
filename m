From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] tg export: implement skipping empty patches for quilt
	mode
Date: Tue, 25 Nov 2008 09:45:31 +0100
Organization: The Debian project
Message-ID: <20081125084531.GA13122@lapse.rw.madduck.net>
References: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 25 21:47:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L54of-0002ca-Hi
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 21:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYKYUqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 15:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbYKYUqI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 15:46:08 -0500
Received: from clegg.madduck.net ([193.242.105.96]:33883 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbYKYUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 15:46:07 -0500
Received: from lapse.rw.madduck.net (lapse.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:20a:e4ff:fe30:4316])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id BA3201D40AC;
	Tue, 25 Nov 2008 21:45:50 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id D838480E5; Tue, 25 Nov 2008 09:45:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227563810-5426-1-git-send-email-u.kleine-koenig@pengutronix.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.27-1-686 i686
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8680/Tue Nov 25 19:37:58 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101679>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [2008.11.24=
=2E2256 +0100]:
> +skipempty=3Dfalse

Any reason not to make it default? Why do we even need this option?
Do empty quilt files ever have a purpose?

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"the husbands of very beautiful women
 belong to the criminal classes."
                                                        -- oscar wilde

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkruysACgkQIgvIgzMMSnUs1ACfecUa+FVoo41ZIBSBtRuai4a0
x+8Ani08o2sqPxE04LvPTFi9JoRwQPqp
=Z0VO
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
