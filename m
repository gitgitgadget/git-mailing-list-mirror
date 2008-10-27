From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 22:07:16 +0100
Message-ID: <20081027210716.GS2273@genesis.frugalware.org>
References: <ge0rla$mce$1@ger.gmane.org> <200810271512.26352.arne_bab@web.de> <200810271901.48925.jnareb@gmail.com> <200810272149.13542.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xtmLDbP6TiKhntQb"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Arne Babenhauserheide <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 22:08:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuZKJ-0006sU-FN
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 22:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbYJ0VHX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 17:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYJ0VHX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 17:07:23 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55938 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978AbYJ0VHV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 17:07:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4C9F8580AC;
	Mon, 27 Oct 2008 22:07:19 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2C01F4465E;
	Mon, 27 Oct 2008 22:07:17 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 04F1011901A1; Mon, 27 Oct 2008 22:07:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200810272149.13542.arne_bab@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99266>


--xtmLDbP6TiKhntQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2008 at 09:48:50PM +0100, Arne Babenhauserheide <arne_bab@w=
eb.de> wrote:
> 1) Writing Python is much easier and quicker than writing C, especially w=
hen=20
> you can just experiment with the Python interpreter (or better still: wit=
h=20
> ipython). No memory management hassle, no strange compiler bugs, no stray=
=20
> pointers. Just plain writing what you want to do. But if you need C speed=
, you=20
> can still include parts written in C - where you really need it. For all =
other=20
> cases you have more readable and far more compact code.=20

You compare Python to C here, but did you realize that in git you can
write your git command in any language you want? Of course it's
recommended to do it in C/shell/perl if you want to get it included in
git.git, but that's just a decision.

> 2) You can easily access every core function, and you can replace every=
=20
> command.=20
> You don't have to invent a "git foolog" command. Instead you can just ada=
pt=20
> the regular log to do a foolog which people can use via "hg log".=20

IIRC the main reason git aliases can't overwrite git commands is because
that would break scripts relying on the output of existing git commands.
Given that I install such an extension, won't my script break?

> The defaults should be the most common way to use the tool, so people can=
=20
> easily learn it.=20
>=20
> Advanced stuff can be added with extensions.=20

=46rom a user's point of view, I think external git commands and such hg
plugins are equal. The user instally the "foo"
extension/command/plugin/whatever and gets the "git/hg foo" command.

> And because the most used plugins are distributed with Mercurial, I can a=
lso=20
> activate them when I don't control the Mercurial installation - and shoul=
d=20
> something be missing which I need, I can just download and activate a plu=
gin=20
> without having to compile anything, since they are simply Python modules.=
=20
>=20
> Just set=20
> [extensions]
> foo =3D /blah/foo.py
>=20
> in ~/.hgrc and the foo plugin is active.=20

Same for git, as long as it's written in a scripting language; you
should include git-foo in PATH then you can use git foo.

--xtmLDbP6TiKhntQb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkGLYQACgkQe81tAgORUJZ6/gCeNcO4yUB73g6fIlNSUumt5IiQ
xckAnAmywp3bkzN2xK3X6b1DkHklpu/I
=MrTX
-----END PGP SIGNATURE-----

--xtmLDbP6TiKhntQb--
