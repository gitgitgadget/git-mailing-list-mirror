From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] fast-import: make tagger information optional
Date: Sat, 20 Dec 2008 01:59:12 +0100
Message-ID: <20081220005912.GM21154@genesis.frugalware.org>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302> <20081218213407.GX5691@genesis.frugalware.org> <7viqphf4ua.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812200059480.30769@pacific.mpi-cbg.de> <7vfxkj65y5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 02:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDqDw-0004Wh-Bv
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 02:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbYLTA7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 19:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYLTA7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:59:16 -0500
Received: from virgo.iok.hu ([212.40.97.103]:60171 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbYLTA7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 19:59:16 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0592E5808F;
	Sat, 20 Dec 2008 01:59:15 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7BF654465E;
	Sat, 20 Dec 2008 01:59:12 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 83E2D11B862F; Sat, 20 Dec 2008 01:59:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxkj65y5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103615>


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2008 at 04:33:38PM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 91b5ace..5a2aaf2 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -56,6 +56,12 @@ M 644 :2 file2
>  M 644 :3 file3
>  M 755 :4 file4
> =20
> +tag series-A
> +from :5
> +data <<EOF
> +An annotated tag without an tagger

Minor nit: isn't this (here and later one more time) 'a tagger'?

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklMQ2AACgkQe81tAgORUJZSFQCgmRRUg4e6CvvoG26sJjG06pGi
jcwAn2cDuzB5U9w0zLicwgrBgvc0pARz
=AGr8
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--
