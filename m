From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how do I remove a tag on a remote repository I pushed to ?
Date: Wed, 2 Jul 2008 15:24:47 +0200
Message-ID: <20080702132447.GH4729@genesis.frugalware.org>
References: <46d6db660807020552x400b8f3x81f8bf6970729b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDpvzslK0qRw06MN"
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 15:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2LE-00053a-Gj
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 15:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYGBNYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 09:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbYGBNYw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 09:24:52 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50208 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbYGBNYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 09:24:51 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2BDA91B2545;
	Wed,  2 Jul 2008 15:24:50 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B14A944697;
	Wed,  2 Jul 2008 14:55:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CC7451190498; Wed,  2 Jul 2008 15:24:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46d6db660807020552x400b8f3x81f8bf6970729b0c@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87132>


--vDpvzslK0qRw06MN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 02, 2008 at 02:52:58PM +0200, Christian MICHON <christian.michon@gmail.com> wrote:
> I've seen here how to remove remote branches, but was there any hint
> on how to perform the same removal on remote tags ?

The same way:

git push origin :refs/tags/mytag

--vDpvzslK0qRw06MN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhrgZ8ACgkQe81tAgORUJY5qQCfbeSNkKrGeZqFyVkl/UAkuJVJ
ejkAoJdi8CpZgjwUAXQ/QaxEhNgY5nM4
=WWPF
-----END PGP SIGNATURE-----

--vDpvzslK0qRw06MN--
