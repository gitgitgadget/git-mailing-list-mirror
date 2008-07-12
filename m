From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git call graph
Date: Sat, 12 Jul 2008 03:27:27 +0200
Message-ID: <20080712012727.GP10347@genesis.frugalware.org>
References: <20080712004714.GL10347@genesis.frugalware.org> <7vd4ljj4u1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cXxibKNEnJOqEg4"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 03:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHTua-0005gd-5i
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 03:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYGLB1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 21:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbYGLB1d
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 21:27:33 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51361 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbYGLB1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 21:27:33 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3B6161B24FA;
	Sat, 12 Jul 2008 03:27:30 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 00B394465E;
	Sat, 12 Jul 2008 02:52:40 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C5F55177001C; Sat, 12 Jul 2008 03:27:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4ljj4u1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88214>


--7cXxibKNEnJOqEg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2008 at 05:58:46PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Here is the result:
> >
> > http://vmiklos.hu/pic/git-call-graph.png
>=20
> Your pull does not seem to call either fetch nor merge...  Strange.

My bad. I tracked shell calls using a wrapper around 'git' so it missed
calls without the 'remove-dashes' patches I posted yesterday.

http://vmiklos.hu/pic/git-call-graph-v2.png

This one now shows that.

--7cXxibKNEnJOqEg4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh4CH8ACgkQe81tAgORUJZhswCfXifYU4nRzZzjXixWBk5/O1Vg
1gkAn3g+zWmtdzXw0yncvWp9m4+we0Mk
=lZsK
-----END PGP SIGNATURE-----

--7cXxibKNEnJOqEg4--
