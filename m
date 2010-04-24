From: Joey Hess <joey@kitenet.net>
Subject: ciabot scripts and merge flood prevention
Date: Sat, 24 Apr 2010 11:05:11 -0400
Message-ID: <20100424150511.GA7318@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Cc: git@vger.kernel.org
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 17:05:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5gvB-0002Th-67
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 17:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab0DXPFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 11:05:17 -0400
Received: from wren.kitenet.net ([80.68.85.49]:36630 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab0DXPFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 11:05:16 -0400
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id C51B7119048;
	Sat, 24 Apr 2010 11:05:13 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 7074A49A3C; Sat, 24 Apr 2010 11:05:11 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145682>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's a problem with the old ciabot scripts, and I think also the v3
versions, when two published branches are merged. In this case, ciabot
reports all the changes twice, once when they're first committed to the
first branch, and a second time when the first branch is merged into the
second. This can unleash a flood of redundant commit messages that wipes
out conversation in any poor irc channel that has CIA in it. I've
generated floods that lasted up to 15 minutes.

I document the problem and one solution here. There's also a link to=20
the hook script Gnome is using, based on the same method.
http://kitenet.net/~joey/blog/entry/lazyweb:_git_cia_hooks/
Maybe this could be built into the ciabot scripts?


(BTW, in both scripts, the example of git-rev-list ... | tac
could perhaps more efficiently be written as git-rev-list --reverse ...)

--=20
see shy jo

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBS9MIpMkQ2SIlEuPHAQjLlw/+ODEv/Refd/htuULpWAr9QxiJbGRXoHzp
dxwxeTU9Tf08qSru1kyc4yjALiK5xAGM1yT1UUX7EayPnAyd/RETVtdasPUfYv3B
t0UPQOTppOi9rN30fu1tLoKaCCRReCJHCh9Fc/33No2AJpaZSznoKSbo3lqWW/Yl
xxRPwDZFmeUNMtGAvRmJpweRMADCtwUZ4AHRQLXOJzqnvoHxa5GSRrObF7agOwSB
o/bCNjQTQJMAGxKMovoe9hI1o47q7smfyLf4RFcttBlLiJNcX4B+J90r+Yh6SlBM
aDEHDMG+VPFRKxuKm+CjESRhv7zbwNS/lO7EGLda+25q8A+tKQtNvzEwU8NFK5PS
sVLT8EQxBMvlYUNYRjU/PLpjOJzNT0REgceWBghVBGlqvVcCDm2JpT1H0YHKj45N
+KojFNqR+pKjPCiDGswXjsnRlYIRgsHHUUyoKOwzVPqYxsQpYTGKfquEwmHbXAS3
YNvSlo/G3UDVoKVEDod7WWJqlYO3xSnEE5gb47yeGexH+/41jT/AAHjh1vB7Gu6c
0v2/6gXz7CxJC0u7+hZfBzV+e1HC8BaJ+bbwaRCtnLkvbGGVSierJ50YOgyFiCFh
ZVdMslik7tTOEP+rHxjAcX2yAvPn/7c6LjySJxMSfXtnhlReugbf5DhDpHmAog7B
NvYyFpxbUUk=
=YMYL
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
