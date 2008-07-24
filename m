From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] t/: Replace diff [-u|-U0] with test_cmp to allow
	compilation with old diff
Date: Thu, 24 Jul 2008 02:19:16 +0200
Message-ID: <20080724001916.GP32057@genesis.frugalware.org>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <E23rxnPh0xeYPsUuTseZ3Y6bteX3uHIcbLzTlyVPsX_N5fqcvRp1vA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZH76yXETYuyhTGDD"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLoZC-0001Id-FV
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYGXATT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 20:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753974AbYGXATT
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:19:19 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35148 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753729AbYGXATS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:19:18 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BA72C1B252C;
	Thu, 24 Jul 2008 02:19:17 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 15DAB4465E;
	Thu, 24 Jul 2008 01:37:43 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 95EC311909DF; Thu, 24 Jul 2008 02:19:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E23rxnPh0xeYPsUuTseZ3Y6bteX3uHIcbLzTlyVPsX_N5fqcvRp1vA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89819>


--ZH76yXETYuyhTGDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2008 at 04:17:43PM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>  t/t0002-gitfile.sh               |    2 +-
>  t/t1002-read-tree-m-u-2way.sh    |   12 ++++++------
>  t/t2201-add-update-typechange.sh |   10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Hmm, after applying this patch, I have:

~/git/t$ git grep 'diff -U'
t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 4.out >4diff.out
t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 5.out >5diff.out
t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 14.out >14diff.out
t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 15.out >15diff.out

Any reason you left this out? ;-)

--ZH76yXETYuyhTGDD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiHyoQACgkQe81tAgORUJacUACgnQXn/b55omvxje3zrTdhCdzh
qhYAnApToX/8ClehhhvfxyrAJkGM7kwu
=2gZP
-----END PGP SIGNATURE-----

--ZH76yXETYuyhTGDD--
