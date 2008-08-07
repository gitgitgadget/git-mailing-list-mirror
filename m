From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Thu, 7 Aug 2008 10:03:41 +0100
Message-ID: <20080807090341.GA6421@bit.office.eurotux.com>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net> <7v3alirw6b.fsf@gitster.siamese.dyndns.org> <4899D119.1080403@obry.net> <7vy73aqe9m.fsf@gitster.siamese.dyndns.org> <7vr692oufw.fsf@gitster.siamese.dyndns.org> <2008-08-07-10-45-21+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	pascal@obry.net, Pierre Habouzit <madcoder@debian.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Aug 07 15:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR5Ak-0005Zd-Dq
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 15:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbYHGNDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 09:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYHGNDu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 09:03:50 -0400
Received: from os.eurotux.com ([216.75.63.6]:51583 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbYHGNDt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 09:03:49 -0400
Received: (qmail 29994 invoked from network); 7 Aug 2008 09:03:46 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@213.205.93.24)
  by 0 with AES256-SHA encrypted SMTP; 7 Aug 2008 09:03:46 -0000
Content-Disposition: inline
In-Reply-To: <2008-08-07-10-45-21+trackit+sam@rfc1149.net>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91579>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2008 at 10:45:21AM +0200, Samuel Tardieu wrote:
> >>>>> "Junio" =3D=3D Junio C Hamano <gitster@pobox.com> writes:
>=20
> Junio> When running "git commit -F file" and "git tag -F file" from a
> Junio> subdirectory, we should take it as relative to the directory we
> Junio> started from, not relative to the top-level directory.
>=20
> Don't we have the same problem with "git show"? If you go into
> the "gitweb" directory of the GIT source, "git show HEAD:README" will
> show you the toplevel "README" instead of the one in the "gitweb"
> directory.

No, git show has different semantics. It has been discussed often in
this list.

For instance:
http://thread.gmane.org/gmane.comp.version-control.git/68786/focus=3D68852

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiaum0ACgkQinSul6a7oB9P1QCfUsKRGruHFOCoOiM66OzvPO3e
qx4AnijH7tbMAHRFFXZtFcl72foeRRZR
=+WIE
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
