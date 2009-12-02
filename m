From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 23:12:32 +0100
Message-ID: <20091202221232.GF31763@genesis.frugalware.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202192614.GD30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6d/YZw7aFPcgCGm"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 23:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFxRB-0000sD-3Y
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 23:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbZLBWM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 17:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbZLBWM1
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 17:12:27 -0500
Received: from virgo.iok.hu ([212.40.97.103]:43425 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbZLBWM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 17:12:27 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D3F875809B;
	Wed,  2 Dec 2009 23:12:32 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B18D842F0A;
	Wed,  2 Dec 2009 23:12:32 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A4A941240011; Wed,  2 Dec 2009 23:12:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091202192614.GD30778@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134406>


--R6d/YZw7aFPcgCGm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2009 at 02:26:14PM -0500, Jeff King <peff@peff.net> wrote:
> Do you really want to set the date to something arbitrary, or do you
> just want to set it to "now"? If the latter case, do you really just
> want the recently discussed --reset-author?

No, I want to set it to two days ago, for example when I forgot to
commit at the end of the day and I notice it two days later before I
start to work on something again.

> Also, is there a good reason why GIT_AUTHOR_DATE is not respected in
> this case?  If not, should we simply be fixing that bug instead?

GIT_AUTHOR_DATE is respected by --reset-author, just given that we have
--author already, using environment variables for a user can be
uncomfortable.

--R6d/YZw7aFPcgCGm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksW5lAACgkQe81tAgORUJbYPgCeJ8+GRbKgRMsKyTsCA5x/wANZ
JsAAn1MFHTYF3DWRfssq6EeqxRv6xbW4
=AfpK
-----END PGP SIGNATURE-----

--R6d/YZw7aFPcgCGm--
