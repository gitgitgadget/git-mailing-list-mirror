From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Issues building docs on an offline box again.
Date: Tue, 24 Feb 2009 03:28:56 +0100
Message-ID: <20090224022856.GN4371@genesis.frugalware.org>
References: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DvkZXeeOEg7hUvqr"
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 03:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbn41-0006lc-5F
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 03:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZBXC3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 21:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbZBXC27
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 21:28:59 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37852 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751388AbZBXC26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 21:28:58 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B4956580DA;
	Tue, 24 Feb 2009 03:28:57 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7F871446D6;
	Tue, 24 Feb 2009 03:28:56 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B65F511B877C; Tue, 24 Feb 2009 03:28:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111198>


--DvkZXeeOEg7hUvqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2009 at 06:07:54PM -0500, Tim Visher <tim.visher@gmail.com>=
 wrote:
> xmlto -m callouts.xsl man git-add.xml
> I/O error : Attempt to load network entity
> http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> warning: failed to load external entity
> "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
> compilation error: file /tmp/xmlto-xsl.f254nC line 4 element import
> xsl:import : unable to load
> http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
> make: *** [git-add.1] Error 1
>=20
> Strange thing is that I thought I had gotten these to build offline
> before with the exact same configuration.  Any thoughts?

Probably you somehow broke your docbook toolchain.

> My current solution is to build them on the online box and then copy
> them over the sneaker net to the offline box.  But, this is kludgey,
> so not cool. :)

That's just a workaround. The solution is to have the correct mappings
under /etc/xml, so that it maps the doctype to
/usr/share/xml/docbook/manpages/docbook.xsl, or a similar path. After
all, ideally your distro does this for you automatically. :)

--DvkZXeeOEg7hUvqr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmjW2gACgkQe81tAgORUJZK0QCcC/o3NVOLhhCBsI2cSfj7PxEF
v1kAn0apS3N8ggdQ87TVib1DJmS0CfiI
=WvZb
-----END PGP SIGNATURE-----

--DvkZXeeOEg7hUvqr--
