From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 13:14:28 +0200
Message-ID: <20110411111428.GD5146@genesis.frugalware.org>
References: <20110411084229.GW5146@genesis.frugalware.org>
 <20110411091919.GE28959@kytes>
 <4DA2CED1.6070107@drmicha.warpmail.net>
 <20110411101614.GB5146@genesis.frugalware.org>
 <4DA2DAC6.1010009@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Guq+xBHXhbnAFmh4"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	timar74@gmail.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 13:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9F4q-0007xR-QM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 13:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab1DKLOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 07:14:35 -0400
Received: from virgo.iok.hu ([212.40.97.103]:59877 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232Ab1DKLOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 07:14:35 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 283EA580AB;
	Mon, 11 Apr 2011 13:14:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0BE2B44965;
	Mon, 11 Apr 2011 13:14:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5124F1358449; Mon, 11 Apr 2011 13:14:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DA2DAC6.1010009@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171328>


--Guq+xBHXhbnAFmh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2011 at 12:41:10PM +0200, Michael J Gruber <git@drmicha.war=
pmail.net> wrote:
> git config diff.po.textconv 'msgcat - --no-wrap'
> git config diff.po.cachetextconv true
>=20
> If you want to normalise the repo, you may want to look at hooks instead
> of clean/smudge if they are a performance problem.

Ah - using hooks instead is indeed a better option.

Thanks!

--Guq+xBHXhbnAFmh4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2i4pQACgkQe81tAgORUJa0MQCeOSwL8d+d3w3DjgEqMBCsyOwE
eskAoJvN5YBeoN7HzlxJfPmKeWQyveU8
=1lGj
-----END PGP SIGNATURE-----

--Guq+xBHXhbnAFmh4--
