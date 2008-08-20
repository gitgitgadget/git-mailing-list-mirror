From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: "git-merge": allow fast-forwarding in a stat-dirty tree
Date: Thu, 21 Aug 2008 00:35:11 +0200
Message-ID: <20080820223511.GM23800@genesis.frugalware.org>
References: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl> <7v7iabpejv.fsf@gitster.siamese.dyndns.org> <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl> <7vljyrnxt3.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:36:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwHw-0002CU-4P
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYHTWfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYHTWfT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:35:19 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40370 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbYHTWfS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:35:18 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 444D31B24F0;
	Thu, 21 Aug 2008 00:35:14 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A72A34465E;
	Wed, 20 Aug 2008 23:38:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A78F91770019; Thu, 21 Aug 2008 00:35:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vljyrnxt3.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93066>


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2008 at 03:09:28PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>  	if (read_cache_unmerged())
>  		die("you need to resolve your current index first");
> +	refresh_cache(REFRESH_QUIET);

I did not realise that we need a refresh_cache() after
read_cache_unmerged() here, and thus the other refresh_cache() call is
unnecessary.

Thanks.

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkisnB8ACgkQe81tAgORUJam5wCgpEklkUSebDDMbPRYK/AL2KqB
/w4An1Bma1yONE4gtQ9j+XdBnD68M6Rp
=TLZK
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--
