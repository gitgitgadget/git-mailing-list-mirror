From: "Fernando J. Pereda" <ferdy@ferdyx.org>
Subject: Re: [PATCH] Skip unwritable tests for root
Date: Mon, 30 Jun 2008 11:27:35 +0200
Message-ID: <20080630092735.GA10979@ferdyx.org>
References: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org> <7vabh31e9p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 11:28:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDFge-0005WH-MP
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 11:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101AbYF3J1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 05:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759553AbYF3J1l
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 05:27:41 -0400
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:45378
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbYF3J1k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 05:27:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 8D80F8D314;
	Mon, 30 Jun 2008 11:31:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at ferdyx.org
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FUMjRQJLekrG; Mon, 30 Jun 2008 11:31:05 +0200 (CEST)
Received: from ferdyx.org (ares.ferdyx.org [192.168.0.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTPSA id 3EC008D307;
	Mon, 30 Jun 2008 11:31:05 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vabh31e9p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86895>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2008 at 02:08:18AM -0700, Junio C Hamano wrote:
> "Fernando J. Pereda" <ferdy@ferdyx.org> writes:
>=20
> > Signed-off-by: Fernando J. Pereda <ferdy@ferdyx.org>
>=20
> Hmm.  Actually we've deliberately ignored this so far.  If we were to do
> anything, don't we rather want to fail everything upfront when the tests
> are run by root?
>=20
> Running "make" and "make test" before "make install" is so that you have
> less chance hurting your running system, and I find it simply crazy to
> build (i.e. "make all") as root, let alone running tests.

*nod*

This originated because Gentoo can be told to build stuff as root (and
run test as root) under a sandbox. Since I already had the patch
locally, I guessed you might be interested in it and just sent it.

I'll just apply it locally.

- ferdy


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Darwin)

iEYEARECAAYFAkhopwcACgkQCkhbDGC9KNRdQgCfb2yJx4sf0D8a4d2l56xhocfK
1zoAoJCUdNEy1dBt+Lsm3848qqH80Bv2
=Jj57
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
