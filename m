From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] checkout without arguments does not make sense
Date: Mon, 21 Jul 2008 22:49:55 +0200
Message-ID: <20080721204955.GI32057@genesis.frugalware.org>
References: <200807212206.32818.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 21 22:51:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL2Lm-0007S7-JW
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 22:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbYGUUt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 16:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755996AbYGUUt6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 16:49:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:53218 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbYGUUt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 16:49:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CDB001B257B;
	Mon, 21 Jul 2008 22:49:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1091D4465E;
	Mon, 21 Jul 2008 22:09:34 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6462E11901B3; Mon, 21 Jul 2008 22:49:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807212206.32818.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89403>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2008 at 10:06:32PM +0200, Johannes Sixt <johannes.sixt@tele=
com.at> wrote:
> @@ -487,7 +487,8 @@ int cmd_checkout(int argc, const char **argv, const c=
har *prefix)
>  		}
> =20
>  		return checkout_paths(source_tree, pathspec);
> -	}
> +	} else if (!new.name && !opts.new_branch)
> +		usage_with_options(checkout_usage, options);
> =20
>  	if (new.name && !new.commit) {
>  		die("Cannot switch branch to a non-commit.");

Actually I think it _is_ useful, like this:

$ git checkout
Your branch is ahead of the tracked remote branch 'junio/next' by 1 commit.

How will it be possible to get that info easily after your patch?

Thanks.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiE9nMACgkQe81tAgORUJZFKwCfYxTGSGqYxVERwSL+8RBtJNkU
XIUAnjDrkqKSn8okExN2+0HbIDpt1wfM
=+KG9
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
