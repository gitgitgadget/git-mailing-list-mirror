From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-svn problems with branches containing spaces
Date: Tue, 10 Jul 2007 20:33:28 +0200
Message-ID: <20070710183328.GB4808@efreet.light.src>
References: <3F225D5F64550C4AA5F23286244275D4298C84@srvkrsexc07.nov.com> <20070710134236.2870.qmail@986bac8bfff25d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 20:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8KX8-0006GX-TY
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 20:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763829AbXGJSdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 14:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762736AbXGJSdd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 14:33:33 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:37190 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbXGJSdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 14:33:31 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 84C5F572B4
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 20:33:30 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id scl+XW7eio2P for <git@vger.kernel.org>;
	Tue, 10 Jul 2007 20:33:28 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C3B6B572EC
	for <git@vger.kernel.org>; Tue, 10 Jul 2007 20:33:28 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8KWe-0001Ia-9v
	for git@vger.kernel.org; Tue, 10 Jul 2007 20:33:28 +0200
Content-Disposition: inline
In-Reply-To: <20070710134236.2870.qmail@986bac8bfff25d.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52105>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2007 at 13:42:35 +0000, Gerrit Pape wrote:
> On Wed, Jun 27, 2007 at 08:53:06AM +0200, Ewald, Robert wrote:
> > As I have reported yesterday on IRC, git-svn has problems with branches
> > containing spaces.
> > I get the following message, when I want to clone from the repository
> > containing a branch with a space.
> > Cloning until the revision the branch is created everything works fine.
> >=20
> > fatal: refs/remotes/Modbus Error Limit Fix: cannot lock the ref
> > update-ref -m r1897 refs/remotes/Modbus Error Limit Fix
> > ff0819c8e9c97c24e9865bc868c503fd9b64f980: command returned error: 128
> >=20
> > Thanks for your help.
>=20
> Hi, the same problem has been reported some time ago through
>  http://bugs.debian.org/430518
>=20
> There's a patch attached to the report, but from a first glance, I don't
> think it's the solution.

It depends on whether it's OK for git to have refs with funny characters in
them. If it is, than the patch would be a fix. If not, than the escaping the
patch removes needs to be added to all other places that have any business
with refs.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGk9D4Rel1vVwhjGURAoDJAJ9TGRElj3CnMFfElHGyoGNtAQdLEQCeK4DT
ltiJ8daRAmCG/ZOXUD3v2Kw=
=kZcz
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
