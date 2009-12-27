From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 4/4] clone: use --progress to force progress reporting
Date: Sun, 27 Dec 2009 02:20:32 +0100
Message-ID: <20091227012032.GE25474@genesis.frugalware.org>
References: <1261761126-5784-1-git-send-email-rctay89@gmail.com>
 <1261761126-5784-2-git-send-email-rctay89@gmail.com>
 <1261761126-5784-3-git-send-email-rctay89@gmail.com>
 <1261761126-5784-4-git-send-email-rctay89@gmail.com>
 <1261761126-5784-5-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wHmMVWdCgqSO3x88"
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 02:20:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOhoU-0001Vk-Uk
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 02:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464AbZL0BUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2009 20:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbZL0BUl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Dec 2009 20:20:41 -0500
Received: from virgo.iok.hu ([212.40.97.103]:55838 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529AbZL0BUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2009 20:20:39 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 057AA5809B;
	Sun, 27 Dec 2009 02:20:34 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8A34B44965;
	Sun, 27 Dec 2009 02:20:33 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 29D791240014; Sun, 27 Dec 2009 02:20:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1261761126-5784-5-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135697>


--wHmMVWdCgqSO3x88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 26, 2009 at 01:12:06AM +0800, Tay Ray Chuan <rctay89@gmail.com>=
 wrote:
> -v/--verbose now does not force progress reporting. Make git-clone.txt
> say so.
>=20
> This should cover all the bases in 21188b1 (Implement git clone -v),
> which implemented the option to force progress reporting.
>=20
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  Documentation/git-clone.txt |    3 +++
>  builtin-clone.c             |    8 ++++++--
>  t/t5702-clone-options.sh    |    3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index e722e6c..f43c8b2 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -102,6 +102,9 @@ objects from the source repository into a pack in the=
 cloned repository.
> =20
>  --verbose::
>  -v::
> +	Run verbosely.

What about mentioning this "does not force progress reporting" behaviour
in documentation of the "new" -v option?

--wHmMVWdCgqSO3x88
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks2tmAACgkQe81tAgORUJa53gCfbqe12edc9hN7Zn8mSNFkmOJz
EB0AoKAQnW65GMd0esZPfKwXIYOyRUFm
=OFQL
-----END PGP SIGNATURE-----

--wHmMVWdCgqSO3x88--
