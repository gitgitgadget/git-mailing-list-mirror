From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-stash: use git rev-parse -q
Date: Mon, 8 Dec 2008 09:46:53 +0100
Message-ID: <20081208084653.GR5691@genesis.frugalware.org>
References: <1228179369-3766-1-git-send-email-vmiklos@frugalware.org> <20081207231723.GA5068@atjola.homenet> <7vhc5fcui1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 09:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9bmm-00081H-Qy
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 09:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYLHIqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 03:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYLHIqz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 03:46:55 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37943 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbYLHIqz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 03:46:55 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 089BA580A8;
	Mon,  8 Dec 2008 09:46:53 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9F5164465E;
	Mon,  8 Dec 2008 09:46:52 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 27B7311B8831; Mon,  8 Dec 2008 09:46:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhc5fcui1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102537>


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 07, 2008 at 05:42:46PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Thanks; I'll revert this one.  Use of -q is simply not worth this
> aggravation.

Sorry, I missed that 2>/dev/null is used for this purpose there as well.=20

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk83v0ACgkQe81tAgORUJaWtACeLj+T2RHxOAyj8GNbaOPBSf1M
rbEAoIadWXhhM7i1L6Tm9MyV/GJb/KDv
=BTXv
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
