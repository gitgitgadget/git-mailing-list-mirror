From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Query about status of http-pull
Date: Wed, 24 Aug 2005 18:10:47 +0200
Message-ID: <1124899847.7187.18.camel@lycan.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fEni1HgS49TdOSwY2FGN"
X-From: git-owner@vger.kernel.org Wed Aug 24 18:14:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7xpF-0004zF-7N
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 18:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVHXQKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 12:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVHXQKA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 12:10:00 -0400
Received: from ctb-mesg9.saix.net ([196.25.240.89]:44790 "EHLO
	ctb-mesg9.saix.net") by vger.kernel.org with ESMTP id S1751086AbVHXQJ7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 12:09:59 -0400
Received: from gateway.lan (wblv-146-217-49.telkomadsl.co.za [165.146.217.49])
	by ctb-mesg9.saix.net (Postfix) with ESMTP id 849514565
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 18:07:27 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 1F9F43A260B
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 17:43:15 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04716-05 for <git@vger.kernel.org>; Wed, 24 Aug 2005 17:42:59 +0200 (SAST)
Received: from lycan.lan (lycan.lan [192.168.0.5])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 6A1763A2605
	for <git@vger.kernel.org>; Wed, 24 Aug 2005 17:42:59 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7711>



--=-fEni1HgS49TdOSwY2FGN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Recently cogito again say that the rsync method will be deprecated in
future (due to http-pull now supporting pack objects I suppose), but it
seems to me that it still have other issues:

-----
lycan linux-2.6 # git pull origin
Fetching HEAD using http
Getting pack list
error: Couldn't get 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf: not separate =
or in any pack
error: Tried http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-=
2.6.git/objects/05/72e3da3ff5c3744b2f606ecf296d5f89a4bbdf
Cannot obtain needed object 0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf
while processing commit 0000000000000000000000000000000000000000.
lycan linux-2.6 # cg-update
17:50:02 URL:http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-=
2.6.git/refs/heads/master [41/41] -> "refs/heads/.origin-pulling" [1]

FINISHED --17:50:09--
Downloaded: 11,949 bytes in 5 files
Missing object of tag v2.6.13-rc7... unable to retrieve
Up to date.

Applying changes...
Branch already fully merged.
lycan linux-2.6 #
-----

If you switch it however to rsync again, it works just fine.  Other
branches like that of KLIBC and one or two others do not even pull via
http-pull.

So basically the question is if this is known issues (had mail issues,
so missed the last week or so's mail) ?


Thanks,

--=20
Martin Schlemmer


--=-fEni1HgS49TdOSwY2FGN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDDJwHqburzKaJYLYRAizRAJwOnq/rM7tjT2ixxYl2S6QtpR7SZQCcDgTR
E4xXMxD5EL+8j+EZ6LsBJMs=
=vnxp
-----END PGP SIGNATURE-----

--=-fEni1HgS49TdOSwY2FGN--
