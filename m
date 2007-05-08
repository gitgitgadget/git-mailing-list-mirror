From: Ismail =?iso-8859-1?q?D=F6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Tue, 8 May 2007 18:23:33 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705081823.37602.ismail@pardus.org.tr>
References: <200705081349.34964.ismail@pardus.org.tr> <20070508150220.GA18860@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3686785.VxNdBDZ4h3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue May 08 17:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRsj-0007mV-2R
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967834AbXEHPco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966398AbXEHPYm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:24:42 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:44285 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S966433AbXEHPVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:21:54 -0400
Received: from southpark.local (unknown [85.97.17.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 9F73D5FA48C5;
	Tue,  8 May 2007 18:21:45 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070508150220.GA18860@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46589>

--nextPart3686785.VxNdBDZ4h3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
On Tuesday 08 May 2007 18:02:20 Uwe Kleine-K=F6nig wrote:
> Ismail D=F6nmez wrote:
> > According to FHS standard default man page path is $prefix/share/man [0]
> > , attached patch fixes this for GIT.
>
> According to some GNU standard it's $prefix/man.
>
> E.g. autoconf managed projects use $prefix/man if you don't give
> --mandir=3D... to configure.

Just noticed one can do make mandir=3D/usr/share/man

> Personally I prefer FHS, so I have
>
> 	mandir=3D$(prefix)/share/man
>
> in my config.mak.

Same here, IMHO FHS makes more sense and AFAIK most distros=20
uses /usr/share/man.

Regards,
ismail

=2D-=20
Le mieux est l'ennemi du bien.

--nextPart3686785.VxNdBDZ4h3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGQJX5Gp0leluI9UwRAi87AJ9lZ94qDzzRU+KIgO+9bX50w2nSGACgiViV
WO/m/whrcUTc0hqcCFZwGqY=
=x+4E
-----END PGP SIGNATURE-----

--nextPart3686785.VxNdBDZ4h3--
