From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:55:37 +0200
Message-ID: <20060529215537.GH14325@admingilde.org>
References: <20060529202851.GE14325@admingilde.org> <20060529204158.GC28538@spearce.org> <20060529212249.GF14325@admingilde.org> <20060529213543.GA29054@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:56:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkpi9-0003DE-Ba
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWE2Vzj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWE2Vzj
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:55:39 -0400
Received: from admingilde.org ([213.95.32.146]:57295 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1751346AbWE2Vzi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:55:38 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Fkpi5-0000XA-68; Mon, 29 May 2006 23:55:37 +0200
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060529213543.GA29054@spearce.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20981>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 29, 2006 at 05:35:43PM -0400, Shawn Pearce wrote:
> Now that diff+apply is probably faster than a 3 way merge in
> read-tree precisely because it doesn't need to run merge-recursive
> I'm starting to look at how we can use apply to do partial
> application of a patch and use RCS' diff3 or just drop a reject
> file out when a hunk doesn't apply cleanly.

but when applying patches, we have to be careful not to overwrite
any changes in the working tree which have not yet been committed.
With read-tree it should operate entirely in its temporary index without
touching the working tree.

> > But then an operation as important as commit has to be bullet-proof
> > and I don't like to do anything complex in there.
>=20
> I agree.  But I'd like to see some sort of functionality to
> automatically handle some common topic branche cases in commit.
> Of course I consider the current commit tool to already be too
> complex (like being able to pull the commit message from any
> random commit).

And I really feel guilt for trying to add even more.
Is there some other way to add such a feature?

I have been dreaming of such a system for years now, and with GIT
it really feels feasible at last.
Graphics programs could compose an image out of different layers for
ages, now it is time for version control software to do the same :-)

--=20
Martin Waitz

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEe23Zj/Eaxd/oD7IRAp0ZAJ9WR0hZEB9aY0K6VFxluLvqptf/XgCeLVHK
JjdyTRAsh0pACN9xprDx8TQ=
=WQ+y
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
