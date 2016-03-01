From: Joey Hess <id@joeyh.name>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Tue, 1 Mar 2016 19:14:22 -0400
Message-ID: <20160301231422.GA3731@kitenet.net>
References: <20160301204218.GA4083@kitenet.net>
 <CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
 <CAGZ79kbV9y6nDuBgqLbzQ=xaroG_uF8RF6gqzk=unJ-9rrtvfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:14:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatUx-00063t-Pq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbcCAXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:14:32 -0500
Received: from kitenet.net ([66.228.36.95]:43714 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbcCAXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:14:31 -0500
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=Xl65N9Eh;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1456874062; bh=2mizP8B99LciOgn1XFr1j11E0dw6N5vgpIsbcWlK4d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xl65N9Ehd0hpKJstTnVcQ6IUnrDxPPEDOhtep6c2jV3SMvUkg7lyCbp9IHaSUPUCB
	 YZxpndJdURTdBuH+WZkMjeI3+UeGM2IlN6eeCByLIlXFPCjfVdSWNri6+JrpBx63As
	 fFpgHxVc2M+YtmorRoFy84nYzO8uc320Aa+5qfWs=
Content-Disposition: inline
In-Reply-To: <CAGZ79kbV9y6nDuBgqLbzQ=xaroG_uF8RF6gqzk=unJ-9rrtvfw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288077>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stefan Beller wrote:
> To elaborate on that: Starting in 2.7 parts of the submodule stuff
> has been rewritten in C, in 2.8 even more and there is more in flight for
>  > 2.8.
>=20
> However your bug is also to be found in 2.6, which doesn't contain any
> recent rewrites, so it is a rather long standing bug, I would presume.

Yes, I saw it with 2.7.0, but I think the user who reported it was on
2.6.

> As a workaround for now:
>=20
>     echo "gitdir: ../gitdir/.git" > .git

Not an option in our particular situation, unfortunately.

I wonder if the miscalculated ../../../somedir could cause git to access
files outside the git repos?

--=20
see shy jo

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVtYiTMkQ2SIlEuPHAQKqyA/+KJAh5FiGJ2qLbMSjVAfIZw0d9ZmIfz6y
pd7jPjmp6ocaCAJWT4CFsN5oAIBDsqo2diJAfKMo9gZEtJXlh6y+MPlzf/0eBHWD
QkwaytgQ05wlbRevDleCGHkEyvhLdBC1F7F1YEiWQHFDvMpM15ft8gJBUHB+tLZb
rh7Hnsn0NxRhXoLN7DStcLAkdP6jiwImsMNVga5E2EGQgFUvKkU16roKAYbIUkiB
lA4mJJkpOvm9xySwf0rzqU1YXwTZ+EFViDOIX5nFu7Rv9E+2+OVE8rrvMa9g0cP+
Is2+TDXGybecXCda+jurYY9kgt6M8Am+9XgE0enixTXTdlFIcHJ5DrG0lccE0ybm
mdt9xg4tvmtpQg1jr2k0Tqkz6ulgx2UFuQhwQFdAhlUPoRt/zxw6shDQqyozdy7U
0YJIDyAAuMtrSQCbXW125dDsKzq9YwIGea6gqUNMgnw37uhmpLT3hTKuf+zO/h/0
pnMUu3fSAarwGO9OkBt/yLHxE3fgyVpLyraHF7QEH+4zO6GweRUigBiAilGSJeKc
fX288I8y9NI+e8uh4konJoyUpGcnrJ9MxkSnm4YT74Jg4ZIeWLf+AN61WTyarfZh
o/BcmJ53YM1pcfjGODrJA7JaP9gn/LeNK3Kwi0oH7p03Cmar1BQQ2/pJuYeFeYid
xikKT7WpmGo=
=3Vai
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
