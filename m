From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept
	more than 2 arguments
Date: Sun, 27 Jul 2008 17:28:06 +0200
Message-ID: <20080727152806.GA32057@genesis.frugalware.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org> <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BeJB7u2HmcNo1GIz"
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 17:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN8BP-0006HF-Sj
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 17:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbYG0P2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbYG0P2P
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 11:28:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52594 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbYG0P2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 11:28:15 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1655A1B250C;
	Sun, 27 Jul 2008 17:28:11 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E165F4465E;
	Sun, 27 Jul 2008 16:44:29 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5930F1190A0A; Sun, 27 Jul 2008 17:28:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90341>


--BeJB7u2HmcNo1GIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2008 at 04:38:05PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> BTW I seem to recall that get_merge_bases_many() was _not_ the same as=20
> get_merge_octopus().  Could you please remind me what _many() does?

get_octopus_merge_bases() takes a commit_list, and tries to figure out
the common bases of those commits.

get_merge_bases_many(), which is used by reduce_heads() takes a commit
and a commit_list, and counts the bases of the heads against the commit
specified as the first parameter.

I think get_merge_bases_many() could be even static, it is not really
interesting for anything else than reduce_heads() at the moment.

--BeJB7u2HmcNo1GIz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiMlAYACgkQe81tAgORUJYVUwCfZ0UV+91jACmz8NO0NFLkzeVs
sPIAn1RKh/+ht5nbXsyxwzSLGsWytSb8
=Cm5D
-----END PGP SIGNATURE-----

--BeJB7u2HmcNo1GIz--
