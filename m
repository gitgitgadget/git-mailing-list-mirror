From: martin f krafft <madduck@debian.org>
Subject: Re: [PATCH] Remove duplicate pathspecs from ls-files command line
Date: Wed, 29 Aug 2007 22:57:35 +0200
Organization: The Debian project
Message-ID: <20070829205735.GA1537@piper.oerlikon.madduck.net>
References: <20070829081122.GA604@piper.oerlikon.madduck.net> <20070829194410.GA11824@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Cc: Alex Riesen <raa.lkml@gmail.com>, 439992-quiet@bugs.debian.org,
	Junio C Hamano <junkio@cox.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQUbs-0007TV-Tc
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907AbXH2U5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbXH2U5w
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 16:57:52 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51116 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbXH2U5v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 16:57:51 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id AE4B8BFE5;
	Wed, 29 Aug 2007 22:57:37 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C4AFE9F161;
	Wed, 29 Aug 2007 22:57:36 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id D591C43F4; Wed, 29 Aug 2007 22:57:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070829194410.GA11824@steel.home>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Debbugs-No-Ack: please spare me
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4107/Wed Aug 29 18:16:42 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56981>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alex Riesen <raa.lkml@gmail.com> [2007.08.29.2144 +0200]:
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Signed-off-by: martin f krafft <madduck@madduck.net>

I confirm that Alex' patch does what it should:

$ git init
Initialized empty Git repository in .git/
$ date > a; git add a; git commit -m.
Created initial commit afb6bca: .
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
$ date >> a
$ git commit -m. a a
Created commit f41d10a: .
 1 files changed, 1 insertions(+), 0 deletions(-)

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"although occasionally there is something to be said for solitude."
                                          -- special agent dale cooper

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1d2/IgvIgzMMSnURAtGWAKCAUfB0BbsSzWQmrjI1zyEZoYbEJwCeNRZG
NVzi0UnLRGQnyD8zTbliB6M=
=D4gI
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
