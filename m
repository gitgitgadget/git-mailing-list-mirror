From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 9/9] refs: use warning() instead of fprintf(stderr,
	"warning: ")
Date: Tue, 24 Mar 2009 02:23:34 +0100
Message-ID: <20090324012334.GL27459@genesis.frugalware.org>
References: <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org> <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org> <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org> <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org> <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org> <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org> <cover.1237856682.git.vmiklos@frugalware.org> <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org> <f6b2ede9af2bd40ce89f0251b32861098af46aad.1237856682.git.vmiklos@frugalware.org> <40aa078e0903231817g41fd1bc1s296121d85923f7ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r6fxLKBTHCmC166Z"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvOH-0001XL-1N
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbZCXBXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZCXBXi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:23:38 -0400
Received: from virgo.iok.hu ([212.40.97.103]:43820 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbZCXBXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:23:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 08F43580D1;
	Tue, 24 Mar 2009 02:23:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8C74B44783;
	Tue, 24 Mar 2009 02:23:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BC8BF153C002; Tue, 24 Mar 2009 02:23:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <40aa078e0903231817g41fd1bc1s296121d85923f7ea@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114385>


--r6fxLKBTHCmC166Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2009 at 02:17:24AM +0100, Erik Faye-Lund <kusmabite@googlem=
ail.com> wrote:
> > @@ -996,7 +996,7 @@ int delete_ref(const char *refname, const unsigned =
char *sha1, int delopt)
> >
> >        err =3D unlink(git_path("logs/%s", lock->ref_name));
> >        if (err && errno !=3D ENOENT)
> > -               fprintf(stderr, "warning: unlink(%s) failed: %s",
> > +               warning("unlink(%s) failed: %s",
>=20
> Doesn't this add a newline? The original string doesn't have a '\n' at
> the end of the format-field, but AFAIK warning() terminates with one.
> I'm not saying it's a problem, I'm just pointing it out.

Yes, it adds. As Jeff pointed out earlier in this thread, the lack of
newline was a bug:

http://article.gmane.org/gmane.comp.version-control.git/110783

--r6fxLKBTHCmC166Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknINhYACgkQe81tAgORUJZOsACePMX7shBNSONFEgTDewc61RGz
hM4AnRrrrdgDT+DSreIq/Q3fe6RqPiX1
=QxkE
-----END PGP SIGNATURE-----

--r6fxLKBTHCmC166Z--
