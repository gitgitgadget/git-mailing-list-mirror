From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 3/5] Make verbosity configurable in reset_index_file()
Date: Tue, 27 May 2008 16:49:19 +0200
Message-ID: <20080527144919.GJ27724@genesis.frugalware.org>
References: <cover.1211586801.git.vmiklos@frugalware.org> <40d6845554a032ef66a20289aea6c7b2f157fed3.1211586801.git.vmiklos@frugalware.org> <28874c24faf45e6e4499c9692cc1de1e93cd4dcf.1211586801.git.vmiklos@frugalware.org> <dace39a3a72957bec9a7f4b8528b08fc7fbe3341.1211586801.git.vmiklos@frugalware.org> <1211897281.13838.1.camel@gaara.bos.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UZbF713KgFe4yePC"
Cc: git@vger.kernel.org
To: Kristian H?gsberg <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue May 27 16:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K10VC-00052R-ET
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 16:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbYE0OtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755935AbYE0OtW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 10:49:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47011 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848AbYE0OtV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 10:49:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 333961B255B;
	Tue, 27 May 2008 16:49:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 87E1E4465E;
	Tue, 27 May 2008 16:33:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C195A1190498; Tue, 27 May 2008 16:49:19 +0200 (CEST)
Mail-Followup-To: Kristian H?gsberg <krh@redhat.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1211897281.13838.1.camel@gaara.bos.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83022>


--UZbF713KgFe4yePC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2008 at 10:08:01AM -0400, Kristian H?gsberg <krh@redhat.com=
> wrote:
> > -int reset_index_file(const unsigned char *sha1, int is_hard_reset)
> > +int reset_index_file(const unsigned char *sha1, int is_hard_reset, int=
 verbose)
>=20
> I would suggest using flags here instead of a bunch of boolean args.
> Consider the readability of
>=20
>     reset_index_file(sha1, 1, 1);
>=20
> vs
>=20
>     reset_index_file(sha1, RESET_HARD | RESET_VERBOSE);

Thanks for the suggestion, but - as Daniel already pointed out - the
same functionality can be achieved by using the unpack_trees() API
directly, so the patch is useless.

--UZbF713KgFe4yePC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg8H28ACgkQe81tAgORUJa0tgCfe1FV3rvcCX2mdHGP3P9sOpgm
ER8AoIFBacIX/1Em/9dRvEPYh2ZszYjk
=pTt5
-----END PGP SIGNATURE-----

--UZbF713KgFe4yePC--
