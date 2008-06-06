From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 08/10] Introduce commit_list_append() in commit.c
Date: Sat, 7 Jun 2008 01:52:39 +0200
Message-ID: <20080606235239.GY29404@genesis.frugalware.org>
References: <cover.1212698317.git.vmiklos@frugalware.org> <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <7v8wxjzd41.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="axy+G8Ep0JfHiOnj"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lkU-0008Es-K8
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758226AbYFFXwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbYFFXwl
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:52:41 -0400
Received: from virgo.iok.hu ([193.202.89.103]:43640 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216AbYFFXwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:52:40 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C1AF71B2532;
	Sat,  7 Jun 2008 01:52:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B2D16446A6;
	Sat,  7 Jun 2008 01:34:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2C30B1190ACA; Sat,  7 Jun 2008 01:52:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wxjzd41.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84146>


--axy+G8Ep0JfHiOnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2008 at 04:16:46PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Do you have a caller of this function that keeps a pointer to commit_list
> that needs to be appended at the tail or inserted at the beginning
> depending on the phase of the moon, or does the caller always append to
> that list?

The later. I use it for appending a new parent for the merge commit and
after parsing a new remote head. In both cases I always append a list.

--axy+G8Ep0JfHiOnj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhJzccACgkQe81tAgORUJanTQCfQVOQekvWuPsVTaWUa40FTDYC
ZpAAn3aX5/SlB1Xidj+bjEOoBJu6mQWY
=AJXC
-----END PGP SIGNATURE-----

--axy+G8Ep0JfHiOnj--
