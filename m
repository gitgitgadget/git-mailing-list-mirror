From: Joey Hess <id@joeyh.name>
Subject: undocumented core.sharedRepository=2 set by git init --shared=world
Date: Mon, 6 Jul 2015 15:25:47 -0400
Message-ID: <20150706192547.GA15396@kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 23:31:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCDyg-0005vy-AE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 23:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbbGFVaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 17:30:46 -0400
Received: from kitenet.net ([66.228.36.95]:34597 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788AbbGFVap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 17:30:45 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2015 17:30:45 EDT
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=lDUUraQQ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1436210747; bh=iqMTM7FKkLLDEtBS7OUZsTr/4x3E/2QbuHpV46yoBcE=;
	h=Date:From:To:Subject:From;
	b=lDUUraQQE3W3QUhSS8QUempAIBJ7FnI4OsurTHLMt+u5Ue0ohrTE+zbiuVkcFfnkd
	 Skghl44EXl3g0JfT5eORGYn+BExwXNKVTdUWoLb4H9sq91K0idnT+D652yUKeIawZX
	 bNZkb4NhTZShhsXf8cogC9nTUKcydTy5zMY/5JAE=
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273464>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

joey@darkstar:~/tmp>git init --shared=3Dworld testrepo
Initialized empty shared Git repository in /home/joey/tmp/testrepo/.git/
joey@darkstar:~/tmp>grep shared testrepo/.git/config=20
	sharedrepository =3D 2

This magic value of 2 seems to be undocumented, as is the magic value of 1
that's equvilant to "group".

I think it would be better to have git init put in "world" or "group" and n=
ot
these magic values. Anyway, I suppose they ought to be documented too.

--=20
see shy jo

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVZrWOskQ2SIlEuPHAQJM3A//bQ7n6vDymf7Ysyyn0qQ5QQSww+hmX1xF
n46mKEeKqPa3fudZ83gJ8ElHdJWglOqSIHmlqRxAR1dNsN2LsHzrF52l+ew3UE7T
1SI5iEhggGtnrE1/OQ62ksRAIwIaVaAoCNJbFvtfj9OiJXlBOaeG0C9PqsCjnETx
xbaUepr8FlAl3S13nJuV0LcnHUiItFO0UIqNEmNxkN7elzAZCeKeF9Z6jJCtPskb
K8wyZ7FBsneNTDMDUdgEZhTFwTvnSPjVWFyaGix/UcL9rELx6UtfRqpajCxx7Bn7
e5rdk8jCXbtS9bZxFqTO7C4cC8PC5IPRh8gXfq+0M00S/yypzYxLVGQkWO3lo2e9
lu+ff5lQDbM2jqXSEzjTqqhI5xxS9jVVVzkvEx1FYhElRtUaEKkQvZfRoUtMDFHO
rcEfVeCGwkOIxNG5pYayVy27N15ZFUD0LWXXWA6O0DGCTU7c4qresU0q+4EhAFtt
8rouAm5zYo52YSA/52WHWKzLDFFKMVpaq//pqdaZbX7gUMWm330djT2MPaaSBosj
jgghuChgTea5UkUnZe85kn6GmvFbaZQPDfn5m7NBlW5AdRQ8e5BoRb4JfAXVUgJi
OTPgeJPEOX6VhlVjMdUNM9+ovC3D1mIBk5urBcWoV6E5GRWdJWT37OX0eNOieD+E
+2CpgxTyghM=
=1C6T
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
