From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto (try2)
Date: Wed, 2 Apr 2008 03:14:47 +0200
Message-ID: <20080402011447.GO3264@genesis.frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 03:15:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgrZn-0006sL-Q1
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 03:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbYDBBOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 21:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbYDBBOu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 21:14:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:21702 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbYDBBOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 21:14:50 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8B77E1B2503;
	Wed,  2 Apr 2008 03:14:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B871A446A3;
	Wed,  2 Apr 2008 03:11:37 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 866801190A16; Wed,  2 Apr 2008 03:14:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhceldv12.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78673>


--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2008 at 04:18:01PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > - removed unnecessary stdout_to_stderr from builtin-gc.c::run_hook()
>=20
> Wait, a, minute, please.  Not so fast.  I did not say "I think this is
> wrong, please fix it".
>=20
> I only asked why it is so.
>=20
> Care to explain why it was thought to be necessary, and why you now think
> it is unnecessary?

Ok, let me explain. I think it would be logical to put it to stderr, as
the other gc --auto messages are there, as well. See the fprintf() in
cmd_gc().

Though, I don't think it's that important, so I thought if you think
it's unnecessary, I would not argue for it.

So may I put it back? :)

Also, is the other parts of the series looks correct?

Thanks

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfy3gcACgkQe81tAgORUJYgXQCfbkwidduBZrY9lmnw5z1ki7ib
igQAoKYsqLBdQf+zI44cvIpEUcDAj50t
=Tsmx
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
