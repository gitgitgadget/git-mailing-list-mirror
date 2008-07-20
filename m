From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Mon, 21 Jul 2008 01:08:33 +0200
Message-ID: <20080720230833.GT10347@genesis.frugalware.org>
References: <200807202111.48332.johannes.sixt@telecom.at> <200807202334.36506.johannes.sixt@telecom.at> <7vzloc2odx.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807210034050.3305@eeepc-johanness> <7vprp82nb6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8HClOqJ7YWh1FLv"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKi27-0004Nz-6B
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYGTXIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYGTXIk
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:08:40 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49801 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbYGTXIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:08:39 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3DB261B2557;
	Mon, 21 Jul 2008 01:08:38 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D935C4465E;
	Mon, 21 Jul 2008 00:28:43 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 81239177001C; Mon, 21 Jul 2008 01:08:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vprp82nb6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89260>


--e8HClOqJ7YWh1FLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2008 at 03:38:53PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> That's a rather misguided approach, isn't it?
>=20
> After all, the work requested by the end user will be handled by code in
> the main git executable by spawning a subprocess, and you are auditing the
> codepath that leads to the spawning anyway.

Hm, but then what's the purpose of having git-shell as a not-builtin?

--e8HClOqJ7YWh1FLv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDxXEACgkQe81tAgORUJZh2ACfcTGiIeNn0vWcMYATnoahAclf
fDgAnjKDZ8ZrMjqv9LRu2lJAdBNP7VmK
=oze4
-----END PGP SIGNATURE-----

--e8HClOqJ7YWh1FLv--
