From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Tue, 28 Oct 2008 14:16:10 +0300
Message-ID: <20081028111610.GE1682@wo.int.altlinux.org>
References: <7vljy13sq0.fsf@gitster.siamese.dyndns.org> <20080910062529.6117@nanako3.lavabit.com> <20080910200318.6117@nanako3.lavabit.com> <7v8wtzvd8h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 12:26:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kumia-0007XU-Jc
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 12:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbYJ1LZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 07:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYJ1LZE
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 07:25:04 -0400
Received: from vint.altlinux.org ([194.107.17.35]:33636 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772AbYJ1LZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 07:25:03 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id E5FA23F80240;
	Tue, 28 Oct 2008 14:16:10 +0300 (MSK)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id D724D3F48C90; Tue, 28 Oct 2008 14:16:10 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7v8wtzvd8h.fsf@gitster.siamese.dyndns.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99283>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
=20
On Wed, Sep 10, 2008 at 03:37:50PM -0700, Junio C Hamano wrote:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>=20
> > Subject: [PATCH] Install git-cvsserver in $(bindir)
> >
> > It is one of the server side programs and needs to be found on usual $P=
ATH.
> >
> > Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> > ...
> > -	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-arch=
ive$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
> > +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-arch=
ive$X git-shell$X git-cvsserver$X '$(DESTDIR_SQ)$(bindir_SQ)'
>=20
> Thanks.
>=20
> Will queue but without $X at the end, as I do not think we want it even on
> Windows because cvsserver is a script.

Please apply this compatibility fix (commit v1.6.0.1-308-gede4caf)
to maint as well.


--=20
ldv

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkG9HoACgkQfKvmrJ41Nh7IIwCgqu3La7HeLpvXSccEvA1BkCaD
qvsAoLJ7gHHdtaIjspk24AwEx0E6iAnf
=k9k9
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
