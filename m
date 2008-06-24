From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v2] git-svn: make rebuild respect rewriteRoot option
Date: Mon, 23 Jun 2008 22:11:26 -0400
Message-ID: <20080624021126.GA31093@kodama.kitenet.net>
References: <20080624021736.2d272d9c@neuron>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 04:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAy8l-0007IA-VD
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 04:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbYFXCTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 22:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbYFXCTK
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 22:19:10 -0400
Received: from wren.kitenet.net ([80.68.85.49]:46755 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbYFXCTH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 22:19:07 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jun 2008 22:19:07 EDT
Received: from kodama.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 787EE3142F7
	for <git@vger.kernel.org>; Mon, 23 Jun 2008 22:11:29 -0400 (EDT)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 978E811439D; Mon, 23 Jun 2008 22:11:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080624021736.2d272d9c@neuron>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93/7081/Fri May  9 11:52:50 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85980>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jan Kr=FCger wrote:
> Suppose someone fetches git-svn-ified commits from another repo and then
> attempts to use 'git-svn init --rewrite-root=3Dfoo bar'. Using git svn re=
base
> after that will fail badly:
>=20
>  * For each commit tried by working_head_info, rebuild is called indirect=
ly.
>  * rebuild will iterate over all commits and skip all of them because the
>    URL does not match. Because of that no rev_map file is generated at al=
l.
>  * Thus, rebuild will run once for every commit. This takes ages.
>  * In the end there still isn't any rev_map file and thus working_head_in=
fo
>    fails.

Very timely, I had just been beating my head against this problem.
Your patch works great for me.

--=20
see shy jo

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIYFfDd8HHehbQuO8RAl8CAKCq1fGDITYTkpwPwwSCwecX+Ljq8QCgrith
EqmallVrT85njIvD4u+DEy4=
=wbmH
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
