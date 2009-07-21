From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: vimrc
Date: Tue, 21 Jul 2009 11:20:07 +0100
Message-ID: <20090721102006.GA27793@bit.office.eurotux.com>
References: <0EBD460B-AA87-44AD-A98C-86787F3BA91A@roalddevries.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Tue Jul 21 12:35:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTCh7-0004rT-2y
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 12:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbZGUKb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 06:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbZGUKbF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 06:31:05 -0400
Received: from os.eurotux.com ([216.75.63.6]:42779 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbZGUK2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 06:28:04 -0400
Received: (qmail 16418 invoked from network); 21 Jul 2009 10:28:02 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES128-SHA encrypted SMTP; 21 Jul 2009 10:28:02 -0000
Content-Disposition: inline
In-Reply-To: <0EBD460B-AA87-44AD-A98C-86787F3BA91A@roalddevries.nl>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123655>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2009 at 12:09:33PM +0200, Roald de Vries wrote:
>  Hi all,
>=20
>  I have my ~/.vimrc in a repository, and if I commit something, I get:
>=20
>  $ git commit
>  Error detected while processing /home/rdv/.vimrc:
>  line   11:
>  E518: Unknown option: foldmethod=3Dindent
>  line   12:
>  E518: Unknown option: foldlevel=3D10
>  line   13:
>  E518: Unknown option: foldcolumn=3D4
>  line   16:
>  E538: No mouse support: mouse=3Da
>=20
>  Anybody knows why? It doesn't seem to break anything, but still...

Your $EDITOR (by default vi) doesn't support those directives in .vimrc.

Try EDITOR=3Dvim git commit ...

If it works, set export EDITOR=3Dvim in your .bashrc.

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkplllUACgkQinSul6a7oB8vAQCfX9/6HEdQKYSjg8P9doEL86Ju
o2UAn19wfWwKZZgTYu3ltSRp8FwfK/EX
=GMuY
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
