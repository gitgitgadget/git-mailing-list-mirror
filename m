From: martin f krafft <madduck@debian.org>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log
	--graph
Date: Tue, 19 May 2009 15:28:54 +0200
Organization: The Debian project
Message-ID: <20090519132854.GA9606@piper.oerlikon.madduck.net>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Tue May 19 15:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PNm-0004PX-HR
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZESN3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 09:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbZESN3R
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:29:17 -0400
Received: from clegg.madduck.net ([193.242.105.96]:41915 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbZESN3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 09:29:17 -0400
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "piper.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id AD9631D409E;
	Tue, 19 May 2009 15:28:55 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id DB1F644C6; Tue, 19 May 2009 15:28:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.30-rc5-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9370/Tue May 19 15:10:15 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119525>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2009.05.19.0744 +0200=
]:
> @@ -62,12 +70,33 @@ git for-each-ref refs/top-bases |
>  			continue
>  		fi
>  		if [ -n "$graphviz" ]; then
> +
> +			if [ -n "$graphviz_verbose" ]; then
> +				type=3D"header"
> +				lines=3D0
> +				echo "\t\"$name\" ["

You need to pass -e to echo for it to honour escape sequences. That
should solve Michael's problem. Alternatively, just use ^I directly.

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"in just seven days, i can make you a man!"
                                      -- the rocky horror picture show

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkoStBMACgkQIgvIgzMMSnXxoQCgm8mK1xbWdo9UnhqLe6JNLa4W
xwIAoMSYC24rPLZ2zv3S+Ve+LbUQMELN
=DzOC
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
