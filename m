From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 09/10] Introduce get_octopus_merge_bases() in commit.c
Date: Sat, 7 Jun 2008 04:30:33 +0200
Message-ID: <20080607023033.GC29404@genesis.frugalware.org>
References: <0a2c2130f9fd87e98192ab0fe0d23e16c902997c.1212698317.git.vmiklos@frugalware.org> <9867fa302ce1c28f4bd8534a70bda19786c75971.1212698317.git.vmiklos@frugalware.org> <5aca216074b88d68f97b8223ebf6272dfe6bddeb.1212698317.git.vmiklos@frugalware.org> <3168647573b1325f47ab16f9ee3cae5abaaee473.1212698317.git.vmiklos@frugalware.org> <01dd116d05eedba51578935e39f679a8747380d6.1212698317.git.vmiklos@frugalware.org> <514d4184569ab033cad97be9afbd88c767bfb484.1212698317.git.vmiklos@frugalware.org> <2e4b20178405cf993ce9e0f1ffe4ac402a96fd03.1212698317.git.vmiklos@frugalware.org> <cbafb7e632b176658fe84e1eb9926f0a8d3c96b4.1212698317.git.vmiklos@frugalware.org> <e13c0c2e9c8b0ebef84ac062bf05c05f729b3b20.1212698317.git.vmiklos@frugalware.org> <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhNoKa8EeSU2TVlt"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 04:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4oDz-0004GY-3m
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 04:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYFGCau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 22:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYFGCau
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 22:30:50 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44148 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbYFGCat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 22:30:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 12EFD1B2532;
	Sat,  7 Jun 2008 04:30:46 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 927EE446A7;
	Sat,  7 Jun 2008 04:12:42 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 32CFB1190ACA; Sat,  7 Jun 2008 04:30:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vk5h3xlt9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84167>


--AhNoKa8EeSU2TVlt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2008 at 08:51:46PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> In what sense is this "like show-branch --merge-base"?
>=20
> The only similarlity I can spot is that it can take more than two heads,
> but what it computes and the way it computes it seem to be different.  It
> certainly looks much less efficient as it does not walk the ancestry chain
> in one-go like show-branch does.

Exactly. The original idea was to avoid the current limitation:
show-branch uses object flags for each branch, which is not something
that works if you have a lot of ones.

--AhNoKa8EeSU2TVlt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhJ8skACgkQe81tAgORUJbhFgCgmt7G7GpIeSQciPwvtukLf7/N
tbkAniEaweTX/fK1gczHQ5vLRyf3ZZh7
=J8+z
-----END PGP SIGNATURE-----

--AhNoKa8EeSU2TVlt--
