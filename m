From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
Subject: Re: [PATCH 5/5] glossary: clarify description of HEAD
Date: Thu, 23 Jun 2011 19:06:58 +0200
Message-ID: <20110623170658.GC3142@centaur.lab.cmartin.tk>
References: <7vy60s36mm.fsf@alter.siamese.dyndns.org>
 <1308847958-3429-1-git-send-email-gitster@pobox.com>
 <1308847958-3429-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnMc-0008KO-Ki
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560Ab1FWRGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 13:06:42 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:58339 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313Ab1FWRGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 13:06:41 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e393.pool.mediaWays.net [77.185.227.147])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C85B9461EB;
	Thu, 23 Jun 2011 19:06:06 +0200 (CEST)
Received: (nullmailer pid 30462 invoked by uid 1000);
	Thu, 23 Jun 2011 17:06:58 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1308847958-3429-6-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176281>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2011 at 09:52:38AM -0700, Junio C Hamano wrote:
> HEAD on a branch does reference a commit via the branch ref it refers to.
> The main difference of a detached HEAD is that it _directly_ refers to
> a commit.  Clarify this.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/glossary-content.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-=
content.txt
> index dd690bd..f79da21 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -170,7 +170,7 @@ to point at the new commit.
>  	working tree>> is normally derived from the state of the tree
>  	referred to by HEAD.  HEAD is a reference to one of the
>  	<<def_head,heads>> in your repository, except when using a
> -	<<def_detached_HEAD,detached HEAD>>, in which case it may
> +	<<def_detached_HEAD,detached HEAD>>, in which case it may directly

Why "may"? As I understand it, in detached HEAD, it /does/ point
directly to a commit

>  	reference an arbitrary commit.
> =20
>  [[def_head_ref]]head ref::

Cheers,
   cmn
--=20
Carlos Mart=C3=ADn Nieto | http://cmartin.tk

"=C2=BFC=C3=B3mo voy a decir bobadas si soy mudo?" -- CACHAI

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOA3KyAAoJEHKRP1jG7ZzTrToH/1qxHYNSt/z1g8y2AsDia0Zr
43FaLfrOPFvWnEReQUBXZW1xG1khHMznfnRre3/fYqPxbhVUI/fUYaK4sPR9/h2c
frh3v/VVn7LKTH5/H+dWlouQvjLx+ASRE//ufhahfi/vhaJVcFUcoTL+1sb43ddt
sAiji9KVJ5UkbSn2sTaIz+nI6RWhqyL2QEgwpGNsifyMITTwhGDv1A1af5KlVSdU
D6jnBj9/xjgSUYlO6PNhAlnwc7UZs/e8Chh+yNUBr+VpvTOX/uraSMuV4TgZprQk
49dEwz2bDh8n6keAtr9thSDyBSeiT4zL67pg4Ls//eBZ/uMpnEm1XxqAF4GH6kI=
=DlJA
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
