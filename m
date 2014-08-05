From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] Documentation: avoid dangling modifier for imap-send
Date: Tue, 5 Aug 2014 02:52:29 +0000
Message-ID: <20140805025229.GB10435@vauxhall.crustytoothpaste.net>
References: <xmqq8un4rtv6.fsf@gitster.dls.corp.google.com>
 <1407201189-12787-1-git-send-email-sandals@crustytoothpaste.net>
 <20140805024535.GV12427@google.com>
 <20140805025108.GW12427@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 04:52:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEUri-0003Ql-D6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 04:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbaHECwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 22:52:38 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49313 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753439AbaHECwi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2014 22:52:38 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 471012808F;
	Tue,  5 Aug 2014 02:52:36 +0000 (UTC)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20140805025108.GW12427@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254799>


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 07:51:08PM -0700, Jonathan Nieder wrote:
> Jonathan Nieder wrote:
>=20
> > Should the neighboring instances of '[Rr]equired to use imap-send
> > be changed to plain "Required", too?  (I suspect yes.)
>=20
> Here's what that would look like.
>=20
> -- >8 --
> From: brian m. carlson <sandals@crustytoothpaste.net>
> Subject: imap-send doc: omit confusing "to use imap-send" modifier
>=20
> It wouldn't make sense for these configuration variables to be
> required for Git in general to function.  'Required' in this context
> means required for git imap-send to work.
>=20
> Noticed while trying to figure out what the sentence describing
> imap.tunnel meant.
>=20
> [jn: expanded to also simplify explanation of imap.folder and
>  imap.host in the same way]
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-imap-send.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-sen=
d.txt
> index 875d283..d3b465d 100644
> --- a/Documentation/git-imap-send.txt
> +++ b/Documentation/git-imap-send.txt
> @@ -38,17 +38,17 @@ Variables
>  imap.folder::
>  	The folder to drop the mails into, which is typically the Drafts
>  	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
> -	"[Gmail]/Drafts". Required to use imap-send.
> +	"[Gmail]/Drafts". Required.
> =20
>  imap.tunnel::
>  	Command used to setup a tunnel to the IMAP server through which
>  	commands will be piped instead of using a direct network connection
> -	to the server. Required when imap.host is not set to use imap-send.
> +	to the server. Required when imap.host is not set.
> =20
>  imap.host::
>  	A URL identifying the server. Use a `imap://` prefix for non-secure
>  	connections and a `imaps://` prefix for secure connections.
> -	Ignored when imap.tunnel is set, but required to use imap-send
> +	Ignored when imap.tunnel is set, but required.

This has an extra period at the end of the line.

>  	otherwise.
> =20
>  imap.user::
> --=20
>=20

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT4EbsAAoJEL9TXYEfUvaLZPMP/iSHGiUmGlum8wNKbDjzicgm
T8IOorvnd1ssYp25FqvUoIBy3bH9DiVRawjMWvFrnwbnBtEv/RkU3mJXgmuXbKw4
osv/XsH/N/DJaeCKwf1khNdsPHFZtPfxmmBdxMc44KSf10Awk4Cks7j2OOyhOlmp
28Vy3ox01OPr9O+8enO7v5mjkaFiVcYpeTDdJeepUveQ49DeMtt4FCGT/Ss1h7WR
MAdl//jPSIdEK/NE3aRSFKvPzmQuV0S4MyvIMXUAuFegzUK8232XjlJwaaWSf2X5
zDW9Bubtl/uUCCXmMy/J7FN1VdNAZNM8B4A6jRaAIfAlpFMqwsqCzqUZmInXSjSx
OqVckQmp/koBOPnUViriANvMuiHR7tb6ay/SrkDMCcEkRYRaryZFzl4823hSzUHV
eteGByE1kyIT/xtnNLjIhAJRtnaAtCACgmH8EJtpMKorsNqNCKbhqtQmbkCROxWP
G6TKE6/nOaXTVaLIMYi3HuoXGUweehh6s/HH9FFSeq1L+XI5ih6G/6f5Sf+WnnfF
+teR4FtGIiCla5Tditx8BMqkxZLn8IB6ZdzqF0JLUR/e0dHcVxqKe4CIqqYUZPC6
fwP/Z4yGbN5vJ+GXrvgwTHV1Gu5fl4SdLYLfX5cPzVOyKKiImIuRfurJpRjCuGBV
4DMCajRhOHVPnYET6Kws
=u7dy
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
