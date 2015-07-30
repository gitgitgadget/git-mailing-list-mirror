From: Joey Hess <id@joeyh.name>
Subject: git pull --upload-pack reversion in git 2.5.0
Date: Thu, 30 Jul 2015 11:45:23 -0400
Message-ID: <20150730154523.GA17002@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 30 17:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq1Z-0000Up-QD
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbG3Ppd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:45:33 -0400
Received: from kitenet.net ([66.228.36.95]:54492 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbbG3Ppa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:45:30 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=J4dzyl7h;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1438271123; bh=qCGD8vuKHUDwPjISaxpaXVribBAjbX5CO7VPIU9YfW0=;
	h=Date:From:To:Subject:From;
	b=J4dzyl7hGqZx5LB8OmiXz815wAQTFVgdpve+hjxbU5BDE0LjSmFDoajaI3nO2fSA3
	 4MBxKJ36I1jnfFrdp2edacjOTHKFCAUoVOglo7fDVjCnCiYo+g32rUWCaWr+ZzxzDo
	 c1ID9TSPvA1Q8q72rxqjvA3ZTO8azaJ74zuIlfSM=
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-94.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,
	RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no autolearn_force=no
	version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275001>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In git 2.1.4, I can run: git pull --upload-pack 'echo --foo'

This also seems to work in 2.4.6, but in 2.5.0, the option parser
does something weird, apparently looking inside the quoted parameter
and parsing parameters in there:

error: unknown option `foo'
usage: git fetch [<options>] [<repository> [<refspec>...]]

Needless to say, this broke my use of --upload-pack.

--=20
see shy jo

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVbpGk8kQ2SIlEuPHAQIHuQ/+KdwFaYlubidjwHyloLHbyLh95lnekOC9
ZR5O62wwhndRwAjCUmfczzFl8NJJ73G3o8aLT2FrhLpaiESRR9xZyKUFQoqZ6MYH
KPd13ZOi/x4Xv05D7szANiJ0QDljUBtLnXF/bED8grCEVw04FPtfr9Fl9X1WVnne
sNSvg+lEH6L9VF0UxVZ18LNxJMR8UmFzuJIGB797EXFEviEtyionHJLiTyA6oWyO
N6F3o8BjT2okI+ZdCSM2tdV7pAQD04jwvB/ji04jEbfywZBjxZi5c2wpzFF+7thG
ZnI42ij1uX/giSahL9wBiEPk/0sTQbCdrc5ZnaagXb2GHk36ng0lzkfhu3IVWd20
XxZkYp4O9QKvdG+DNJ++v65b6E8P/G9C9BAui2BUyEhRcqTbwyG3IC5JR0DiVCjd
4HZqsPg9lm4XlHrb+txOrjYYA8B6QQGVB9GXezebu/Eea8xI8Cf/3OwJKHJYD4z3
eLWHc15apbSIH48hlxvAVhR+UbglWgG1DcI/ywVgB0yEcrxrfkIIxVL1O0fYxz7X
Qq2kbZt7QfjZj0r+nnb7+CKc57eSP0jZo3l0CCWhA6FTDuT9oiKqQjgBO3xt52ho
rzQjyf33yn3RsPLazPlwYNi4X90tSJYq33QQXMXHbhgxnXzY8zAGTxIXPjUTO1Hb
7k8CKpAql4E=
=xAHq
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
