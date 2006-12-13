X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sebastian Harl <sh@tokkee.org>
Subject: Re: More Perl fun: man and System directories
Date: Wed, 13 Dec 2006 14:14:14 +0100
Message-ID: <20061213131414.GQ2476@albany.tokkee.org>
References: <4F093D53-CFC7-44F1-9460-22DAD35DBAC8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MXxcbiX/Q4+iy5U7"
NNTP-Posting-Date: Wed, 13 Dec 2006 13:17:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4F093D53-CFC7-44F1-9460-22DAD35DBAC8@silverinsanity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34219>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuTzB-0001dX-Sv for gcvg-git@gmane.org; Wed, 13 Dec
 2006 14:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964964AbWLMNPQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 08:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWLMNOQ
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 08:14:16 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39642 "EHLO
 albany.tokkee.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S964963AbWLMNOP (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 08:14:15 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000) id E1B4C364001;
 Wed, 13 Dec 2006 14:14:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--MXxcbiX/Q4+iy5U7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 13, 2006 at 08:07:19AM -0500, Brian Gernhardt wrote:
> 1) Perl is creating man files in the wrong place.  My system expects =20
> them to be in /usr/local/share/man, but Perl is installing them in /=20
> usr/local/man.  Currently I'm just moving them by hand every time I =20
> pull-make-install, which is less than optimal.

Try "perl Makefile.PL INSTALLDIRS=3Dvendor".

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--MXxcbiX/Q4+iy5U7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFf/ymEFEKc4UBx/wRApwhAJ99tsH3IMBtuuO1DnWpINwcnicrBACfeIwY
SNq4PzgbR3skksHRukCYw5A=
=rjzd
-----END PGP SIGNATURE-----

