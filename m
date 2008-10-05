From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: use reduce_heads() only when
	appropriate
Date: Sun, 5 Oct 2008 21:43:40 +0200
Message-ID: <20081005194340.GT23137@genesis.frugalware.org>
References: <20081003023518.GA3291@spearce.org> <1223035487-2576-1-git-send-email-vmiklos@frugalware.org> <20081003150927.GG6839@neumann>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7aLy7NWYeEog7w9O"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, jnareb@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:44:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZXC-0005zr-5C
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbYJETnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbYJETnn
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:43:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54378 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753148AbYJETnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:43:42 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F2005580D0;
	Sun,  5 Oct 2008 21:43:40 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 99C534465E;
	Sun,  5 Oct 2008 21:43:40 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 824EC11901A1; Sun,  5 Oct 2008 21:43:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081003150927.GG6839@neumann>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97528>


--7aLy7NWYeEog7w9O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2008 at 05:09:27PM +0200, SZEDER G=E1bor <szeder@ira.uka.de=
> wrote:
>   I think this should be squashed onto Mikl=F3s' patch.

I'll resend a squashed patch with your signoff included.

>   I'm not sure about putting these two new test into t7600-merge.sh.
>   Although the infrastructure to keep these tests very short (repo with
>   branches already set up, verify_parents) is there available, the first
>   test tests not only merge, but the cooperation of merge and commit,
>   and this second one tests only commit.

Given that originally it was git-merge.sh that did this reduction, I
think it's OK.

--7aLy7NWYeEog7w9O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjpGOwACgkQe81tAgORUJb70gCfR1EQvT36ogLXsiGYTAK0FrOB
6NgAoIpHbdxvVGLTev/CgM4uyiCIS9+S
=NXau
-----END PGP SIGNATURE-----

--7aLy7NWYeEog7w9O--
