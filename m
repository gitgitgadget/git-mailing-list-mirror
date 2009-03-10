From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] ls-files: fix broken --no-empty-directory
Date: Tue, 10 Mar 2009 23:16:48 +0100
Message-ID: <20090310221648.GB4371@genesis.frugalware.org>
References: <20090308012049.GA18616@coredump.intra.peff.net> <20090308012722.GB18714@coredump.intra.peff.net> <20090308211312.GE4371@genesis.frugalware.org> <20090310191111.GA27662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BBkx5mFZr42MYbGL"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 23:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhAHJ-0007tV-V4
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 23:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbZCJWQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbZCJWQ4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 18:16:56 -0400
Received: from virgo.iok.hu ([212.40.97.103]:49375 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754274AbZCJWQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 18:16:55 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6C47858100;
	Tue, 10 Mar 2009 23:16:51 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7315A44783;
	Tue, 10 Mar 2009 23:16:48 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DF4DE11B80AE; Tue, 10 Mar 2009 23:16:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090310191111.GA27662@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112855>


--BBkx5mFZr42MYbGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2009 at 03:11:11PM -0400, Jeff King <peff@peff.net> wrote:
> which is even still a little confusing, as you get "--empty-directory"
> in the usage message. But you would almost never want to use that, as it
> is already the default.

Exactly, that's why I suggested the usage of PARSE_OPT_NONEG, which
would avoid a new no-op option. ;-)

But I'm fine with the above patch as well, in case having the "no-"
prefix in an option name is considered as an improper negation.

--BBkx5mFZr42MYbGL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm25tAACgkQe81tAgORUJZkNwCgi2HO/kji8utqwLk+gBKTpB2v
jTwAnjkCHinbF/6bU6RyktYambXNiq3r
=U9F5
-----END PGP SIGNATURE-----

--BBkx5mFZr42MYbGL--
