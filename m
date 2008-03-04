From: Joey Hess <joey@kitenet.net>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 4 Mar 2008 13:16:25 -0500
Message-ID: <20080304181625.GA30366@kodama.kitenet.net>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <7vk5ki91zj.fsf@gitster.siamese.dyndns.org> <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041203320.22527@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 19:26:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWbpz-00037Q-1f
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 19:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760044AbYCDSZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 13:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758237AbYCDSZ0
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 13:25:26 -0500
Received: from wren.kitenet.net ([80.68.85.49]:58577 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753945AbYCDSZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 13:25:25 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 13:25:25 EST
Received: from kodama.kitenet.net (66-168-92-132.dhcp.kgpt.tn.charter.com [66.168.92.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 865D1314344
	for <git@vger.kernel.org>; Tue,  4 Mar 2008 13:16:27 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 1842A11407E; Tue,  4 Mar 2008 13:16:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803041203320.22527@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/6124/Tue Mar  4 07:01:21 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76126>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> Can you be even more explicit?  IOW why does this have to be a pre-commit=
=20
> hook, and cannot be done before calling git-commit itself?

metastore adds a .metadata file that contains information (permissions,
owners, etc) not normally tracked with git. The pre-commit hook updates
the metadata just before committing, to ensure that the metadata
included in the commit is consistent with the rest of the commit. You
could do it by hand, but that would be an extra step that would have to
be rememebered every time.

There's no particular reason for the pre-commit hook to interactively
prompt before updating the metadata. I suspect it prompts only because
it's an example.

--=20
see shy jo

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHzZH5d8HHehbQuO8RAnnbAKCRxohDy9UEp/ZoYhHmS8x1ETy92wCgvqDd
T9bEGrhHOZs1PNIglw9Pbj8=
=YYCT
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
