From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: Failed binary detection.
Date: Sat, 22 Dec 2007 02:00:45 +0300
Message-ID: <20071221230045.GA9442@wo.int.altlinux.org>
References: <20071221195019.GA20668@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 22 00:01:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5qrf-0005IN-D2
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 00:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759756AbXLUXAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 18:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758980AbXLUXAs
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 18:00:48 -0500
Received: from vint.altlinux.org ([194.107.17.35]:45242 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758098AbXLUXAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 18:00:47 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 950DCB48711
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 02:00:45 +0300 (MSK)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 89175B45487; Sat, 22 Dec 2007 02:00:45 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20071221195019.GA20668@old.davidb.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69105>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2007 at 11:50:19AM -0800, David Brown wrote:
> A coworker has a branch with some large binary files (video test streams).
> Git doesn't seem to be detecting this file is binary, and is causing thin=
gs
> that try to generate diffs to fail.
>=20
> Specifically, he is unable to rebase his branch, getting an error:
>=20
> .dotest/patch:3241:LD   :=3D ld
> fatal: corrupt patch at line 84682
> Patch failed at 0001.
>=20
> Line 84682 is in the middle of what appear to be the binary contents of t=
he
> large media file, with pluses inserted after newline.
>=20
> Any advice on where to look or possibly how to fix this?

See discussion of this issue in git archives, e.g.
http://marc.info/?t=3D119652720900002


--=20
ldv

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHbEWdfKvmrJ41Nh4RAlXcAJ9JznBO0ULuIT9CU5tN2oN6HLjNcgCgpRX6
AMEOBn76rhItJlsj58Vud78=
=oU9h
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
