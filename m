From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 09:29:08 +0200
Message-ID: <20080619072908.GM29404@genesis.frugalware.org>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3sv7gENtRriLHjvQ"
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 09:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Eas-0002J2-85
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 09:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbYFSH3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 03:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYFSH3L
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 03:29:11 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35711 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbYFSH3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 03:29:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1E08A1B2586;
	Thu, 19 Jun 2008 09:29:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9B87144697;
	Thu, 19 Jun 2008 09:07:12 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3D74B1778015; Thu, 19 Jun 2008 09:29:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080619072308.GA12727@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85453>


--3sv7gENtRriLHjvQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2008 at 09:23:08AM +0200, Karl Hasselstr=F6m <kha@treskal.c=
om> wrote:
> > Side note: builtin-merge does not have problem with merging 25+ refs
> > even in case every ref contains "new" commits.
>=20
> So how many parents can a commit have, exactly? Is there a hard limit
> somewhere, or just a point beyond which some git tools will start
> behaving strangely?

AFAIK there is no limit at a core level. git-show-branch has a limit of
25 refs (it can't show more then 25 refs at one time) and git-merge.sh
uses show-branch, while builtin-merge does not.

--3sv7gENtRriLHjvQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhaCsQACgkQe81tAgORUJaRyACdGW4f+z76Ek6GAdaDDTbl0WXE
UsIAoJ1BSahwcGRXvND2pxrHgqo83Rs8
=RGAR
-----END PGP SIGNATURE-----

--3sv7gENtRriLHjvQ--
