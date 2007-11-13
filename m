From: Kristis Makris <kristis.makris@asu.edu>
Subject: Re: Git and Scmbug integration
Date: Tue, 13 Nov 2007 16:55:42 -0700
Message-ID: <1194998142.4106.24.camel@localhost>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_morpheus-31438-1194998173-0001-2"
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: David Symonds <dsymonds@gmail.com>, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 14 00:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5cN-0008Ey-2M
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbXKMX4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758133AbXKMX4P
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:56:15 -0500
Received: from net.mkgnu.net ([67.40.69.52]:60113 "EHLO mail.mkgnu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758070AbXKMX4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:56:14 -0500
Received: from syd-mkgnu-net.dhcp.asu.edu (syd-mkgnu-net.dhcp.asu.edu [::ffff:149.169.179.39])
  (AUTH: LOGIN mkgnu@mkgnu.net)
  by morpheus with esmtp; Tue, 13 Nov 2007 16:56:12 -0700
  id 0000601F.473A399C.00007ACE
In-Reply-To: <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64912>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_morpheus-31438-1194998173-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-11-14 at 10:00 +1100, David Symonds wrote:
> > http://bugzilla.mkgnu.net/show_bug.cgi?id=3D991
> >
> > There's no hook that will trigger when a tag is applied.
>=20
> I believe the 'update' hook is run when the tag is pushed.

Even if that is true, there no hook that will trigger when a local tag
is applied.

> > (2)
> >
> > http://bugzilla.mkgnu.net/show_bug.cgi?id=3D992
> >
> > Git does not offer metadata describing a change on the commit trigger
> >
> > The commit trigger seems to be "post-commit" but it supplies no argumen=
ts. The
> > "update" trigger supplies a lot of information but that's only triggere=
d when
> > changes are published to a remote repository.
>=20
> Isn't this some kind of centralised bug-tracking system anyway? It
> would be nice, I see, for the 'commit' hook to take, say, the commit
> SHA-1 hash as a parameter.

It isn't a centralized bug-tracking system necessarily. Because
different developers may used different, custom bug-tracking systems,
with custom hooks in their own local Git repositories that integrate
with only their own bug-tracking systems. And perhaps we can add the
support in the Scmbug Git frontend to integrate with a centralized
bug-tracker only on push operations if desired.

But we can't explore any of these issues, discussed in the thread below
too, unless we can extract what's needed from the hooks.

http://thread.gmane.org/gmane.comp.version-control.git/48981/focus=3D49011


I'd like the commit hook to provide enough information to be able to
tell which files were modified and their respective old/new version (or
perhaps their old/new SHA-1 hash). If the new SHA-1 hash can be used to
extract all that, that's ok with me. But right now there's nothing.



--=_morpheus-31438-1194998173-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHOjl+/KuTDwnYLxERAqvOAKCjD28k7qs43YdkMTXFX7I9pizxhQCcDy1P
QGCgvWNtGkpzzvOHI9XzoSw=
=CM4h
-----END PGP SIGNATURE-----

--=_morpheus-31438-1194998173-0001-2--
