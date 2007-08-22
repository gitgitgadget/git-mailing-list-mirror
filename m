From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH] Allow multiple tag and branch directories in
	git-svnimport
Date: Wed, 22 Aug 2007 12:24:15 +0200
Message-ID: <20070822102415.GA24305@jack.stsp.lan>
References: <20070821170858.GA1721@jack.stsp.lan> <20070821173838.GC1721@jack.stsp.lan> <86wsvook5s.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Cc: git@vger.kernel.org, subversion@elego.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 12:34:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INnXL-0003mi-Ht
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbXHVKeE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 06:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752957AbXHVKeD
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:34:03 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34958 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbXHVKeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 06:34:01 -0400
X-Envelope-From: stsp@elego.de
Received: from stsp.lan (stsp2.in-vpn.de [217.197.85.95])
	(authenticated bits=128)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id l7MAXjgk022838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Aug 2007 12:33:52 +0200
Received: from jack.stsp.lan (stsp@localhost.stsp.lan [127.0.0.1])
	by stsp.lan (8.14.1/8.14.0) with ESMTP id l7MAOGxb001056;
	Wed, 22 Aug 2007 12:24:16 +0200 (CEST)
Received: (from stsp@localhost)
	by jack.stsp.lan (8.14.1/8.14.0/Submit) id l7MAOFJq006875;
	Wed, 22 Aug 2007 12:24:15 +0200 (CEST)
X-Authentication-Warning: jack.stsp.lan: stsp set sender to stsp@elego.de using -f
Mail-Followup-To: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	git@vger.kernel.org, subversion@elego.de
Content-Disposition: inline
In-Reply-To: <86wsvook5s.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56369>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 21, 2007 at 10:46:23AM -0700, Randal L. Schwartz wrote:
> Stefan> Ouch, just noticed it's a bad idea to try to initialise
> Stefan> an array with a scalar. Sorry :-/
>=20
> That's completely normal.  Perl predictably promotes the single scalar to=
 an
> array of one element.  I wouldn't have even noticed it in a detailed code
> review, since it's so normal to do that.
>=20
> In fact, the parens that you added do *not* make it a list.  The parens
> are purely for precedence

> So, your parens are not only uncommon, they are also completely ineffecti=
ve,
> similar to replacing 2 + 3 with (2) + (3) :)

Thanks for clarifying. Prior to hacking on git-svnimport
my perl "skills" (if any) were strictly read-only.
So I'm quite a noob wrt perl.
Feel free to nit the patch further :)

--=20
Stefan Sperling <stsp@elego.de>                 Software Developer
elego Software Solutions GmbH                            HRB 77719
Gustav-Meyer-Allee 25, Gebaeude 12        Tel:  +49 30 23 45 86 96=20
13355 Berlin                              Fax:  +49 30 23 45 86 95
http://www.elego.de                 Geschaeftsfuehrer: Olaf Wagner

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (OpenBSD)

iD8DBQFGzA7O5dMCc/WdJfARAoCjAJ9YWml7QLxpmWPbpC+qkjdxia6RkQCfXSU1
3JiHaK7EgiqWRGVCl+HYlZY=
=sYO5
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
