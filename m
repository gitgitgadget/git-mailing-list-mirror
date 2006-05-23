From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Q: xasprintf
Date: Tue, 23 May 2006 15:28:54 +0400
Message-ID: <20060523112854.GD5582@basalt.office.altlinux.org>
References: <e7bda7770605221609h7c18c2ccpe92db34050d46f9f@mail.gmail.com> <BAYC1-PASMTP115C9137E5BDABD705881BAE9B0@CEZ.ICE> <7vzmh98seo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
X-From: git-owner@vger.kernel.org Tue May 23 13:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiV4c-0001Tg-1P
	for gcvg-git@gmane.org; Tue, 23 May 2006 13:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWEWL25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEWL25
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 07:28:57 -0400
Received: from mh.altlinux.org ([217.16.24.5]:51859 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1751071AbWEWL24 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 07:28:56 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP id 140965F413
	for <git@vger.kernel.org>; Tue, 23 May 2006 15:28:55 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id BC434B0D89; Tue, 23 May 2006 15:28:54 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzmh98seo.fsf@assigned-by-dhcp.cox.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20590>


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 22, 2006 at 06:02:39PM -0700, Junio C Hamano wrote:
> Sean <seanlkml@sympatico.ca> writes:
[...]
> > -		name =3D xmalloc(len_a + len_b - pfx_length - sfx_length + 7);
> > +		name =3D xmalloc(pfx_length + a_midlen + b_midlen + sfx_length + 7);
> >  		sprintf(name, "%.*s{%.*s =3D> %.*s}%s",
>=20
> Obviously correct given what the sprintf() that immediately
> follows does.  Sheesh, what was I smoking back then.  *BLUSH*

What about introducing xasprintf() to eliminate such issues?


--=20
ldv

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEcvH2fKvmrJ41Nh4RAp4zAJ91mokNOG+cxlsxIF46AuBh7LJp0QCfQFPJ
ntyH1lNVlTV2pWu8P/Xu/no=
=9WU3
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
