From: martin f krafft <madduck@debian.org>
Subject: Re: Bug#476076: gitweb fails with pathinfo and project with ++ in
	the name
Date: Sun, 20 Apr 2008 23:03:20 +0200
Message-ID: <20080420210320.GA22732@piper.oerlikon.madduck.net>
References: <20080420144654.GA11479@piper.oerlikon.madduck.net> <20080420155318.GV6024@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: 476076@bugs.debian.org
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:04:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnghu-0004lB-Gk
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYDTVDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 17:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYDTVDc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 17:03:32 -0400
Received: from clegg.madduck.net ([82.197.162.59]:47334 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbYDTVDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 17:03:32 -0400
Received: from wall.oerlikon.madduck.net (84-75-148-163.dclient.hispeed.ch [84.75.148.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id E7BD6A80FF;
	Sun, 20 Apr 2008 23:03:21 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 2E8939F18E;
	Sun, 20 Apr 2008 23:03:21 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 01B6BC1757; Sun, 20 Apr 2008 23:03:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080420155318.GV6024@mail-vs.djpig.de>
X-Debbugs-No-Ack: please spare me
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.91.2/6850/Sun Apr 20 19:05:45 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79985>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

reassign 476076 perl-modules
forcemerge 411735 476076
thanks

also sprach Frank Lichtenheld <djpig@debian.org> [2008.04.20.1753 +0200]:
> CGI->path_info in etch's version is broken, you need either use a newer
> CGI.pm or $ENV{PATH_INFO} directly.

Fwiw: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D411735

Fixing it exposed a similar bug in gitweb.perl; the patch will
follow in a few minutes.

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIC6+YIgvIgzMMSnURAvbCAJ0Rzvb+c8OshXp1eszoGqVf7p+7ugCeMow+
WOzgJswoB6pJmVIqnFMfrb4=
=9vpa
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
