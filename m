From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 14:41:00 +0200
Message-ID: <20080713124100.GB10347@genesis.frugalware.org>
References: <loom.20080713T073129-112@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qCGCnlPZoKZX9mDP"
Cc: git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 14:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI0tw-0006o9-9Q
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 14:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYGMMlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 08:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbYGMMlE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 08:41:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55820 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430AbYGMMlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 08:41:03 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8381C1B24FB;
	Sun, 13 Jul 2008 14:41:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 530BD4465E;
	Sun, 13 Jul 2008 14:05:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 21D4A11901B3; Sun, 13 Jul 2008 14:41:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <loom.20080713T073129-112@post.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88309>


--qCGCnlPZoKZX9mDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2008 at 08:13:55AM +0000, Sverre Hvammen Johansen <hvammen+=
git@gmail.com> wrote:
> Great that we now are introducing merge in C.  Great job Miklos.
> However, it is broken as this patch shows.  This have been
> bisected to 1c7b76be Build in merge.
>=20
> The test case when run will record the parents that were asked for which =
is
> fine.  However, only c2 is recorded as a parent in the commit object.  Bo=
th
> c1 and c2 should have been recorded.  The merge is otherwise working
> correctly.

Thanks for the testcase, I'm on it. ;-)

--qCGCnlPZoKZX9mDP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh599wACgkQe81tAgORUJY7WQCgg3Px19YTAPJ6oUuV5QgeZS3l
FXMAnAtktXmJlFPobXIfCUNH2tkYzHpP
=S7sd
-----END PGP SIGNATURE-----

--qCGCnlPZoKZX9mDP--
