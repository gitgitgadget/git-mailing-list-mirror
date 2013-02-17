From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v2 02/15] user-manual: Update for
 receive.denyCurrentBranch=refuse
Date: Sun, 17 Feb 2013 12:06:06 -0500
Message-ID: <20130217170606.GA3432@odin.tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
 <cover.1360508415.git.wking@tremily.us>
 <ba62167be6df7a6ba666373913bfd235bcc29c9d.1360508415.git.wking@tremily.us>
 <7vd2w7uajk.fsf@alter.siamese.dyndns.org>
 <20130210214621.GA8000@odin.tremily.us>
 <7v1ucnssnw.fsf@alter.siamese.dyndns.org>
 <7v4nhezpta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=sdtB3X0nJg68CQEu
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U77hU-0002oL-CK
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 18:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235Ab3BQRG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 12:06:28 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:53864 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3BQRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 12:06:27 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MID002U2JI73640@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 11:06:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0405E8851FF; Sun,
 17 Feb 2013 12:06:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361120767; bh=2X63NdcN4J+iPZVr/QRLw/b6NEaKb9qONhMg5bea0W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q2fGb1OTbVZxalrBwSKt4UlpWjUXN7I502A5plFVQd9uOjALZiwtYb2O547bIZYQe
 FRCuYOlbRdkRZbykAj7URNqiZ0daEswMvZSWjSAenKmAohT8l/E8bUQin8mmNv40ZV
 8YktfO4GilH2fYlCEKZCzXAD4TZLoIX/7TmndFU0=
Content-disposition: inline
In-reply-to: <7v4nhezpta.fsf@alter.siamese.dyndns.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216399>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2013 at 10:57:21AM -0800, Junio C Hamano wrote:
> So let's tone everything down and do this instead:
>=20
> -- >8 --
> From: "W. Trevor King" <wking@tremily.us>
> Date: Fri, 8 Feb 2013 12:04:20 -0500
> Subject: [PATCH] user-manual: Update for receive.denyCurrentBranch=3Drefu=
se
>=20
> acd2a45 (Refuse updating the current branch in a non-bare repository
> via push, 2009-02-11) changed the default to refuse such a push, but
> it forgot to update the docs.
>=20
> 7d182f5 (Documentation: receive.denyCurrentBranch defaults to
> 'refuse', 2010-03-17) updated Documentation/config.txt, but forgot to
> update the user manual.
>=20
> Signed-off-by: W. Trevor King <wking@tremily.us>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/user-manual.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 85651b5..7c534dc 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -1986,9 +1986,10 @@ handling this case.
> =20
>  Note that the target of a "push" is normally a
>  <<def_bare_repository,bare>> repository.  You can also push to a
> -repository that has a checked-out working tree, but the working tree
> -will not be updated by the push.  This may lead to unexpected results if
> -the branch you push to is the currently checked-out branch!
> +repository that has a checked-out working tree, but a push to update the
> +currently checked-out branch is denied by default to prevent confusion.
> +See the description ofthe receive.denyCurrentBranch option
> +in linkgit:git-config[1] for details.
> =20
>  As with `git fetch`, you may also set up configuration options to
>  save typing; so, for example, after

Looks good to me.

Thanks,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRIQ38AAoJEEUbTsx0l5OMRMIQAK9MXh2VWfCOmutgpr/3aqG0
Pu9Lhe6c+DJpMPDidQ+cP3AcNFNZGr6LqxWr5fke5NHJ1jdUVMr/TMWmzQfBBi60
Ac1a0ENVqQ/gwlD2/QVsJv8strQlmwbQAB8LKA+BRHquSMNQl1FQakO0DiNYahiZ
9tOHimU5p7a/32dBe5WfIBh8rhsCGPw+UhHfgT6fyKs49vKF3Io/LF2CNSN8k3Jb
97TbLkMaZaV7pKi8SEPuzG9cGEgQPE6RFJfhOzGW+g2u7jg6aborCxUiUuSEnEVZ
5yBtRFk3ysrMkPA5WDClC3syMBWka3NhY87/OIS3gPaIMOeGx0BM0IqGZsRAPXHp
fOvXAbRKwcXboelD5dnJfnCTTyHgjNbyXwJ8tx8rvYu1gvBJM43KLbg9BWVivDhR
c8vYowCR3olBfhMtDZve1lwL8VAOS8JBsY0DGayrnosEUbl4PtWigA2JxSl+MByh
43zO2aH7BKl/PYvTvuBQAkhDdvbFYdDUga9xdZw+kdKTom1gtwP40Wr9jAwhzxL2
i0DTJaR/tvFTwiiOBFR8F9sXz5ulzI2tmsRYxWZMBtf48SEL7aaeLgdQb4nmzNZH
bf52W+J8Mc79+clsTyXEetiVFVD2Evp76qcuCS6ec7zwG3WCV8GUX2S0mlvPEdYL
3MBPhrmGefcNT8MBuV0J
=fzTG
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
