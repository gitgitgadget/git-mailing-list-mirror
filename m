From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as
 an escape character
Date: Wed, 7 Jul 2010 11:16:33 +0200
Message-ID: <20100707091633.GB31048@genesis.frugalware.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f6nK9RR+X1IX2pXa"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 11:16:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWQkE-0005xo-5u
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 11:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0GGJQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 05:16:36 -0400
Received: from virgo.iok.hu ([212.40.97.103]:52447 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108Ab0GGJQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 05:16:35 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E57065809C;
	Wed,  7 Jul 2010 11:16:33 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A80E044659;
	Wed,  7 Jul 2010 11:16:33 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 85AB112D90F0; Wed,  7 Jul 2010 11:16:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vpqyz278o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150459>


--f6nK9RR+X1IX2pXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 06, 2010 at 10:25:43PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Why do I feel a deja-vu for this patch?
>=20

Maybe this one:

http://thread.gmane.org/gmane.comp.version-control.git/146999

But the sed hack used there isn't a clean solution, IMHO a more elegant
solution is to use read -r, what my patch does.

--f6nK9RR+X1IX2pXa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkw0RfEACgkQe81tAgORUJbl3gCfSyUwjDsQAuLAbms4iVLbjhum
sEsAn3K5PmGUWmnM56c88KQlWbOiRNBr
=/dj8
-----END PGP SIGNATURE-----

--f6nK9RR+X1IX2pXa--
