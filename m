From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Can a git changeset be created with no parent
Date: Sun, 25 Sep 2011 16:33:21 +0200
Message-ID: <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
References: <1316960136073-6829212.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/QWNR2y0hOLlCcIX1OGB"
Cc: git@vger.kernel.org
To: vra5107 <venkatram.akkineni@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 16:33:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7pm2-0004Rl-Ch
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 16:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1IYOdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 10:33:33 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:56580 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab1IYOdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 10:33:32 -0400
Received: from [192.168.1.17] (brln-4d0c2f69.pool.mediaWays.net [77.12.47.105])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 8D9B046180;
	Sun, 25 Sep 2011 16:33:10 +0200 (CEST)
In-Reply-To: <1316960136073-6829212.post@n2.nabble.com>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182077>


--=-/QWNR2y0hOLlCcIX1OGB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2011-09-25 at 07:15 -0700, vra5107 wrote:
> Hi
>=20
>         I am currently in the process of converting a large hg repository=
.
> One of the changesets has no parents assigned. So to mirror that is it
> possible to create a git changeset that doesnot have a parent ?

They're called commits in git, and yes it's possible. They are called
orphan commits and it's what you get when you do the first commit in the
repository.

You can do this with 'git checkout --orphan somebranch'. Notice that the
index will be kept, you'll need to either use 'git rm' or 'git add -A'.

There is a longer explanation in the manpage for 'git checkout'.

   cmn

--=-/QWNR2y0hOLlCcIX1OGB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOfzuxAAoJEHKRP1jG7ZzTnNMIAJNr+ZKECNjlZipjjFEaj/oe
ROq3AZikhzI36jtkAKo8H4XDRmvJ9hKCjWN6M05v0i/WSGKASAPNtQfYApDR9HEg
0XXfmjlRUOWkp8lz0cSF0RCjdGMtpIK0xxkUBlfjYafFtSucnV3AliTKYrzQv2bG
/IkhMywAoKgnZwZgY8Mdg5cCZdPqclcqAWRCCfO+gu779B3jWtx49SckXkrV8/Bn
ZCIYSHF7GCvaD0YBPPRjECwOQowukiji2Fdyr6RIv1l1NJac256FUcxTIzFIFfxn
XViEDmz/er104bzqits7CHPFVgc1a6la+m7ScoY03X7zejIihOs4Z3c+jBzr2T0=
=WIIP
-----END PGP SIGNATURE-----

--=-/QWNR2y0hOLlCcIX1OGB--
