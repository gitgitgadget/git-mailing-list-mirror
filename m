From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 3/4] Automatically detect a bare git repository.
Date: Sun, 31 Dec 2006 18:54:07 +0100
Message-ID: <20061231175407.GC6115@admingilde.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043019.GC5823@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Dec 31 18:54:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H14sv-0008Qr-TK
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 18:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWLaRyL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 12:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWLaRyL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 12:54:11 -0500
Received: from mail.admingilde.org ([213.95.32.147]:59405 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030374AbWLaRyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 12:54:10 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1H14sp-0003iz-Ux; Sun, 31 Dec 2006 18:54:07 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20061231043019.GC5823@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35704>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 30, 2006 at 11:30:19PM -0500, Shawn O. Pearce wrote:
> We test the current working directory only after we have tried
> searching up the directory tree.  This is to retain backwards
> compatibility with our previous behavior on the off chance that
> a user has a 'refs' and 'objects' subdirectories and a 'HEAD'
> file that looks like a symref, all stored within a repository's
> associated working directory.

Hmm, I have my dot files under GIT control so I can't use this mechanism
to use bare GIT repositories under ~/git/*.git.

Perhaps we should test the current directory first, but check that it
ends in .git?

--=20
Martin Waitz

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFl/k/j/Eaxd/oD7IRAnR8AJoD/iZQT3IINwMjMZAbEMOOQYDlaQCfXxel
X6RLw3dx/A1NmJpxxKW1/1s=
=hInK
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
