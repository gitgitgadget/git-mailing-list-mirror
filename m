From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH] git-mergetool--lib.sh: fix mergetool.<tool>.*
 configurations ignored for known tools
Date: Sun, 06 Jun 2010 00:42:29 +0200
Message-ID: <1275777749.18270.23.camel@kheops>
References: <1275705112-8088-1-git-send-email-sylvain@abstraction.fr>
	 <1275705112-8088-2-git-send-email-sylvain@abstraction.fr>
	 <m2fx11n8rp.fsf@igel.home>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MUNXUKCHnO7syFPQ2HG4"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jun 06 00:42:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL24h-0001Rh-3J
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933466Ab0FEWmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 18:42:36 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60344 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab0FEWmf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 18:42:35 -0400
Received: by wwc33 with SMTP id 33so323108wwc.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 15:42:34 -0700 (PDT)
Received: by 10.227.143.66 with SMTP id t2mr12177041wbu.116.1275777754259;
        Sat, 05 Jun 2010 15:42:34 -0700 (PDT)
Received: from [192.168.0.77] (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id u36sm23032855wbv.0.2010.06.05.15.42.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 15:42:33 -0700 (PDT)
In-Reply-To: <m2fx11n8rp.fsf@igel.home>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148503>


--=-MUNXUKCHnO7syFPQ2HG4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2010-06-05 at 11:11 +0200, Andreas Schwab wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>=20
> > +			if !test -f "$merge_tool_path/$merge_tool_cmd_base"; then
>=20
> Missing space after '!'.
>=20
> > +			elif !test -x "$merge_tool_path/$merge_tool_cmd_base"; then
>=20
> Likewise.
>=20
> Andreas.
>=20

Thanks,=20

I have updated the patch, you can find it here
git://git.abstraction.fr/~sylvain/git.git in the mergetool-lib branch.

http://git.abstraction.fr/~sylvain/?p=3Dgit.git;a=3Dcommitdiff;h=3D905bfb5c=
ea0750a67bf9bcc2baf22079054742fa

--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-MUNXUKCHnO7syFPQ2HG4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwK0tEACgkQ+TklUoyVcyfiagCfYKdHAHXFefxQdFndJId+epqe
m0QAniLemTklubyDyrnjaiZXVPt6qo7S
=FdJS
-----END PGP SIGNATURE-----

--=-MUNXUKCHnO7syFPQ2HG4--
