From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: [PATCH] t1402: work around shell quoting issue on NetBSD
Date: Tue, 08 Jan 2013 20:27:24 -0500
Message-ID: <rmihamrjgcj.fsf@fnord.ir.bbn.com>
References: <50EC8025.8000707@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 09 02:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TskSJ-0003Me-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 02:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3AIB10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 20:27:26 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:54093 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044Ab3AIB10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 20:27:26 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 07AF0A644; Tue,  8 Jan 2013 20:27:25 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:130109:git@vger.kernel.org::3e1mtiQRiRZq7Mwe:0000000000000000000000000000000000000000000E9I
X-Hashcash: 1:20:130109:rene.scharfe@lsrfire.ath.cx::3e1mtiQRiRZq7Mwe:00000000000000000000000000000000001Lfu
X-Hashcash: 1:20:130109:mhagger@alum.mit.edu::ZfsbCkrCZ6wKShIE:000000000000000000000000000000000000000000Nel
X-Hashcash: 1:20:130109:jrnieder@gmail.com::ZfsbCkrCZ6wKShIE:00000000000000000000000000000000000000000001c/h
X-Hashcash: 1:20:130109:gitster@pobox.com::ZfsbCkrCZ6wKShIE:0000000000000000000000000000000000000000000012fW
In-Reply-To: <50EC8025.8000707@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of
	"Tue, 08 Jan 2013 21:23:01 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213021>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> invalid_ref() constructs a test case description using its last argument,
> but the shell seems to split it up into two pieces if it contains a
> space.  Minimal test case:

This is indeed a bug in NetBSD's shell, which I reported after finding
this test case problem, and I think someone is working on a fix.  But
because git does not intend to be a shell torture test, if it's possible
to avoid bugs in a reasonable way, I think it's nice to do so.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDsx30ACgkQ+vesoDJhHiXrAgCfbpnqk9z1+UvnvM51hv6GkOJ9
H1cAniURcaikn9i2IQniyEVE5TpiHE/S
=j83f
-----END PGP SIGNATURE-----
--=-=-=--
