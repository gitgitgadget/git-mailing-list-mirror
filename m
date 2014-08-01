From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: cherry picking and merge
Date: Fri, 1 Aug 2014 02:43:29 +0000
Message-ID: <20140801024329.GA28914@vauxhall.crustytoothpaste.net>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Cc: git@vger.kernel.org
To: Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Fri Aug 01 04:43:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD2or-0004eW-3T
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 04:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbaHACnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 22:43:41 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49226 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751663AbaHACnk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2014 22:43:40 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:84c3:81a6:6259:5e7b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 819322808F;
	Fri,  1 Aug 2014 02:43:33 +0000 (UTC)
Mail-Followup-To: Mike Stump <mikestump@comcast.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254618>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 05:58:17PM -0700, Mike Stump wrote:
> Cherry picking doesn=E2=80=99t work as well as it should.  I was testing =
on
> git version 1.7.9.5.
>=20
> Put in a line in a file, call it:
>=20
> first version
>=20
> then cherry pick this into your branch. Then update on master and transfo=
rm that into:
>=20
> second version
>=20
> then, merge that branch back to master.  Death in the form of conflicts.
>=20
> In gcc land, I do this sort of thing all the time, and I need a
> merging subsystem to actually keep track of things.  I can manage this
> will diff and patch and it works flawlessly.  The point of using
> something better than diff and patch is for it to be better than diff
> and patch.
>=20
> I=E2=80=99d like for merge to merge in the work that has yet to be merged.
> Not that, plus blindly try and apply or reapply cherry picked items.

You're not the first person to be surprised by the way merge works.
=46rom the git-merge manpage:

  [This behavior] occurs because only the heads and the merge base are
  considered when performing a merge, not the individual commits.

(That was added after 1.7.9.5.)

If you want the behavior of applying multiple patches in a row, you want
to use git rebase, not git merge.  Since rebase re-applies the patches
of each of your commits on top of another branch, the identical change
won't cause conflicts.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT2v7RAAoJEL9TXYEfUvaLwXEP/jZPp/8TCimH8hWzvmkHX8ME
+lqrfKruTYoWUkXp5EgGJCUQ6Dv2LkUiUGz1Goy8FHIshSmLJDdD/o+L7zzBkk/z
3M8ZP9f/Akgz0ZPSY9lKNCS11gifSuiJlFCOJzWeqtKTHjP+BBLjS4h1K2Ln3OuM
Xl8W6MB7C3IwhfMMu1zIqxifg1y9nIRc/1uKTRMwjfivYgHtDrcC9fEAXs+4h8dX
iB2MdlF/o+Ax4lpvlNNlDilBG9Z5k+t50tKBxqmG1DU6yNu3lx4YJb3FYj2l55r3
ph3GgkNceYLff9IizeSftAtAW0CWlwlwZuqTsh8/drCJTTG6/sotsIwgqygtVq/l
HiwTVzrTyjiydUKclnHs6jXx2yMHrxtcdl23h0RJxKopI9Hw5DHN+foXy+mV35cy
x4KXExVlbkCw1XWwpeRtkkDuiQE3kL3/VUjkRW0RULLIAtHVuHRrHJvDX06FfwLN
jSXE2e6YnfN8tLlqh17xUcs98qliSNFGwMljsbg/wr8QbPU5M4GqLb0riLR3HCvd
goM5IofLTTxlHEtEEMRLug8RMxFRYQePqBZBU72h/R++UNtCll24yOmy8GtEsdIH
AF6dg4yEwUzJnw5vcYvsqhgvL86i28JzVgHocOCPFppNyQNafQ5xFp0aOitQkH7B
/H2rzlDxW0XCaaZhSyrT
=sVkW
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
