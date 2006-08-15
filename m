From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: configurable home link string
Date: Wed, 16 Aug 2006 00:11:48 +0200
Message-ID: <20060815221147.GB14459@admingilde.org>
References: <11555958491891-git-send-email-yashi@atmark-techno.com> <ebsrsn$tgq$1@sea.gmane.org> <20060815192737.GA14459@admingilde.org> <8fe92b430608151236l35ff169cjea6580250182b5ef@mail.gmail.com> <87mza5ycfr.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 00:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD78t-0001sx-S8
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 00:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWHOWLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 18:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHOWLu
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 18:11:50 -0400
Received: from agent.admingilde.org ([213.95.21.5]:22195 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1750748AbWHOWLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 18:11:49 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GD78W-0000KH-Az; Wed, 16 Aug 2006 00:11:48 +0200
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87mza5ycfr.wl%cworth@cworth.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25487>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Aug 15, 2006 at 01:24:40PM -0700, Carl Worth wrote:
> Currently I've got gitweb running at the root URL on its own domain
> with the following apache configuration:
>=20
> 	ScriptAlias / /usr/lib/cgi-bin/gitweb

I use the following configuration:

    DocumentRoot /pub/git
    RewriteEngine on
    RewriteRule ^/(.*\.git/(.*\.html)?)?$ /cgi-bin/gitweb.cgi%{REQUEST_URI}=
  [L,PT]

this has the advantage that normal http: repository accesses go to the
normal web server and only gitweb accesses go to the CGI.

> Finally, once I get that working, I would like gitweb to generate URLs
> of this form in the link it generates. Does it have that capability
> yet? (It would also be nice if it didn't append options that are the
> default anyway, such as ";a=3Dsummary").

I had this for an very old gitweb version and am currently
reimplementing it for current gitweb versions.

--=20
Martin Waitz

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE4kajj/Eaxd/oD7IRAuuyAJ0Sn5gsNp4PbkLEX0vbWehHKe9vhQCcDP3p
Zv84DW04t68El2Yikbp77o0=
=AFvC
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
