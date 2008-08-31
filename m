From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] merge-recursive: fix subtree merge
Date: Mon, 1 Sep 2008 01:49:48 +0200
Message-ID: <20080831234948.GB16514@genesis.frugalware.org>
References: <1220110929-6803-1-git-send-email-vmiklos@frugalware.org> <7vabeuie0j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JEhTuUFIcUlI65CC"
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 01:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZwh9-0008H4-5Y
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 01:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbYHaXtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 19:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYHaXtx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 19:49:53 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45277 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751618AbYHaXtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 19:49:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 00F7D1B2526;
	Mon,  1 Sep 2008 01:49:50 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 841A24465E;
	Mon,  1 Sep 2008 01:49:48 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5C6AD119003C; Mon,  1 Sep 2008 01:49:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabeuie0j.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94515>


--JEhTuUFIcUlI65CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 30, 2008 at 10:55:24AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> This makes me wonder why we didn't see any breakages in the existing
> tests.

That is a really interesting question. I have no idea how t6029 can pass
without this fix, but actually it does. (Yes, I read that part of the
code and the testsuite as well, but still no clue.)

--JEhTuUFIcUlI65CC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAki7LhwACgkQe81tAgORUJacOwCgh8cxhSAsRmnl5zoNvPfv7+aj
3IMAnR35A1J1BtsAEMj3dIzvk7G9Gvqb
=q1U2
-----END PGP SIGNATURE-----

--JEhTuUFIcUlI65CC--
