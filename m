From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 01:39:23 +0200
Message-ID: <20080916233923.GF4829@genesis.frugalware.org>
References: <1221607297-33212-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PD84dSQJNgoRXpJr"
Cc: git@vger.kernel.org
To: Jonathan del Strother <jon.delStrother@bestbefore.tv>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:40:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfk9q-0004Cu-BV
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYIPXj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYIPXj0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:39:26 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48673 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752373AbYIPXjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:39:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C5B5B1B2507;
	Wed, 17 Sep 2008 01:39:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 816B24465E;
	Wed, 17 Sep 2008 01:39:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2060D11901A1; Wed, 17 Sep 2008 01:39:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221607297-33212-1-git-send-email-jon.delStrother@bestbefore.tv>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96049>


--PD84dSQJNgoRXpJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2008 at 12:21:37AM +0100, Jonathan del Strother <jon.delStrother@bestbefore.tv> wrote:
> +	{ "objc", "^[\t ]*\\([-+][\t ]*([\t ]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$"      // Objective-C methods
> +			"\\|"
> +			"^[\t ]*\\(\\([\t ]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[\t ]*([^;]*\\)$" // C functions
> +			"\\|"
> +			"^@\\(implementation\\|interface\\|protocol\\).*"   // Objective-C class/protocol definitions

Please avoid C++-style comments. Just use /* */.

Thanks.

--PD84dSQJNgoRXpJr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjQQ6sACgkQe81tAgORUJaR1wCgmnC2W6AbILCuIguEsm1Ziq98
Lp4An3w6kUMqpUDhSzHEMOG9d5fcrFLb
=s41Q
-----END PGP SIGNATURE-----

--PD84dSQJNgoRXpJr--
