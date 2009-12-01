From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: Re: Umlaut in filename makes troubles
Date: Tue, 1 Dec 2009 08:44:20 +0100
Message-ID: <20091201074420.GC3618@triton>
References: <200912010815.14515.rick23@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
To: rick23@gmx.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 08:51:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNVl-0004kB-IH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbZLAHuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZLAHuu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:50:50 -0500
Received: from smtp.domeneshop.no ([194.63.248.54]:33968 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbZLAHuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:50:50 -0500
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2009 02:50:49 EST
Received: from sfn-inkubator-70-242.hib.no ([158.37.70.242] helo=triton)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <sunny@sunbase.org>)
	id 1NFNPJ-0000bv-TI; Tue, 01 Dec 2009 08:44:21 +0100
Content-Disposition: inline
In-Reply-To: <200912010815.14515.rick23@gmx.net>
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134174>


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009-12-01 08:15:08, rick23@gmx.net wrote:
> I have problems with my repository under slackware vs. windows. I=20
> created a repo in linux and every time I use it under msysgit, the=20
> files containing umlauts in the filename are marked as deleted (and=20
> vice versa).
>
> For instance: the repo perfectly synced under msysgit leads to:
>
> user@sauron:/media/disk-2$ git status |grep Auszug
> #       deleted:    "trunk/007_Literatur/Auszug aus Ergonomische=20
> Untersuchung des Lenkgef\374hles.docx"
> #       "trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=20
> Lenkgef\303\274hles.docx"
>
> in linux. But the file exists and is displayed correctly in the shell=20
> or in dolphin (my filemanager under X):
>
> user@sauron:/media/disk-2$ ls trunk/007_Literatur/Auszug*
> trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=20
> Lenkgef=C3=BChles.docx
>
> Can you please give me a hint what to do?

Try to specify "utf8" as mount option under Linux. You can also try=20
experimenting with the "nls" mount option, check out the mount(8) man=20
page to see how it's used.

Additionally, I found that I need "shortname=3Dmixed" when mounting USB=20
memory cards. As filenames are case insensitive in Windowsworld and=20
gadgets using vfat, Linux tend to treat them differently.

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.39548=C2=B0 E 5.31735=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 760e5d4a-de4c-11de-a982-90e6ba3022ac |-------------+

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksUyVQACgkQ+wy+6JSlBuVQtQCfdc9HM+gwfXzIqopF99HSTt+V
oKIAnjUNWe9X0UscGXb1YheYrTLgnaGV
=aTkf
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
