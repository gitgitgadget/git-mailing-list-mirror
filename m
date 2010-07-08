From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as
 an escape character
Date: Thu, 8 Jul 2010 12:35:52 +0200
Message-ID: <20100708103552.GF31048@genesis.frugalware.org>
References: <20100706225522.GA31048@genesis.frugalware.org>
 <7vpqyz278o.fsf@alter.siamese.dyndns.org>
 <20100707091633.GB31048@genesis.frugalware.org>
 <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
 <20100707094620.GC31048@genesis.frugalware.org>
 <7v7hl6stna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aJFFgG5QZHt5jcrP"
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 12:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWoSW-0004Zk-SR
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 12:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0GHKf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 06:35:56 -0400
Received: from virgo.iok.hu ([212.40.97.103]:39324 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613Ab0GHKfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 06:35:55 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3DD7358054;
	Thu,  8 Jul 2010 12:35:54 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A246344659;
	Thu,  8 Jul 2010 12:35:53 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4AC3B12D90F0; Thu,  8 Jul 2010 12:35:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7hl6stna.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150557>


--aJFFgG5QZHt5jcrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2010 at 05:29:29PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Our patches do seem to fix the reading side of the issue, but I am not
> sure if the writing side needs further fix.  If I recall, the script had
> liberal use of "echo $var"; some implementations of echo interprets
> backslash sequence without being asked with an explicit "-e".

Possibly, I just have the bash builtin and the coreutils echo here, both
are writing \t properly without -e.

--aJFFgG5QZHt5jcrP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkw1qggACgkQe81tAgORUJYE9wCfVtyZYsDCaZjhY4gV5N2mkiOA
jtAAn1Q6/okm3FUweTfBeB9bfS8QScGg
=ndXa
-----END PGP SIGNATURE-----

--aJFFgG5QZHt5jcrP--
