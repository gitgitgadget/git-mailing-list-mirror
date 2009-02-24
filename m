From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Issues building docs on an offline box again.
Date: Tue, 24 Feb 2009 15:07:47 +0100
Message-ID: <20090224140747.GS4371@genesis.frugalware.org>
References: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com> <20090224022856.GN4371@genesis.frugalware.org> <c115fd3c0902240504y9fe6ce4m65ba73ce2937cb9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/YLrkxBeBoBPjrwx"
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 15:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbxyH-0002ty-Qg
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbZBXOHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 09:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754313AbZBXOHu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:07:50 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54700 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752AbZBXOHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 09:07:50 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A2458581B5;
	Tue, 24 Feb 2009 15:07:48 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 402C5446D6;
	Tue, 24 Feb 2009 15:07:47 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 49FB611B877C; Tue, 24 Feb 2009 15:07:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c115fd3c0902240504y9fe6ce4m65ba73ce2937cb9e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111288>


--/YLrkxBeBoBPjrwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2009 at 08:04:47AM -0500, Tim Visher <tim.visher@gmail.com>=
 wrote:
> How would I do that?  Unfortunately I have no experience whatsoever
> with configuring docbook.  I've always just used a package manager to
> install it.  Anyway, there's a `catalog` file in /etc/xml with the
> following:
>=20
> $ cat /etc/xml/catalog
> <?xml version=3D"1.0"?>
> <!DOCTYPE catalog PUBLIC "-//OASIS//DTD Entity Resolution XML Catalog
> V1.0//EN" "http://www.oasis-open.org/committees/entity/release/1.0/catalo=
g.dtd">
> <catalog xmlns=3D"urn:oasis:names:tc:entity:xmlns:xml:catalog">
>   <public publicId=3D"-//OASIS//DTD DocBook XML V4.2//EN"
> uri=3D"http://www.oasis-open.org/docbook/xml/4.2/"/>
>   <rewriteSystem
> systemIdStartString=3D"http://www.oasis-open.org/docbook/xml/4.2/"
> rewritePrefix=3D"/usr/share/xml/docbook/4.2/"/>
> </catalog>
>=20
> To my untrained eye there seems to be a local path in there but I have no=
 idea.

I'm not a docbook expert, either - but It seems the url your config
rewrites is http://www.oasis-open.org/docbook/xml/4.2, while the url you
try to access during the build is
http://docbook.sourceforge.net/release/xsl/current. So I *think* you
need to add two other entries as well for the xsl urls, but I'm just
guessing.

If it does not work, probably it worth asking on a docbook list, where
people have more clue about docbook. :)

--/YLrkxBeBoBPjrwx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmj/zMACgkQe81tAgORUJY70gCfbZnm4F2v7toTMwFjfqbcZhgz
vuwAnA3CzVzze0BZalaBvuv5XNw7kvI2
=aVV5
-----END PGP SIGNATURE-----

--/YLrkxBeBoBPjrwx--
