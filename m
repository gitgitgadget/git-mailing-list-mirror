From: Henri GEIST <geist.henri@laposte.net>
Subject: Re: [PATCH/RFC] Documentation: Say that submodule clones use a
 separate gitdirs.
Date: Fri, 07 Mar 2014 23:35:14 +0100
Message-ID: <1394231714.7891.39.camel@Naugrim>
References: <1394178834.7891.38.camel@Naugrim>
	 <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GisMbIdteuHA6t5U/2Sj"
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 23:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM3MZ-0000bF-2L
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 23:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893AbaCGWf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 17:35:27 -0500
Received: from smtpout5.laposte.net ([193.253.67.230]:34010 "EHLO
	smtpout.laposte.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbaCGWf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 17:35:26 -0500
Received: from [192.168.0.8] ([82.242.149.125])
	by mwinf8509-out with ME
	id ambE1n0052iaXuy03mbFSB; Fri, 07 Mar 2014 23:35:21 +0100
In-Reply-To: <BEB30FB8-204C-4272-8F94-6210D96FB2CB@kellerfarm.com>
X-Mailer: Evolution 3.4.4-3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243635>


--=-GisMbIdteuHA6t5U/2Sj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 07 mars 2014 =C3=A0 16:42 -0500, Andrew Keller a =C3=A9crit :
> On Mar 7, 2014, at 2:53 AM, Henri GEIST <geist.henri@laposte.net> wrote:
>=20
> > Adding a note in the submodule documentation signaling that the
> > automatically cloned missing submodules are cloned with a separate
> > gitdir. And where it is put.
> >=20
> > Signed-off-by: Henri GEIST <geist.henri@laposte.net>
> > ---
> > Documentation/git-submodule.txt |    5 +++++
> > 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
> > index 21cb59a..ea837fd 100644
> > --- a/Documentation/git-submodule.txt
> > +++ b/Documentation/git-submodule.txt
> > @@ -64,6 +64,11 @@ using the 'status' subcommand and get a detailed ove=
rview of the
> > difference between the index and checkouts using the 'summary'
> > subcommand.
> >=20
> > +*NOTE*: when submodule add or submodule update commands clone a missin=
g
> > +submodule, the option --separate-git-dir is passed to the clone comman=
d
> > +and the gitdir of the submodule is placed outside of its working
> > +directory in the .git/module of the current repository.
> > +
>=20
> The modules directory is 'modules'.  And, the '.git' folder is not always=
 called '.git' -- in a submodule, for example, the directory name is the na=
me of the module.
>=20
> Also, this file contains mostly high-level documentation, and this additi=
on feels technical in nature.  Is there a location for more technical docum=
entation?  Or, perhaps it can be reworded to sound less technical?

This information is technical in nature but has some importance for general=
 users.
As this kind of clone have a separate gitdir, you will have a surprise if y=
ou
copy past the worktree as the gitdir will not come together.
I have done it and as the doc say nothing about that it take me some time t=
o
understand what happened. And why this repository behave differently than o=
thers.

May be I can rephrase like this :

*NOTE*: when 'submodule add' or 'submodule update' commands clone a missing
submodule, the $GIT_DIR of the submodule containing the metadata is placed
outside of its working directory in the $GIT_DIR/modules of the current
repository. Those submodule can not directly be copied or move.
You need to use 'git clone'.


>=20
> >=20
> > COMMANDS
> > --------
> > --=20
> > 1.7.9.3.369.gd715.dirty
> >=20
> >=20
> > --
>=20
>  - Andrew Keller
>=20



--=-GisMbIdteuHA6t5U/2Sj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iF4EABEKAAYFAlMaSaIACgkQkKuHPdwEGdRUPwD+KU+z0yesNlSt1pxUeiRA7QcQ
3vmygjdo4gocAmC5vAYA/iBOX+YAMk7rQdOfIou0+ZXptDEZEHGPG+ce+AdsiFUJ
=y25V
-----END PGP SIGNATURE-----

--=-GisMbIdteuHA6t5U/2Sj--
