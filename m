From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Wed, 16 Apr 2008 10:44:35 +0200
Message-ID: <20080416084435.GJ8387@genesis.frugalware.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <m3ej97rmc0.fsf@localhost.localdomain> <20080416003725.GF8387@genesis.frugalware.org> <7vd4oqwkev.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7SAgGoIHugoKhRwh"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 10:45:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm3H3-0007sk-Mv
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 10:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757990AbYDPIoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 04:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbYDPIon
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 04:44:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35159 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758793AbYDPIoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 04:44:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 94E9A1B2509;
	Wed, 16 Apr 2008 10:44:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D60E244659;
	Wed, 16 Apr 2008 10:41:09 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BD39311904CE; Wed, 16 Apr 2008 10:44:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4oqwkev.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79686>


--7SAgGoIHugoKhRwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2008 at 08:25:28PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > If we are at it, I had a similar bugreport: If one doesn't use an empty
> > line after the first line in the commit message, a git-format-patch +
> > git-am combo will strip newlines from the commit message:
>=20
> That's not a bug but an intended behaviour.  You are triggering "RFC 2822
> line folding" of Subject: header.

Hm, then is it git-am that would have to be fixed up to properly unfold
such a subject? (I mean not stripping newlines.)

--7SAgGoIHugoKhRwh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgFvHMACgkQe81tAgORUJYhpwCeP5T0FkT/bYDcGwtlTNvXR5K4
WbYAnj18XTfnqNadNDJFToVCu2VGMC0J
=apFW
-----END PGP SIGNATURE-----

--7SAgGoIHugoKhRwh--
