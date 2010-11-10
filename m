From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git describe weird behaviour
Date: Wed, 10 Nov 2010 23:07:30 +0100
Message-ID: <20101110220730.GR22105@genesis.frugalware.org>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <7vaalhhstp.fsf@alter.siamese.dyndns.org>
 <20101110204034.GO22105@genesis.frugalware.org>
 <20101110212410.GA13782@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B1ozxjQqW1UYvlaJ"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 23:07:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGIpS-0003PE-7k
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 23:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab0KJWHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 17:07:32 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54395 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756610Ab0KJWHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 17:07:32 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C0C9E580A0;
	Wed, 10 Nov 2010 23:07:30 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7EAC744659;
	Wed, 10 Nov 2010 23:07:30 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 57013132C041; Wed, 10 Nov 2010 23:07:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101110212410.GA13782@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161188>


--B1ozxjQqW1UYvlaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2010 at 03:24:10PM -0600, Jonathan Nieder <jrnieder@gmail.c=
om> wrote:
> Miklos Vajna wrote:
>=20
> > But I think the approach to follow the first parent only would solve the
> > problem outlined in the commit message of 80dbae0 as well: I think it's
> > pretty rare to tag a commit in a feature branch, then merge it.
>=20
> Doesn't that happen in linux-2.6 history fairly often (subsystem trees
> syncing with upstream)?

Hm, makes sense - I don't think it ever happened in
torvalds/linux-2.6.git, but probably it happens in subsystem trees where
a given maintainer never tags anything, but regularly merges from
torvalds/linux-2.6.git. So my proposal would break git describe output
when it's invoked in a subsystem tree, you are right.

(Note that Peff's patch at least fixes the tag part of the issue for me,
and that should not really break the above situation.)

--B1ozxjQqW1UYvlaJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzbF6IACgkQe81tAgORUJY5kwCeIf76hAtNPmQ1JgWvSfZqZC2Z
9B8An3glgU3QhL0PFp7doRm+vO9bt4fU
=HFCH
-----END PGP SIGNATURE-----

--B1ozxjQqW1UYvlaJ--
