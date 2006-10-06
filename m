From: Martin Waitz <tali@admingilde.org>
Subject: Re: git show and gitweb gives different result for kernel
Date: Fri, 6 Oct 2006 20:30:55 +0200
Message-ID: <20061006183054.GU2871@admingilde.org>
References: <eg65cl$cvs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KM+e2hnYAO+MCJ5e"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuTM-0003tT-Cq
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWJFSa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbWJFSa5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:30:57 -0400
Received: from agent.admingilde.org ([213.95.21.5]:8163 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1422823AbWJFSa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:30:56 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GVuTH-0007CG-4F; Fri, 06 Oct 2006 20:30:55 +0200
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg65cl$cvs$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28429>


--KM+e2hnYAO+MCJ5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Oct 06, 2006 at 11:26:35PM +0530, Aneesh Kumar K.V wrote:
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommit;h=3D363e065c02b1273364d5356711a83e7f548fc0c8
>=20
> git show 363e065c02b1273364d5356711a83e7f548fc0c8

what do you mean? the diff?
git show uses diff --cc so that only changes which are not in
the parent trees are shown.
gitweb just diffs against the first parent, and this diff is
large in your example because a new upstream Linux kernel
got merged into a topic branch.  But it should still be correct.

But perhaps gitweb should use --cc, too.

--=20
Martin Waitz

--KM+e2hnYAO+MCJ5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFJqDej/Eaxd/oD7IRAoYUAJ4kjI9u8DkAuerZR/2BbX6l5HoN6ACfcR2n
hps/Gj/waXbParkRTUwERVg=
=HvJR
-----END PGP SIGNATURE-----

--KM+e2hnYAO+MCJ5e--
