From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 08/10] Introduce commit_list_append() in commit.c
Date: Sat, 7 Jun 2008 04:03:26 +0200
Message-ID: <20080607020326.GB29404@genesis.frugalware.org>
References: <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <7v8wxjzd41.fsf@gitster.siamese.dyndns.org> <20080606235239.GY29404@genesis.frugalware.org> <7viqwmqexg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmKz1uriVzYz+bTd"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 04:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4nn4-0006Q5-WC
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 04:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYFGCD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 22:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYFGCD3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 22:03:29 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44076 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbYFGCD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 22:03:29 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6A3CE1B2532;
	Sat,  7 Jun 2008 04:03:27 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5BE53446A1;
	Sat,  7 Jun 2008 03:45:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C27141190ACA; Sat,  7 Jun 2008 04:03:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7viqwmqexg.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84165>


--vmKz1uriVzYz+bTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2008 at 05:14:35PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> If that is the case, you might want to check how parse_commit_buffer() in
> commit.c builds "parents" list.  It is a standard pattern to append to the
> list using commit_list_insert() and that is the reason why it returns a
> pointer.

Ah, great, then this patch is not necessary. I removed it from my
working branch.

Thanks.

--vmKz1uriVzYz+bTd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhJ7G4ACgkQe81tAgORUJZLuACgl7q0vqB0UpX0WHhfEwBb9bWR
81UAoILMlELUr5mJxoxmgZEEmgUlBlsp
=jxqH
-----END PGP SIGNATURE-----

--vmKz1uriVzYz+bTd--
