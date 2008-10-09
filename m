From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Thu, 9 Oct 2008 02:17:27 +0200
Message-ID: <20081009001727.GP536@genesis.frugalware.org>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3ovhOgMYmj8MRdq"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 02:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnjEo-0000VM-M0
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbYJIARb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbYJIARb
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:17:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:53875 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbYJIARa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:17:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F395058124;
	Thu,  9 Oct 2008 02:17:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B2D8E4465E;
	Thu,  9 Oct 2008 02:17:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EF99411901A1; Thu,  9 Oct 2008 02:17:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97814>


--z3ovhOgMYmj8MRdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2008 at 07:07:54PM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> While we're at it, change the allocation to reference the variable it is
> allocating memory for to try to prevent a similar mistake if the type is
> changed in the future.

If this is really a problem, then I think it would be good to mention
this in Documentation/CodingGuidelines.

--z3ovhOgMYmj8MRdq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjtTZcACgkQe81tAgORUJZPUwCdH48tngVFtZMWMObmZVesBw6t
lKEAn2eLlY6QnObVPvyso0GEkJf7DE3e
=/9HT
-----END PGP SIGNATURE-----

--z3ovhOgMYmj8MRdq--
