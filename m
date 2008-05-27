From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: git grep and word boundaries
Date: Tue, 27 May 2008 09:56:12 +0100
Message-ID: <20080527085612.GA31765@bit.office.eurotux.com>
References: <483BC7E2.6090804@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Cc: git@vger.kernel.org
To: Thomas Volpini <tvolpini@gmx.net>
X-From: git-owner@vger.kernel.org Tue May 27 10:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0uzY-0000UO-BQ
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 10:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbYE0I4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 04:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756853AbYE0I4U
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 04:56:20 -0400
Received: from os.eurotux.com ([216.75.63.6]:56748 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806AbYE0I4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 04:56:19 -0400
Received: (qmail 23361 invoked from network); 27 May 2008 08:56:16 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@82.102.23.9)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 27 May 2008 08:56:16 -0000
Content-Disposition: inline
In-Reply-To: <483BC7E2.6090804@gmx.net>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82995>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2008 at 10:35:46AM +0200, Thomas Volpini wrote:
>  Hello,
>=20
>  it seems that git grep doesn't do word boundaries as described:
>=20
>  $ cat bar
>  foo bar baz
>  $ grep "\<bar\>" *
>  foo bar baz
>  $ git grep "\<bar\>" *
>  $ git grep -w "\<bar\>" *
>  $ git grep -w "bar" *
>  bar:foo bar baz
>  $ git grep -E "\<bar\>" *
>  $ git grep -E "\bbar\b" *
>  $

It works here. Did you add the file?
$ grep "\<bar\>" *
foo bar baz
$ git grep "\<bar\>"
bar:foo bar baz
$ git grep "\<bar\>" *
bar:foo bar baz
$ git grep \\bbar\\b
bar:foo bar baz
$ git grep \\bbar\\b *
bar:foo bar baz

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg7zKwACgkQinSul6a7oB95tACglesE/IhafihUJxZHOWxpdJF5
5cwAn0Ao0aUUexvl3h0+vafH+F1t7QtP
=Vcsq
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
