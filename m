From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 4/4] Documentation/git-svn.txt: Fix formatting errors
Date: Fri, 2 Mar 2007 21:23:17 +0300
Message-ID: <20070302182317.GB6811@procyon.home>
References: <1172778077659-git-send-email-vsu@altlinux.ru> <11727780872894-git-send-email-vsu@altlinux.ru> <11727780982140-git-send-email-vsu@altlinux.ru> <11727781092949-git-send-email-vsu@altlinux.ru> <20070301203833.GB25782@localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 19:24:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNCQE-0007L1-6A
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 19:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXCBSX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 13:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbXCBSX7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 13:23:59 -0500
Received: from master.altlinux.org ([62.118.250.235]:1606 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbXCBSX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 13:23:58 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 6D756E4B21; Fri,  2 Mar 2007 21:23:57 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20070301203833.GB25782@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41232>


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2007 at 12:38:33PM -0800, Eric Wong wrote:
> Sergey Vlasov <vsu@altlinux.ru> wrote:
> > Fix some formatting problems:
> >=20
> >   - Some list labels were missing their "::" characters.
> >   - Some of continuation paragraphs in labeled lists were incorrectly
> >     formatted as literal paragraphs.
> >   - In one case "[verse]" was missing before the config key list.
> >   - The "Basic Examples" section was incorrectly nested inside the
> >     "Config File-Only Options" section.
>=20
> Thanks.  However, are the indentation changes in the source absolutely
> necessary for asciidoc to correctly format these things?

Yes - normally asciidoc formats indented text as literal paragraphs;
only the first paragraph after "tag::" is processed specially.
And using a "+" line inside a "--" block also does not work.

> I try to avoid building the docs because my computers are too slow.

Yes, asciidoc is slow, and xmlto (xsltproc) is even slower :(

> If so:
>=20
> Acked-by: Eric Wong <normalperson@yhbt.net>
>=20
> > Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> > Cc: Eric Wong <normalperson@yhbt.net>

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF6GuVW82GfkQfsqIRAkYeAJsFopiYxX7ooXCAqBSmHj+H2wGVSQCeO/C6
bMQWNpioRG29L9l3JS3NpnE=
=e1Yt
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
