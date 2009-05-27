From: Christian Senkowski <csenkowski@gmx.de>
Subject: How to share config and hooks ?
Date: Wed, 27 May 2009 21:58:04 +0200
Message-ID: <4A1D9B4C.7030504@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig356D4A9AA57F2DE0429D3DBB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 22:00:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9PIY-0006Nw-1P
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759716AbZE0UAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756320AbZE0UAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:00:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:49532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756021AbZE0UAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:00:15 -0400
Received: (qmail invoked by alias); 27 May 2009 20:00:15 -0000
Received: from essn-4db698ab.pool.einsundeins.de (EHLO [192.168.2.4]) [77.182.152.171]
  by mail.gmx.net (mp002) with SMTP; 27 May 2009 22:00:15 +0200
X-Authenticated: #16561160
X-Provags-ID: V01U2FsdGVkX19y5OJSOlVyYIubXlMrFyp1SOJZQQzK9l2NTgqcls
	1JHVm6eS78FGz6
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.7
OpenPGP: id=E665EEA6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120098>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig356D4A9AA57F2DE0429D3DBB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I am searching for a way to share 'config' and hooks/* automatically.
I'd like to change and commit them as normal files and every user
cloning this repo should get those.

One way might be a little wrapper-script for git-clone which looks if
repo/.gitconfig or repo/.githooks exist and copies then the files to
repo/.git/[...]

But I am searching for a way to do this without any additional scripts.

Does anyone have an idea ?
And what'd you say about implementing this (with a
yes-please-copy-the-found-files/no-leave-them-alone - question) directly
into the git-binary ?


--=20


--------------enig356D4A9AA57F2DE0429D3DBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (MingW32)
Comment: GnuPT v3.5.3
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkodm04ACgkQ6enlpuZl7qbYVACfXJAOy230sBvCYP7d+kd4Iz83
J0cAmQHKNNUBX1uhQhzSif4njHSMzExz
=Wu5i
-----END PGP SIGNATURE-----

--------------enig356D4A9AA57F2DE0429D3DBB--
