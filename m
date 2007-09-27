From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Equivalent of `svn switch` for git-svn?
Date: Thu, 27 Sep 2007 12:06:07 +0200
Message-ID: <20070927100607.GC10289@artemis.corp>
References: <46FB5086.7070408@apple.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="f0KYrhQ4vYSV2aJu";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 12:06:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaqGL-0002DO-R7
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 12:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbXI0KGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 06:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbXI0KGN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 06:06:13 -0400
Received: from pan.madism.org ([88.191.52.104]:58815 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755711AbXI0KGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 06:06:11 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EAE3421CCC;
	Thu, 27 Sep 2007 12:06:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 564D093EF; Thu, 27 Sep 2007 12:06:07 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Adam Roben <aroben@apple.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46FB5086.7070408@apple.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59279>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2007 at 06:41:10AM +0000, Adam Roben wrote:
> Hi all-
>   I've recently been informed that the Subversion server I and several=20
> others have been tracking with git-svn will be switching from using the=
=20
> svn+ssh scheme to the http scheme. To handle this, users of svn will be=
=20
> running `svn switch` to move their working copies to the new repository=
=20
> URL. Is there some way to do the same for git-svn? I suspect the biggest=
=20
> complication will come from the git-svn-id: lines in the commit logs,=20
> since changing that line would require changing the commit hash as well.

  edit your .git/config, in the section [svn-remote "svn"], change url =3D

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG+4CPvGr7W6HudhwRAo/HAJ9kxyr44IzQ6uEDw2uBaWRP5+Md6QCePfVB
u6ew9VpsovRzCssfBruXMos=
=SUC8
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
