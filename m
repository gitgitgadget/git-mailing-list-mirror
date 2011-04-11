From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 12:16:14 +0200
Message-ID: <20110411101614.GB5146@genesis.frugalware.org>
References: <20110411084229.GW5146@genesis.frugalware.org>
 <20110411091919.GE28959@kytes>
 <4DA2CED1.6070107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qfesBOB4TKwppX3D"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	timar74@gmail.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 12:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9EAQ-0001BG-UM
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 12:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1DKKQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 06:16:17 -0400
Received: from virgo.iok.hu ([212.40.97.103]:40027 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab1DKKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 06:16:16 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5FF09580C9;
	Mon, 11 Apr 2011 12:16:15 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1FEF544965;
	Mon, 11 Apr 2011 12:16:14 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3B6EBBAC005; Mon, 11 Apr 2011 12:16:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DA2CED1.6070107@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171325>


--qfesBOB4TKwppX3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 11, 2011 at 11:50:09AM +0200, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> But maybe there is a better solution for your actual use case? Do you
> want to ignore line wrap or normalise it?

I want to avoid those, so we get readable diffs, whatever line width the
different translator tools are using. (If tool1 is using 72 and tool2 is
using 80, then it would reformat the whole file.)

Do you have a better idea than

        git config filter.po.clean 'msgcat - --no-wrap'

?

Thanks.

--qfesBOB4TKwppX3D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEUEARECAAYFAk2i1O4ACgkQe81tAgORUJZnYQCXfTCt1J6F6LgGxgnTjeHG+/IS
fQCgi0k4pHLaE90lWueIy3sEC3D72mc=
=ad+g
-----END PGP SIGNATURE-----

--qfesBOB4TKwppX3D--
