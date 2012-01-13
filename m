From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 18:56:17 +0100
Message-ID: <20120113175617.GE2850@centaur.lab.cmartin.tk>
References: <loom.20120112T193624-86@post.gmane.org>
 <loom.20120113T181805-423@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0/kgSOzhNoDC5T3a"
Cc: git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 18:56:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RllMZ-0007KZ-6j
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 18:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab2AMR4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 12:56:15 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:51974 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab2AMR4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 12:56:15 -0500
Received: from centaur.lab.cmartin.tk (brln-4db9f5ad.pool.mediaWays.net [77.185.245.173])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id BB62C461BE;
	Fri, 13 Jan 2012 18:56:01 +0100 (CET)
Received: (nullmailer pid 27180 invoked by uid 1000);
	Fri, 13 Jan 2012 17:56:17 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Yves Goergen <nospam.list@unclassified.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20120113T181805-423@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188522>


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 05:37:38PM +0000, Yves Goergen wrote:
> I have updates to this issue.

You still haven't told us what version of (msys)git you're using nor
have you provided a transcript of your session or found a minimal
reproducible example.

Gmane is a mailing list viewer and there /only/ is the real maling
list. The e-mail you provided for yourself looks bogus, but if it
isn't, you'll notice we communicate via e-mail.

>=20
> After asking several people who didn't believe me,
> after all I could pass all checks to ensure that
> the file in question really is tracked, despite the error
> message telling it is not. (The file has a history, it is
> part of the branch,
> git status behaves as expected when I rename it, and so on.)
>=20
> I had found a workaround hack to access my
> data again: I have cloned the repo
> into another directory, then switched to
> the branch in there (it actually
> worked) and used BeyondCompare to manually(!)
> switch my original repo and
> working directory by copying some (not all) files
> in .git and all differences in
> the working directory.
>=20
> That worked fine at first, I could commit to that branch.
>=20
> Today I wanted to merge that branch into master again.
> Switching to master was
> fine, but merging from the form-refactoring branch
> now fails for the very same
> "reason":
>=20
> -----
> git.exe merge    --no-commit form-refactoring
>=20
> error: The following untracked working tree files
> would be overwritten by merge:
> Form1.Designer.cs
> Please move or remove them before you can merge.
> Aborting
> -----
>=20
> Again, that file is NOT untracked. Git just fails
> processing its own data. I
> cannot move that file because it is part of the
> other branch and must be merged now.
>=20
> Am I now supposed to checkout both branches and
> do the merge somehow on my own?
>=20
> Maybe it's not a good idea to use branching and
> then rename, create and delete
> files on that branch, as switching and merging
> fail completely afterwards. And
> in the end, maybe Git isn't all that good and
> some of the alternatives with real
> file tracking should be preferred.
>=20
> I, for one, have lost a great amount of trust
> in Git in the last two days.
>=20
> (Sorry for the formatting mess, but the stupid Gmane
> post editor forced me to do that or it wouldn't
> accept my message... Don't you have a real mailing
> list, if there's no web forum??)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPEHBBAAoJEHKRP1jG7ZzTfMQIAJJ43l1199ZDjdPvqvp9KLCt
T0k0OPSkVOeUke8gpxILrmkeItBjUHfzZjnH8x/gEBboVtAyJaB6Ci3ozi4FJLpi
URq+o6frRbxParakSl+f8h53w99yXvoU8UxtDBsYuhMRUSCtTlQ4tdWqotQyhj9L
+f65TQP4sNFXtnfD3RvCXmZoK/lipShvc39noIv0A1tsqnKc8636CnF90buvvfFk
Mk50Ev+LsrCOND1TkZpUbmaYANWHFl106oa68GOxeD4gt2/W73jxp0ObxOQbCbqV
l3/mOoEYclBQDd5QCMt/xLimtaiviLNTv3U76zynCrc1h9BuhWSYKib+zwoQwkE=
=e8Hk
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
