From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] git svn: info: correctly handle absolute path args
Date: Mon, 8 Sep 2014 00:22:56 +0000
Message-ID: <20140908002256.GB43902@vauxhall.crustytoothpaste.net>
References: <20140907080626.GA6273@dcvr.yhbt.net>
 <540C1E07.7030105@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Cc: Eric Wong <normalperson@yhbt.net>,
	Andrej Manduch <amanduch@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 02:23:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQmjd-0000Yo-I7
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 02:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbaIHAXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 20:23:05 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50027 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751001AbaIHAXD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2014 20:23:03 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 354822808F;
	Mon,  8 Sep 2014 00:23:00 +0000 (UTC)
Mail-Followup-To: Johannes Sixt <j6t@kdbg.org>,
	Eric Wong <normalperson@yhbt.net>,
	Andrej Manduch <amanduch@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <540C1E07.7030105@kdbg.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256631>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 07, 2014 at 10:57:43AM +0200, Johannes Sixt wrote:
> Am 07.09.2014 10:06, schrieb Eric Wong:
> >  sub cmd_info {
> > -	my $path =3D canonicalize_path(defined($_[0]) ? $_[0] : ".");
> > -	my $fullpath =3D canonicalize_path($cmd_dir_prefix . $path);
> > +	my $path_arg =3D defined($_[0]) ? $_[0] : '.';
> > +	my $path =3D $path_arg;
> > +	if ($path =3D~ m!\A/!) {
>=20
> There must be a more portable way to check for an absolute path. Think
> of DOS-style paths...

You probably want File::Spec->file_name_is_absolute($path).  Either that
or always turn the path into absolute or relative form with
File::Spec->abs2rel or File::Spec->rel2abs, and then go from there.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUDPbgAAoJEL9TXYEfUvaLaQkP/16ogcSdue8bwzakKGuIU1WK
BKd7AFoukp71iAuHIQQvMvJS1FGlPJ8oT2O+HhPf+CXOLUjkYocP4IAFX2AnUGH2
QBFZLi7vt2oe7KjgNkqKpR6wd9I/YoPIfn78jGtzcJKiMuXZxwFsStsUchLnrSa3
yLRqJoymhv4s7a/faR+ZnsSPHoEpycycteLyxweZknUe9G62l93o29gBY+H1yGWQ
106vmu1dCtXwg77QTZIntE1D30eQw/L9rOAA4PZlKBnTpKxTSWHE2Ed3sZzte9sq
Z2uKodfGuhZtdv1IKYucmI+bKZYfmtZokJ3mVRPEBN7p8Yj+KCAQy51aIWEapBaB
3unjcGvgtzcaRaCvMhobGtcktcqxNQfrvshXPXiFJOkzwAtEF5fPWLcooq2u8oyx
Hb4GrNr7WN4gfxK/ALulnjp3ILL2R5i3c1OFKThPBqdnpmauloyCGF7GcH+y0UQp
eo1oUKHlm2lis1qLajnfmTEIYczuzOaqd2eZUJRLObBmwjFEvo8Z5fZySoTPVqn0
9cnSjqI1c9EzFOvQiDjCWQVSKbaeAnpjPCMvmGriTFkQEHS9D38KQkV53EPMVYBt
Ac7biNaJDUtgIFc1qOcZXTTqyWanGxGCGSA/vh0hClwURwgvG56FzCjRIfsiCj2t
ASlIN7sZpcg2+5U3osO0
=b6UD
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
