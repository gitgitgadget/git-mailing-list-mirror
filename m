From: "W. Trevor King" <wking@tremily.us>
Subject: Re: submodules
Date: Thu, 23 Jan 2014 09:20:14 -0800
Message-ID: <20140123172014.GS29063@odin.tremily.us>
References: <CAH_OBicG4bLWu_C=uF6bTzzdJP5SSZ=odQF-qsP4n+VvAN4nrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkdIF91f86UUr6LJ"
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 18:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Nx4-0004je-H9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 18:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbaAWRUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 12:20:20 -0500
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:54538
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751544AbaAWRUS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 12:20:18 -0500
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta13.westchester.pa.mail.comcast.net with comcast
	id HUMw1n00C0cZkys5DVLHV1; Thu, 23 Jan 2014 17:20:17 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id HVLF1n00p152l3L3WVLG1Q; Thu, 23 Jan 2014 17:20:17 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id BFCCEF0C3AA; Thu, 23 Jan 2014 09:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1390497614; bh=t1+BCYmrqdOvfAwwpgjAGH17o9E5bCjInCHFDlmFE7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hlm9xOeQHqzoAoqMzPVp8mWXwao3gsrKng1gigDEYHwVKlrMkRL+wQfQQtRaNgy1V
	 Z5mR3d8mm/AqMdNx7pBgGeyTDXS183DBoYtNBVpVJkOxEoULqVerQ4+T9Qe5Pw45hh
	 SIdWbKvetZ0KngJTYrsZxsP+9TcZn8ElZ8PFAN+M=
Content-Disposition: inline
In-Reply-To: <CAH_OBicG4bLWu_C=uF6bTzzdJP5SSZ=odQF-qsP4n+VvAN4nrQ@mail.gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390497617;
	bh=agkGCSs5J4EQgL/ZwiXSzw/2RezLOzM2G9sn/H49MXs=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=YgzsJzwuuQEXKykWhyMsMiB9gEuFkZ90lgq1/7JPC8CgYOS18TQ5juvLEEfu2pnnJ
	 dHCNS4jhjbW16/x1NU3a41vKpsu+f/s+cdr5dm5arP0s/dZq5vJU1hkIpYu2Qg1f/P
	 L9QUy5TZiAFTeTXML7F2xkRZxZK/ZMXc7yYW7Ad5BH4e17t9ngRDOoWXK2mG1ADoKP
	 J1dSMUXTld1t6HamRrcqLo2XYUenjHjPK711cpZUQcZan4pmaNN4tde/vMNNGe0QLd
	 l3ya7hpvg7KmaYjkuMvJh3mbPZ3ozInAcK8TlsDIPQHSJjC95kIrcU8OSJ7YjChvRW
	 5lJJfMMRt/FUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240919>


--JkdIF91f86UUr6LJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2014 at 03:38:49AM -0500, shawn wilson wrote:
> My issue is in trying to update the submodules, I'm getting:
>  % git submodule update --init
>                                                 gits/kt (master =E2=9A=A1)
> swlap1
> fatal: reference is not a tree: 98f1e9f99fca32ab3de901219eb2f600d38ab3a5
> Unable to checkout '98f1e9f99fca32ab3de901219eb2f600d38ab3a5' in
> submodule path 'repo_a'
>=20
> Ok, so a bit of googling and I found this:
> http://stackoverflow.com/questions/13425298/git-submodule-update-fatal-er=
ror-reference-is-not-a-tree
> Ok, so update the repo that contains the submodules every time you
> push from a sub repo? How / where do I create a hook to do this?

You've got it switched.  You *did* push the superproject, but forgot
to push the new submodule commits that it references.  An easy way to
avoid this problem is to always push the superproject using:

  $ git push --recurse-submodules=3Don-demand =E2=80=A6

If you no longer have access to the submodule repositories that
weren't pushed, you'll have to roll back the superproject so it
references submodule commits that were pushed.  The easiest way to do
this is probably to just cd into the submodule directory and checkout
an appropriate commit (e.g. origin/master):

  $ cd repo_a
  $ git fetch origin
  $ git checkout origin/master

That will put you on a detached HEAD, so you might want to replace the
checkout with:

  $ git checkout -B master origin/master

or some such to get a local branch.

Then cd back into the superproject and commit the submodule
(referencing the current submodule commit):

  $ cd ..
  $ git commit -m 'repo_a: Roll back to last public commit' repo_a

When you push that commit, don't forget to push everything ;)

  $ git push --recurse-submodules=3Don-demand

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--JkdIF91f86UUr6LJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4U9KAAoJEKKfehoaNkbtotYP/jR/0PoKAluqESj0powpZIvH
6bPxtT7P1vLc/M+Q2TtnqDcAzS5TLVKcB73Wy+kJZ0qiJW1jPElQh0m8BD4q6Dc8
qmQQ5ECXp/XrQGTKxnBIMHZi8wh4IEr75AzC7mK2ee8yV70Cm0K9SGcESGj9jfnL
7zodQxKrh47Zgy8hGw9ilUIlZOCUqNcmKK1gX9p4KRVoEGe8qrbe9t9x7BMFFg+5
N0YtBOXR+Iyu2AJwE7G3x7J5OSZxW+2bHi0qyoTDdrV7go1bD6c5CaTlrqCynl+O
i2DClNa+qrjaK9RGxcNGRw4XBxd4mYjvpUg+FqaqLuknR7rjDHkSzJLBhUzZWXQY
nweor2nMY+m+IheGUw6XDzIO0FZyx9V0HWAkWilYQlS60SVRARzPnUI5JDuvLZS9
wws6XDBrNW9TGlltaTprQSnj3ME3S8O4ExmDO5CebRgeQ27MTBuF9MhHJPjnnQnN
mdbi1Mc38O517dLTRS7OCkb6W3aJwiMG1i67FuJil41dRntlX3hdsGhi4xD+kkPP
wCGJcWOFQaZC1g/YR9VYVzr8pVzzzjDP32uiNGuWxNAJzs8WrnOUrRAqMsvksb/6
IxKGrRAe8ty+DIHq1X9OtsbYDsY2tVWxuruA6apQck+cH8hBCa0usMYbBE2g14DG
FdwWCTMZkDzrobJZFFRl
=duMe
-----END PGP SIGNATURE-----

--JkdIF91f86UUr6LJ--
