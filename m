From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 3/4] git-remote rename: support branches->config
	migration
Date: Wed, 12 Nov 2008 03:01:58 +0100
Message-ID: <20081112020158.GK24201@genesis.frugalware.org>
References: <cover.1226349595.git.vmiklos@frugalware.org> <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org> <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org> <cover.1226349595.git.vmiklos@frugalware.org> <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org> <7v63mtvkdx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xmaaO/kAkmiSHqEM"
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 03:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L054j-00068T-Sd
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 03:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYKLCCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 21:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYKLCCE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 21:02:04 -0500
Received: from virgo.iok.hu ([193.202.89.103]:48561 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbYKLCCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 21:02:03 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1500158091;
	Wed, 12 Nov 2008 03:02:02 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 6F61844698;
	Wed, 12 Nov 2008 03:01:59 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E5C2E119019E; Wed, 12 Nov 2008 03:01:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v63mtvkdx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100712>


--xmaaO/kAkmiSHqEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2008 at 04:49:14PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> There is something fishy going on between 2/4 and 3/4.  2/4 was advertised
> to migrate remotes to config and had a call to migrate_file() for that
> purpose.  Here this one now allows to convert branches but there is no
> change to the callsite of migrate_file().
>=20
> Which would mean that 2/4 would convert branches/foo too.  And this one is
> only to remove the leftover branches/foo file.
>=20
> Or am I utterly confused?

The trick is that 2/4 already added support for remotes/foo as it uses
remote_get() and that detects remotes/foo as well, but that is
completely unintentional. If you think it makes sense, just squash 3/4
to 2/4, I made it two separate patches because I think these are
logically separate changes.

--xmaaO/kAkmiSHqEM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkaORYACgkQe81tAgORUJYOewCfY8k6MpZ0E8fZqKKKeT16umcB
EWgAoIZJ9Es33l3QZ/j3/RvTjM8F7USw
=95V7
-----END PGP SIGNATURE-----

--xmaaO/kAkmiSHqEM--
