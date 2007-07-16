From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH 1/2] git-p4: use subprocess in p4CmdList
Date: Mon, 16 Jul 2007 20:33:56 +0200
Message-ID: <200707162033.56888.simon@lst.de>
References: <11845582912155-git-send-email-slamb@slamb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9407572.dloZlKypit";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 20:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAVOG-0005Xh-Iy
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 20:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbXGPSdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758288AbXGPSdn
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 14:33:43 -0400
Received: from verein.lst.de ([213.95.11.210]:52861 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbXGPSdm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 14:33:42 -0400
Received: from luria.local (2.84-48-121.nextgentel.com [84.48.121.2])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l6GIXbNK023122
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 16 Jul 2007 20:33:38 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <11845582912155-git-send-email-slamb@slamb.org>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52706>

--nextPart9407572.dloZlKypit
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 16 July 2007 05:58:10 Scott Lamb wrote:
> This allows bidirectional piping - useful for "-x -" to avoid commandline
> arguments - and is a step toward bypassing the shell.

Thanks! I have pushed your two patches into

	http://gitweb.freedesktop.org/?p=3Dusers/hausmann/git-p4;a=3Dsummary

Unless somebody else wants to try earlier I intend to ask Junio to pull you=
r=20
changes from there after 1.5.3.


Simon

--nextPart9407572.dloZlKypit
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGm7oUWXvMThJCpvIRAnkgAKCY7segvCkyvcrN1LRJyyYXVNNZNwCg0+CU
CDHt7e1sN2AhJw4dAhArrnI=
=BnjE
-----END PGP SIGNATURE-----

--nextPart9407572.dloZlKypit--
